module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q
);
    
    reg[3:0]q0;
    reg[3:0]q1;
    reg[3:0]q2;
    reg[3:0]q3;
    
    wire [3:1]en;
    
    dec_counter d1 (clk, 1'b1, reset, q0);
 
    assign ena[1] = (q0 == 4'd9) ? 1'b1 : 1'b0;
    
    assign en[1] = ena[1];
    
    dec_counter d2 (clk, en[1], reset, q1);
    
    assign ena[2] = ((q0 == 4'd9)&&(q1 == 4'd9)) ? 1'b1 : 1'b0;
    
    assign en[2] = ena[2];
    
    dec_counter d3 (clk, en[2], reset, q2); 
    
    assign ena[3] = ((q0 == 4'd9)&&(q1 == 4'd9)&&(q2 == 4'd9)) ? 1'b1 : 1'b0;
    
    assign en[3] = ena[3];
    
    dec_counter d4 (clk, en[3], reset, q3);
        
    assign q = {q3,q2,q1,q0};

endmodule

module dec_counter (
    input clk,
    input en,
    input reset,
    output [3:0] q);
    
    always @ (posedge clk)
        begin
            if (reset)
                q <= 4'b0;
            else if (en)
                q <= (q == 9)? 4'b0 : (q + 1'b1);
        end

endmodule