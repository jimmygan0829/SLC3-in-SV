//register R0-R7
module regs
(	input logic Clk, Reset, LD_REG,
	input logic [2:0] DRMUX_OUT, SR1MUX_OUT, SR2,
   input logic [15:0]  D_in,
   output logic [15:0]  SR1_OUT, SR2_OUT);

logic[15:0] din[8];
	
always_ff @ (posedge Clk)
begin
	if (Reset) //reset registers
	begin
		din[0] = 16'h0000;
		din[1] = 16'h0000;
		din[2] = 16'h0000;
		din[3] = 16'h0000;
		din[4] = 16'h0000;
		din[5] = 16'h0000;
		din[6] = 16'h0000;
		din[7] = 16'h0000;
	end
	else if (LD_REG)
		din[DRMUX_OUT] = D_in;
end

assign SR1_OUT = din[SR1MUX_OUT];
assign SR2_OUT = din[SR2];

endmodule