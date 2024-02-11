module producer #(parameter DATA_WIDTH=32)(
input logic w_clk,wrst,wr_req,
//input logic f_full,
input logic [DATA_WIDTH-1:0]data_in,
output logic [DATA_WIDTH-1:0]d_out,
output logic w_en
);

//assign d_out = wr_req?data_in:'z;

always_ff@(posedge w_clk or negedge wrst) begin
	if(!wrst) begin
		d_out <= 'z;
		w_en <= '0;
	end
	else
		if(wr_req)begin
			w_en <= 1;
			d_out <= data_in;
		end
		else begin
			w_en<= 0;
			d_out <= 'z;
		end
		
end
endmodule