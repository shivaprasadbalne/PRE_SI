parameter DATA_WIDTH = 32;

module top;
	logic clk = 0;
	logic rst;
	logic [DATA_WIDTH-1:0]d_in;
	logic [DATA_WIDTH-1:0]d_out;
	
	synchronizer #(DATA_WIDTH) SYN(clk,rst,d_in,d_out);
	
	always #5 clk = ~clk;
	
	initial begin
		rst = 1;
		repeat(10) @(posedge clk);
		rst = 0;
	end
	
	initial begin
		repeat(10) @(negedge clk) begin
			d_in = $random;
		end
		
		$finish;
	end
	
	initial begin
		$monitor("d_in = %0d  d_out = %0d",d_in,d_out);
	end
	
	
endmodule