module RPTR_LOGIC #(parameter ADDR_WIDTH = 9, parameter DATA_WIDTH = 32)(
	input logic r_clk,rrst,r_en,
	input logic [ADDR_WIDTH:0]wptr_gray_sync,
	output logic [ADDR_WIDTH:0]rptr,rptr_gray,
	output logic f_empty
);

	logic rempty;
	
	
	assign rempty = (wptr_gray_sync == rptr_gray);
	assign rptr_gray = (rptr>>1)^rptr;
	assign f_empty = rempty;

	always_ff @(posedge r_clk or negedge rrst) begin
		if(!rrst) begin 
			rptr <= '0;
		end
		else begin
			if(r_en && !rempty)
				rptr <= rptr+1'b1; //(r_en && !rempty) ? rptr+1: rptr;
			else
				rptr <= rptr;
		end
	end
	
	
endmodule