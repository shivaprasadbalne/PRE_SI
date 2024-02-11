vlib work

vlog WRITE_POINTER_LOGIC.sv -sv
#vlog WRITE_POINTER_TB.sv -sv
vlog RPTR_LOGIC.sv -sv
#vlog RPTR_TB.sv -sv
vlog synchronizer.sv -sv
#vlog synchronizer_tb.sv -sv
vlog CONSUMER.sv -sv
#vlog CONSUMER_TB.sv -sv
vlog PRODUCER.sv -sv
#vlog PRODUCER_TB.sv -sv
vlog fifo_mem.sv -sv
vlog top_design.sv -sv
vlog top_tb.sv -sv

vsim work.top

add wave -r *
 run -all