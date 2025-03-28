`ifndef MY_TRANSACTION
`define MY_TRANSACTION

`include "uvm_macros.svh"
import uvm_pkg::*;

class my_transaction extends uvm_sequence_item;

rand bit [7:0]  data;
rand bit        inject_error;
bit             parity_bit;
//bit             PalDataOutValid;
constraint c_parity{
    parity_bit == ~^data;
    if (inject_error) 
	parity_bit != ~^data;
}

`uvm_object_utils_begin(my_transaction)
	`uvm_field_int(data,UVM_ALL_ON)
	`uvm_field_int(inject_error,UVM_ALL_ON)
	`uvm_field_int(parity_bit,UVM_ALL_ON)
	//`uvm_field_int(PalDataOutValid, UVM_ALL_ON)
`uvm_object_utils_end

function new(string name="my_transaction");
	super.new(name);
	`uvm_info("my_transaction","the my_transaction new is called!",UVM_LOW)
endfunction

endclass

`endif