///////////////////////////////////////////////////////////////////////////
//Project Name: Design and Verification of Asynchronous FIFO using UVM   //
//File Name:fifo_mem.sv                                                  //
//Authors: Shiva Prasad Balne, Ram Gopal Kasireddy, Praveen Kumar Palli  //
//Description: Fifo memory module for storing the data                   //
//			                                                             //
//                                                                       //
///////////////////////////////////////////////////////////////////////////


/*
Fifo memory module for storing the data. 
*/


module fifo_mem(async_fifo pin);
  logic [31:0] fifo[0:511];   //Defining FIFO memory
  
  
  always_ff@(posedge pin.w_clk or posedge pin.wrst) begin
	 if(pin.wrst) begin    //If write reset is asserted initialize all elements in the fifo to x.
		foreach(fifo[i]) begin
			fifo[i] <= 'x;
		end
	end
	else 
    if(pin.w_en && !pin.f_full)    // if write enable signal is asserted and FIFO is not full write data into the FIFO at the write pointer location.
      	fifo[pin.wptr[8:0]] <= pin.d_out;
	else
      	fifo[pin.wptr[8:0]] <= fifo[pin.wptr[8:0]];   //If the above condition does not meet have the same fifo data.
  end
  
  always_ff@(posedge pin.r_clk or posedge pin.rrst) begin
    if(pin.rrst) begin    
			pin.mem_data_out  <= 'x;
		end
	
    else if(pin.r_en && !pin.f_empty) // If read enable signal is asserted and FIFO is not empty read data from the FIFO at the read pointer location.
      	pin.mem_data_out <= fifo[pin.rptr[8:0]];
	else
		pin.mem_data_out <= 'x ; //pin.data_out;
  end
endmodule