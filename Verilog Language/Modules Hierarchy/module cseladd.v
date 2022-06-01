module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire [15:0] sumh1, sumh2;
    wire c1,c2, c3;
    add16 adder1 (a[15:0], b[15:0], 1'b0, sum[15:0], c3);
    add16 adder2 (a[31:16], b[31:16], 1'b0, sumh1, c1);
    add16 adder3 (a[31:16], b[31:16], 1'b1, sumh2, c2);
    
    always @ (*)
        begin
            case(c3)
                1'b0: sum[31:16] = sumh1;
                1'b1: sum[31:16] = sumh2;
            endcase
        end 
    

endmodule