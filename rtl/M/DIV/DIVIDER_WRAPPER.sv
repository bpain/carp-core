module DIVIDER_wrapper(
    input clk, go, clr,
    input [1:0] func3, //first bit always 1 for divide 
    input [31:0] rs1, rs2, 
    output done, 
    output logic [31:0] rd); 

    logic error, en, r_done; 
    wire w_done; 
    wire [31:0] quotient, remainder; 
    logic [31:0] nume, den;

    DIVIDER divider(.nume(nume), 
                    .den(den),  
                    .en(en), 
                    .clk(clk), 
                    .clr(clr), 
                    .quotient(quotient), 
                    .remainder(remainder), 
                    .done(w_done)); 
                    
    assign done = r_done; 
    
    always_ff@(posedge clk) begin 
        en <= 0; 
        r_done <= w_done; 
        if(go)begin 
            if(~func3[0])begin 
                nume <= rs1[31] ? ~rs1 + 1: rs1; 
                den <= rs2[31] ? ~rs2 + 1: rs2; 
             end 
             else begin 
                nume <= rs1; 
                den <= rs2; 
             end 
             en <= 1; 
            end 
        if(func3[1])begin  //if mod operator 
            if(~func3[0] && (rs1[31]^rs2[31]))begin //signed + negative 
                    rd <= ~remainder + 1; 
            end 
            else begin //unsigned + positive signed 
                rd <= remainder; 
            end
        end 
        else begin 
            if(~func3[0] && (rs1[31]^rs2[31]))begin //signed + negative 
                    rd <= ~quotient + 1;
            end 
            else begin //unsigned + positive signed 
                rd <= quotient; 
            end
        end 
        
    end 
    





endmodule