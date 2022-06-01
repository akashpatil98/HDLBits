module top_module (
    input clk,
    input j,
    input k,
    output Q);
    
    wire d;
    
    assign d = (j&!Q)|(!k&Q);
    d_ff (d, clk, Q);

endmodule

module d_ff (input d, clk,
             output reg q);
    
    always @ (posedge clk)
        begin
            q <= d;
        end
endmodule