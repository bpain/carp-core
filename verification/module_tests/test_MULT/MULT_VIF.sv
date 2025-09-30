interface MULT_VIF(input clk); 

    logic clk; 
    wire EN = 0; 
    wire [31:0] RS1; 
    wire [31:0] RS2;
    wire [1:0] MUL_OP;

    logic [63:0] product1;
    logic [63:0] product2; 
    logic [31:0] product3;

endinterface 