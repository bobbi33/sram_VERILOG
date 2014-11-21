`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:13:03 11/21/2014 
// Design Name: 
// Module Name:    seven_seg_top 
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
module seven_seg_top(
			input clk,			// this is 100MHz
			input rst,
			input [15:0] data_in,
			output [7:0] seg,
			output reg [3:0] ctl
    );
	 
		reg [12:0] count;
		reg clk_low;
		reg [1:0] choose;
		reg [3:0] din;
		
		seven_seg_decoder seg1 (
			.data_in(din), 
			.data_out(seg)
			);
		
//-------generate a low frequency clock		
		always@(posedge clk)
		begin
			if(rst)
			begin
				count <= 13'b0;
				clk_low <= 13'b0;
			end
			else 
			begin
				count <= count + 1'b1;
				if(count == 13'd5000)
				begin
					count <= 13'b0;
					clk_low <= ~clk_low;
				end
			end
		end

//------choose which seven seg is on-----
	
	always@(posedge clk_low)
	begin
		if(rst)
			choose <= 2'b0;
		else
		begin 
			choose <= choose + 1'b1;
		end
	end
	
	always@(choose,data_in)
	begin
		case(choose)
			2'b00 : begin ctl = 4'b0111; din = data_in[15:12]; end
			2'b01 : begin ctl = 4'b1011; din = data_in[11:8]; end
			2'b10 : begin ctl = 4'b1101; din = data_in[7:4]; end
			2'b11 : begin ctl = 4'b1110; din = data_in[3:0]; end
		endcase
	end
//-----------		

endmodule
