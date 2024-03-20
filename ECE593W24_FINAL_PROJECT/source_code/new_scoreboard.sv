///////////////////////////////////////////////////////////////////////////
//Project Name: Design and Verification of Asynchronous FIFO using UVM   //
//File Name:new_scoreboard.sv                                            //
//Authors: Shiva Prasad Balne, Ram Gopal Kasireddy, Praveen Kumar Palli  //
//Description:  It monitors the write and read transactions and verifies //
//			    the correctness of data flow between the                 //
//              write and read agents.                                   //
///////////////////////////////////////////////////////////////////////////

`uvm_analysis_imp_decl(_WRITE_FIFO)
`uvm_analysis_imp_decl(_READ_FIFO)

class scoreboard extends uvm_scoreboard;
   `uvm_component_utils(scoreboard)
   logic [31:0] ref_fifo [$];
   logic [31:0] expected_rdata;
   logic [31:0]matched,mismatched;
   

   uvm_analysis_imp_WRITE_FIFO #(seq_item, scoreboard) write_scoreboard_port;
   uvm_analysis_imp_READ_FIFO #(rd_seq_item, scoreboard) read_scoreboard_port;
   
   function new(string name="scoreboard", uvm_component parent = null);
      super.new(name, parent);
   endfunction 

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      write_scoreboard_port = new("write_scoreboard_port", this);
      read_scoreboard_port = new("read_scoreboard_port", this);
   endfunction 

   virtual function void write_WRITE_FIFO(seq_item req);
      if(req.wrst) begin
		expected_rdata = 'x;
	  end
	  else if(ref_fifo.size()<512 && req.wr_req == 1'b1) begin
		ref_fifo.push_front(req.data_in);
		`uvm_info(get_type_name(),$sformatf("---------------------------------- data_in: %h, wrst: %0d, wr_req:%0d",req.data_in, req.wrst, req.wr_req),UVM_LOW)
		`uvm_info(get_type_name(),$sformatf("---------------------------------- Data written to scoreboard: %h", req.data_in),UVM_LOW)
      end
	  
   endfunction

   virtual function void write_READ_FIFO(rd_seq_item rd_pkt);
      if(rd_pkt.rrst) begin
		expected_rdata = 'x;
		if(expected_rdata == rd_pkt.data_out) begin
			matched++;
			`uvm_info(get_type_name(),$sformatf("---------------------------------- Data matched at reset in scoreboard: expected_rdata: %h, received_rdata: %h", expected_rdata, rd_pkt.data_out),UVM_LOW)
		end 
		else begin
			`uvm_error(get_type_name(),$sformatf("---------------------------------- Data mismatched at reset in scoreboard: expected_rdata: %h, received_rdata: %h", expected_rdata, rd_pkt.data_out))
			mismatched++;
		end
	  end
	  else if(ref_fifo.size()>0 && rd_pkt.rd_req == 1'b1 ) begin
		expected_rdata = ref_fifo.pop_back();
		`uvm_info(get_type_name(),$sformatf("----------------------------------  data_out: %h, fifo_empty: %0d", rd_pkt.data_out, rd_pkt.fifo_empty),UVM_LOW)
		if(expected_rdata == rd_pkt.data_out) begin
			matched++;
			`uvm_info(get_type_name(),$sformatf("---------------------------------- Data matched in scoreboard: expected_rdata: %h, received_rdata: %h", expected_rdata, rd_pkt.data_out),UVM_LOW)
		end 
		else begin
			`uvm_error(get_type_name(),$sformatf("---------------------------------- Data mismatched in scoreboard: expected_rdata: %h, received_rdata: %h", expected_rdata, rd_pkt.data_out))
			mismatched++;
		end
	  end
	  
   endfunction


endclass 

