///////////////////////////////////////////////////////////////////////////
//Project Name: Design and Verification of Asynchronous FIFO using UVM   //
//File Name:driver.sv                                          //
//Authors: Shiva Prasad Balne, Ram Gopal Kasireddy, Praveen Kumar Palli  //
//Description: write_driver class to drive write transactions to the     //
//			   DUT's interface                                           //
//             driver -- write_driver	                                 //
//			   seq_item -- write_sequence_item							 //
///////////////////////////////////////////////////////////////////////////


`include "uvm_macros.svh"
import uvm_pkg::*;
class driver extends uvm_driver#(seq_item);

//interface to connect with DUT
  virtual tintf vif;
  `uvm_component_utils(driver)
  seq_item req;
  
  //Constructor
  function new(string name = "driver", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
   `uvm_info("[DRIVER]","build Phase of write driver",UVM_LOW)
    super.build_phase(phase);
    if(!uvm_config_db#(virtual tintf) :: get(this, "", "tintf_i", vif))
      `uvm_fatal(get_type_name(), "Not set at top level");
  endfunction
  
  virtual task run_phase (uvm_phase phase);
  `uvm_info("[DRIVER]","run Phase of write driver",UVM_LOW)
  super.run_phase(phase);
  req= seq_item::type_id::create("req");
    forever begin
      seq_item_port.get_next_item(req);
	  @(posedge vif.w_clk);
		`uvm_info(get_type_name, "Write driving to DUT", UVM_LOW);
		`uvm_info(get_type_name(), $sformatf("Driving write transaction: time = %0t  data_in = %h, wrst: %0d, wr_req: %0d",$time, req.data_in, req.wrst, req.wr_req), UVM_NONE);
		vif.wr_req <= req.wr_req;
		vif.data_in<= req.data_in;
		vif.wrst <= req.wrst;
      seq_item_port.item_done();
    end
  endtask
  
endclass
