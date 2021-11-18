

`timescale 1 ns / 1 ps


module pixelTop(
				input logic        clk,
				input logic      reset,
				output [15:0]      pixelDataOut
			);
				
	
		//------------------------------------------------------------
		// Pixel
		//------------------------------------------------------------
		parameter real    dv_pixel = 0.5;  //Set the expected photodiode current (0-1)

	//Analog signals
	logic              anaBias1;
	logic              anaRamp;
	logic              anaReset;

	assign anaReset = 1;

	//Digital
	wire              erase;
	wire              expose;
	wire [3:0]         read;
	wire             convert;

	tri[15:0]         pixData; //  We need this to be a wire, because we're tristating it
	
	//Instanciate the pixel
	pixelArray  #(.dv_pixel(dv_pixel))  ps1(.VBN1(anaBias1),.RAMP(anaRamp), .RESET(anaReset), .ERASE(erase),.EXPOSE(expose), .READ(read),.DATA(pixData));
	
	//Instanciate the state machine
	
	pixelState #(.c_erase(5),.c_expose(255),.c_convert(255),.c_read(5))
	
 	fsm1(.clk(clk),.reset(reset),.erase(erase),.expose(expose),.read(read),.convert(convert));




	//------------------------------------------------------------
	// DAC and ADC model
	//------------------------------------------------------------
	logic[7:0] data;

	// If we are to convert, then provide a clock via anaRamp
	// This does not model the real world behavior, as anaRamp would be a voltage from the ADC
	// however, we cheat
	assign anaRamp = convert ? clk : 0;

	// During expoure, provide a clock via anaBias1.
	// Again, no resemblence to real world, but we cheat.
	assign anaBias1 = expose ? clk : 0;

	// If we're not reading the pixData, then we should drive the bus
	assign pixData = read ? 16'bZ: {2{data}};

	// When convert, then run a analog ramp (via anaRamp clock) and digtal ramp via
	// data bus.
	always_ff @(posedge clk or posedge reset) begin
		if(reset) begin
			data =0;
		end
		if(convert) begin
			data +=  1;
		end
		else begin
			data = 0;
		end
	end // always @ (posedge clk or reset)


 	//------------------------------------------------------------
 	// Readout from databus
 	//------------------------------------------------------------
	logic [15:0] pixelDataOut;
	always_ff @(posedge clk or posedge reset) begin
		if(reset) begin
			pixelDataOut = 0;
		end
		else begin
			if(read == 4'b1100 || read== 4'b0011)begin
				pixelDataOut <= pixData;
			end
			else begin
				pixelDataOut <= 0;
			end 
		end
	end

endmodule // pixelTop