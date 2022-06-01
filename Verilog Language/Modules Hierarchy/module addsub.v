module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);
    wire cout, dummy;
    wire [31:0] negate;
    
    add16 adder3 (a[15:0], negate[15:0], sub, sum[15:0], cout);
    add16 adder4 (a[31:16], negate[31:16], cout, sum[31:16], dummy);
    
    always @ (*)
        begin
            case (sub)
                1'b0: negate = b;
                1'b1: negate = b ^ ({32{sub}});
            endcase
        end
endmodule