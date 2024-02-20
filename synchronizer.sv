 import pkg::*;
 module synchronizer(
	input logic clk,rst,
	input logic [ADDR_WIDTH:0]d_in,
	output logic [ADDR_WIDTH:0]d_out
	); 
	//import pkg::* ;
	//module synchronizer(async_fifo.sync_if sif);	
	logic [ADDR_WIDTH-1:0]q1;
	
	always@(posedge clk) begin
		if(!rst) begin
			q1 <= 0;
			d_out <= 0;
		end
		else begin
			q1 <= d_in;
			d_out <= q1;
		end
	end
	
endmodule