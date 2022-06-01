module top_module(
    input clk,
    input load,
    input [255:0] data,
    output [255:0] q ); 
    
    reg [3:0] counter;
    reg [323:0] data_padding;
    reg [255:0] q_next;
    
    always @ (posedge clk)
        begin
            if (load)
                q <= data;
            else
                q <= q_next;
        end
    
//calculate q_next 
    always @(*) begin 
        data_padding[17:0] = {q[240],q[255:240],q[255]}; 
        data_padding[323:306] = {q[0],q[15:0],q[15]}; 
        for(int i=1;i<17;i++) 
            begin 
                data_padding[i*18 +:18] = {q[(i-1)*16],q[(i-1)*16 +: 16],q[i*16-1]}; 
			end 
        for(int i=1;i<17;i++) 
            begin 
                for(int j=1;j<17;j++) 
                    begin 
                        counter = data_padding[18*i+j-1]+data_padding[18*i+j+1]+data_padding[18*(i-1)+j-1]+data_padding[18*(i-1)+j]+data_padding[18*(i-1)+j+1] +data_padding[18*(i+1)+j-1]+data_padding[18*(i+1)+j]+data_padding[18*(i+1)+j+1]; 
                        case(counter) 
                            2: q_next[16*(i-1)+j-1] <= q[16*(i-1)+j-1];
                            3: q_next[16*(i-1)+j-1] <= 1;
                            default: q_next[16*(i-1)+j-1] <= 0;
                        endcase
					end
             end
     end   

endmodule