module NZP (input logic Clk, Reset, Load, 
	    input logic [15:0] bus,
	    output logic [2:0] NZP);				//get the condition code out accordingly

always_ff @ (posedge Clk)
begin
	if (Load==1'b1)
	begin
		if (bus == 16'h0000)
		begin
			NZP <= 3'b010;
		end

		else
		begin
		if(bus[15] == 1'b0)	
				
				begin
					NZP <= 3'b001;
				end
			else
				begin
					NZP <= 3'b100;
				end
		      
	       end
      end
end


	
	

endmodule
