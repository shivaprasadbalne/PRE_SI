all:	clean compile run

compile:
	vlib work
	vlog -source -coveropt 3 +cover -lint  testbench.sv 

run:
	vsim -coverage -vopt top -c -voptargs=+acc=npr -do "coverage save -onexit cov_report; run -all; quit"
	vcover report cov_report > coverage_report.txt

clean:
	rm -rf transcript work/ *.vcd *.txt *.ucdb