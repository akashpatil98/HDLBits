module top_module ( 
    input p1a, p1b, p1c, p1d, p1e, p1f,
    output p1y,
    input p2a, p2b, p2c, p2d,
    output p2y );
    
    wire out1, out2, out3, out4;
	
    assign out1 = p2a & p2b;
    assign out2 = p2c & p2d;
    assign p2y = out1 | out2;
    
    assign out3 = p1a & p1b & p1c;
    assign out4 = p1d & p1e & p1f;
    assign p1y = out3 | out4;

endmodule