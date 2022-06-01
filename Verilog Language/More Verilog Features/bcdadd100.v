module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum );
    
    wire [99:0]carry;
    
    genvar i;
    
    generate
        bcd_fadd init (a[3:0], b[3:0], cin, carry[0], sum[3:0]);
        for (i=4; i<400; i=i+4) begin: bcd_fadd_list
            bcd_fadd u0 (a[i+3:i], b[i+3:i], carry[i/4-1], carry[i/4], sum[i+3:i]);
        end
    endgenerate
    
    assign cout = carry[99];

endmodule