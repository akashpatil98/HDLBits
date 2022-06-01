module fadd (input a, b, cin, 
             output cout, sum);
    assign cout = a&b | b&cin | cin&a;
    assign sum = a^b^cin;
endmodule

module top_module (
    input [3:0] x,
    input [3:0] y, 
    output [4:0] sum);
    
    wire [3:0]cout;
    
    fadd u0 (x[0], y[0], 1'b0, cout[0], sum[0]);
    fadd u1 (x[1], y[1], cout[0], cout[1], sum[1]);
    fadd u2 (x[2], y[2], cout[1], cout[2], sum[2]);
    fadd u3 (x[3], y[3], cout[2], cout[3], sum[3]);
    
    assign sum[4] = cout[3];

endmodule