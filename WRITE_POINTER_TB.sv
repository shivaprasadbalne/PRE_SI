parameter ADDR_WIDTH = 9;
parameter DATA_WIDTH =32;

module top;
	logic w_clk = 0;
	logic wrst,w_en;
	logic [ADDR_WIDTH:0]rptr_gray_sync,wptr,wptr_gray,t_g_rptr_sync;
	logic f_full;

	WPTR_LOGIC #(ADDR_WIDTH,DATA_WIDTH)WP(w_clk,wrst,w_en,rptr_gray_sync,wptr,wptr_gray,f_full);
	
	always #5 w_clk = ~w_clk;
	
	
initial begin
	wrst = 0;
	repeat(5) @(posedge w_clk); 
	wrst=1;
end
	
initial begin
	repeat(5) @(posedge w_clk);
	
	w_en= 0;
	for(int i=0; i< 100; i++) begin
		@(posedge w_clk); w_en=1;
		t_g_rptr_sync = (i >>1)^i;
		rptr_gray_sync = {~t_g_rptr_sync[ADDR_WIDTH:ADDR_WIDTH-1],t_g_rptr_sync[ADDR_WIDTH-2:0]};
		@(posedge w_clk); w_en= 0;
	end
	
	w_en = 0;
	repeat(100)@(negedge w_clk);

	
	$finish;
end


initial begin
	$monitor("wptr= %0d rptr_gray_sync = %0d f_full = %0d at time=%0t",WP.wptr,WP.rptr_gray_sync,f_full, $time);
end
endmodule

	
