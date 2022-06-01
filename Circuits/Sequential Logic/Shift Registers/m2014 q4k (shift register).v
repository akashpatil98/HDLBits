module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output out);
    
    wire [2:0]q;
    
    always @ (posedge clk)
        begin
            if (resetn == 0)
                q[2] <= 1'b0;
            else
                begin
                    q[2] <= in;
                end
        end
    
        always @ (posedge clk)
        begin
            if (resetn == 0)
                q[1] <= 1'b0;
            else
                begin
                    q[1] <= q[2];
                end
        end
    
        always @ (posedge clk)
        begin
            if (resetn == 0)
                q[0] <= 1'b0;
            else
                begin
                    q[0] <= q[1];
                end
        end
    
        always @ (posedge clk)
        begin
            if (resetn == 0)
                out <= 1'b0;
            else
                begin
                    out <= q[0];
                end
        end

endmodule