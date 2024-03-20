///////////////////////////////////////////////////////////////////////////
//Project Name: Design and Verification of Asynchronous FIFO using UVM   //
//File Name:monitor.sv                                                   //
//Authors: Shiva Prasad Balne, Ram Gopal Kasireddy, Praveen Kumar Palli  //
//Description: write monitor class communicates with virtual interface   //
//			    of DUT and captures the write activity and sends it to   //
//              the scoreboard through analysis ports.                   //
///////////////////////////////////////////////////////////////////////////

class monitor extends uvm_monitor;
    `uvm_component_utils(monitor)
	seq_item mon_item; //instance of sequence item

    virtual tintf vif; //instance of virtual interface
    uvm_analysis_port #(seq_item) item_collect_port; //instance of analysis port
    
  
  
  function new(input string name = "monitor", uvm_component parent = null); //constructor
    super.new(name, parent);
	//creating analysis port using new method
    item_collect_port = new("item_collect_port", this);
   
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    `uvm_info(" [MON] ","build Phase of MON",UVM_LOW)
    super.build_phase(phase);
	mon_item = seq_item::type_id::create("mon_item",this);
	
    if(!uvm_config_db #(virtual tintf)::get(this, "*", "tintf_i", vif))
      `uvm_fatal(get_type_name(), "virtual interface not set at top level");
  endfunction
  
  task run_phase (uvm_phase phase);
    `uvm_info(" [MON] ","run Phase of MON",UVM_LOW)
    forever begin
	  wait(vif.wr_req || vif.wrst);
	  if(vif.wrst) begin
		@(posedge vif.w_clk);
        mon_item.wr_req = vif.wr_req;
		mon_item.data_in = vif.data_in;
		mon_item.fifo_full = vif.fifo_full;
	  end
	  else if(vif.wr_req) begin 
		@(posedge vif.w_clk);
		@(posedge vif.w_clk);
		mon_item.wr_req = vif.wr_req;
		mon_item.data_in = vif.data_in;
		mon_item.fifo_full = vif.fifo_full;
	  end
      
	  `uvm_info(get_type_name(), $sformatf("Monitoring write transaction: time = %0t  data_in = %h, wrst: %0d, wr_req: %0d",$time, mon_item.data_in, mon_item.wrst, mon_item.wr_req), UVM_LOW);
	  `uvm_info(get_type_name(), "Sent sequence item to scoreboard", UVM_NONE);
	  
      item_collect_port.write(mon_item);
    end
  endtask
endclass