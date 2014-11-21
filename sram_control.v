`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:39:23 11/21/2014 
// Design Name: 
// Module Name:    sram_control 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module sram_control(
			input [3:0] data_in,
			input [3:0] address_in,
			input write,
			input read,
			inout [3:0] sram_data,
			input clk,				//this is 10MHz
			input rst,
			output [3:0] data_out,
			output [3:0] address_out,
			output ce,
			output reg we,
			output oe,
			output sram_clk,
			output adv,
			output cre,
			output lb,
			output ub,
			output [1:0] state
			);

		parameter [1:0] s0 = 2'b0, s1 = 2'b01, s2 = 2'b10;
		reg [1:0] current_state, next_state;
		reg [3:0] address = 0;
		reg [3:0] data [0:3];
		
		assign sram_clk = 1'b0;
		assign adv = 1'b0;
		assign ce = 1'b0;
		assign oe = 1'b0;
		assign cre = 1'b0;
		assign lb = 1'b0;
		assign ub = 1'b0;
		assign address_out = address;
		assign data_out = data[address];
		assign state = current_state;
		assign sram_data = (we == 1'b0) ? data[address] : 4'bz;

		
//----------state machine for the control part-----------
				
		always@(posedge clk)
		begin			
			if(rst)
				current_state <= s0;
			else
				current_state <= next_state;
		end
		
		always@(current_state,write,read)
		begin
			case(current_state)
				s0 : begin
					we = 1'b0;
					if(write == 1)
						next_state = s1;
					else if(read == 1)
						next_state = s2;
					else
						next_state = s0;
					  end
				s1 : begin
					we = 1'b0;
					next_state = s0;
					  end
				s2 : begin
					we = 1'b1;
					next_state = s0;
					  end
				default : begin next_state = s0; we = 1'b0; end
			endcase
		end
//-----this is for the address part------
// if write , address = address + 1
// if read,   address = sw 		

		always@(posedge clk)
		begin
			if(current_state == s1)
				address <= address + 1'b1;
			else if(current_state == s2)
				address <= address_in;
			else
				address <= address;
		end
		
//-----this is for the data part----
// if write, data = sw
// if read, data = sram_data
		
		always@(posedge clk)
		begin
			if(current_state == s1)
				data[address] <= data_in;
			else if(current_state == s2)
				data[address] <= sram_data;
			else
				data[address] <= data[address];		
		end


endmodule
