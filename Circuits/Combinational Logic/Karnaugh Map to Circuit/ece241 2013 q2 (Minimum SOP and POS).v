module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
); 
    
    assign out_sop = (c&d) | (!a & c & !b);
    assign out_pos = (c) & (d | !a) & (!b | d);

endmodule