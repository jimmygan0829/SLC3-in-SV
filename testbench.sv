module testbench();

timeunit 10ns;	// Half clock cycle at 50 MHz
			// This is the amount of time represented by #1 
timeprecision 1ns;

// These signals are internal because the processor will be 
// instantiated as a submodule in testbench.
logic [15:0] S;
logic Clk = 0;
logic Reset, Run, Continue;
logic [11:0] LED;
logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7;
logic CE, UB, LB, OE, WE;
logic [19:0] ADDR;
wire [15:0] Data;				

// Instantiating the DUT
// Make sure the module and signal names match with those in your design
lab6_toplevel aaaaa(.*);	

// Toggle the clock
// #1 means wait for a delay of 1 timeunit
always begin : CLOCK_GENERATION
#1 Clk = ~Clk;
end

initial begin: CLOCK_INITIALIZATION
    Clk = 0;
end 

// Testing begins here
// The initial block is not synthesizable
// Everything happens sequentially inside an initial block
// as in a software program
initial begin: TEST_VECTORS
Reset = 0;	
Run = 1;
Continue = 1;

#20 Reset  = 1;

S = 16'h0014;

#20 Run = 0;
#20 Run = 1;
#20 S = 16'h0002;
#20 Continue = 0;
#20 Continue = 1;
#20 S = 16'h0003;
#20 Continue = 0;
#20 Continue = 1;



//#40 Run = 0;
//#20 Run = 1;
//
//#20 Continue = 0;
//#40 Continue = 1;
//
//#20 Continue = 0;
//#40 Continue = 1;

end

endmodule
