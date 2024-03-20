///////////////////////////////////////////////////////////////////////////
//Project Name: Design and Verification of Asynchronous FIFO using UVM   //
//File Name:rd_agent.sv                                                  //
//Authors: Shiva Prasad Balne, Ram Gopal Kasireddy, Praveen Kumar Palli  //
//Description:  read agent where read monitor, read driver and read      //
//			    sequencer are defined                                    //
//              							                             //
///////////////////////////////////////////////////////////////////////////

class read_agent extends uvm_agent;
  `uvm_component_utils(read_agent)
  read_driver rd_drv;
  read_seqcr rd_seqr;
  read_monitor rd_mon;
  
  function new(string name = "read_agent", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
  `uvm_info("[read_agent]","build Phase of read_agent",UVM_LOW)
    super.build_phase(phase);
    
    if(get_is_active == UVM_ACTIVE) begin 
      rd_drv = read_driver::type_id::create("rd_drv", this);
      rd_seqr = read_seqcr::type_id::create("rd_seqr", this);
    end
    
    rd_mon = read_monitor::type_id::create("rd_mon", this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
  `uvm_info(" [read_agent] ","connect phase of read_agent",UVM_LOW)
    if(get_is_active == UVM_ACTIVE) begin 
      rd_drv.seq_item_port.connect(rd_seqr.seq_item_export);
    end
  endfunction
endclass