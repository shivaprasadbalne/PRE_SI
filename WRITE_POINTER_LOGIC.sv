module WPTR_LOGIC #(parameter ADDR_WIDTH = 9, parameter DATA_WIDTH = 32)(
	input logic w_clk,wrst,w_en,
	input logic [ADDR_WIDTH:0]rptr_gray_sync,
	output logic [ADDR_WIDTH:0]wptr,wptr_gray,
	output logic f_full
);

  logic wfull;
  assign wptr_gray = (wptr >>1)^wptr;
  
  always@(posedge w_clk or negedge wrst) begin
    if(!wrst) begin
      wptr <= 0; 
    end
    else begin
	if(w_en && !wfull)
		wptr <= wptr+ 1'b1 /* (w_en && !wfull) */;
	else
		wptr <= wptr;
	end
  end
  
  assign f_full= wfull;
  
  assign wfull = (wptr_gray=={~rptr_gray_sync[ADDR_WIDTH:ADDR_WIDTH-1], rptr_gray_sync[ADDR_WIDTH-2:0]});
  
endmodule
