///////////////////////////////////////////////////////////////////////////
//Project Name: Design and Verification of Asynchronous FIFO using UVM   //
//File Name:testbench.sv                                                 //
//Authors: Shiva Prasad Balne, Ram Gopal Kasireddy, Praveen Kumar Palli  //
//Description:testbench of the design                                    //
//			                                                             //
//																		 //
///////////////////////////////////////////////////////////////////////////
//`timescale 1ns/1ps;
`include "uvm_macros.svh"
import uvm_pkg::*;
`include "FILES.sv"

module top;
parameter WR_FREQ = 750; //in MHz
parameter RD_FREQ = 250; //in MHz
parameter DUTY = 50;

real wr_clk_pd = 1.0/(WR_FREQ*1e6) * 1e9; // convert to ns
real wr_clk_on = DUTY/100.0 * wr_clk_pd;
real wr_clk_off = (100.0 - DUTY)/100.0 * wr_clk_pd;

real rd_clk_pd = 1.0/(RD_FREQ*1e6) * 1e9; // convert to ns
real rd_clk_on = DUTY/100.0 * rd_clk_pd;
real rd_clk_off = (100.0 - DUTY)/100.0 * rd_clk_pd;


	bit w_clk,r_clk;
	//bit wrst,rrst;
	
	tintf tintf_inst(w_clk,r_clk);
	
	Async_FIFO dut_inst(tintf_inst.dut_modport);
	
	
	
	always begin
	w_clk= 1;
	#wr_clk_on;
	w_clk= 0;
	#wr_clk_off;
	end
	always begin
	r_clk= 1;
	#rd_clk_on;
	r_clk= 0;
	#rd_clk_off;
	end
	

  initial begin
$display("*****************************************");
$display("        WRITE CLOCK GENERATION           ");
$display("*****************************************");
$display (" WR_FREQ= %0d in MHz",WR_FREQ);
$display (" wr_clk_pd= %0.3f in ns",wr_clk_pd);
$display (" wr_clk_on= %0.3f in ns", wr_clk_on);
$display (" wr_clk_off= %0.3f in ns", wr_clk_off);

$display("*****************************************");
$display("        READ CLOCK GENERATION            ");
$display("*****************************************");
$display (" RD_FREQ= %0d in MHz",RD_FREQ);
$display (" rd_clk_pd= %0.3f in ns",rd_clk_pd);
$display (" rd_clk_on= %0.3f in ns",rd_clk_on);
$display (" rd_clk_off= %0.3f in ns",rd_clk_off);
    // set interface in config_db
    uvm_config_db#(virtual tintf)::set(uvm_root::get(), "*", "tintf_i", tintf_inst);
   
  end
  initial begin
    run_test("base_test");
  end	
	
endmodule