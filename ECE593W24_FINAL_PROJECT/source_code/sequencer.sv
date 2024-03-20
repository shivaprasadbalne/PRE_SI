///////////////////////////////////////////////////////////////////////////
//Project Name: Design and Verification of Asynchronous FIFO using UVM   //
//File Name:sequencer.sv                                                 //
//Authors: Shiva Prasad Balne, Ram Gopal Kasireddy, Praveen Kumar Palli  //
//Description: write sequencer                                           //
//			                                                             //
//																		 //
///////////////////////////////////////////////////////////////////////////

`include "uvm_macros.svh"
import uvm_pkg::*;


class seqcr extends uvm_sequencer#(seq_item);
  `uvm_component_utils(seqcr)
  
  function new(input string name = "seqcr", uvm_component parent = null);
    super.new(name, parent);
  endfunction
 
 
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction 
  
endclass 