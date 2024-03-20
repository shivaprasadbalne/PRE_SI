///////////////////////////////////////////////////////////////////////////
//Project Name: Design and Verification of Asynchronous FIFO using UVM   //
//File Name:base_test.sv                                                 //
//Authors: Shiva Prasad Balne, Ram Gopal Kasireddy, Praveen Kumar Palli  //
//Description: Multiple test scenarios are given in order to check       //
//			  fifo behavior                                              //
//																		 //
///////////////////////////////////////////////////////////////////////////


class base_test extends uvm_test;
  `uvm_component_utils(base_test)
  env env_o;
  agent agt_wr;
  read_agent agt_rd;
  
  single_write_seq s_wr_seq;
  single_read_seq s_rd_seq;
  write_reset_seq wr_rst_seq;
  read_reset_seq rd_rst_seq;
  write_reset_down wr_rst_down;
  read_reset_down rd_rst_down;
  fifo_full_seq f_full_seq;
  fifo_empty_seq f_empty_seq;
  few_write_seq sim_wr_seq;
  few_read_seq sim_rd_seq;

  
  function new(string name = "base_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
   function void build_phase(uvm_phase phase);
  `uvm_info(get_type_name, "Build phase of Basetest", UVM_LOW);
    super.build_phase(phase);
    env_o = env::type_id::create("env_o", this);
	agt_wr = agent::type_id::create("agt_wr",this);
	agt_rd = read_agent::type_id::create("agt_rd",this);
	uvm_config_db#(agent)::set(this,"","write_agent_configuration",agt_wr);
	uvm_config_db#(read_agent)::set(this,"","read_agent_configuration",agt_rd);
	
	wr_rst_seq = write_reset_seq::type_id::create("wr_rst_seq");
	rd_rst_seq = read_reset_seq::type_id::create("rd_rst_seq");
	s_wr_seq = single_write_seq::type_id::create("s_wr_seq");
	s_rd_seq = single_read_seq::type_id::create("s_rd_seq");
	wr_rst_down = write_reset_down::type_id::create("wr_rst_down");
	rd_rst_down = read_reset_down::type_id::create("rd_rst_down");
	f_full_seq = fifo_full_seq::type_id::create("f_full_seq");
	f_empty_seq = fifo_empty_seq::type_id::create("f_empty_seq");
	sim_wr_seq = few_write_seq::type_id::create("sim_wr_seq");
	sim_rd_seq = few_read_seq::type_id::create("sim_rd_seq");

  endfunction 
  
  //END OF ELABORATION PHASE
  virtual function void end_of_elaboration_phase(uvm_phase phase);
	super.end_of_elaboration_phase(phase);
	uvm_top.print_topology();
	endfunction: end_of_elaboration_phase
	

virtual task reset_phase(uvm_phase phase);
phase.raise_objection(this);
super.reset_phase(phase);
`uvm_info(get_type_name,"reset phase of base test",UVM_LOW)
wr_rst_seq.start(env_o.agt_wr.seqr);

wr_rst_down.start(env_o.agt_wr.seqr);

rd_rst_seq.start(env_o.agt_rd.rd_seqr);

rd_rst_down.start(env_o.agt_rd.rd_seqr);
phase.drop_objection(this);
endtask 

virtual task main_phase(uvm_phase phase);
super.run_phase(phase);
`uvm_info(get_type_name, "Base test started", UVM_LOW); 
phase.raise_objection(this);


/*  s_wr_seq.start(env_o.agt_wr.seqr);
#20;
wr_rst_down.start(env_o.agt_wr.seqr);
#20;
s_rd_seq.start(env_o.agt_rd.rd_seqr);
#20;
rd_rst_down.start(env_o.agt_rd.rd_seqr);

#20; */
f_full_seq.start(env_o.agt_wr.seqr);
#20;
wr_rst_down.start(env_o.agt_wr.seqr);
#20;
f_empty_seq.start(env_o.agt_rd.rd_seqr);
#20;
rd_rst_down.start(env_o.agt_rd.rd_seqr);

/*
fork

sim_wr_seq.start(env_o.agt_wr.seqr);

sim_rd_seq.start(env_o.agt_rd.rd_seqr); 

join_any
*/

phase.drop_objection(this);
endtask
  
endclass