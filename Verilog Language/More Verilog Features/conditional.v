module top_module (
    input [7:0] a, b, c, d,
    output [7:0] min);//

    wire [7:0] less1, less2;
    assign less1 = (a < b)? a: b;
    assign less2 = (c < d)? c: d;
    assign min = (less1 < less2)? less1 : less2;
    

endmodule