parameter DATA_WIDTH = 32;
parameter ADDR_WIDTH = 9;
module top;
	
	logic w_clk=0;
	logic r_clk=0;
	logic wrst,rrst;
	logic wr_req;
	logic rd_req ;
	logic [DATA_WIDTH-1:0]data_in;
	logic fifo_full,fifo_empty;
	logic [DATA_WIDTH-1:0]data_out;
	
	Async_FIFO #(ADDR_WIDTH,DATA_WIDTH) dut_inst(w_clk,r_clk,wrst,rrst,wr_req,rd_req,data_in,fifo_full,fifo_empty,data_out);
	
	always #5 w_clk = ~w_clk;
	always #15 r_clk = ~r_clk;
	
	initial begin
		//wrst = 1;
		repeat(10) @(posedge w_clk)
		wrst = 0;
		wrst = 1;
	end
	
	initial begin
		//rrst = 1;
		repeat(3) @(posedge r_clk)
		rrst = 0;
		rrst = 1;
	end
	
	initial begin
		wr_req=1;
		repeat(5) @(posedge w_clk)
		wr_req = 0;
		repeat(10) @(negedge w_clk) begin
		data_in = $random; wr_req = 1;
		end
		@(negedge w_clk);
		wr_req = 0;
		
		repeat(100) @(negedge w_clk);
		$finish;
	end 
	
	
	initial begin
		rd_req=1;
		repeat(2) @(posedge r_clk)
		rd_req=0;
		repeat(10) @(negedge r_clk)
		rd_req = 1;
		repeat(5) @(negedge r_clk);
		rd_req = 0;
		repeat (100) @(negedge r_clk);
		$finish;
		
	end
	
	
	initial begin
		$display("data_in = %0d , wr_req = %0d rd_req = %0d data_out = %0d",data_in,wr_req,rd_req,data_out);
	end
endmodule