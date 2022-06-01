module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
); 
    reg [2:0]next;  //holds the next value of flow rates 
    reg [2:0]state; //holds the value of current value of flow rates
    
	always @(posedge clk)
		begin
			if(reset)
				state <= 3'b111;
			else
				state <= next;
        end
    
    /*Next flow rate logic*/
    always @ (*)
        begin
            //based on sensor inputs, change the flow rates
            case(s)
                3'b000: next <= 3'b111;
                3'b001: next <= 3'b011;
                3'b011: next <= 3'b001;
                3'b111: next <= 3'b000;
                default: next <= 3'b111;
            endcase
        end
    
    assign {fr3, fr2, fr1} = state;
    
    /*dfr logic*/
    always @ (posedge clk)
        begin
            if (reset)
                dfr <= 1;
            else begin
                if (state > next)
                    dfr <= 0;
                else if (state < next)
                    dfr <= 1;
                else
                    dfr <= dfr;
            end
        end

endmodule