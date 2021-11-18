// Pixel_array 

module pixelArray(   
	input logic      VBN1,
	input logic      RAMP,
	input logic      RESET,
	input logic      ERASE,
	input logic      EXPOSE,
	input [3:0]      READ,
	inout [(N*8-1):0]      DATA
	);
	
	parameter real    dv_pixel = 0.5;  //Set the expected
	parameter integer N = 2;


genvar i;
genvar j;
generate
	for(j=0; j<N; j++) begin
	  for(i=0; i<N; i++) begin
		PIXEL_SENSOR  #(.dv_pixel(dv_pixel))  ps1(VBN1, 
			RAMP, 
			RESET, 
			ERASE,
			EXPOSE, 
			READ[i+(j*N)],
			DATA[(1+i)*8-1:i*8]);
	  end
	end

endgenerate

endmodule
	
	

