module fadd (input a, b, cin,
             output cout, sum);
    assign cout = a&b | b&cin | cin&a;
    assign sum = a^b^cin;
endmodule

module top_module( 
    input [2:0] a, b,
    input cin,
    output [2:0] cout,
    output [2:0] sum );
    
    genvar i;
    
    generate
        fadd u0 (a[0], b[0], cin, cout[0], sum[0]);
        for (i=1; i<3; i++) begin: fadd_label
            fadd u0 (a[i], b[i], cout[i-1], cout[i], sum[i]);
        end
    endgenerate

endmodule