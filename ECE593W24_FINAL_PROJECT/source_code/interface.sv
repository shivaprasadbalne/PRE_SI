///////////////////////////////////////////////////////////////////////////
//Project Name: Design and Verification of Asynchronous FIFO using UVM   //
//File Name:interface.sv                                                 //
//Authors: Shiva Prasad Balne, Ram Gopal Kasireddy, Praveen Kumar Palli  //
//Description: interface for the design                                  //
//			                                                             //
//                                                                       //
///////////////////////////////////////////////////////////////////////////


interface tintf(input logic w_clk,r_clk);
	logic wrst,rrst;
	logic wr_req,rd_req;
	logic fifo_full,fifo_empty;	
    logic [31:0]data_in;		 
    logic [31:0]data_out;	
	
	
	modport dut_modport(input w_clk,r_clk,wrst,rrst,wr_req,rd_req,data_in, output fifo_full,fifo_empty,data_out);
	
	//MODPORT DRIVER
	modport driver_modport (output data_in, rd_req, wr_req,fifo_full,fifo_empty);
	

endinterface