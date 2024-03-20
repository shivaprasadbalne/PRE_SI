///////////////////////////////////////////////////////////////////////////
//Project Name: Design and Verification of Asynchronous FIFO using UVM   //
//File Name:rd_monitor.sv                                                //
//Authors: Shiva Prasad Balne, Ram Gopal Kasireddy, Praveen Kumar Palli  //
//Description:  Read monitor where read sequence packet is driven to DUT //
//			    via virtual interface and observed output data           //
//              							                             //
///////////////////////////////////////////////////////////////////////////

class read_monitor extends uvm_monitor;
    `uvm_component_utils(read_monitor)
	rd_seq_item rd_mon_item; //instance of sequence item

    virtual tintf vif; //instance of virtual interface
    uvm_analysis_port #(rd_seq_item) item_collect_port; //instance of analysis port
    
  
  
  function new(input string name = "read_monitor", uvm_component parent = null); //constructor
    super.new(name, parent);
	//creating analysis port using new method
    item_collect_port = new("item_collect_port", this);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    `uvm_info(" [rd_MON] ","build Phase of rd_MON",UVM_LOW)
    super.build_phase(phase);
	rd_mon_item = rd_seq_item::type_id::create("rd_mon_item",this);
	
    if(!uvm_config_db #(virtual tintf)::get(this, "*", "tintf_i", vif))
      `uvm_fatal(get_type_name(), "virtual interface not set at top level");
  endfunction
  
  task run_phase (uvm_phase phase);
    `uvm_info(" [rd_MON] ","run Phase of rd_MON",UVM_LOW)
    forever begin
      //wait(vif.r_clk);
      wait(vif.rd_req || vif.rrst);
      if(vif.rrst) begin 
		@(posedge vif.r_clk);
		@(posedge vif.r_clk);
		rd_mon_item.rd_req = vif.rd_req;
		rd_mon_item.fifo_empty = vif.fifo_empty;
		rd_mon_item.data_out = vif.data_out;
		end
	  else if(vif.rd_req) begin
		@(posedge vif.r_clk);
		@(posedge vif.r_clk);
		rd_mon_item.rd_req = vif.rd_req;
		rd_mon_item.fifo_empty = vif.fifo_empty;
		rd_mon_item.data_out = vif.data_out;
	  end
	`uvm_info(get_type_name(), $sformatf("rd_req = %0d, data_out = %0h", rd_mon_item.rd_req, rd_mon_item.data_out), UVM_LOW);
	`uvm_info(get_type_name(), "Sent sequence item to scoreboard", UVM_NONE);
	item_collect_port.write(rd_mon_item);
    end
  endtask
endclass