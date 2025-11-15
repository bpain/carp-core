module TB_DIVIDER_WRAPPER(); 

    logic [31:0] nume, den; 
    logic [1:0] func3; 
    logic en, done, clk, test, clr; 
    logic [31:0] out; 

    typedef enum bit[1:0] {
        DIV = 2'b00, 
        DIVU = 2'b01, 
        REM = 2'b10, 
        REMU = 2'b11
    } func3_code;

    DIVIDER_wrapper DUT(.clk(clk), 
                        .go(en), 
                        .clr(clr), 
                        .func3(func3), //first bit always 1 for divide 
                        .rs1(nume), 
                        .rs2(den), 
                        .done(done), 
                        .rd(out)); 
    

    initial begin
        $display("starting sim"); 
        clk = 0; 
        nume = 0; 
        den = 0; 
        en = 0; 
        clr = 1; 
        // repeat (4) @(posedge clk); 
        // en = 1; 
        repeat(2) @(posedge clk);  
        
        clr = 0;

        test_div_mod(100, 10, DIVU); 
        test_div_mod(999, 1, DIVU); 
        test_div_mod(999, 9, DIVU); 
        test_div_mod(100, 10,DIVU); 
        test_div_mod(1000000, 10, DIVU);
        
        test_div_mod(21, 3, DIVU); 
        test_div_mod(32, 2, DIVU); 
        
        test_div_mod(33, 4, DIVU); 
        test_div_mod(32, 4, DIVU); 
        
        test_div_mod(33, 8, DIVU); 
        test_div_mod(32, 8, DIVU); 
        
        test_div_mod(5000, 3, DIVU); 
        test_div_mod(3000, 3, DIVU); 
        
            
        test_div_mod(100, 10, DIV); 
        test_div_mod(999, 1, DIV); 
        test_div_mod(999, 9, DIV); 
        test_div_mod(100, 10,DIV); 
        test_div_mod(1000000, 10, DIV);
        
        test_div_mod(21, 3, DIV); 
        test_div_mod(32, 2, DIV); 
        
        test_div_mod(33, 4, DIV); 
        test_div_mod(32, 4, DIV); 
        
        test_div_mod(33, 8, DIV); 
        test_div_mod(32, 8, DIV); 
        
        test_div_mod(5000, 3, DIV); 
        
        
        
        test_div_mod(100, 10, DIV); 
        test_div_mod(999, 1, DIV); 
        test_div_mod(999, 9, DIV); 
        test_div_mod(100, 10,DIV); 
        test_div_mod(1000000, 10, DIV);
        
        test_div_mod(-21, 3, DIV); 
        test_div_mod(32, -2, DIV); 
        
        test_div_mod(33, -4, DIV); 
        test_div_mod(-32, 4, DIV); 
        
        test_div_mod(33, -8, DIV); 
        test_div_mod(-32, 8, DIV); 
        
        test_div_mod(5000, -3, DIV); 
        
        

        test_div_mod(100, 10, REM); 
        test_div_mod(999, 1, REM); 
        test_div_mod(999, 9, REM); 
        test_div_mod(100, 10,REM); 
        test_div_mod(1000000, 10, REM);
        
        test_div_mod(21, 3, REM); 
        test_div_mod(32, 2, REM); 
        
        test_div_mod(33, 4, REM); 
        test_div_mod(32, 4, REM); 
        
        test_div_mod(33, 8, REM); 
        test_div_mod(32, 8, REM); 
        test_div_mod(5000, 3, REM);
   
        test_div_mod(100, -10, REM); 
        test_div_mod(-999, 1, REM); 
        test_div_mod(999, -9, REM); 
        test_div_mod(-100, 10,REM); 
        test_div_mod(1000000, -10, REM);
        
        test_div_mod(-21, 3, REM); 
        test_div_mod(32, -2, REM); 
        
        test_div_mod(-33, 4, REM); 
        test_div_mod(32, -4, REM); 
        
        test_div_mod(-33, 8, REM); 
        test_div_mod(32, -8, REM); 

        test_div_mod(100, 10, REMU); 
        test_div_mod(999, 1, REMU); 
        test_div_mod(999, 9, REMU); 
        test_div_mod(100, 10,REMU); 
        test_div_mod(1000000, 10, REMU);
        
        test_div_mod(21, 3, REMU); 
        test_div_mod(32, 2, REMU); 
        
        test_div_mod(33, 4, REMU); 
        test_div_mod(32, 4, REMU); 
        
        test_div_mod(33, 8, REMU); 
        test_div_mod(32, 8, REMU); 
        
        test_div_mod(5000, 3, REMU); 
        $display("type shit big dawg"); 
        $finish;  
    end   

    always begin 
        #10 clk =~ clk;
    end 
    
    initial begin 
        if($test$plusargs("dump")||1)begin 
            $dumpfile("wave.vcd"); 
            $dumpvars(0, TB_DIVIDER_WRAPPER); 
        end 
    end 
    
    task automatic test_div_mod(bit[31:0] a, bit[31:0] b, func3_code op); 
        @(posedge clk); 
        #20 nume = a;
            den = b;
            func3 = op;          
        #20 en = 1;  
        #20 en = 0; 
        @(posedge done);
        case(op)
            DIV: 
                begin 
                    assert($signed(out) == ($signed(a)/$signed(b)))
                    else begin
                        $display("incorrect signed quotient, NUMERATOR: %0d, DENOMINATOR: %0d, out: %0d, expected: %d", $signed(nume), $signed(den), $signed(out), ($signed(a)/$signed(b)));             
                    end 
                end 
            DIVU:
                begin 
                    assert($unsigned(out) == $unsigned(a)/$unsigned(b))
                    else begin
                        $display("incorrect unsigned quotient, NUMERATOR: %0d, DENOMINATOR: %0d, out: %0d", nume, den, out);             
                    end 
                end 
            REM: 
                begin 
                    assert($signed(out) == $signed(a)%$signed(b))
                    else begin 
                        $display("incorrect signed remainder, NUMERATOR: %0d, DENOMINATOR: %0d, out: %0d", $signed(nume), $signed(den), $signed(out)); 
                    end 
                end 
            REMU: 
                begin 
                    assert($unsigned(out) == $unsigned(a)%$unsigned(b))
                    else begin 
                        if(1 == 1) begin end 
                        $display("incorrect unsigned remainder, NUMERATOR: %0d, DENOMINATOR: %0d, out: %0d", nume, den, out); 
                    end 
                end
        endcase 
    endtask
    


endmodule 