parameter DATA_WIDTH=32;
module top;
	logic w_clk = 0;
	logic wrst,wr_req;
	logic f_full = 0;
	logic [DATA_WIDTH-1:0]data_in;
	logic [DATA_WIDTH-1:0]d_out;
	logic w_en;
	
	producer #(DATA_WIDTH) PRO(w_clk,wrst,wr_req,f_full,data_in,d_out,w_en);
	
	always #5 w_clk = ~w_clk;
	always #10 f_full = ~f_full;
	
	initial begin 
		wrst = 1;
		repeat(10) @(posedge w_clk);
		wrst = 0;
	end
	
	initial begin 
		repeat(5) @(negedge w_clk);
		wr_req = 0;
		for(int i=0; i< 100; i++) begin
			@(posedge w_clk); wr_req=1;
			data_in = $random;
			repeat(3)@(posedge w_clk); wr_req= 0;
		end	
		
		$finish;
	end
	
	initial begin
		$monitor("data_in = %0d   wr_req =%0d  d_out = %0d  w_en = %0d ",data_in,wr_req,d_out,w_en);
	end 
endmodule