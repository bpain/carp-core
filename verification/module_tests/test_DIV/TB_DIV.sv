module TB_DIV #() (
    
);

    logic [31:0] nume, den; 
    logic en, done, clr, clk, error, busy, test; 
    logic [31:0] quotient, remainder; 


    DIVIDER DUT(.*); 

    initial begin
        $display("starting sim"); 
        clk = 0; 
        nume = 0; 
        den = 0; 
        en = 0; 
        // repeat (4) @(posedge clk); 
        // en = 1; 
        test = 1; 
        repeat(2) @(posedge clk); 
        test = 0; 


        test_div(100, 10); 
        test_div(999, 1); 
        test_div(999, 9); 
        test_div(100, 10); 
        test_div(1000000, 10);
        
        test_div(21, 3); 
        test_div(32, 2); 
        
        test_div(33, 4); 
        test_div(32, 4); 
        
        test_div(33, 8); 
        test_div(32, 8); 
        
        test_div(5000, 3); 

        $finish;  
    end   

    always begin 
        #10 clk =~ clk;
    end 
    
    initial begin 
        if($test$plusargs("dump")||1)begin 
            $dumpfile("wave.vcd"); 
            $dumpvars(0, TB_DIVIDER); 
        end 
    end 


    // initial begin 
    //     wait (en == 1); 
    //     repeat (2) @(posedge clk); 
    //     nume = 4; 
    //     den = 2; 

    //     repeat (2) @(posedge clk); 
    //     nume = 4; 
    //     den = 2; 

    //     $display("Test Complete"); 
    //     #50
    //     $finish; 
    // end 
    
    task automatic test_div(bit[31:0] a, bit[31:0] b); 
        $display("starting task"); 
        @(posedge clk); 
        #20 nume = a;
        #20 den = b;
        #20 en = 1;  
        #20 en = 0; 
         

        @(posedge done);  

        assert(den == 0) begin 
            assert(error == 1)begin 
                $display("correct divide by zero"); 
            end 
            else begin
                $display("incorrect divide by zero, no error detected"); 
                $finish(); 
            end 
        end 
        else begin 
            assert(quotient != a/b)begin
                $display("incorrect quotient, NUMERATOR: %0d, DENOMINATOR: %0d, QUOTIENT: %0d", nume, den, quotient);             
                $finish(); 
            end 
            else begin 
                $display("correct quotient, NUMERATOR: %0d, DENOMINATOR: %0d, QUOTIENT: %0d", nume, den, quotient); 
            end 
        
            assert(remainder != a%b)begin 
                $display("incorrect remainder, NUMERATOR: %0d, DENOMINATOR: %0d, QUOTIENT: %0d", nume, den, remainder); 
                $finish(); 
            end 
            else begin 
                $display("correct remainder, NUMERATOR: %0d, DENOMINATOR: %0d, REMAINDER: %0d", nume, den, remainder);
            end 
            end 
        
    endtask
    

endmodule
