parameter ADDR_WIDTH = 9;
parameter DATA_WIDTH =32;

module top;
	
	logic r_clk = 0;
	logic rrst, r_en;
	logic [ADDR_WIDTH:0]wptr_gray_sync,t_g_rptr;
	logic [ADDR_WIDTH:0]rptr;
	logic [ADDR_WIDTH:0]rptr_gray;
	logic f_empty;
	logic rempty;
	//logic [ADDR_WIDTH:0]t_g_wptr_sync;
	
	RPTR_LOGIC #(ADDR_WIDTH,DATA_WIDTH) RP(r_clk,rrst,r_en,wptr_gray_sync,rptr,rptr_gray,f_empty);
	
	always #5 r_clk = ~r_clk;
	
	initial begin
		rrst = 0;
		repeat(10) @(posedge r_clk);
		rrst = 1;
	end
	
	initial begin
		repeat(5) @(posedge r_clk);
	
		r_en= 0;
		//wptr_gray_sync = 0;
		for(int i=0; i< 100; i++) begin
			@(posedge r_clk); r_en=1;
			wptr_gray_sync = (i >>1)^i;
			t_g_rptr = 10'd68;
			//wptr_gray_sync = t_g_wptr_sync + 1;
			@(posedge r_clk); r_en= 0;
		end
	
		r_en = 0;
		repeat(100)@(negedge r_clk);

	
		$finish;
	end
	
	initial begin 
		$monitor("rptr= %0d wptr_gray_sync = %0d f_empty = %0d at time=%0t",RP.rptr,RP.wptr_gray_sync,f_empty, $time);
	end
	
endmodule	
	
	

	