class MULT_environment extends uvm_env; 
    `uvm_component_utils(MULT_Environment)

    MULT_agent a0; 
    MULT_scoreboard sb0; 

    function new(string name="MULT_Environment", uvm_component parent=null);
        super.new(name, parent);
    endfunction
    
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        a0 = MULT_agent::type_id::create("a0", this);
        sb0 = MULT_scoreboard::type_id::create("sb0", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        a0.m0.write_port.connect(sb0.m_analysis_imp);
        a0.d0.port.connect(a0.m0.read_port); 
    endfunction

endclass