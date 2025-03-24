
`ifndef MY_DRIVER
`define MY_DRIVER

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "my_transaction.sv"
`include "rtl_if.sv"


class my_driver extends uvm_driver#(my_transaction);
	`uvm_component_utils(my_driver)
	virtual rtl_if vif;
	//my_transaction req;
	int count=0;

	function new(string name="my_driver",uvm_component parent);
		super.new(name,parent);
		`uvm_info("my_driver","the my_driver new is called!",UVM_LOW)
	endfunction

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(virtual rtl_if)::get(this, "", "rtl_if", vif))
    			`uvm_info("my_driver", "Virtual interface not set",UVM_LOW)
		`uvm_info("my_driver","the my_driver build_phase is called!",UVM_LOW)
	endfunction

	virtual function void connect_phase(uvm_phase phase);
		`uvm_info("my_driver","the my_driver connect_phase is called!",UVM_LOW)
	endfunction

	virtual task run_phase(uvm_phase phase);
		`uvm_info("my_driver","the my_driver run_phase is called!",UVM_LOW)
		forever begin
		count++;
		`uvm_info("my_driver", $sformatf("the count = %0d",count),UVM_LOW)
    		seq_item_port.get_next_item(req);
		drive_packet(req);
    		seq_item_port.item_done();
  		end
	endtask


	task drive_packet(my_transaction req);
		/*
		`uvm_info("my_driver",$sformatf("drive_packet, PalDataInPermit=%d",vif.PalDataInPermit),UVM_LOW)
		wait(vif.PalDataInPermit==1);
		`uvm_info("my_driver",$sformatf("drive_packet, PalDataInPermit=%d",vif.PalDataInPermit),UVM_LOW)
		`uvm_info("my_driver",$sformatf("drive_packet, %d_%d_%d | %d_%d_%d",
			vif.SerDataIn,vif.PalDataOut,vif.PalDataOutValid,vif.PalDataIn,vif.PalDataInEn,vif.SerDataOut),UVM_LOW)

		@(posedge vif.Clk);
    		vif.PalDataIn <= req.data;
    		vif.PalDataInEn <= 1;
		@(posedge vif.Clk);
    		vif.PalDataInEn <= 0;
		*/
		send_parallel(req.data);
    		send_serial({req.parity_bit, req.data});
	endtask
	
	task send_parallel(bit [7:0] frame);
		`uvm_info("my_driver",$sformatf("drive_packet, PalDataInPermit=%d",vif.PalDataInPermit),UVM_LOW)
		wait(vif.PalDataInPermit==1);
		`uvm_info("my_driver",$sformatf("drive_packet, PalDataInPermit=%d",vif.PalDataInPermit),UVM_LOW)

		`uvm_info("my_driver",$sformatf("drive_packet vif: %d_%d | %d_%d | %d_%d",
			vif.PalDataOut[7:0],vif.PalDataOutValid,vif.PalDataIn,vif.PalDataInEn,vif.SerDataIn,vif.SerDataOut),UVM_LOW)
		`uvm_info("my_driver",$sformatf("drive_packet data, data=%d",frame),UVM_LOW)

		@(posedge vif.Clk);
    		vif.PalDataIn <= frame;
    		vif.PalDataInEn <= 1;
		@(posedge vif.Clk);
    		vif.PalDataInEn <= 0;
	endtask

	task send_serial(bit [8:0] frame);
    		vif.SerDataIn = 0;
    		#vif.BIT_PERIOD;

    		for (int i=0; i<8; i++) begin
      			vif.SerDataIn = frame[i];
      			#vif.BIT_PERIOD;
    		end

    		vif.SerDataIn = frame[8];
    		#vif.BIT_PERIOD;

    		vif.SerDataIn = 1;
    		#vif.BIT_PERIOD;
  	endtask
endclass

`endif