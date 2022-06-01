module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output [31:0] out
);
    reg [31:0] temp;
	always @(posedge clk) begin
		temp <= in;
		if(reset)
			out <= 32'b0;
		else
			out <= (temp & ~in) | out;
	end


endmodule