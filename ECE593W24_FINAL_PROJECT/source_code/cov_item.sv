///////////////////////////////////////////////////////////////////////////
//Project Name: Design and Verification of Asynchronous FIFO using UVM   //
//File Name:cov_item.sv                                                  //
//Authors: Shiva Prasad Balne, Ram Gopal Kasireddy, Praveen Kumar Palli  //
//Description: coverage item class with signals from read and write      //
//			   sequence items and further used in coverage class         //
//																		 //
///////////////////////////////////////////////////////////////////////////

class cov_item extends uvm_sequence_item;
	rand bit wr_req;
	rand bit rd_req;
    rand bit [31:0] data_in;
	
  	bit [31:0] data_out;
	bit fifo_full, fifo_empty;
	rand bit rrst, wrst;
  
  function new(input string name = "cov_item");
    super.new(name);
  endfunction
  
  `uvm_object_utils_begin(cov_item)
    `uvm_field_int(wr_req,UVM_ALL_ON)
    `uvm_field_int(rd_req,UVM_ALL_ON)
	`uvm_field_int(data_in,UVM_ALL_ON)
	`uvm_field_int(data_out,UVM_ALL_ON)
	`uvm_field_int(fifo_full,UVM_ALL_ON)
	`uvm_field_int(fifo_empty,UVM_ALL_ON)
	`uvm_field_int(wrst,UVM_ALL_ON)
	`uvm_field_int(rrst,UVM_ALL_ON)
  `uvm_object_utils_end
endclass


