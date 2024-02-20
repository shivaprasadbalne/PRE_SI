/*module producer #(parameter DATA_WIDTH=32)(
input logic pif.w_clk,pif.wrst,pif.wr_req,
input logic [DATA_WIDTH-1:0]pif.data_in,
output logic [DATA_WIDTH-1:0]pif.d_out,
output logic pif.w_en
);*/
import pkg::* ;
module producer (async_fifo.producer_if pif);

//assign pif.d_out = pif.wr_req?pif.data_in:'z;

always_ff@(posedge pif.w_clk or negedge pif.wrst) begin
	if(!pif.wrst) begin
		pif.d_out <= 'z;
		pif.w_en <= '0;
	end
	else
		if(pif.wr_req)begin
			pif.w_en <= 1;
			pif.d_out <= pif.data_in;
		end
		else begin
			pif.w_en<= 0;
			pif.d_out <= 'z;
		end
		
end
endmodule