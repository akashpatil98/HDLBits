module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output done
); 
    
    parameter start=3'd0,data_recv = 3'd1, validate=3'd2, wait_for_stop=3'd3;
    
    reg[1:0] current_state, next_state;
    reg [2:0] counter;
    
    always @ (*)
        begin
            case(current_state)
				start: begin
                    next_state = (in == 0)? data_recv : start;
                end
                
                data_recv: begin
                    next_state = (counter == 7)? validate : data_recv;
                end
                
                validate: begin
                    next_state = (in==1) ? start : wait_for_stop;
                end
                
                wait_for_stop: begin
                    next_state = (in==1)? start : wait_for_stop;
                end
                
                default: next_state = start;
            endcase
        end
    
    always @ (posedge clk)
        begin
            if (reset)
                current_state = start;
            else
               	current_state = next_state;
        end
    
    always @ (posedge clk)
        begin
            case (current_state)
                start: begin
                    done <= 0;
                    counter <= 0;
                end
                
                data_recv: begin
                    done <= 0;
                    counter <= counter + 1'b1;
                end
                
                validate: begin
                    counter <= 0;
                    done <= (in == 1) ? 1'b1 : 1'b0;
                end
                
                wait_for_stop: begin
                    counter <= 0;
                	done <= 0;
                end
                
                default: begin
                    counter <= 0;
                    done <= 0;
                end
            endcase
        end

endmodule