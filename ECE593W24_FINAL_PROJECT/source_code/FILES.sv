///////////////////////////////////////////////////////////////////////////
//Project Name: Design and Verification of Asynchronous FIFO using UVM   //
//File Name:FILES.sv                                                     //
//Authors: Shiva Prasad Balne, Ram Gopal Kasireddy, Praveen Kumar Palli  //
//Description: enclosed all file names hierarchically for simulation     //
//			                                                             //
//                                                                       //
///////////////////////////////////////////////////////////////////////////

`include "design_interface.sv"
`include "producer.sv"
`include "fifo_mem.sv"
`include "wptr.sv"
`include "rptr.sv"
`include "synchronizer.sv"
`include "consumer.sv"
`include "design.sv"

`include "interface.sv"
//`include "testbench.sv"

//write agent files
`include "seq_item.sv"
`include "read_seq_item.sv"
`include "cov_item.sv"
`include "base_seq.sv"
`include "sequencer.sv"
`include "driver.sv"
`include "monitor.sv"
`include "agent.sv"


//read agent files

`include "rd_sequences.sv"
`include "read_sequencer.sv"
`include "rd_driver.sv"
`include "rd_monitor.sv"
`include "rd_agent.sv"

//scoreboard
`include "new_scoreboard.sv"

`include "unified_cov.sv"

`include "env.sv"
`include "base_test.sv"