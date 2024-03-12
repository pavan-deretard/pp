`timescale 1ns/1ns
module decode(inst,clk,alu_op,mf_op,reg_n,reg_d,operand,s_cpsr,dp_dt,r_i);	
input wire[31:0] inst;																			//31:28 27:26 25 24:21 20 19:16 15:12 
input wire clk;																					//cond  fmt 	I  opc  S   Rn   Rd
output reg[3:0] alu_op;
output reg[5:0] mf_op;
output reg[3:0] reg_n,reg_d;
output reg[11:0] operand;
output reg s_cpsr,dp_dt,r_i;
always @(posedge clk) begin
	#1
	case(inst[31:28])																//cond
		4'b1110: begin 													// always	
						reg_n<=inst[19:16];		//operand_1
						reg_d<=inst[15:12];		//destination
						case(inst[27:26])								
							2'b00:begin												//data processing
										dp_dt<=1'b1;
										mf_op<=6'hxx;
										if(inst[20]) begin	
											s_cpsr=1;
										end
										else begin
											s_cpsr=0;
										end
										if(inst[25]) begin						//intermediate 
											r_i<=1'b0;
										end
										else begin									//register
											r_i<=1'b1;
										end
										alu_op<=inst[24:21];
										operand<=inst[11:0];
									end
							2'b01:begin												//data transfer
									dp_dt<=1'b0;
									s_cpsr=0;
									alu_op<=4'hx;
									mf_op<=inst[25:20];
									operand<=inst[11:0];
									end
						endcase
					end
		endcase
end
endmodule


module decode_tb();
reg[31:0] inst; 
reg clk;
wire[3:0] alu_op;
wire[5:0] mf_op;
wire[3:0] reg_n,reg_d;
wire[11:0] operand;
wire s_cpsr,dp_dt,r_i;
decode d1(inst,clk,alu_op,mf_op,reg_n,reg_d,operand,s_cpsr,dp_dt,r_i);
always #5 clk=~clk;
initial begin
clk=0;
	inst=32'he0810002; #15
	inst=32'he0443005; #10
	inst=32'he1a07128;#10;

end
endmodule
