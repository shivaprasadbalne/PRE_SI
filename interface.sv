import pkg::*;

interface tintf(input w_clk,r_clk,wrst,rrst);

	

	logic wr_req,rd_req;
	logic fifo_full,fifo_empty;				 
	logic [DATA_WIDTH-1:0]data_in;		 
	logic [DATA_WIDTH-1:0]data_out;	
	
	modport dut_modport(input w_clk,r_clk,wrst,rrst,wr_req,rd_req,data_in, output fifo_full,fifo_empty,data_out);
	
	//MODPORT DRIVER
	modport driver_modport (output data_in, rd_req, wr_req);
	

endinterface