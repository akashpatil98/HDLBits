module top_module ( input clk, input d, output q );
    wire d1_out, d2_out;
    
    my_dff d1 (.clk(clk), .d(d), .q(d1_out));
    my_dff d2 (.clk(clk), .d(d1_out), .q(d2_out));
    my_dff d3 (.clk(clk), .d(d2_out), .q(q));

endmodule