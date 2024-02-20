`include "environment.sv"
program test(tintf inf);
  
  class my_packet extends packet;
    constraint c1 {wr_req == 1;}
	
	constraint c2 {rd_req == 1;}
    
  endclass
    
  //declaring environment instance
  environment env;
  my_packet my_pkt;
  
  initial begin
    //creating environment
    env = new(inf);
    
    my_pkt = new;
    
    //setting the repeat count of generator as 10, means to generate 10 packets
    env.gen.repeat_count = 10;
    
    env.gen.pkt = my_pkt;
    
    //calling run of env, it interns calls generator and driver main tasks.
    env.run();
	//$finish;
  end
endprogram