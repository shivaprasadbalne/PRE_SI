///////////////////////////////////////////////////////////////////////////
//Project Name: Design and Verification of Asynchronous FIFO using UVM   //
//File Name:synchronizer.sv                                              //
//Authors: Shiva Prasad Balne, Ram Gopal Kasireddy, Praveen Kumar Palli  //
//Description: Two stage flip-flop synchronizer module                   //
//			  for synchronizing read and write pointer values.           //
//			    														 //
///////////////////////////////////////////////////////////////////////////

/*
 
*/

 module synchronizer(
	input logic clk,rst,
   	input logic [9:0]d_in, //used for passing gray pointer value wptr gray or rptr gray for synchronization process. 
   	output logic [9:0]d_out //used for passing synchronized gray pointer value wptr gray sync or rptr gray sync.
	); 
	
   logic [9:0]q1;
	
	always_ff@(posedge clk or posedge rst) begin
		if(rst) begin //if reset set incoming ptr values to 0.
			q1 <= 0;
			d_out <= 0;
		end
		else begin
			q1 <= d_in;   // if no reset set the incoming gray ptr value as 1st FF output and then 2nd FF output for synchronization. 
			d_out <= q1; 
		end
	end
	
endmodule