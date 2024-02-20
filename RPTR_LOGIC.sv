/*module rif.rptr_LOGIC #(parameter ADDR_WIDTH = 9, parameter DATA_WIDTH = 32)(
	input logic rif.r_clk,rif.rrst,rif.r_en,
	input logic [ADDR_WIDTH:0]rif.wptr_gray_sync,
	output logic [ADDR_WIDTH:0]rif.rptr,rif.rptr_gray,
	output logic rif.f_empty
); */
import pkg::*;
module RPTR_LOGIC (async_fifo.rd_ptr_if rif);

	logic rempty;
	
	
	assign rempty = (rif.wptr_gray_sync == rif.rptr_gray);
	assign rif.rptr_gray = (rif.rptr>>1)^rif.rptr;
	assign rif.f_empty = rempty;

	always_ff @(posedge rif.r_clk or negedge rif.rrst) begin
		if(!rif.rrst) begin 
			rif.rptr <= '0;
		end
		else begin
			if(rif.r_en && !rempty)
				rif.rptr <= rif.rptr+1'b1; //(rif.r_en && !rempty) ? rif.rptr+1: rif.rptr;
			else
				rif.rptr <= rif.rptr;
		end
	end
	
	
endmodule