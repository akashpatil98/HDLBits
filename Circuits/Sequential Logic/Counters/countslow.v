module top_module (
    input clk,
    input slowena,
    input reset,
    output [3:0] q);
    
    always @ (posedge clk)
        begin
            if (reset)
                q <= 4'b0;
            else if (slowena)
                q <= (q == 9)? 4'b0 : (q + 1'b1);
        end

endmodule