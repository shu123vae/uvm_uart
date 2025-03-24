`ifndef MY_I_MONITOR
`define MY_I_MONITOR

`include "uvm_macros.svh"
`include "my_transaction.sv"
`include "rtl_if.sv"
import uvm_pkg::*;

class my_i_monitor extends uvm_monitor;
	`uvm_component_utils(my_i_monitor)
	virtual rtl_if vif;
	uvm_analysis_port #(my_transaction) ap;
	
	logic [8:0] out_data;
	int	cnt_data=0;
	function new(string name="",uvm_component parent);
		super.new(name,parent);
		ap=new("ap",this);
		`uvm_info("my_i_monitor","the my_i_monitor new is called!",UVM_LOW)
	endfunction
	
	function void build_phase(uvm_phase phase);
		`uvm_info("my_i_monitor","the my_i_monitor build_phase is called!",UVM_LOW)
		if(!uvm_config_db#(virtual rtl_if)::get(this,"","rtl_if",vif))	
			`uvm_info("my_i_monitor", "Virtual interface not set",UVM_LOW)
	endfunction

	function void connect_phase(uvm_phase phase);
		`uvm_info("my_i_monitor","the my_i_monitor connect_phase is called!",UVM_LOW)
	endfunction

/*
	task run_phase(uvm_phase phase);
		`uvm_info("my_i_monitor","the my_i_monitor run_phase is called!",UVM_LOW)
		forever begin
			my_transaction tr;
			@(posedge vif.clk);
			tr = my_transaction::type_id::create("tr");
			if(vif.SerDataIn!= 'x)begin
				cnt_data++;
				out_data[cnt_data]=vif.SerDataIn;
				if(cnt_data==8)begin
					cnt_data=0;
					tr.PalDataOut = out_data;
					tr.PalDataOutValid = 1;
					ap.write(tr);
				end
			end
		end
	endtask
*/
   	function void write_input(my_transaction tr);
        	`uvm_info("my_i_monitor","the my_i_monitor write_input is called!",UVM_LOW)
    	endfunction

   	function void write_output(my_transaction tr);
        	`uvm_info("my_i_monitor","the my_i_monitor write_output is called!",UVM_LOW)
    	endfunction
endclass


`endif