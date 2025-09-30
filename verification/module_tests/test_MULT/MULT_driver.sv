class MULT_Driver extends uvm_driver #(MULT_data); 
    `uvm_component_utils(MULT_Driver)

    virtual MULT_Interface vif; 
    uvm_analysis_port (MULT_data) port; 


    function new(string name = "MULT_Driver", uvm_component parent = NULL)' 
        super.new(name); 
    endfunction

    function build_phase(uvm_phase phase); 
        super.build_phase(phase); 
            if (!uvm_config_db#(virtual MULT_Interface)::get(this, "", "vif", vif))
                `uvm_fatal("DRIVER", "Did not get vif")   

        port = new("port", this);
    endfunction

    task run_phase (uvm_phase phase); 
        super.run_phase(phase); 
        MULT_data Item; 
        forever begin 
            seq_item_port.get_next_item(Item); 
            drive_data(Item); 
            MULT_data send_copy = MULT_data::type_id::create("send_copy"); 
            send_copy.copy(Item); 
            port.write(send_copy); 
            seq_item_port.finish_item(Item); 
        end
        
    endtask 

    task drive_data(MULT_data Item); 
        @posedge (vif.clk) begin 
            vif.EN <= 1; 
            vif.RS1 <= Item.RS1; 
            vif.RS2 <= Item.RS2;
            vif.MUL_OP <= Item.MUL_OP;
        end 
    endtask
endclass