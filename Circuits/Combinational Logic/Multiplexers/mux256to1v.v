module top_module( 
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out );
    
    int index;
    always @ (*)
        begin
            index = sel;
            out = in[index*4+:4]; //vector[LSB+:width]
        end

endmodule