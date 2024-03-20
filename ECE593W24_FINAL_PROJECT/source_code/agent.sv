///////////////////////////////////////////////////////////////////////////
//Project Name: Design and Verification of Asynchronous FIFO using UVM   //
//File Name:agent.sv                                                     //
//Authors: Shiva Prasad Balne, Ram Gopal Kasireddy, Praveen Kumar Palli  //
//Description:write_agent class for building & connecting write_driver,  //
//			  write_sequencer and write_monitor components.              //
//	driver -- write_driver                                               //
//	seqcr -- write_sequencer                                             //
//	monitor -- write_monitor                                             //
//                                                                       //
///////////////////////////////////////////////////////////////////////////

class agent extends uvm_agent;
  `uvm_component_utils(agent)
  driver drv;
  seqcr seqr;
  monitor mon;
  
  //Constructor
  function new(string name = "agent", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  //Build phase: Initializing and building write_driver, write_sequencer and write_monitor
  function void build_phase(uvm_phase phase);
  `uvm_info("[agent]","build Phase of agent",UVM_LOW)
    super.build_phase(phase);
    
    if(get_is_active == UVM_ACTIVE) begin //Build only if the write_agent is active
      drv = driver::type_id::create("drv", this);
      seqr = seqcr::type_id::create("seqr", this);
    end
    
    mon = monitor::type_id::create("mon", this);
  endfunction
  
  //Connect phase: Establish connection between components
  function void connect_phase(uvm_phase phase);
  `uvm_info(" [AGENT] ","connect phase of agent",UVM_LOW)
    if(get_is_active == UVM_ACTIVE) begin 
      drv.seq_item_port.connect(seqr.seq_item_export); //connect write_driver to write_sequencer
    end
  endfunction
endclass