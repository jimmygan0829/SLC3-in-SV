module regBEN (input logic Clk, 
					 input logic Reset, 
					 input logic Load,
					input logic [2:0] IR_nzp, 
					input logic [2:0] CC, 
					output logic BEN);

    logic BEN_output;

    always_ff @ (posedge Clk)
    begin
	 	 if (Reset) 						
			  BEN <= 1'b0;
		 else if (Load)
			  BEN <= BEN_output;
    end

    always_comb
    begin
			BEN_output = 1'b0;					// Default 
			
		if ((IR_nzp[0] & CC[0]) | (IR_nzp[1] & CC[1]) | (IR_nzp[2] & CC[2]))
		
			BEN_output = 1'b1;
    end										//checking if the condition code matches

endmodule