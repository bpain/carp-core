class MULT_data extends uvm_sequence_item #(
    parameter integer unsigned max_input; 
); 
    'uvm_object_utils(MULT_data)
    
    MULT_data input[3]; 
    bit [63:0] product1;
    bit [63:0] product2; 
    bit [31:0] product3;

    function new(string name="MULT_data");        
        super.new(name);
    endfunction

    virtual function void display ();
		`uvm_info (get_type_name (), $sformatf ("RS1 = 0x%0h, RS2, = 0x%oh, MUL_OP = 0x%0h", RS1, RS2, MUL_OP), UVM_MEDIUM);
	endfunction

endclass