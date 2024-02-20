
						 

/*module Async_FIFO#(parameter ADDR_WIDTH = 9,DATA_WIDTH =32)(input logic w_clk,r_clk,
	input logic wrst,rrst,
	input logic wr_req,
	input logic rd_req,
	input logic [DATA_WIDTH-1:0]data_in,
	output logic fifo_full,fifo_empty,
	output logic [DATA_WIDTH-1:0]data_out
);*/
import pkg::*;
module Async_FIFO(tintf dif);

	/* logic [ADDR_WIDTH:0]rptr_gray_sync,wptr_gray_sync;
	logic w_en,r_en;
	logic [ADDR_WIDTH:0]wptr,wptr_gray;
	logic f_full,f_empty;
	logic [DATA_WIDTH-1:0]mem_data_out,d_out;
	logic [ADDR_WIDTH:0]rptr,rptr_gray; */
	
	assign dif.fifo_full = inf.f_full;
	assign dif.fifo_empty = inf.f_empty;
	assign inf.data_in = dif.data_in;
	assign inf.wr_req = dif.wr_req;
	assign inf.rd_req = dif.rd_req;
	assign dif.data_out = inf.data_out;
	
	//interface instantiation
	async_fifo inf(dif.r_clk,dif.w_clk,dif.wrst,dif.rrst);
	
	//producer instantiation
	producer  PRO(inf.producer_if);
	
	//consumer instantiation
	//CONSUMER #(DATA_WIDTH)CON(r_clk,rrst,rd_req,mem_data_out,r_en,data_out);
	CONSUMER CON(inf.consumer_if);
	
	//write pointer logic instantiation
//	WPTR_LOGIC WP(w_clk,wrst,w_en,rptr_gray_sync,wptr,wptr_gray,f_full);
	WPTR_LOGIC WP(inf.wr_ptr_if);
	
	//read pointer instantiation
	//RPTR_LOGIC #(ADDR_WIDTH,DATA_WIDTH) RP(r_clk,rrst,r_en,wptr_gray_sync,rptr,rptr_gray,f_empty);
	RPTR_LOGIC RP(inf.rd_ptr_if);
	
	//WRITE pointer synchronized value to Read pointer
	//synchronizer #(DATA_WIDTH) W_SYN(r_clk,rrst,wptr_gray,wptr_gray_sync);
	synchronizer W_SYN(//inf.w_sync
	.clk(inf.r_clk),
	.rst(inf.rrst),
	.d_in(inf.wptr_gray),
	.d_out(inf.wptr_gray_sync));
	
	//WRITE pointer synchronized value to Read pointer
	//synchronizer #(DATA_WIDTH) R_SYN(w_clk,wrst,rptr_gray,rptr_gray_sync);
	synchronizer R_SYN(//inf.r_sync
	.clk(inf.w_clk),
	.rst(inf.wrst),
	.d_in(inf.rptr_gray),
	.d_out(inf.rptr_gray_sync));
	
	//fifo memory instantiation
	//fifo_mem #(DATA_WIDTH, ADDR_WIDTH) my_fifo(w_clk,wrst,rrst,r_clk,r_en,w_en,f_full,f_empty,wptr,rptr,d_out,mem_data_out);
	fifo_mem my_fifo(inf.mem_if);
	

	

	
	
endmodule