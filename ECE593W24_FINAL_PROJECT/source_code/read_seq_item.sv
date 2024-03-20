///////////////////////////////////////////////////////////////////////////
//Project Name: Design and Verification of Asynchronous FIFO using UVM   //
//File Name:read_sequence_item.sv                                        //
//Authors: Shiva Prasad Balne, Ram Gopal Kasireddy, Praveen Kumar Palli  //
//Description:  Read sequence item class where signals required for read //
//			    are declared to randomise further for generating packets //
//              to enable transaction level of abstracion                //
///////////////////////////////////////////////////////////////////////////

class rd_seq_item extends uvm_sequence_item;
	rand bit rd_req;
  	bit [31:0] data_out;
	bit fifo_empty;
	rand bit rrst;
  
  function new(input string name = "rd_seq_item");
    super.new(name);
  endfunction
  
  `uvm_object_utils_begin(rd_seq_item)
    
    `uvm_field_int(rd_req,UVM_ALL_ON)
	
	`uvm_field_int(fifo_empty,UVM_ALL_ON)
	
	`uvm_field_int(rrst,UVM_ALL_ON)
	
  `uvm_object_utils_end
  
 
endclass