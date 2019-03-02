module ALU (input logic [15:0] X,
				input logic [15:0] Y,
            input logic [1:0] sel,
            output logic [15:0] out);

always_comb
begin

	case (sel)
	       2'b00:					// ADD
		       out = X + Y;
	       2'b01:					// AND
		       out = X & Y;
	       2'b10:					// NOT 
		       out = ~X;	       
	       2'b11:					// NOTHING
		       out = X;
       endcase
end

endmodule