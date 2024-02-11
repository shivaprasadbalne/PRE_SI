module fifo_mem #(parameter DATA_WIDTH=32, ADDR_WIDTH = 9) (
  input logic w_clk, wrst, rrst, r_clk, r_en,w_en,f_full, f_empty,
  input logic [ADDR_WIDTH:0]wptr,rptr,	//size??
  input logic [DATA_WIDTH-1:0] data_in,
  output logic [DATA_WIDTH-1:0] data_out
);


  logic [DATA_WIDTH-1:0] fifo[0:(2**ADDR_WIDTH)-1];
  
  
  always_ff@(posedge w_clk or negedge wrst) begin
	/* if(!wrst) begin
		foreach(fifo[i]) begin
			fifo[i] <= 'x;
		end
	end
	else */
    if(w_en && !f_full)
		fifo[wptr[ADDR_WIDTH-1:0]] <= data_in;
	else
		fifo[wptr[ADDR_WIDTH-1:0]] <= fifo[wptr[ADDR_WIDTH-1:0]];
  end
  
  always_ff@(posedge r_clk or negedge rrst) begin
    if(r_en && !f_empty)
		data_out <= fifo[rptr[ADDR_WIDTH-1:0]];
	else
		data_out <= 'z ; //data_out;
  end
endmodule