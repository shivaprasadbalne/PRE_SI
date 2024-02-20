import pkg::*;
module top;
	bit w_clk,r_clk;
	bit wrst,rrst;
	
	tintf tintf_inst(w_clk,r_clk,wrst,rrst);
	
	Async_FIFO dut_inst(tintf_inst.dut_modport);
	
	
	
	always #5 w_clk = ~w_clk;
	always #10 r_clk = ~r_clk;
	
	initial begin
		//wrst = 1;
		repeat(5) @(negedge w_clk)
		wrst = 0;
		wrst = 1;
	end
	
	initial begin
		//rrst = 1;
		repeat(5) @(negedge r_clk)
		rrst = 0;
		rrst = 1;
	end
	

	test t0(tintf_inst);
	
/*	
	covergroup fifo_status;
	coverpoint fifo_full
	endgroup 
	*/
	
	/*
	initial begin
		//wr_req=1;
		repeat(5) @(negedge tintf_inst.w_clk)
		wr_req = 0;
		repeat(20) @(negedge tintf_inst.w_clk) begin
		data_in = $random; wr_req = 1;
		end
		@(negedge tintf_inst.w_clk);
		wr_req = 0;
		
		repeat(100) @(negedge tintf_inst.w_clk);
		$finish;
	end 
	
	
	initial begin
		//rd_req=1;
		repeat(5) @(negedge tintf_inst.r_clk)
		rd_req=0;
		repeat(20) begin
		@(negedge tintf_inst.r_clk)
		rd_req = 1;
		@(negedge tintf_inst.r_clk)
		rd_req = 0;
		end
		
		repeat (100) @(negedge tintf_inst.r_clk);
		$finish;
		
	end
	
	
	initial begin
		$display("data_in = %0d , wr_req = %0d rd_req = %0d data_out = %0d",data_in,wr_req,rd_req,data_out);
	end
	*/
endmodule