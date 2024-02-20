vlib work

vlog   packages.sv  
vlog   interface.sv 
#vlog   packet.sv

vlog   design_interface.sv  
vlog   WRITE_POINTER_LOGIC.sv  
vlog   RPTR_LOGIC.sv  
vlog   synchronizer.sv  
vlog   cons.sv  
vlog   PRODUCER.sv  
vlog   fifo_mem.sv  
vlog   top_design.sv 
  
#vlog   generator.sv  
#vlog   driver.sv  
#vlog   monitor.sv  
#vlog   scoreboard.sv  
vlog   environment.sv  
vlog   test0.sv  
vlog   top_tb.sv  
 

vsim work.top

add wave -r *
#do wave.do
 run -all