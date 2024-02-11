module synchronizer #(parameter DATA_WIDTH = 32)(
	input logic clk,rst,
	input logic [DATA_WIDTH-1:0]d_in,
	output logic [DATA_WIDTH-1:0]d_out
	);
	
	logic [DATA_WIDTH-1:0]q1;
	
	always@(posedge clk) begin
		if(!rst) begin
			q1 <= 0;
			d_out <= 0;
		end
		else begin
			q1 <= d_in;
			d_out <= q1;
		end
	end
	
endmodule