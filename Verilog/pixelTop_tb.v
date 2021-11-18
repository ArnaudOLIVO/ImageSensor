`timescale 1 ns / 1 ps


module pixelTop_tb;


	//------------------------------------------------------------
	// Testbench clock
	//------------------------------------------------------------
	logic clk =0;
	logic reset =0;
	parameter integer clk_period = 500;
	parameter integer sim_end = clk_period*2400;
	always #clk_period clk=~clk;

   	tri[15:0]         pixData; //  We need this to be a wire, because we're tristating it

	pixelTop #() top(.clk(clk),.reset(reset),.pixelDataOut(pixData));


	//------------------------------------------------------------
   // Testbench stuff
   //------------------------------------------------------------
   initial
     begin
        reset = 1;

        #clk_period  reset=0;

        $dumpfile("pixelTop_tb.vcd");
        $dumpvars(0,pixelTop_tb);

        #sim_end
          $stop;

   	end
   	
endmodule // pixelTop_tb

