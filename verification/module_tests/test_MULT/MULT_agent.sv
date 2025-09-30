class MULT_Agent extends uvm_agent; 
    `uvm_component_utils(MULT_Agent)

    MULT_Driver d0; 
    MULT_Monitor m0; 
    uvm_sequencer #(MULT_data) s0; 

    function new(string name="MULT_Agent", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    function build_phase(uvm_phase phase); 
        super.build_phase(phase);  
        d0 = MULT_Driver::type_id::create("d0", this); 
        m0 = MULT_Monitor::type_id::create("m0", this); 
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        d0.seq_item_port.connect(s0.seq_item_export);
        d0.port.connect()
    endfunction


endclass