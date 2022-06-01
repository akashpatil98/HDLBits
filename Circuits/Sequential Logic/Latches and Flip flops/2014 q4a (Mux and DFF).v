module top_module (
    input clk,
    input w, R, E, L,
    output Q
);
    wire qn;
    assign qn = Q;
    
    always @ (posedge clk)
        begin
            Q <= L? R : (E ? w : qn);
        end

endmodule