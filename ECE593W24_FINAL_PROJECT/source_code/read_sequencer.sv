///////////////////////////////////////////////////////////////////////////
//Project Name: Design and Verification of Asynchronous FIFO using UVM   //
//File Name:read_sequencer.sv                                            //
//Authors: Shiva Prasad Balne, Ram Gopal Kasireddy, Praveen Kumar Palli  //
//Description:  Read sequencer class                                     //
//			    													     //
//              							                             //
///////////////////////////////////////////////////////////////////////////

`include "uvm_macros.svh"
import uvm_pkg::*;


class read_seqcr extends uvm_sequencer#(rd_seq_item);
  `uvm_component_utils(read_seqcr)
  
  function new(input string name = "read_seqcr", uvm_component parent = null);
    super.new(name, parent);
  endfunction
 
 
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction 
  
endclass 