module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output done); //
    
    parameter B1 = 2'b00, B2 = 2'b01, B3 = 2'b10, DONE = 2'b11;
    reg [1:0] state,next;

    // State transition logic (combinational)
    always @ (*)
        begin
            case(state)
                B1: begin
                    if (in[3])
                        next = B2;
                    else
                        next = B1;
                end
                
                B2: next = B3;
                
                B3: next = DONE;
                
                DONE: begin
                    if(in[3])
                        next = B2;
                    else
                        next = B1;
                end
                
                default: next = B1;
            endcase
        end

    // State flip-flops (sequential)
    always @ (posedge clk)
        begin
            if (reset)
                state <= B1;
            else
                state <= next;
        end
 
    // Output logic
    assign done = (state==DONE);

endmodule