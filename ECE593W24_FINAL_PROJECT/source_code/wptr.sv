///////////////////////////////////////////////////////////////////////////
//Project Name: Design and Verification of Asynchronous FIFO using UVM   //
//File Name:wptr.sv                                                      //
//Authors: Shiva Prasad Balne, Ram Gopal Kasireddy, Praveen Kumar Palli  //
//Description:Write pointer module for generating write pointer binary   //
//			  values and convert them to gray values and also to         //
//			  evaluate the fifo full condition.							 //
///////////////////////////////////////////////////////////////////////////

module WPTR_LOGIC (async_fifo.wr_ptr_if wif);

//To generate the gray code for the write pointer by an XOR operation on the right-shifted write pointer.
  assign wif.wptr_gray = wif.wrst?0:(wif.wptr >>1)^wif.wptr;
  
  always@(posedge wif.w_clk or posedge wif.wrst) begin
    if(wif.wrst) begin   //If write reset is asserted set the write pointer value to 0.
      wif.wptr <= 0; 
    end
    else begin
	if(wif.w_en && !wif.f_full) //If write enable is asserted and fifo is not full increment the write pointer by 1 otherwise maintain the same write pointer value.
		wif.wptr <= wif.wptr+ 1'b1;
	else
		wif.wptr <= wif.wptr;
	end
  end 
  // Logic to generate fifo full condition.
  assign wif.f_full = wif.wrst?0:(wif.wptr_gray=={~wif.rptr_gray_sync[9:8], wif.rptr_gray_sync[7:0]});
  
endmodule
