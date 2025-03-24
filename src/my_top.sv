 `timescale 1ns/1ps

`include "uvm_macros.svh"
`include "my_test.sv"
`include "rtl_if.sv"
`include "Uart.sv"
import uvm_pkg::*;


module my_top;

  	rtl_if dif(.*);

  	Uart dut(
	.Clk(dif.Clk), 
	.Rstn(dif.Rstn), 
	.SerDataIn(dif.SerDataIn), 
	.PalDataOut(dif.PalDataOut), 
	.PalDataOutValid(dif.PalDataOutValid),
	.PalDataIn(dif.PalDataIn),
	.PalDataInEn(dif.PalDataInEn),
	.PalDataInPermit(dif.PalDataInPermit),
	.SerDataOut(dif.SerDataOut)
	);

	initial begin
		`uvm_info("my_top","my_top,begin!",UVM_LOW)
		uvm_config_db#(virtual rtl_if)::set(null, "*", "rtl_if", dif);
		run_test("my_test");
		`uvm_info("my_top","my_top,end!",UVM_LOW)
	end

 
	initial begin
		dif.Rstn = 0;
    		#10 dif.Rstn = 1;
		//$finish;
  	end

endmodule