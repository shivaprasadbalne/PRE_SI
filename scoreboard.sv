//gets the packet from monitor, Generated the expected result and compares with the //actual result recived from Monitor
//`include "packet.sv"
import pkg::*;
class scoreboard;

  packet pkt;

  logic [31:0] queue [$:511];
  
  task ref_model();
    
    case({pkt.wr_req, pkt.rd_req})
      2'b00: begin
        $display("No operation");
      end
      2'b01: begin
        if(queue.size>0) begin
			#2;
			pkt.data_out = queue.pop_back();
		end
      else begin
        $display("queue is empty");
		if(!pkt.fifo_empty)
		$error("Fifo sould be empty");
		end
      end
      2'b10: begin
        if(queue.size()<512) begin
			#1;
			queue.push_front(pkt.data_in);
		end
		else begin
			$display("queue is full");
			if(!pkt.fifo_full)
			$error("Fifo sould be full");
		end
      end
      2'b11: begin
        if(queue.size>0) begin
			#2;
      		pkt.data_out = queue.pop_back();
		end
        if(queue.size()<512)  begin
			#1;
      		queue.push_front(pkt.data_in);
		end
      end
    endcase

  endtask


   
  //creating mailbox handle
  mailbox mon2scb;
  
  //used to count the number of transactions
  int no_pkts;
  
  //constructor
  function new(mailbox mon2scb);
    //getting the mailbox handles from  environment 
    this.mon2scb = mon2scb;
  endfunction
  
  //Compares the Actual result with the expected result
  task main;
    
    forever begin
      mon2scb.get(pkt);
	  ref_model();
        // if(pkt.data_out == vif.data_out)
        //   $display("Result is as Expected");
        // else
        //   $error("Wrong Result.\n\tExpeced: %0d Actual: %0d",pkt.data_out,vif.data_out);
        no_pkts++;
      pkt.display("[ Scoreboard ]");
    end
  endtask
  
endclass
