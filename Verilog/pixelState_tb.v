`timescale 1 ns / 1 ps


module pixelState_tb;

	//------------------------------------------------------------
	// Testbench clock
	//------------------------------------------------------------
	logic clk =0;
	logic reset =0;
	parameter integer clk_period = 500;
	parameter integer sim_end = clk_period*2400;
	always #clk_period clk=~clk;


   //Digital
   logic              erase;
   logic              expose;
   logic[3:0]         read;
   logic             convert;

	pixelState #(.c_erase(5),.c_expose(255),.c_convert(255),.c_read(5))
	fsm1(.clk(clk),.reset(reset),.erase(erase),.expose(expose),.read(read),.convert(convert));


	initial
	begin
		reset = 1;

	#clk_period  reset=0;

		$dumpfile("pixelState_tb.vcd");
		$dumpvars(0,pixelState_tb);

	#sim_end
	 $stop;

	end

endmodule // pixelState_tb
