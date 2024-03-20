///////////////////////////////////////////////////////////////////////////
//Project Name: Design and Verification of Asynchronous FIFO using UVM   //
//File Name:rptr.sv                                                      //
//Authors: Shiva Prasad Balne, Ram Gopal Kasireddy, Praveen Kumar Palli  //
//Description: Read pointer module for generating read                   //
//			   pointer binary values and convert them to gray            //
//             values and also to evaluate the fifo empty condition      //
///////////////////////////////////////////////////////////////////////////

/*
  .
*/

module RPTR_LOGIC (async_fifo.rd_ptr_if rif);

  logic [9:0] b_rptr_next;
  logic [9:0] g_rptr_next;
  logic rempty;
  
// Calculating the next binary read pointer value based on the current read pointer value, read enable, and FIFO empty status.
  assign b_rptr_next = rif.rptr+(rif.r_en & !rif.f_empty);
  
  // Convert the binary next read pointer value to Gray code.
  assign g_rptr_next = (b_rptr_next >>1)^b_rptr_next;
  
  //Evaluating FIFO empty by comparing write pointer gray value from the synchronizer to gray read pointer next value.
  assign rempty = (rif.wptr_gray_sync == g_rptr_next);
  
  always@(posedge rif.r_clk or posedge rif.rrst) begin
    if(rif.rrst) begin  //If read reset is asserted set read pointer values to 0.
      rif.rptr <= 0;
      rif.rptr_gray <= 0;
    end
    else begin
      rif.rptr <= b_rptr_next;
      rif.rptr_gray <= g_rptr_next;
    end
  end
  
  always@(posedge rif.r_clk or posedge rif.rrst) begin
    if(rif.rrst) rif.f_empty <= 1; //If read reset assert fifo empty high.
    else        rif.f_empty <= rempty;
  end	
	
endmodule 