module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //

    parameter B1 = 2'b00, B2 = 2'b01, B3 = 2'b10, DONE = 2'b11;
    reg [1:0] state,next;
    reg [23:0]temp;
    
    // State flip-flops (sequential)
    always @ (posedge clk)
        begin
            if (reset)
                state <= B1;
            else
                state <= next;
        end

    // State transition logic (combinational)
    always @ (*)
        begin
            case(state)
                B1: begin
                    if (in[3]) begin
                        next = B2;
                    end
                    else begin
                        next = B1;
                    end
                end
                
                B2: begin next = B3;
                end
                
                B3: begin 
                    next = DONE;
                end
                
                DONE: begin
                    if(in[3]) begin
                        next = B2;
                    end
                    else
                        next = B1;
                end
                
                default: next = B1;
            endcase
        end


    
    always@(posedge clk) begin
		if (reset) begin
			temp <= 0;
		end
		else begin
			case (state)
				B1: begin
					if(in[3]) begin
						temp [23:16] = in;
					end//in[3]
					else begin
						temp = 0;
					end//else
				end//s0
                
				B2: begin
					temp [15:8] <= in;
				end
				
                B3: begin
					temp [7:0] <= in;
					done <= 1;
				end

                DONE: begin
                    done <= 0;
					if(in[3]) begin
                        temp [23:16] = in;
					end//in[3]
                    else begin
                        temp = 0;
                    end
                end
                
                default: begin
                    temp <= 0;
                end
            endcase
        end
    end
    
 
    // Output logic
    assign out_bytes = done? temp : 23'd0;

endmodule