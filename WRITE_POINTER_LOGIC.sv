/*module wif.wptr_LOGIC #(parameter ADDR_WIDTH = 9, parameter DATA_WIDTH = 32)(
	input logic wif.w_clk,wif.wrst,wif.w_en,
	input logic [ADDR_WIDTH:0]wif.rptr_gray_sync,
	output logic [ADDR_WIDTH:0]wif.wptr,wif.wptr_gray,
	output logic wif.f_full
); */
import pkg::*;
module WPTR_LOGIC (async_fifo.wr_ptr_if wif);

  logic wfull;
  assign wif.wptr_gray = (wif.wptr >>1)^wif.wptr;
  
  always@(posedge wif.w_clk or negedge wif.wrst) begin
    if(!wif.wrst) begin
      wif.wptr <= 0; 
    end
    else begin
	if(wif.w_en && !wfull)
		wif.wptr <= wif.wptr+ 1'b1 /* (wif.w_en && !wfull) */;
	else
		wif.wptr <= wif.wptr;
	end
  end
  
  assign wif.f_full= wfull;
  
  assign wfull = (wif.wptr_gray=={~wif.rptr_gray_sync[ADDR_WIDTH:ADDR_WIDTH-1], wif.rptr_gray_sync[ADDR_WIDTH-2:0]});
  
endmodule
