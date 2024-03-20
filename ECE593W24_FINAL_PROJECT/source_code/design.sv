///////////////////////////////////////////////////////////////////////////
//Project Name: Design and Verification of Asynchronous FIFO using UVM   //
//File Name:design.sv                                                    //
//Authors: Shiva Prasad Balne, Ram Gopal Kasireddy, Praveen Kumar Palli  //
//Description: Top design module with instantion of all design modules   //
//			   						                                     //
//																		 //
///////////////////////////////////////////////////////////////////////////


module Async_FIFO(tintf dif);

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
	CONSUMER CON(inf.consumer_if);
	
	//write pointer logic instantiation
	WPTR_LOGIC WP(inf.wr_ptr_if);
	
	//read pointer instantiation

	RPTR_LOGIC RP(inf.rd_ptr_if);
	
	//WRITE pointer synchronized value to Read pointer
	synchronizer W_SYN(
	.clk(inf.r_clk),
	.rst(inf.rrst),
	.d_in(inf.wptr_gray),
	.d_out(inf.wptr_gray_sync));
	
	//WRITE pointer synchronized value to Read pointer
	synchronizer R_SYN(//inf.r_sync
	.clk(inf.w_clk),
	.rst(inf.wrst),
	.d_in(inf.rptr_gray),
	.d_out(inf.rptr_gray_sync));
	
	//fifo memory instantiation
	fifo_mem my_fifo(inf.mem_if);
	
endmodule