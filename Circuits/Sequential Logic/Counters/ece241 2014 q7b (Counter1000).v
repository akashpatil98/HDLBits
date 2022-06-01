module top_module (
    input clk,
    input reset,
    output OneHertz,
    output [2:0] c_enable
); 
    wire [3:0]Q0;
    wire [3:0]Q1;
    wire [3:0]Q2;
    bcdcount counter0 (clk, reset, c_enable[0], Q0);
    bcdcount counter1 (clk, reset, c_enable[1], Q1);
    bcdcount counter2 (clk, reset, c_enable[2], Q2);
    
    assign c_enable[0] = ~reset;
    assign c_enable[1] = ~reset && (Q0 == 4'd9); 
    assign c_enable[2] = ~reset && (Q0 == 4'd9) && (Q1 == 4'd9);
    
    assign OneHertz = ((Q0 == 4'd9) && (Q1 == 4'd9) && (Q2 == 4'd9)) ? 1'b1 : 1'b0;

endmodule