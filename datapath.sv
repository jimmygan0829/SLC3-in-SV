//datapath 

module datapath(input logic Clk, Reset,
		input logic LD_MAR, LD_MDR, LD_IR, LD_BEN, LD_CC, LD_REG, LD_PC, LD_LED,
		input logic GatePC, GateMDR, GateALU, GateMARMUX,
		input logic ADDR1MUX, DRMUX, SR1MUX, SR2MUX, 
		input logic MIO_EN,  
		input logic [1:0] PCMUX, ADDR2MUX, ALUK, 
		input logic [15:0] MDR_In,
		output logic BEN_OUT, 
		output logic [15:0] MAR_OUT, MDR_OUT, IR_OUT, PC_OUT,
		output logic [11:0] LED
);

always_ff @ (posedge Clk)
begin
	if (Reset)
		LED <= {12{1'b0}};	//reset LED
	else if (LD_LED)
		LED <= IR_OUT[11:0];
end

logic [15:0] bus_data;
logic[15:0] ADDER_OUTPUT; 
logic[15:0] ADDR1MUX_OUTPUT;
logic[15:0] ADDR2MUX_OUTPUT;
logic[15:0] PCMUX_OUTPUT;
logic[15:0] ALU_OUTPUT;
logic[15:0] SR1_OUT; 
logic[15:0] SR2_OUT; 
logic[15:0] SR2MUX_OUT; 
logic[15:0] MDRMUX_OUT;
logic[3:0] BUS_SELECT;
logic[2:0] DRMUX_OUT, SR1MUX_OUT, NZP;

always_comb
begin
	BUS_SELECT = {GatePC, GateMDR, GateALU, GateMARMUX}; //select gate output
	
	case (BUS_SELECT)
		4'b1000:
			bus_data = PC_OUT;
		4'b0100:
			bus_data = MDR_OUT;
		4'b0010:
			bus_data = ALU_OUTPUT;
		4'b0001:
			bus_data = ADDER_OUTPUT;
		default:
			bus_data = 16'hABCD;
	endcase	
end

mux4to1 pcmux	//pc 4 to 1 mux
(
		.s00(bus_data),
		.s01(ADDER_OUTPUT),
		.s10(PC_OUT + 16'h0001),
		.s11({16{1'bX}}),
		.sel(PCMUX),
		.out(PCMUX_OUTPUT)
);

reg_16 RegPC	//pc register
(		
		.Clk(Clk), 
		.Reset(Reset), 
		.Load(LD_PC), 
		.D_in(PCMUX_OUTPUT), 
		.D_out(PC_OUT)
);


assign ADDER_OUTPUT = ADDR1MUX_OUTPUT + ADDR2MUX_OUTPUT;

mux2to1 addr1mux
(
		.s0(SR1_OUT), 
		.s1(PC_OUT), 
		.sel(ADDR1MUX), 
		.out(ADDR1MUX_OUTPUT)
);

mux4to1 addr2mux
(
		.s00({{5{IR_OUT[10]}}, IR_OUT[10:0]}),
		.s01({{7{IR_OUT[8]}}, IR_OUT[8:0]}),
		.s10({{10{IR_OUT[5]}}, IR_OUT[5:0]}),
		.s11(16'h0000),
		.sel(ADDR2MUX),
		.out(ADDR2MUX_OUTPUT)
);

mux2to1 #(3) drmux
(
		.s0(3'b111), 
		.s1(IR_OUT[11:9]), 
		.sel(DRMUX),
		.out(DRMUX_OUT)
);

mux2to1 #(3) sr1mux
(
		.s0(IR_OUT[11:9]), 
		.s1(IR_OUT[8:6]), 
		.sel(SR1MUX),
		.out(SR1MUX_OUT)
		);

mux2to1 sr2mux
(
		.s0(SR2_OUT), 
		.s1({{11{IR_OUT[4]}}, IR_OUT[4:0]}), 
		.sel(SR2MUX),
		.out(SR2MUX_OUT)
);

regs reg_r0_r7		//register r0-r7
(
		.Clk(Clk),
		.Reset(Reset),
		.LD_REG(LD_REG),
		.DRMUX_OUT(DRMUX_OUT),
		.SR1MUX_OUT(SR1MUX_OUT),
		.SR2(IR_OUT[2:0]),
		.D_in(bus_data),
		.SR1_OUT(SR1_OUT),
		.SR2_OUT(SR2_OUT)
);

ALU alu
(
		.X(SR1_OUT), 
		.Y(SR2MUX_OUT), 
		.sel(ALUK), 
		.out(ALU_OUTPUT)
);

NZP nzp
(
		.Clk(Clk),
		.Reset(Reset),
		.Load(LD_CC),
		.bus(bus_data), 
		.NZP(NZP)
);

regBEN RegBEN
(
		.Clk(Clk), 
		.Reset(Reset),
		.Load(LD_BEN), 
		.IR_nzp(IR_OUT[11:9]), 
		.CC(NZP), 
		.BEN(BEN_OUT)
);

reg_16 RegMAR
(		
		.Clk(Clk), 
		.Reset(Reset), 
		.Load(LD_MAR), 
		.D_in(bus_data), 
		.D_out(MAR_OUT) 
);

mux2to1 mdrmux
(
		.s0(bus_data), 
		.s1(MDR_In), 
		.sel(MIO_EN),
		.out(MDRMUX_OUT)
);

reg_16 RegMDR
(		
		.Clk(Clk), 
		.Reset(Reset), 
		.Load(LD_MDR), 
		.D_in(MDRMUX_OUT), 
		.D_out(MDR_OUT)
);

reg_16 RegIR
(		
		.Clk(Clk), 
		.Reset(Reset), 
		.Load(LD_IR), 
		.D_in(bus_data), 
		.D_out(IR_OUT)
);

endmodule