module top_module (
    input clk,
    input d,
    output q
);
    
     reg temp1, temp2;
	 always @(posedge clk)
		temp1 <= d;
	 
	 always @(negedge clk)
		temp2 <= d;
	 
    always @(temp1 or temp2 or clk) begin
		if(clk)
			q <= temp1;
		else
			q <= temp2;
	 end

endmodule