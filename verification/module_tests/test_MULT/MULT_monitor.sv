class MULT_Monitor extends uvm_monitor; 
    `uvm_component_utils(MULT_Monitor)

    event read_data; 
    virtual MULT_Interface vif; 
    MULT_data current_state[]; 
    uvm_analysis_imp   #(MULT_data, MULT_Monitor) read_port; 
    uvm_analysis_port  #(MULT_monitor_data) write_port; 

    function new(string name = "MULT_Monitor", uvm_component parent = null); 
        super.new(name); 
    endfunction

    function build_phase(uvm_phase phase); 
        super.build_phase(phase); 
        if (!uvm_config_db#(virtual MULT_Interface)::get(this, "", "vif", vif))begin 
            `uvm_fatal("MONITOR", "Did not get vif")  
        end 
        read_port  = new("read_port",  this);
        write_port = new("write_port", this);
        current_state = new[3]; 
    endfunction

    task run_phase(uvm_phase phase); 
        super.run_phase(phase); 
        @posedge(vif.en); 
        forever begin 
            @(read_data); 
            MULT_monitor_data Item = MULT_monitor_data::type_id::create("Item"); 
            Item.product1 = vif.product1; 
            Item.product2 = vif.product2; 
            Item.product3 = vif.product3; 
            Item.input = new[3]; 
            for(int i = 0; i <3; i++) begin 
                if(current_state[i] != null)begin 
                    MULT_data thing = MULT_data::type_id::create("thing"); 
                    thing.copy(current_state[i]); 
                    Item.input[i] = thing;  
                end
            end 
            write_port.write(Item); 
        end 
    endtask
    
    virtual function void write (MULT_data data);
        current_state[2] = current_state[1]; 
        current_state[1] = current_state[0]; 
        MULT_data new_data = MULT_data::type_id::create("new_data"); 
        new_data.copy(data); 
        current_state[0] = new_data; 
        ->read_data; 
    endfunction


endclass    