`default_nettype none
module top_module(
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n   ); 
    
    wire andout1, andout2, orout;
    assign andout1 = a&b;
    assign andout2 = c&d;
    assign orout = andout1 | andout2;
    assign out = orout;
    assign out_n = !orout;

endmodule