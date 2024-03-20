///////////////////////////////////////////////////////////////////////////
//Project Name: Design and Verification of Asynchronous FIFO using UVM   //
//File Name:seq_item.sv                                                  //
//Authors: Shiva Prasad Balne, Ram Gopal Kasireddy, Praveen Kumar Palli  //
//Description: write sequence item class for generating random values    //
//			   of signlas required for further randomisation             //
//																		 //
///////////////////////////////////////////////////////////////////////////

class seq_item extends uvm_sequence_item;
	rand bit wr_req;
	//rand bit rd_req;
    rand bit [31:0] data_in;
	
  	//bit [31:0] data_out;
	//rand bit [DATA_WIDTH-1:0] data_in;
	
	//bit [DATA_WIDTH-1:0] data_out;
	//bit fifo_full, fifo_empty;
	bit fifo_full;
	//rand bit rrst, wrst;
	rand bit wrst;
  
  function new(input string name = "seq_item");
    super.new(name);
  endfunction
  
  `uvm_object_utils_begin(seq_item)
    `uvm_field_int(wr_req,UVM_ALL_ON)
    //`uvm_field_int(rd_req,UVM_ALL_ON)
	`uvm_field_int(data_in,UVM_ALL_ON)
	//`uvm_field_int(data_out,UVM_ALL_ON)
	`uvm_field_int(fifo_full,UVM_ALL_ON)
	//`uvm_field_int(fifo_empty,UVM_ALL_ON)
	`uvm_field_int(wrst,UVM_ALL_ON)
	//`uvm_field_int(rrst,UVM_ALL_ON)
  `uvm_object_utils_end
  
  //constraint ip_c {wr_req < 2; rd_req < 2; data_in < 32'hFFFFFFFF;}
endclass


