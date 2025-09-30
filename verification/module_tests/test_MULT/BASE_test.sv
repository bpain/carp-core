class BASE_test extends uvm_test;
  `uvm_component_utils(BASE_test)
  function new(string name = "BASE_test", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  MULT_environment  	e0;
  MULT_sequence 		seq;
  virtual  	MULT_VIF 	vif;

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    e0 = env::type_id::create("e0", this);

    // Get virtual IF handle from top level and pass it to everything in env level
    if (!uvm_config_db#(virtual I2C_Interface)::get(this, "", "vif", vif))
      `uvm_fatal("TEST", "Did not get vif")
    uvm_config_db#(virtual I2C_Interface)::set(this, "e0.a0.*", "vif", vif);

    // Create sequence and randomize it
    seq = gen_item_seq::type_id::create("seq");
    seq.randomize();
  endfunction

  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    seq.start(e0.a0.s0);
    @posedge(vif.clk)
    phase.drop_objection(this);
  endtask

endclass