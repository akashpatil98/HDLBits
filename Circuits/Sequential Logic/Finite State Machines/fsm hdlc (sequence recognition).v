module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err);
    
    parameter none=4'd0, one = 4'd1, two = 4'd2, three = 4'd3;
    parameter four = 4'd4, five = 4'd5, six = 4'd6, error = 4'd7;
    parameter flag_frame=4'd8, discard=4'd9;
    
    reg [4:0]state;
    reg [4:0]next_state;
    
    /*State transition logic*/
    always @ (*)
        begin
            case(state)
                none: begin
                    next_state = (in == 1) ? one : none;
                end
                
                one: begin
                    next_state = (in == 1) ? two : none;
                end
                
                two: begin
                    next_state = (in == 1) ? three : none;
                end
                
                three: begin
                    next_state = (in == 1) ? four : none;
                end
                
                four: begin
                    next_state = (in == 1) ? five : none;
                end
                
                five: begin
                    next_state = (in == 1) ? six : discard;
                end
                
                six: begin
                    next_state = (in == 1) ? error : flag_frame;
                end
                
                discard: begin
                    next_state = (in == 1) ? one : none;
                end
                
                flag_frame: begin
                    next_state = (in == 1) ? one : none;
                end
                
                error: begin
                    next_state = (in == 1) ? error : none;
                end
                
                default: begin
                    next_state = none;
                end
            endcase
        end
    
    always @ (posedge clk)
        begin
            if (reset)
                state <= none;
            else
                state <= next_state;
        end
    
    always @ (posedge clk)
        begin
            if (reset)
                begin
                    disc <= 0;
                    flag <= 0;
                    err <= 0;
                end
            else begin
            case (next_state)
                error : begin
                    disc <= 0;
                    flag <= 0;
                    err <= 1;
                end
                
                flag_frame : begin
                    disc <= 0;
                    flag <= 1;
                    err <= 0;
                end
                
                discard : begin
                    disc <= 1;
                    flag <= 0;
                    err <= 0;
                end
                
                default : begin
                    disc <= 0;
                    flag <= 0;
                    err <= 0;
                end
            endcase
        end
        end

endmodule