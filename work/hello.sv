`timescale 1ns/1ps
`include "uvm_macros.svh"
 
import uvm_pkg::*;
module hello;
 	initial begin
	#10
	`uvm_info("info","hello world!!!",UVM_LOW)
	end
endmodule