`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:29:03 11/21/2014 
// Design Name: 
// Module Name:    debounce 
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
module debounce(
		input clk,			// this is 10Mhz
		input rst,
		input btn_in,
		output reg btn_out
    );
	 
	 reg [19:0] count;
	 
	 always@(posedge clk)
	 begin
		if(rst)
		begin
			count <= 0;
			btn_out <= 0;
		end
		else
		begin
			if(btn_in == 1)
			begin
				count <= count + 1'b1;
				if(count == 20'd1000000)
				begin
					btn_out <= 1'b1;
					count <= 0;
				end
				else
					btn_out <= 1'b0;
			end
		end
	 end
	
	 

endmodule
