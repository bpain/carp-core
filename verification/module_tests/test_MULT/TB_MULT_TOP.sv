module tb_top (); 
    reg clk;

    always #10 clk =~ clk;
    MULT_VIF _if(clk); 
    MULT_Wrapper DUT(_if); 

initial begin
    clk <= 0;
    uvm_config_db#(virtual MULT_VIF)::set(null, "uvm_test_top", "vif", _if);
    run_test("base_test");
end

endmodule 