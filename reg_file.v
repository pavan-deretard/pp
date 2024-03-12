`timescale 1ns/1ns
module reg_file(clk,w_en,reg_n,reg_m,reg_s,reg_d,w_data,operand_1,operand_2,shift_amt);
input wire clk,w_en;
input wire[3:0] reg_n,reg_m,reg_s,reg_d;
input wire[31:0] w_data;
output reg[31:0] operand_1,operand_2,shift_amt;
reg[31:0] regs[15:0];
always @* begin
	if(clk) begin
		#1
		operand_1<=regs[reg_n];
		operand_2<=regs[reg_m];
		shift_amt<=regs[reg_s];
		if(w_en) begin
			regs[reg_d]<=w_data;
		end
	end
	else begin
		operand_1<=operand_1;
		operand_2<=operand_2;
		shift_amt<=shift_amt;
	end
end
endmodule

module reg_file_tb();
reg clk,w_en;
reg[3:0] reg_n,reg_m,reg_s,reg_d;
reg[31:0] w_data;
wire[31:0] operand_1,operand_2,shift_amt;
reg_file r1(clk,w_en,reg_n,reg_m,reg_s,reg_d,w_data,operand_1,operand_2,shift_amt);
always #5 clk=~clk;
initial begin
clk=0;
w_en=1;
reg_n=1;
reg_m=2;
reg_s=1;
reg_d=5;
w_data=$random;
#10
w_en=1;
reg_n=5;
reg_m=2;
reg_s=5;
reg_d=1;
w_data=$random;
#10
w_en=0;
reg_n=$random;
reg_m=$random;
reg_s=$random;
reg_d=3;
w_data=$random;
#10
w_en=1;
reg_n=3;
reg_m=$random;
reg_s=$random;
reg_d=8;
w_data=$random;
#10
w_en=$random;
reg_n=$random;
reg_m=$random;
reg_s=$random;
reg_d=$random;
w_data=$random;
#10;
end

endmodule
