`ifndef MY_O_MONITOR
`define MY_O_MONITOR

`include "uvm_macros.svh"
`include "my_transaction.sv"
`include "rtl_if.sv"
import uvm_pkg::*;

class my_o_monitor extends uvm_monitor;
	`uvm_component_utils(my_o_monitor)
	virtual rtl_if vif;
	uvm_analysis_port #(my_transaction) ap;

	function new(string name="",uvm_component parent);
		super.new(name,parent);
		ap=new("ap",this);
		`uvm_info("my_o_monitor","the my_o_monitor new is called!",UVM_LOW)
	endfunction
	
	function void build_phase(uvm_phase phase);
		`uvm_info("my_o_monitor","the my_monitor build_phase is called!",UVM_LOW)
		if(!uvm_config_db#(virtual rtl_if)::get(this,"","rtl_if",vif))	
			`uvm_info("my_o_monitor", "Virtual interface not set",UVM_LOW)
	endfunction

	function void connect_phase(uvm_phase phase);
		`uvm_info("my_o_monitor","the my_o_monitor connect_phase is called!",UVM_LOW)
	endfunction
/*
	task run_phase(uvm_phase phase);
		`uvm_info("my_o_monitor","the my_o_monitor run_phase is called!",UVM_LOW)
		forever begin
			my_transaction tr;
			@(posedge vif.clk);
			if(vif.PalDataOutValid)begin
    				tr = my_transaction::type_id::create("tr");
					tr.SerDataIn = vif.SerDataIn;
					tr.PalDataOut = vif.PalDataOut;
					tr.PalDataOutValid = vif.PalDataOutValid;
				ap.write(tr);
			end
		end
	endtask
*/
   	function void write_input(my_transaction tr);
        	`uvm_info("my_o_monitor","the my_o_monitor write_input is called!",UVM_LOW)
    	endfunction

   	function void write_output(my_transaction tr);
        	`uvm_info("my_o_monitor","the my_o_monitor write_output is called!",UVM_LOW)
    	endfunction
endclass


`endif