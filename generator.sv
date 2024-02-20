//`include "packet.sv"
import pkg::*;
class generator;
	
  
  //declaring transaction class 
  packet pkt;
  
  //repeat count, to specify number of items to generate
  int  repeat_count;
  
  //mailbox, to generate and send the packet to driver
  //mailbox #(packet) gen2driv;
  mailbox gen2driv;
  
  //event, to indicate the end of transaction generation
  event ended;
  
  //constructor
  function new(input mailbox gen2driv);
    //getting the mailbox handle from env, in order to share the transaction packet between the generator and driver, the same mailbox is shared between both.
    this.gen2driv = gen2driv;
    //this.repeat_count = repeat_count;
    //this.pkt = pkt;
	//pkt = new;
  endfunction
  
  //main task, generates(create and randomizes) the repeat_count number of transaction packets and puts into mailbox
  task main();
  //packet pkt;
  
    repeat(repeat_count) begin
      pkt = new();
      assert(pkt.randomize());
      //if( !pkt.randomize() ) $fatal("Gen:: trans randomization failed");
      pkt.display("[ Generator ]");
      gen2driv.put(pkt);
    end
    -> ended; //triggering indicatesthe end of generation
  endtask
  
endclass