`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:28:12 11/21/2014
// Design Name:   debounce
// Module Name:   E:/wpi_course/2014fall/ECE574/SRAM/SRAM/tb_debounce.v
// Project Name:  SRAM
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: debounce
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_debounce;

	// Inputs
	reg clk;
	reg rst;
	reg btn_in;

	// Outputs
	wire btn_out;

	always #5 clk = ~clk;
	
	// Instantiate the Unit Under Test (UUT)
	debounce uut (
		.clk(clk), 
		.rst(rst), 
		.btn_in(btn_in), 
		.btn_out(btn_out)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		btn_in = 0;

		// Wait 100 ns for global reset to finish
		#10;
		
		rst = 1;
		#20;
		rst = 0;
		#20;
		
		btn_in = 1;
		
		#100000000;
		
		btn_in = 0;
		
		#20000;
		$stop;
		
		
	end
      
endmodule

