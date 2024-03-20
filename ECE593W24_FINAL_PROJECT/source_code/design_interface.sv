///////////////////////////////////////////////////////////////////////////
//Project Name: Design and Verification of Asynchronous FIFO using UVM   //
//File Name:design_interface.sv                                          //
//Authors: Shiva Prasad Balne, Ram Gopal Kasireddy, Praveen Kumar Palli  //
//Description: Interface module with modports for all the design modules //
//			   						                                     //
//																		 //
///////////////////////////////////////////////////////////////////////////

interface async_fifo(input r_clk,w_clk,wrst,rrst);

//producer MODPORT
  logic [31:0]d_out;  
  logic w_en,wr_req,rd_req,fifo_full,fifo_empty;
  logic [31:0] data_in,data_out;
 
 modport producer_if(input w_clk, wrst, wr_req, data_in, output d_out, w_en);
 
 //consumer MODPORT
  logic [31:0] mem_data_out;
  logic r_en;
  
 modport consumer_if(input r_clk,rrst,rd_req,mem_data_out, output r_en,data_out);
  
  //FIFO MEMORY MODPORT
  logic f_full, f_empty;
  logic [9:0]wptr,rptr;
  
 modport mem_if(input w_clk, wrst, rrst,r_clk, r_en,w_en,f_full,f_empty,wptr,rptr,d_out, output mem_data_out);
   
   //RPTR MODPORT  
  logic [9:0]wptr_gray_sync;
  logic [9:0]rptr_gray;
	
   modport rd_ptr_if(input r_clk,rrst,r_en,wptr_gray_sync, output rptr,rptr_gray,f_empty);
   
   //WPTR MODPORT 	
  logic [9:0]rptr_gray_sync;
  logic [9:0]wptr_gray;
  
 modport wr_ptr_if(input w_clk,wrst,w_en,rptr_gray_sync, output wptr,wptr_gray,f_full);
	
	//Synchronizer MODPORT
	//MODPORT for WRITE pointer synchronized value to Read pointer
 modport r_sync(input w_clk,wrst,rptr_gray, output rptr_gray_sync);
	//WRITE pointer synchronized value to Read pointer
 modport w_sync(input r_clk,rrst,wptr_gray, output wptr_gray_sync);
 
endinterface