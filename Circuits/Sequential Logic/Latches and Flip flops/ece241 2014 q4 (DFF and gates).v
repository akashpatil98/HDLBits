module top_module (
    input clk,
    input x,
    output z
); 
    wire [2:0]d;
    reg [2:0]q = 3'b000;
    
    assign d[0] = q[0]^x;
    assign d[1] = x&~q[1];
    assign d[2] = x|~q[2];
    flip_flop dff1 (d[0],clk,q[0]);
    flip_flop dff2 (d[1],clk,q[1]);
    flip_flop dff3 (d[2],clk,q[2]);
    assign z = ~(q[0]|q[1]|q[2]);
endmodule

module flip_flop (input d,
    input clk,
    output reg q);
    
    always @ (posedge clk) 
        begin
        	q <= d;
    	end
endmodule