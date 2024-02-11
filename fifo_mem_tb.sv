`timescale 1ns / 1ps
parameter ADDR_WIDTH = 3;
parameter DATA_WIDTH = 32;

module top;
  logic w_clk=0;
  logic r_clk=0;
  logic wrst, rrst, r_en, w_en;
  logic [ADDR_WIDTH:0] wptr, rptr;
  logic [DATA_WIDTH-1:0] data_in;
  logic fifo_full, fifo_empty;
  logic  [DATA_WIDTH-1:0] data_out;

  // Instantiate the FIFO memory module
  fifo_mem #(DATA_WIDTH, ADDR_WIDTH) my_fifo (
    .w_clk(w_clk),
    .wrst(wrst),
    .rrst(rrst),
    .r_clk(r_clk),
    .r_en(r_en),
    .w_en(w_en),
    .wptr(wptr),
    .rptr(rptr),
    .data_in(data_in),
    .fifo_full(fifo_full),
    .fifo_empty(fifo_empty),
    .data_out(data_out)
  );

  // Clock generation

	always #5 w_clk = ~w_clk;
	always #10 r_clk = ~r_clk;


initial begin
	wrst = 0;
	repeat(5) @(posedge w_clk) 
	wrst=1;
	rrst = 0;
	repeat(5) @(posedge r_clk) 
	rrst=1;
end

initial begin
	wptr = 0;
	rptr = 0;
	
	repeat(7) begin 
	w_en = 1;
	data_in = $random;
	@(negedge w_clk)
	wptr = (wptr==7) ? 0 : wptr+1;
	end
	w_en=0;
	
	@(negedge r_clk);
	
	repeat(5) begin
	r_en = 1;
	@(negedge r_clk);
	rptr = (rptr==7) ? 0 : rptr+1;
	end  
	r_en=0;
	$finish;
end

always_comb begin
	fifo_full = (wptr==7) ? 1 : 0;
	fifo_empty = (rptr==0)? 1 : 0;
end
  
initial begin 
  $monitor("time=%0t wptr = %0d  rptr = %0d  data_in = %0d data_out = %0d", $time,wptr,rptr, data_in, data_out);
end


endmodule
