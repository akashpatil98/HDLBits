module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 

    parameter LEFT = 0, RIGHT = 1, AAAH = 3;
    reg [1:0] state, next_state,state_before_fall;
   
    wire [2:0] sel;
    assign sel = {ground,bump_left,bump_right};
    always@(*) begin
        casex(sel)
            3'b0xx: next_state <= AAAH;
            3'b111: begin
                case(state)
                    LEFT: next_state <= RIGHT;
                    RIGHT: next_state <= LEFT;
                    AAAH: next_state <= state_before_fall;
                endcase
            end
            3'b110: begin
                case(state)
                    AAAH: next_state <= state_before_fall;
                    default:next_state <= RIGHT;
                endcase
            end
            3'b101: begin
                case(state)
                    AAAH: next_state <= state_before_fall;
                    default:next_state <= LEFT;
                endcase
            end
            3'b100:  begin
                case(state)
                    AAAH: next_state <= state_before_fall;
                    default:next_state <= state;
                endcase
            end
        endcase
        /*if(!ground&&(state != AAAH))
            state_before_fall <= state;*/
        if(!ground&&(state == LEFT))
            state_before_fall <= LEFT;
        else if(!ground&&(state == RIGHT))
            state_before_fall <= RIGHT;
    end
    
    always@(posedge clk or posedge areset) begin
        if(areset)
            state <= LEFT;
        else
            state <= next_state;
    end
    
    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);
    assign aaah = (state == AAAH);
endmodule