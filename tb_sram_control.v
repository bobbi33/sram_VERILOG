`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:11:13 11/21/2014
// Design Name:   sram_control
// Module Name:   E:/wpi_course/2014fall/ECE574/SRAM/SRAM/tb_sram_control.v
// Project Name:  SRAM
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: sram_control
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_sram_control;

	// Inputs
	reg [3:0] data_in;
	reg [3:0] address_in;
	reg write;
	reg read;
	reg clk;
	reg rst;

	// Outputs
	wire [3:0] data_out;
	wire [3:0] address_out;
	wire ce;
	wire we;
	wire oe;
	wire sram_clk;
	wire adv;
	wire cre;
	wire lb;
	wire ub;
	wire [1:0] state;

	// Bidirs
	wire [3:0] sram_data;
	
	always #1 clk = ~clk;

	// Instantiate the Unit Under Test (UUT)
	sram_control uut (
		.data_in(data_in), 
		.address_in(address_in), 
		.write(write), 
		.read(read), 
		.sram_data(sram_data), 
		.clk(clk), 
		.rst(rst), 
		.data_out(data_out), 
		.address_out(address_out), 
		.ce(ce), 
		.we(we), 
		.oe(oe), 
		.sram_clk(sram_clk), 
		.adv(adv), 
		.cre(cre), 
		.lb(lb), 
		.ub(ub), 
		.state(state)
	);

	initial begin
		// Initialize Inputs
		data_in = 0;
		address_in = 0;
		write = 0;
		read = 0;
		clk = 0;
		rst = 0;

		// Wait 100 ns for global reset to finish
		#10;
		
		rst = 1;
		#5;
		rst = 0;
		
		data_in = 4'd1;
		address_in = 4'd1;
		write = 1;
		#3;
		write = 0;
		#5;
		
		data_in = 4'd2;
		address_in = 4'd2;
		write = 1;
		#3;
		write = 0;
		#5;
		
		data_in = 4'd3;
		address_in = 4'd3;
		write = 1;
		#3;
		write = 0;
		#5;
		
		data_in = 4'd4;
		address_in = 4'd4;
		write = 1;
		#3;
		write = 0;
		#5;
		
	#10;
	
	
		address_in = 4'd1;
		read = 1;
		#5;
		read = 0;
		#5;
		
		address_in = 4'd2;
		read = 1;
		#5;
		read = 0;
		#5;
		
		address_in = 4'd3;
		read = 1;
		#5;
		read = 0;
		#5;
		
		address_in = 4'd4;
		read = 1;
		#5;
		read = 0;
		#5;
		#50;
		$stop;
		
	end
      
endmodule

