///////////////////////////////////////////////////////////////////////////
//Project Name: Design and Verification of Asynchronous FIFO using UVM   //
//File Name:producer.sv                                                  //
//Authors: Shiva Prasad Balne, Ram Gopal Kasireddy, Praveen Kumar Palli  //
//Description:  Producer module for controlling write operation enabling //
//			    write request and write enable signals with respect to   //
//              write clock and write reset.                             //
///////////////////////////////////////////////////////////////////////////

module producer (async_fifo.producer_if pif);
always_ff@(posedge pif.w_clk or posedge pif.wrst) begin
	if(pif.wrst) begin   //If write reset is asserted set write enable to 0 and data to be sent to high impedance.
		pif.d_out <= 'z;
		pif.w_en <= '0;
	end
	else
		if(pif.wr_req)begin  // If write request is asserted set write enable to 1 for write operation to write data.		
			pif.w_en <= 1;
			pif.d_out <= pif.data_in;
		end
		
		else begin   //If no write request and no write reset asserted disable write operation by setting write enable to 0 and data to be sent to high impedance.
			pif.w_en<= 0;     
			pif.d_out <= 'z;
		end
		
end
endmodule