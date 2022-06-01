module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    
    parameter A=2'b00,B=2'b01,C=2'b10;
    
    reg [1:0] state,next_state;
    
    always @(*) begin
        case(state)
            A: next_state = x? B:A;
            B: next_state = x? C:B;
            C: next_state = x? C:B;
            default: next_state = A;
        endcase
    end

    always @(posedge clk or posedge areset) begin
        if(areset) begin
            state <= A;
        end
        else begin
            state <= next_state;
        end  
    end
    
    assign z = (state==B)? 1'b1:1'b0;
    
endmodule