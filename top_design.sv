module Async_FIFO#(parameter ADDR_WIDTH = 9,DATA_WIDTH =32)(input logic w_clk,r_clk,
	input logic wrst,rrst,
	input logic wr_req,
	input logic rd_req,
	input logic [DATA_WIDTH-1:0]data_in,
	output logic fifo_full,fifo_empty,
	output logic [DATA_WIDTH-1:0]data_out
);

	logic [ADDR_WIDTH:0]rptr_gray_sync,wptr_gray_sync;
	logic w_en,r_en;
	logic [ADDR_WIDTH:0]wptr,wptr_gray;
	logic f_full,f_empty;
	logic [DATA_WIDTH-1:0]mem_data_out,d_out;
	logic [ADDR_WIDTH:0]rptr,rptr_gray;
	
	assign fifo_full = f_full;
	assign fifo_empty = f_empty;
	
	
	
	//producer instantiation
	producer #(DATA_WIDTH) PRO(w_clk,wrst,wr_req,data_in,d_out,w_en);
	
	//write pointer logic instantiation
	WPTR_LOGIC #(ADDR_WIDTH,DATA_WIDTH)WP(w_clk,wrst,w_en,rptr_gray_sync,wptr,wptr_gray,f_full);
	
	//WRITE pointer synchronized value to Read pointer
	synchronizer #(DATA_WIDTH) W_SYN(r_clk,rrst,wptr_gray,wptr_gray_sync);
	
	//fifo memory instantiation
	fifo_mem #(DATA_WIDTH, ADDR_WIDTH) my_fifo(w_clk,wrst,rrst,r_clk,r_en,w_en,f_full,f_empty,wptr,rptr,d_out,mem_data_out);
	
	//read pointer instantiation
	RPTR_LOGIC #(ADDR_WIDTH,DATA_WIDTH) RP(r_clk,rrst,r_en,wptr_gray_sync,rptr,rptr_gray,f_empty);
	
	//WRITE pointer synchronized value to Read pointer
	synchronizer #(DATA_WIDTH) R_SYN(w_clk,wrst,rptr_gray,rptr_gray_sync);
	
	//consumer instantiation
	CONSUMER #(DATA_WIDTH)CON(r_clk,rrst,rd_req,mem_data_out,r_en,data_out);
	
endmodule