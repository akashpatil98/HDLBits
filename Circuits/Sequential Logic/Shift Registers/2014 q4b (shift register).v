module top_module (
    input [3:0] SW,
    input [3:0] KEY,
    output [3:0] LEDR
); 
    MUXDFF D3 (KEY[0], KEY[1], KEY[3], SW[3], KEY[2], LEDR[3]);
    MUXDFF D2 (KEY[0], KEY[1], LEDR[3], SW[2], KEY[2], LEDR[2]);
    MUXDFF D1 (KEY[0], KEY[1], LEDR[2], SW[1], KEY[2], LEDR[1]);
    MUXDFF D0 (KEY[0], KEY[1], LEDR[1], SW[0], KEY[2], LEDR[0]);

endmodule

module MUXDFF (
    input clk,
    input E,
	input w,
	input R,
	input L,
	output Q);
    
    always @ (posedge clk)
        begin
            if (L)
                Q <= R;
            else
                begin
                    if (E)
                        Q <= w;
                    else
                        Q <= Q;
                end
        end
endmodule