module top_module ( 
    input [2:0] vec,
    output [2:0] outv,
    output o2,
    output o1,
    output o0  ); // Module body starts after module declaration
    
    assign o0 = vec[0];
    assign o1 = vec[1];
    assign o2 = vec[2];
    
    assign outv[2:0] = vec[2:0];

endmodule