`ifndef MY_MODEL
`define MY_MODEL

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "my_transaction.sv"

class my_model extends uvm_component;
  uvm_analysis_imp #(my_transaction, my_model) imp;
  uvm_analysis_port #(my_transaction) ap;

  `uvm_component_utils(my_model)

function new(string name, uvm_component parent);
	super.new(name, parent);
	imp = new("imp", this);
	ap  = new("ap", this);
	`uvm_info("my_model","the my_model new is called!",UVM_LOW)
endfunction


function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	`uvm_info("my_model","the my_model build_phase is called!",UVM_LOW)
endfunction

function void write(my_transaction tr);
    	my_transaction exp_tr;
	`uvm_info("my_model","the my_model write is called!",UVM_LOW)
    	exp_tr = my_transaction::type_id::create("exp_tr");
    	exp_tr.parity_bit = ~^tr.data;
    	exp_tr.data       = tr.data;
    	ap.write(exp_tr);
endfunction
endclass

`endif