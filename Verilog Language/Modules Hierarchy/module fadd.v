module top_module (
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);//
    wire cout1, cout2;
    add16 sum1 (a[15:0], b[15:0], 1'b0, sum[15:0], cout1);
    add16 sum2 (a[31:16], b[31:16], cout1, sum[31:16], cout2);
endmodule

module add1 ( input a, input b, input cin,   output sum, output cout );

// Full adder module here
    assign sum = a^b^cin;
    assign cout = (a&b)|(b&cin)|(cin&a);

endmodule