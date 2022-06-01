module top_module (
    input clk,
    input in, 
    output out);
    
    wire fb;
    assign fb = out;
    
    always @ (posedge clk)
        begin
            out <= in ^ fb;
        end

endmodule