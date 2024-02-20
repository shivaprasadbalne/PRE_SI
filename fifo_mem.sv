/*module fifo_mem #(parameter DATA_WIDTH=32, ADDR_WIDTH = 9) (
  input logic pin.w_clk, pin.wrst, rrst, pin.r_clk, pin.r_en,pin.pin.w_en,pin.f_full, pin.f_empty,
  input logic [ADDR_WIDTH:0]pin.wptr,pin.rptr,	//size??
  input logic [DATA_WIDTH-1:0] pin.data_in,
  output logic [DATA_WIDTH-1:0] pin.data_out
); */
import pkg::* ;
module fifo_mem(async_fifo pin);


  logic [DATA_WIDTH-1:0] fifo[0:(2**ADDR_WIDTH)-1];
  
  
  always_ff@(posedge pin.w_clk or negedge pin.wrst) begin
	/* if(!pin.wrst) begin
		foreach(fifo[i]) begin
			fifo[i] <= 'x;
		end
	end
	else */
    if(pin.w_en && !pin.f_full)
		fifo[pin.wptr[ADDR_WIDTH-1:0]] <= pin.d_out;
	else
		fifo[pin.wptr[ADDR_WIDTH-1:0]] <= fifo[pin.wptr[ADDR_WIDTH-1:0]];
  end
  
  always_ff@(posedge pin.r_clk or negedge pin.rrst) begin
    if(pin.r_en && !pin.f_empty)
		pin.mem_data_out <= fifo[pin.rptr[ADDR_WIDTH-1:0]];
	else
		pin.mem_data_out <= 'z ; //pin.data_out;
  end
endmodule