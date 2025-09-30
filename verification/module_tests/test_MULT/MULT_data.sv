class MULT_data extends uvm_sequence_item #(
    parameter integer unsigned max_input; 
); 
    'uvm_object_utils(MULT_data)
    
    bit EN = 1; 
    bit [1:0] MUL_OP,
    rand bit [31:0] RS1, RS2; 

    constraint RS1 { 0 < RS1 <= max_input }; 
    constraint RS2 { 0 < RS2 <= max_input }; 

    function new(string name="MULT_data");        
        super.new(name);
    endfunction

    virtual function void display ();
		`uvm_info (get_type_name (), $sformatf ("RS1 = 0x%0h, RS2, = 0x%oh, MUL_OP = 0x%0h", RS1, RS2, MUL_OP), UVM_MEDIUM);
	endfunction

endclass