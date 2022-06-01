module top_module (
    input clk,
    input reset,
    output [3:0] q);
        
    
    always @ (posedge clk)
        begin
            q <= 4'b1;
            if (reset)
                q <= 4'b1;
            else if (q == 10)
                q <= 4'd1;
            else
                q <= q + 1'b1;
        end
				
endmodule