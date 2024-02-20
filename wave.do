onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /top/w_clk
add wave -noupdate -format Logic -radix unsigned /top/r_clk
add wave -noupdate -format Logic -radix unsigned /top/wrst
add wave -noupdate -format Logic -radix unsigned /top/rrst
add wave -noupdate -format Logic -radix unsigned /top/wr_req
add wave -noupdate -format Literal -radix unsigned /top/data_in
add wave -noupdate -format Logic -radix unsigned /top/fifo_full
add wave -noupdate -format Logic -radix unsigned /top/fifo_empty
add wave -noupdate -format Literal -radix unsigned /top/data_out
add wave -noupdate -format Literal -radix unsigned /top/dut_inst/data_in
add wave -noupdate -format Logic -radix unsigned /top/dut_inst/fifo_full
add wave -noupdate -format Logic -radix unsigned /top/dut_inst/fifo_empty
add wave -noupdate -format Literal -radix unsigned /top/dut_inst/data_out
add wave -noupdate -format Logic -radix unsigned /top/dut_inst/w_en
add wave -noupdate -format Logic -radix unsigned /top/dut_inst/r_en
add wave -noupdate -format Literal -radix unsigned /top/dut_inst/wptr
add wave -noupdate -format Literal -radix unsigned /top/dut_inst/mem_data_out
add wave -noupdate -format Literal -radix unsigned /top/dut_inst/d_out
add wave -noupdate -format Literal -radix unsigned /top/dut_inst/rptr
add wave -noupdate -format Logic -radix unsigned /top/dut_inst/PRO/w_clk
add wave -noupdate -format Logic -radix unsigned /top/dut_inst/PRO/wrst
add wave -noupdate -format Logic -radix unsigned /top/dut_inst/PRO/wr_req
add wave -noupdate -format Literal -radix unsigned /top/dut_inst/PRO/data_in
add wave -noupdate -format Literal -radix unsigned /top/dut_inst/PRO/d_out
add wave -noupdate -format Logic -radix unsigned /top/dut_inst/PRO/w_en
add wave -noupdate -format Logic -radix unsigned /top/dut_inst/WP/w_clk
add wave -noupdate -format Logic -radix unsigned /top/dut_inst/WP/wrst
add wave -noupdate -format Logic -radix unsigned /top/dut_inst/WP/w_en
add wave -noupdate -format Literal -radix unsigned /top/dut_inst/WP/wptr
add wave -noupdate -format Logic -radix unsigned /top/dut_inst/WP/f_full
add wave -noupdate -format Logic -radix unsigned /top/dut_inst/my_fifo/r_en
add wave -noupdate -format Logic -radix unsigned /top/dut_inst/my_fifo/w_en
add wave -noupdate -format Literal -radix unsigned /top/dut_inst/my_fifo/rptr
add wave -noupdate -format Literal -radix unsigned /top/dut_inst/my_fifo/data_in
add wave -noupdate -format Literal -radix unsigned /top/dut_inst/my_fifo/data_out
add wave -noupdate -format Logic -radix unsigned /top/dut_inst/RP/r_clk
add wave -noupdate -format Logic -radix unsigned /top/dut_inst/RP/rrst
add wave -noupdate -format Logic -radix unsigned /top/dut_inst/RP/r_en
add wave -noupdate -format Literal -radix unsigned /top/dut_inst/RP/rptr
add wave -noupdate -format Logic -radix unsigned /top/dut_inst/CON/rd_req
add wave -noupdate -format Literal -radix unsigned /top/dut_inst/CON/mem_data_out
add wave -noupdate -format Logic -radix unsigned /top/dut_inst/CON/r_en
add wave -noupdate -format Literal -radix unsigned /top/dut_inst/CON/data_out
add wave -noupdate -format Literal -radix unsigned /top/dut_inst/CON/count
add wave -noupdate -format Logic -radix unsigned /top/dut_inst/CON/read_flag
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {170 ps} 0}
configure wave -namecolwidth 214
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {296 ps}
