`timescale 1ns/1ns
module read(dp_dt,r_i,mf_op,reg_n,reg_d,operand,clk,operand_1,operand_2,r_reg_add_2,r_reg_add_1,r_reg_add_s,opr_1,opr_2,opr_s);
input wire[5:0] mf_op;
input wire[3:0] reg_n,reg_d;
input wire[11:0] operand;
input wire[31:0] opr_1,opr_2,opr_s;
input wire clk,dp_dt,r_i;
output reg[31:0] operand_1,operand_2;
output reg[3:0] r_reg_add_2,r_reg_add_1,r_reg_add_s;
always @(posedge clk) begin								//fetch
#1
case(dp_dt)
	1:begin
			if(r_i) begin					//register
				r_reg_add_2<=operand[3:0];
				if(operand[4]) begin			//shift
					r_reg_add_s<=operand[11:8];
					end
				else begin
					r_reg_add_s<=4'hx;
					end
				r_reg_add_1<=reg_n;
			end
			else begin					//intermediate
				r_reg_add_1<=reg_n;
				r_reg_add_2<=4'hx;
				r_reg_add_s<=4'hx;
				end
		end
	0:begin
		end
endcase
end

always @* begin
	if(clk) begin
		operand_1<=opr_1;
		if(!r_i) begin
			operand_2<=operand[7:0]<<operand[11:8];
			end
		else begin
			if(!operand[4]) begin
				case(operand[6:5])
					0:operand_2<=opr_2<<operand[11:7];
					1:operand_2<=opr_2>>operand[11:7];
					2:operand_2<=opr_2<<<operand[11:7];
					3:operand_2<=opr_2>>>operand[11:7];
					endcase
				end
			else begin
				case(operand[6:5])
					0:operand_2<=opr_2<<opr_s;
					1:operand_2<=opr_2>>opr_s;
					2:operand_2<=opr_2<<<opr_s;
					3:operand_2<=opr_2>>>opr_s;
					endcase
				end
			end
		end
end
endmodule


