`ifndef RTL_IF
`define RTL_IF
`timescale 1ns/1ps
interface rtl_if();
	
	logic Clk;
	logic Rstn;

	logic SerDataIn;
	logic [8:0] PalDataOut;
	logic PalDataOutValid;


	logic [7:0] PalDataIn;
	logic PalDataInEn;
	logic PalDataInPermit;
	logic SerDataOut;


	localparam   CLK_PERIOD  = 82;    // 20ns = 50MHz | 12.288MHz=81.38ns
	localparam   BIT_PERIOD  = 3906;  // 256000bps = 3.906us (195 cycles)

  
  	initial Clk = 0;
  	always #(CLK_PERIOD/2) Clk = ~Clk;
	
	
  	initial begin
    	Rstn = 0;
    	#100 Rstn = 1;
  	end

endinterface

`endif
