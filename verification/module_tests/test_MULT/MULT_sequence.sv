class MULT_sequence extends uvm_sequence; 
    `uvm_object_utils (MULT_sequence);   
    
    MULT_data data_obj; 
    int unsigned n_times; 
 

    function new (string name = "MULT_Sequence"); 
        super.new(name); 
    endfunction

    virtual task pre_body ();
		if (starting_phase != null)
			starting_phase.raise_objection (this);
	endtask

    virtual task body ();
		`uvm_info ("BASE_SEQ", $sformatf ("Starting body of %s", this.get_name()), UVM_MEDIUM)
		data_obj = I2C_data::type_id::create ("data_obj");

		repeat (n_times) begin
			start_item (data_obj);
			assert (data_obj.randomize ());
			finish_item (data_obj);
		end
		`uvm_info (get_type_name (), $sformatf ("Sequence %s is over", this.get_name()), UVM_MEDIUM)
	endtask

	// Drop objection if started as the root sequence
	virtual task post_body ();
		if (starting_phase != null)
			starting_phase.drop_objection (this);
	endtask

endclass