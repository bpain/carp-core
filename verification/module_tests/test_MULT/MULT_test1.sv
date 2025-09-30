class MULT_test1 extends base_test; 
    `uvm_component_utils(test1)

    function new(string name = "test1", uvm_component parent=null);
        super.new(name, parent);
        I2C_environment1  e0;
    endfunction

    virtual function void build_phase(uvm_phase phase); 
        super.build_phase(phase); 
        e0 = env::type_id::create("e0", this);

    endfunction

endclass