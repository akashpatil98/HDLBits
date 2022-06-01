module top_module (
    input clk,
    input enable,
    input S,
    input A, B, C,
    output Z );
    
    reg [7:0]q;
   
    D_FF D0 (clk, enable, S, q[0]);
    genvar i;
    
    generate
        for (i = 0; i<7; i++) begin : DFF_Gen
                D_FF D1 (clk, enable, q[i], q[i+1]);
            end
    endgenerate
    
    always @ (*)
        begin
            case ({A, B, C})
                3'b000: Z<= q[0];
                3'b001: Z<= q[1];
                3'b010: Z<= q[2];
                3'b011: Z<= q[3];
                3'b100: Z<= q[4];
                3'b101: Z<= q[5];
                3'b110: Z<= q[6];
                3'b111: Z<= q[7];
            endcase
        end
endmodule

module D_FF(
    input clk,
    input enable,
    input D,
    output Q);
    
    always @ (posedge clk)
        begin
            if (enable)
            	Q <= D;
            else
                Q <= Q;
        end
endmodule