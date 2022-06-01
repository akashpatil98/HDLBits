module cir_a (input x, input y, output z);
    assign z = (x^y) & x;
endmodule
    
module cir_b (input x, input y, output z);
    assign z = !(x ^ y);
endmodule

module top_module (input x, input y, output z);
    wire [3:0]w;
    wire and_out, or_out;
    
    cir_a A1 (x, y, w[0]);
    cir_b B1 (x, y, w[1]);
    assign or_out = w[0] | w[1];
    cir_a A2 (x, y, w[2]);
    cir_b B2 (x, y, w[3]);
    assign and_out = w[2] & w[3];
    
    assign z = and_out ^ or_out;

endmodule