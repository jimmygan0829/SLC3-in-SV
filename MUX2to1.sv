module mux2to1 #(parameter width = 16) //2 to 1 mux
(
	input logic [width-1:0] s0, s1,
   input logic sel,							//input select bit
   output logic [width-1:0] out
);

always_comb
begin
	case (sel)
	       1'b0:
		       out = s0;
	       1'b1:
		       out = s1;
   endcase
end

endmodule