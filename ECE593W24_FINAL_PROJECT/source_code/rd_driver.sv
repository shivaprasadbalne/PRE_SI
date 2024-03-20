///////////////////////////////////////////////////////////////////////////
//Project Name: Design and Verification of Asynchronous FIFO using UVM   //
//File Name:rd_driver.sv                                                 //
//Authors: Shiva Prasad Balne, Ram Gopal Kasireddy, Praveen Kumar Palli  //
//Description:  Read driver class where read sequence item is driven     //
//			    from read sequencer                                      //
//              								                         //
///////////////////////////////////////////////////////////////////////////

`include "uvm_macros.svh"
import uvm_pkg::*;
class read_driver extends uvm_driver#(rd_seq_item);
  virtual tintf vif;
  `uvm_component_utils(read_driver)
   rd_seq_item rd_pkt;
  
  function new(string name = "read_driver", uvm_component parent = null);
 
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
   `uvm_info("[read_driver]","build Phase of read_driver",UVM_LOW)
    super.build_phase(phase);
    if(!uvm_config_db#(virtual tintf) :: get(this, "", "tintf_i", vif))
      `uvm_fatal(get_type_name(), "Not set at top level");
  endfunction
  
  virtual task run_phase (uvm_phase phase);
  `uvm_info("[read_driver]","run Phase of read_driver",UVM_LOW)
  super.run_phase(phase);
  rd_pkt= rd_seq_item::type_id::create("rd_pkt");
    forever begin
      seq_item_port.get_next_item(rd_pkt);
	  @(posedge vif.r_clk);
	 
		`uvm_info(get_type_name, "read driving to DUT", UVM_LOW);
		`uvm_info(get_type_name, $sformatf("rd_req = %0d, rrst = %0b,", rd_pkt.rd_req, rd_pkt.rrst), UVM_LOW);
		
		vif.rd_req <= rd_pkt.rd_req;
		vif.rrst <= rd_pkt.rrst;
	  @(posedge vif.r_clk);
	  vif.rd_req <= 0;
	  @(posedge vif.r_clk);
      seq_item_port.item_done();
    end
  endtask
  
endclass