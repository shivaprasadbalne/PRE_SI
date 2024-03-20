///////////////////////////////////////////////////////////////////////////
//Project Name: Design and Verification of Asynchronous FIFO using UVM   //
//File Name:unified_cov.sv                                               //
//Authors: Shiva Prasad Balne, Ram Gopal Kasireddy, Praveen Kumar Palli  //
//Description: Coverage class for generating coverage report with        //
//			   covergroups declared                                      //
//																		 //
///////////////////////////////////////////////////////////////////////////

`uvm_analysis_imp_decl(_WRITE_COV)
`uvm_analysis_imp_decl(_READ_COV)

class coverage extends uvm_component; // Use base class for flexibility

	uvm_analysis_imp_WRITE_COV #(seq_item, coverage) write_coverage_port;
	uvm_analysis_imp_READ_COV #(rd_seq_item, coverage) read_coverage_port;
	
	`uvm_component_utils(coverage)
	seq_item req;
	rd_seq_item rd_pkt;
	cov_item cov_pkt;
	
	real cov_score;
	
	
  // Coverage bins
	covergroup cg;
		option.per_instance =1;
		coverpoint cov_pkt.wr_req {
			bins wr_req_0 = {0};
			bins wr_req_1 = {1};
			
		}
		coverpoint cov_pkt.wrst{
			bins wrst_0 = {0};
			
		}
		coverpoint cov_pkt.rd_req {
			bins rd_req_0 = {0};
			bins rd_req_1 = {1};
			
		}
		coverpoint cov_pkt.rrst{
			bins rrst_0 = {0};
		}
		coverpoint cov_pkt.data_in {
		  bins b1[3] = {[0:32'h11111111],[32'h11111112:32'h66666666],[32'h66666667:32'hFFFFFFFF]};
		}
		coverpoint cov_pkt.data_out{
		  bins b2[3] = {[0:32'h11111111],[32'h11111112:32'h66666666],[32'h66666667:32'hFFFFFFFF]};
		}
		coverpoint cov_pkt.fifo_full;
		coverpoint cov_pkt.fifo_empty;
	endgroup

 function new(string name = "coverage", uvm_component parent= null);
	super.new(name, parent);
	cov_pkt = new;
	cg = new;
 endfunction

function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		write_coverage_port = new("write_coverage_port", this);
		read_coverage_port = new("read_coverage_port", this);
endfunction 

  virtual function void write_WRITE_COV(seq_item req);
		cov_pkt.wr_req = req.wr_req;
		cov_pkt.wrst = req.wrst;
		cov_pkt.fifo_full = req.fifo_full;
		cov_pkt.data_in = req.data_in;
		cg.sample();
		cov_score=cg.get_coverage();
        `uvm_info("COV_SCORE",$sformatf("Write_Coverage=%0f ",cov_score),UVM_NONE);
  endfunction
  
  virtual function void write_READ_COV(rd_seq_item rd_pkt);
		cov_pkt.rd_req = rd_pkt.rd_req;
		cov_pkt.rrst = rd_pkt.rrst;
		cov_pkt.fifo_empty = rd_pkt.fifo_empty;
		cov_pkt.data_out = rd_pkt.data_out;
		cg.sample();
		cov_score=cg.get_coverage();
        `uvm_info("COV_SCORE",$sformatf("Read_Coverage=%0f ",cov_score),UVM_NONE);
  endfunction
virtual function void extract_phase(uvm_phase phase);
//Section C7.1 : use uvm_config_db::set to send coverage number to environment
	cov_score = cg.get_coverage();
    uvm_config_db#(real)::set(null,"uvm_test_top.env_o","cov_score",cov_score);
endfunction



endclass
