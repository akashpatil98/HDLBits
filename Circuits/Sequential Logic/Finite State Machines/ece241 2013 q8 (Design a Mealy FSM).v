module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z ); 
    reg [1:0]	state,next_state;
    parameter S0 = 2'd0,S1 = 2'd1,S2 = 2'd2;
    
    always@(posedge clk or negedge aresetn)begin
        if(~aresetn)begin
            state = S0;
        end
        else begin
            state = next_state;
        end
    end
    
    always@(*)begin
        case(state)
            S0:begin
                if(x)begin
                    next_state = S1;
                end
                else begin
                    next_state = S0;
                end
            end
            S1:begin
                if(x)begin
                    next_state = S1;
                end
                else begin
                    next_state = S2;
                end
            end
            S2:begin
                if(x)begin
                    next_state = S1;
                end
                else begin
                    next_state = S0;
                end
            end
        endcase
    end
    assign z = (state == S2 && x);
endmodule