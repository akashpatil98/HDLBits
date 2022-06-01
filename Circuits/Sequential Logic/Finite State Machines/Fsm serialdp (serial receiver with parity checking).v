module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); 
 	parameter IDLE = 5'd00001; 
    parameter START= 5'd00010;
    parameter DATA = 5'd00100; 
    parameter STOP = 5'd01000;
    parameter WAIT = 5'd10000; 
    reg [4:0] state; 
    reg [4:0] next_state; 
    reg [3:0] count; 
    reg [7:0] par_in; 
    // Data bits are given one by one   There are eight  
    wire Isdone; 
    reg odd_temp; 
    
    //  The first paragraph   Status register  
    always @(posedge clk)
        begin 
            if(reset)begin 
                state <= IDLE; 
            end 
            else begin 
                state <= next_state; 
            end 
        end 
    
    // The second paragraph   Combinational logic describes state transition  
    always @(*)begin 
        case(state) 
            IDLE :begin 
                if(in == 1'b0)
                    next_state = START;
                else
                    next_state = IDLE;
            end
            
            START:begin
                next_state = DATA;
            end
            
            DATA :begin
                if(count == 4'd9)begin // Count 8 Time , explain 8 Data reception completed  
                    if(in == 1'b1) // Stop bit appears 
                        next_state = STOP;
                    else
                        next_state = WAIT; 
                end
                else
                       next_state = DATA;
            end
            STOP :begin
                if(in == 1'b0) 
                    next_state = START; 
                else 
                    next_state = IDLE; 
            end 
            
            WAIT :begin 
                if(in == 1'b0)
                    next_state = WAIT;
                else
                    next_state = IDLE;
            end
            
            default:begin 
                next_state = IDLE;   
            end
        endcase
    end
// The third paragraph describes the output , You can use a always Block to contain all output conditions in different states , Here for 
// Have a clear understanding of each output signal , Divided into three or more different always Block to write .
 
 // Output data receiving register 
    always @(posedge clk)
        begin
        if(reset)
            par_in[count] <= 1'd0; 
        else if(next_state == DATA) 
            par_in[count] <= in; 
        else 
            par_in[count] <= 1'd0;
    end
    
 // Output data 
    always @(posedge clk)begin
        if(reset)
            out_byte <= 8'd0;
        else if(next_state == STOP)
           begin 
            if(odd_temp) // Satisfy parity check and output the received data to the  
                out_byte <= par_in; 
            else 
                out_byte <= 8'd0;
          end  
        else
            out_byte <= 8'd0; 
    end 
    
    //done The signal  
    always @(posedge clk)
        begin 
            if(reset)begin 
                done <= 1'd0;
        end
        else if(next_state == STOP)
            begin //STOP Only nine bits of data have been received , But also check whether it is odd 
            if(odd_temp)
                done <= 1'd1; 
            else 
                done <= 1'd0;
        end
        else
            done <= 1'd0; 
        end 
    
    assign Isdone = (next_state == START); 
    
    parity u0(clk,Isdone,in,odd_temp); 
    
    // Designing counters 
    always @(posedge clk)
        begin 
            if(reset)begin 
                count <= 4'd0;
        end   
        else if (next_state == DATA)
             count <= count + 1'd1; 
            else 
             count <= 4'd0;
     end
     
endmodule