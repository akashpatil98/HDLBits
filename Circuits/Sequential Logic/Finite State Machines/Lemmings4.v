module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging );
    
    parameter left=3'd0, right=3'd1,fall_l = 3'd2, fall_r = 3'd3, dig_l = 3'd4;
    parameter dig_r = 3'd5, splatter = 3'd6;
    reg [2:0]state,next;
    reg [7:0]fall_count;
    
    always @ (*)
        begin
            case(state)
                left: begin
                    if(ground)
                        begin
                            if(dig)
                                next = dig_l;
                            else
                                next = 	bump_left ? right : left;
                        end
                    else
                        next = fall_l;
                end
                    
                 right: begin
                        	if(ground)
                        		begin
                            		if(dig)
                                		next = dig_r;
                            		else
                                		next = 	bump_right ? left : right;
                        		end
                    		else
                        		next = fall_r;
                 end
                
                fall_l: begin
                    if (!ground)
                        next = fall_l;
                    else
                        begin
                            if (fall_count > 5'd20)
                                next = splatter;
                            else
                                next = left;
                        end
                end
                
                fall_r: begin
                    if (!ground)
                        next = fall_r;
                    else
                        begin
                            if (fall_count > 5'd20)
                                next = splatter;
                            else
                                next = right;
                        end
                end
                
                dig_l: begin
                    if(ground)
                        next = dig_l;
                    else
                        next = fall_l;
                end
                
                dig_r: begin
                    if(ground)
                        next = dig_r;
                    else
                        next = fall_r;
                end
                
                splatter: next = splatter;
                
                default: ;
            endcase            
        end
    
    always@(posedge clk, posedge areset)
        begin
            if(areset)
                state <= left;
            else
                state <= next;
        end
    
    always @ (posedge clk)
        begin
            if(areset)
                fall_count <= 5'd0;
            else
                begin
                    if(!ground)
                        fall_count = fall_count+1;
                    else
                        fall_count = 5'd0;
                end
        end
    
    assign walk_left = (state==left);
    assign walk_right = (state==right);
    assign aaah = (state==fall_l | state==fall_r);
    assign digging = (state==dig_l | state==dig_r);

endmodule