`timescale 1ns/1ns

module pp(clk,inst,alu_op,mf_op,reg_d,s_cpsr,dp_dt,r_i,operand_1,operand_2,r_reg_add_2,r_reg_add_1,r_reg_add_s);
input wire[31:0] inst; 
input wire clk;	
output reg[3:0] alu_op;
output reg[5:0] mf_op;
output reg[3:0] reg_d;
output reg s_cpsr,dp_dt,r_i;
output reg[31:0] operand_1,operand_2;
output reg[3:0] r_reg_add_2,r_reg_add_1,r_reg_add_s;

wire[3:0] in_alu_op;
wire[5:0] in_mf_op;
wire[3:0] in_reg_n,in_reg_d;
wire[11:0] in_operand;
wire in_s_cpsr,in_dp_dt,in_r_i;


wire[31:0] opr_1,opr_2,opr_s;
wire[3:0] in_r_reg_add_2,in_r_reg_add_1,in_r_reg_add_s;




decode d1(inst,clk,in_alu_op,in_mf_op,in_reg_n,in_reg_d,in_operand,in_s_cpsr,in_dp_dt,in_r_i);
read r1(in_dp_dt,in_r_i,in_mf_op,in_reg_n,in_reg_d,in_operand,clk,in_operand_1,in_operand_2,in_r_reg_add_2,in_r_reg_add_1,in_r_reg_add_s,in_opr_1,in_opr_2,in_opr_s);

always @* begin

alu_op <= in_alu_op;
mf_op <= in_mf_op;
reg_d <= in_reg_d;
s_cpsr <= in_s_cpsr; 
dp_dt <= in_dp_dt; 
r_i <= in_r_i;
operand_1 <= in_operand_1; 
operand_2 <= in_operand_2;
r_reg_add_2 <= in_r_reg_add_2; 
r_reg_add_1 <= in_r_reg_add_1; 
r_reg_add_s <= in_r_reg_add_s;

end

endmodule

module prog_cache();
reg[31:0] inst; 
reg clk;	
	
wire [3:0] alu_op;
wire [5:0] mf_op;
wire [3:0] reg_d;
wire s_cpsr, dp_dt, r_i;
wire [31:0] operand_1, operand_2;
wire [3:0] r_reg_add_2, r_reg_add_1, r_reg_add_s;


pp p1(clk,inst,alu_op,mf_op,reg_d,s_cpsr,dp_dt,r_i,operand_1,operand_2,r_reg_add_2,r_reg_add_1,r_reg_add_s);


always begin
#5 clk=~clk;
end


initial begin
clk=0;
inst=32'h e28db000; #15
inst=32'h e24dd00c; #10
inst=32'h e3a03005; #10
inst=32'h e50b3008; #10
inst=32'h e3a03006; #10
inst=32'h e50b300c; #10
inst=32'h e51b200c; #10
inst=32'h e51b3008; #10
inst=32'h e0823003; #10
inst=32'h e50b300c; #10
inst=32'h e3a03000; #10
inst=32'h e1a00003; #10
inst=32'h e28bd000; #10;

end
endmodule
