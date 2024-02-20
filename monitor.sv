//`include "packet.sv"
import pkg::*;
class monitor;

  packet pkt;
  
  //creating virtual interface handle
  virtual tintf vif;
  
  //creating mailbox handle
  mailbox mon2scb;
  
  //constructor
  function new(virtual tintf vif,mailbox mon2scb);
    //getting the interface
    this.vif = vif;
    //getting the mailbox handles from  environment 
    this.mon2scb = mon2scb;
  endfunction
  
  //Samples the interface signal and send the sample packet to scoreboard
  task main;
    forever begin
      
      pkt = new();
      @(posedge vif.w_clk);
      //wait(vif.wr_req);      //wr_req or w_en
	    pkt.wr_req = vif.wr_req;
      pkt.data_in   = vif.data_in;
      pkt.fifo_full = vif.fifo_full;
      @(posedge vif.r_clk);
	  //wait(vif.rd_req);
      pkt.data_out   = vif.data_out;
	    pkt.fifo_empty = vif.fifo_empty;
	  
     
	 //@(posedge vif.r_clk);     // confirm these lines
      mon2scb.put(pkt);
      pkt.display("[ Monitor ]");
    end
  endtask
endclass
  
