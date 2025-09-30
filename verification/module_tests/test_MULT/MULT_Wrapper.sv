module MULT_Wrapper #(
     
) (
    MULT_VIF _if,   
);

logic EOUT_negate_prod, MIN_negate_prod, MOUT_negate_prod, WIN_negate_prod;
logic [1:0] EOUT_cycles, MIN_cycles, MOUT_cycles, WIN_cycles, MIN_OP, MOUT_OP, WIN_OP; 
logic [31:0] EOUT_rs1, MIN_rs1, MOUT_rs1, WIN_rs1, EOUT_rs2, MIN_rs2, MOUT_rs2, WIN_rs2, WOUT_prod; 
logic [63:0] EOUT_prod, MIN_prod, MOUT_prod, WIN_prod; 

always_ff @( posedge _if.clk ) begin 
    MIN_cycles <= EOUT_cycles;
    MIN_negate_prod <= EOUT_negate_prod ; 
    MIN_prod <= EOUT_prod; 
    MIN_rs1 <= EOUT_rs1; 
    MIN_rs2 <= EOUT_rs2 ; 
    MIN_OP <= _if.MUL_OP; 

    WIN_cycles <= MOUT_cycles; 
    WIN_negate_prod <= MOUT_negate_prod; 
    WIN_prod <= MOUT_prod; 
    WIN_rs1 <= MOUT_rs1; 
    WIN_rs2 <= MOUT_rs2; 
    WIN_OP <= MOUT_OP; 

    _if.product1 <= EOUT_prod; 
    _if.product2 <= MOUT_prod; 
    _if.product3 <= WOUT_prod; 
end


MUL_INIT MUL_E(
    .EN(_if.EN),
    .RS1(_if.RS1),
    .RS2(_if.RS2),
    .MUL_OP(_if.MUL_OP),
    .PROD(EOUT_prod),
    .RS1_U(EOUT_rs1),
    .RS2_U(EOUT_rs2),
    .SIGN(EOUT_negate_prod),
    .CYCLES(EOUT_cycles) 
);

MUL_MID MUL_M(
    .EN(MIN_cycles[0] | MIN_cycles[1]),
    .RDY_M(MIN_cycles[0]),
    .SIGN(MIN_negate_prod),
    .SUM(MIN_prod), 
    .RS1_U_MID(MIN_rs1[21:11]),
    .RS2_U_MID(MIN_rs2[21:11]),
    .PROD(MOUT_prod),
);
//not necessary just makes stuff easier to track
always_comb begin  
    MOUT_cycles = MIN_cycles; 
    MOUT_negate_prod = MIN_negate_prod; 
    MOUT_rs1 = MIN_rs1; 
    MOUT_rs2 = MIN_rs2; 
    MOUT_OP = MIN_OP; 
end 

MUL_FIN MUL_W(
    .EN(WIN_cycles[1]),
    .SIGN(WIN_negate_prod),
    .UPPER(WIN_OP[1] | WIN_OP[0]),
    .SUM(WIN_prod), 
    .RS1_U_END(WIN_rs1[31:22]),
    .RS2_U_END(WIN_rs2[31:22]),
    .PROD(WOUT_prod),
);

endmodule
    
