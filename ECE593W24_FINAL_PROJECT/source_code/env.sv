///////////////////////////////////////////////////////////////////////////
//Project Name: Design and Verification of Asynchronous FIFO using UVM   //
//File Name:env.sv                                                       //
//Authors: Shiva Prasad Balne, Ram Gopal Kasireddy, Praveen Kumar Palli  //
//Description: environment class consisting of both read and write       //
//			   agents, coverage and scoreboard                           //
//                                                                       //
///////////////////////////////////////////////////////////////////////////

class env extends uvm_env;
  `uvm_component_utils(env)
  agent agt_wr;
  read_agent agt_rd;
  coverage cov;
  scoreboard sb;
  real cov_score;

 
  function new(string name = "env", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agt_wr = agent::type_id::create("agt_wr", this);
	agt_rd = read_agent::type_id::create("agt_rd", this);
	cov = coverage::type_id::create("cov", this);
	
	
    sb = scoreboard::type_id::create("sb", this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
	agt_wr.mon.item_collect_port.connect(sb.write_scoreboard_port);
	agt_rd.rd_mon.item_collect_port.connect(sb.read_scoreboard_port);
	agt_wr.mon.item_collect_port.connect(cov.write_coverage_port);
	agt_rd.rd_mon.item_collect_port.connect(cov.read_coverage_port);
	
  endfunction
 
  

virtual function void extract_phase(uvm_phase phase);
	
    if (!uvm_config_db#(real)::get(this,"","cov_score",cov_score))
        `uvm_error("EXTRACT_PHASE", "Failed to retrieve cov_score");
	`uvm_info("COV_SCORE",$sformatf("Coverage= %0f%%", cov_score),UVM_NONE);
 

endfunction


virtual function void report_phase(uvm_phase phase);
super.report_phase(phase);

`uvm_info("COV_SCORE",$sformatf("Coverage= %0f%%",cov_score),UVM_LOW);
endfunction 
endclass

