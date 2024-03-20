///////////////////////////////////////////////////////////////////////////
//Project Name: Design and Verification of Asynchronous FIFO using UVM   //
//File Name:base_seq.sv                                                  //
//Authors: Shiva Prasad Balne, Ram Gopal Kasireddy, Praveen Kumar Palli  //
//Description:Base sequence where sequences for writes are provided      //
//			  including resets                                           //
//																		 //
///////////////////////////////////////////////////////////////////////////


`include "uvm_macros.svh"
import uvm_pkg::*;


class single_write_seq extends uvm_sequence#(seq_item);
  `uvm_object_utils(single_write_seq)
  seq_item req;
  function new (input string name = "single_write_seq");
    super.new(name);
  endfunction

  task body();
  bit[31:0] count;
   
  repeat(5) begin
  req = seq_item::type_id::create("req");
	start_item(req);
	void'(req.randomize() with { wr_req == 1'b1; wrst==0;});
        
    `uvm_info(get_type_name(), $sformatf("Starting write transaction: time = %0t  data_in = %h, wrst: %0d, wr_req: %0d",$time, req.data_in, req.wrst, req.wr_req), UVM_MEDIUM)
        
    finish_item(req);
	count++;
  end
	`uvm_info(get_type_name(), $sformatf("End of single_write_seq"), UVM_MEDIUM)
  endtask 
endclass

//write reset sequence 
class write_reset_seq extends uvm_sequence#(seq_item);
  `uvm_object_utils(write_reset_seq)
  seq_item req;
  function new (input string name = "write_reset_seq");
    super.new(name);
  endfunction
  

  task body();
  bit[31:0] count;
   
  repeat(5) begin
  req = seq_item::type_id::create("req");
	start_item(req);
	void'(req.randomize() with { wrst==1;data_in == 32'b00000000;});
        
    `uvm_info(get_type_name(), $sformatf("Starting write reset transaction: data_in = %h, wrst: %0d, wr_req: %0d", req.data_in, req.wrst, req.wr_req), UVM_MEDIUM)
        
    finish_item(req);
	count++;
  end
	`uvm_info(get_type_name(), $sformatf("End of write reset sequence"), UVM_MEDIUM)
  endtask 
endclass

//write reset down 
class write_reset_down extends uvm_sequence#(seq_item);
  `uvm_object_utils(write_reset_down)
  seq_item req;
  function new (input string name = "write_reset_down");
    super.new(name);
  endfunction
  

  task body();
  bit[31:0] count;
   
  repeat(5) begin
  req = seq_item::type_id::create("req");
	start_item(req);
	void'(req.randomize() with { wrst==0; wr_req == 0;});
        
    `uvm_info(get_type_name(), $sformatf("Starting write reset  DOWN transaction: data_in = %h, wrst: %0d, wr_req: %0d", req.data_in, req.wrst, req.wr_req), UVM_MEDIUM)
        
    finish_item(req);
	count++;
  end
	`uvm_info(get_type_name(), $sformatf("End of write reset DOWN sequence"), UVM_MEDIUM)
  endtask 
endclass


//SEQUENCE FOR FIFO FULL

class fifo_full_seq extends uvm_sequence#(seq_item);
  `uvm_object_utils(fifo_full_seq)
  seq_item req;
  function new (input string name = "fifo_full_seq");
    super.new(name);
  endfunction

  task body();
  bit[31:0] count;
   
  repeat(512) begin
  req = seq_item::type_id::create("req");
	start_item(req);
	void'(req.randomize() with { wr_req == 1'b1; wrst==0;});
        
    `uvm_info(get_type_name(), $sformatf("Starting fifo_full transaction: time = %0t  data_in = %h, wrst: %0d, wr_req: %0d",$time, req.data_in, req.wrst, req.wr_req), UVM_MEDIUM)
        
    finish_item(req);
	count++;
  end
	`uvm_info(get_type_name(), $sformatf("End of fifo_full_seq"), UVM_MEDIUM)
  endtask 
endclass


//FEW writes to call it for simultaneous writes and reads

class few_write_seq extends uvm_sequence#(seq_item);
  `uvm_object_utils(few_write_seq)
  seq_item req;
  function new (input string name = "few_write_seq");
    super.new(name);
  endfunction

  task body();
  bit[31:0] count;
   
  repeat(250) begin
  req = seq_item::type_id::create("req");
	start_item(req);
	void'(req.randomize() with { wr_req == 1'b1; wrst==0;});
        
    `uvm_info(get_type_name(), $sformatf("Starting few writes transaction: time = %0t  data_in = %h, wrst: %0d, wr_req: %0d",$time, req.data_in, req.wrst, req.wr_req), UVM_MEDIUM)
        
    finish_item(req);
	count++;
  end
	`uvm_info(get_type_name(), $sformatf("End of few_write_seq"), UVM_MEDIUM)
  endtask 
endclass

