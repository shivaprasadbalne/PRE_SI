parameter DATA_WIDTH = 32;

module top;

	logic r_clk = 0;
	logic rrst;
	logic rd_req;
	logic [DATA_WIDTH-1:0]mem_data_out;
	logic f_empty = 1;
	logic r_en;
	logic [DATA_WIDTH-1:0]data_out;
	
	
	CONSUMER #(DATA_WIDTH)CON(r_clk,rrst,rd_req,mem_data_out,f_empty,r_en,data_out);
	
	always #5 r_clk = ~r_clk;
	always #8 f_empty = ~f_empty;
	
	initial begin
		rrst = 1;
		repeat(10) @(posedge r_clk);
		rrst = 0;
	end
	
	initial begin
		repeat(2) @(posedge r_clk);	
		rd_req = 0;
		for(int i=0; i< 100; i++) begin
			@(posedge r_clk); rd_req=1;
			mem_data_out = $random;
			repeat(3)@(posedge r_clk); rd_req= 0;
		end	
		
		$finish;
	end
	
	initial begin
		$monitor("mem_data_out = %0d  data_out = %0d r_en = %0d",mem_data_out,data_out,r_en);
	end
	
endmodule