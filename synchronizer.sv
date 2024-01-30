module synchronizer #(parameter WIDTH = 9)(clk_ab,rst_ab,data_in,data_out);
input logic clk_ab,rst_ab;
input logic [WIDTH-1:0]data_in;
output logic [WIDTH-1:0]data_out;
logic [WIDTH-1:0]q1,q2;

always_ff@(posedge clk_ab) begin
	if(!rst_ab)begin
	q1 <= '0;
	q2 <= '0;
	end
	else 
	begin
		q1 <= data_in;
		q2 <= q1;
	end
end

assign data_out = q2;

property p1;
	@(posedge clk);
	disable iff (!rst_ab)
	data_in |-> ##2 (data_out == $past(data_in,2)); 
endproperty

A1 : assert(p1); 

endmodule