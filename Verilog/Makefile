
ps:
	iverilog -g2012 -o pixelSensor -c pixelSensor.fl
	vvp -n pixelSensor
	
	
array:
	iverilog -g2012 -o pixelArray -c pixelArray.fl
	vvp -n pixelArray
	
	
state:
	iverilog -g2012 -o pixelState -c pixelState.fl
	vvp -n pixelState
	
top:
	iverilog -g2012 -o pixelTop -c pixelTop.fl
	vvp -n pixelTop



psfsm:
	iverilog -g2012 -o pixelSensorFsm -c pixelSensorFsm.fl
	vvp -n pixelSensorFsm


ysfsm: synth
	dot pixelSensorFsm.dot -Tpng > pixelSensorFsm.png

synth:
	yosys pixelSensorFsm.ys


test: ps psfsm synth
