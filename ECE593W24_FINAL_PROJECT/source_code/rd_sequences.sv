///////////////////////////////////////////////////////////////////////////
//Project Name: Design and Verification of Asynchronous FIFO using UVM   //
//File Name:rd_sequences.sv                                              //
//Authors: Shiva Prasad Balne, Ram Gopal Kasireddy, Praveen Kumar Palli  //
//Description:Read sequence where sequences for reads are provided       //
//			  including resets                                           //
//																		 //
///////////////////////////////////////////////////////////////////////////


`include "uvm_macros.svh"
import uvm_pkg::*;

//SEQUENCE FOR READ
class single_read_seq extends uvm_sequence#(rd_seq_item);
  `uvm_object_utils(single_read_seq)
  
  rd_seq_item rd_pkt;
  
  function new (input string name = "single_read_seq");
    super.new(name);
  endfunction

  virtual task body();
  bit [31:0] count;
  repeat(5) begin
    rd_pkt = rd_seq_item::type_id::create("rd_pkt"); 
	start_item(rd_pkt);
	void'(rd_pkt.randomize()with {rd_req == 1'b1; rrst == 0; });

    `uvm_info(get_type_name(), $sformatf("Starting read transaction: rd_req = %b, rrst:%0d", rd_pkt.rd_req, rd_pkt.rrst), UVM_MEDIUM)
        
    finish_item(rd_pkt);
	
  end
	`uvm_info(get_type_name(), $sformatf("End of read transaction"), UVM_MEDIUM)
  endtask
endclass

//read reset sequence

class read_reset_seq extends uvm_sequence#(rd_seq_item);
  `uvm_object_utils(read_reset_seq)
  

  rd_seq_item rd_pkt;
  
  function new (input string name = "read_reset_seq");
    super.new(name);
  endfunction

  virtual task body();
  bit [31:0] count;
  repeat(5) begin
    rd_pkt = rd_seq_item::type_id::create("rd_pkt"); 
	start_item(rd_pkt);
	void'(rd_pkt.randomize()with { rrst == 1; });

    `uvm_info(get_type_name(), $sformatf("Starting read reset transaction: rd_req = %b, rrst:%0d", rd_pkt.rd_req, rd_pkt.rrst), UVM_MEDIUM)
        
    finish_item(rd_pkt);
	
  end
	`uvm_info(get_type_name(), $sformatf("End of read reset transaction"), UVM_MEDIUM)
  endtask
endclass

//read reset down sequence

class read_reset_down extends uvm_sequence#(rd_seq_item);
  `uvm_object_utils(read_reset_down)
  
  rd_seq_item rd_pkt;
  
  function new (input string name = "read_reset_down");
    super.new(name);
  endfunction

  virtual task body();
  bit [31:0] count;
  repeat(5) begin
    rd_pkt = rd_seq_item::type_id::create("rd_pkt"); 
	start_item(rd_pkt);
	void'(rd_pkt.randomize()with { rrst == 0; rd_req == 0;});

    `uvm_info(get_type_name(), $sformatf("Starting read reset DOWN transaction: rd_req = %b, rrst:%0d", rd_pkt.rd_req, rd_pkt.rrst), UVM_MEDIUM)
        
    finish_item(rd_pkt);
	
  end
	`uvm_info(get_type_name(), $sformatf("End of read reset DOWN transaction"), UVM_MEDIUM)
  endtask
endclass


// SEQUENCE FOR FIFO EMPTY
class fifo_empty_seq extends uvm_sequence#(rd_seq_item);
  `uvm_object_utils(fifo_empty_seq)
  

  rd_seq_item rd_pkt;
  
  function new (input string name = "fifo_empty_seq");
    super.new(name);
  endfunction

  virtual task body();
  bit [31:0] count;
  repeat(512) begin
    rd_pkt = rd_seq_item::type_id::create("rd_pkt"); 
	start_item(rd_pkt);
	void'(rd_pkt.randomize()with {rd_req == 1'b1; rrst == 0; });

    `uvm_info(get_type_name(), $sformatf("Starting fifo empty transaction: rd_req = %b, rrst:%0d", rd_pkt.rd_req, rd_pkt.rrst), UVM_MEDIUM)
        
    finish_item(rd_pkt);
	
  end
	`uvm_info(get_type_name(), $sformatf("End of fifo empty transaction"), UVM_MEDIUM)
  endtask
endclass

//FEW reads sequence to call it for simultaneous writes and reads

class few_read_seq extends uvm_sequence#(rd_seq_item);
  `uvm_object_utils(few_read_seq)
  
  rd_seq_item rd_pkt;
  
  function new (input string name = "few_read_seq");
    super.new(name);
  endfunction

  virtual task body();
  bit [31:0] count;
  repeat(350) begin
    rd_pkt = rd_seq_item::type_id::create("rd_pkt"); 
	start_item(rd_pkt);
	void'(rd_pkt.randomize()with {rd_req == 1'b1; rrst == 0; });

    `uvm_info(get_type_name(), $sformatf("Starting few read transaction: rd_req = %b, rrst:%0d", rd_pkt.rd_req, rd_pkt.rrst), UVM_MEDIUM)
        
    finish_item(rd_pkt);
	
  end
	`uvm_info(get_type_name(), $sformatf("End of few_read_seq"), UVM_MEDIUM)
  endtask
endclass