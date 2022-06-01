module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss
);
    
    reg[3:0]ss1;
    reg[3:0]ss2;
    reg[3:0]mm1;
    reg[3:0]mm2;
    reg[3:0]hh1;
    reg[3:0]hh2;
       
    always@(posedge clk)begin
        if(reset)
            pm = 1'b0;
        else if((hh1 == 4'd1)&&(hh2 == 4'd1)&&(ss2 == 4'd5)&&(ss1 == 4'd9)&&(mm2 == 4'd5)&&(mm1 == 4'd9))
            pm <= ~pm;
    end
    
    always@(posedge clk)
        begin
        	if(reset)
            	ss1 <= 4'b0;
        	else if(ena)
            	begin
					if(ss1 == 4'd9)
            			ss1 <= 4'd0;
        			else 
           	 			ss1 <= ss1 + 1'b1;
        		end
    	end  
    
    always@(posedge clk)
        begin
        	if(reset)
            	ss2 <= 4'b0;
            else if(ena)
                begin
                    if((ss2 == 4'd5)&&(ss1 == 4'd9))
                        ss2 <= 4'd0;
                    else if(ss1 == 4'd9)
                        ss2 <= ss2 + 1'b1;
                end
    	end  
    
     always@(posedge clk)
         begin
            if(reset)
                mm1 <= 4'b0;
            else if(ena)
                begin
                    if((mm1 == 4'd9)&&(ss2 == 4'd5)&&(ss1 == 4'd9))
                        mm1 <= 4'd0;
                    else if((ss2 == 4'd5)&&(ss1 == 4'd9))
                        mm1 <= mm1 + 1'b1;
         		end
    	end   
    
    always@(posedge clk)begin
        if(reset)
            mm2 <= 4'b0;
        else if(ena)begin
        	if((mm2 == 4'd5)&&(mm1 == 4'd9)&&(ss2 == 4'd5)&&(ss1 == 4'd9))
            	mm2 <= 4'd0;
        	else if((mm1 == 4'd9)&&(ss2 == 4'd5)&&(ss1 == 4'd9))
            	mm2 <= mm2 + 1'b1;
        end
    end    

     always@(posedge clk)begin
        if(reset)
            hh1 <= 4'd2;
         else if(ena)begin
        	if((ss2 == 4'd5)&&(ss1 == 4'd9)&&(mm2 == 4'd5)&&(mm1 == 4'd9))
            	if((hh1 == 4'd9)&&(hh2 == 4'd0))
                	hh1 <= 4'd0;
         		else if((hh1 == 4'd2)&&(hh2 == 4'd1))
                	hh1 <= 4'd1;
         		else
            		hh1 <= hh1 + 1'b1;
         end
    end
    
    always@(posedge clk)begin
        if(reset)
            hh2 <= 4'd1;
        else if(ena)begin
        	if((hh2 == 4'd1)&&(hh1 == 4'd2)&&(ss2 == 4'd5)&&(ss1 == 4'd9)&&(mm2 == 4'd5)&&(mm1 == 4'd9))
            	hh2 <= 4'd0;
        	else if((ss2 == 4'd5)&&(ss1 == 4'd9)&&(mm2 == 4'd5)&&(mm1 == 4'd9)&&(hh1 == 4'd9)) 
            	hh2 <= hh2 + 1'b1;
        end
    end  

    assign ss = {ss2,ss1};
    assign mm = {mm2,mm1};
    assign hh = {hh2,hh1};
    
endmodule