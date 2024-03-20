///////////////////////////////////////////////////////////////////////////
//Project Name: Design and Verification of Asynchronous FIFO using UVM   //
//File Name:consumer.sv                                                  //
//Authors: Shiva Prasad Balne, Ram Gopal Kasireddy, Praveen Kumar Palli  //
//Description: Consumer module for controlling read operation with       //
//			  respect to read clock and read reset.                      //
//																		 //
///////////////////////////////////////////////////////////////////////////

module CONSUMER(async_fifo.consumer_if cif);


    // If read enable signal is asserted, data output is assigned the value of memory data out otherwise, data output is not valid
assign cif.data_out = cif.rrst?'z:((cif.r_en)?cif.mem_data_out:'z);

    always_ff @(posedge cif.r_clk or posedge cif.rrst) begin
		if(cif.rrst)begin   //If read reset is asserted disable read operation by setting read enable signal to 0.
			cif.r_en <= 0;
		end
		else if (cif.rd_req)begin  // If the read request signal is asserted enable read operation by setting read enable signal to 1.
			cif.r_en <= 1;
		end
		else cif.r_en <= 0;
    end
	
endmodule