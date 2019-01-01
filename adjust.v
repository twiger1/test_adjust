input [2:0] code_num_i;			 //这个变量表示有多少个码字需要译码
input [7:0] LLR1_i;				 //LLR_i数据输入口
input [7:0] LLR2_i;
input [7:0] LLR3_i;
input [7:0] LLR4_i;
input [7:0] LLR5_i;
input [7:0] LLR6_i;
input LLR_data_start_i;			//表示开始传输数据的标志，其实也是code_num_i配置完成的象征
input LLR_data_valid_i;			//表示LLR数据有效的信号

output reg LLR_data_ready_o;			//表示模块是否准备好接受LLR信息

		
/*******************************************************多码字的读入***************************************************/
reg [3:0] cnt;										//这个计数表示接收到了多少信息位
always @(posedge clk or negedge rst_n)
	if(!rst_n)
		begin
			cnt <= 4'd0;
		end
	else if(LLR_data_valid_i && LLR_data_ready_o)	//有效同时准备好
		begin
			cnt <= cnt + 1'b1;
		end
	else	
		begin
			cnt <= cnt;
		end
		
reg LLR_recept_over_flag;							//这个信号表示数据接受完毕
always @(posedge clk or negedge rst_n)
	if(!rst_n)
		begin
			LLR_data_ready_o <= 1'b1;
			LLR_recept_over_flag <= 1'b0;
		end
	else if(LLR_data_ready_o && LLR_data_valid_i && cnt == 4'd15)
		begin
			LLR_data_ready_o <= 1'b0;		        //将LLR_data_ready_o拉高的时间是迭代完成的时候，还需要在思考？？？？
			LLR_recept_over_flag <= 1'b1;			//将LLR_recept_over_flag拉低的时间是迭代完成的时候，还需要在思考？？？？
		end
	else
		begin
			LLR_data_ready_o <= LLR_data_ready_o;
			LLR_recept_over_flag <= LLR_recept_over_flag;
		end
		
wire [6:1] LLR_en;									//LLR_en控制不同码字的使能信号
always @(*)
	case code_num_i:
		1: LLR_en = 6'b000001;
		2: LLR_en = 6'b000011;
		3: LLR_en = 6'b000111;
		4: LLR_en = 6'b001111;
		5: LLR_en = 6'b011111;
		6: LLR_en = 6'b111111;
		default:
		   LLR_en = 6'b000000;
	endcase
	
reg [7:0] LLR1 [16:1];			                    //存放第一个码字的所有信息
always @(posedge clk or negedge rst_n)
	if(!rst_n)	
		begin
			for(i=1;i<=N;i=i+1)
				LLR1[i] <= 8'd0;
		end
	else if(LLR_data_valid_i && LLR_data_ready_o && LLR_en[1])
		begin
			LLR1[cnt+1] <= LLR1_i;
		end
	else if(LLR_data_valid_i && LLR_data_ready_o && !LLR_en[1])
		begin
			LLR1[cnt+1] <= 1'b0;
		end
	else	
		begin
			for(i=1;i<N;i=i+1)
				LLR1[i] = LLR[i];
		end 

reg [7:0] LLR2 [16:1];			                    //存放第一个码字的所有信息
always @(posedge clk or negedge rst_n)
	if(!rst_n)	
		begin
			for(i=1;i<=N;i=i+1)
				LLR2[i] <= 8'd0;
		end
	else if(LLR_data_valid_i && LLR_data_ready_o && LLR_en[2])
		begin
			LLR2[cnt+1] <= LLR2_i;
		end
	else if(LLR_data_valid_i && LLR_data_ready_o && !LLR_en[2])
		begin
			LLR2[cnt+1] <= 1'b0;
		end
	else	
		begin
			for(i=1;i<N;i=i+1)
				LLR2[i] = LLR2[i];
		end

reg [7:0] LLR3 [16:1];			                    //存放第一个码字的所有信息
always @(posedge clk or negedge rst_n)
	if(!rst_n)	
		begin
			for(i=1;i<=N;i=i+1)
				LLR3[i] <= 8'd0;
		end
	else if(LLR_data_valid_i && LLR_data_ready_o && LLR_en[3])
		begin
			LLR3[cnt+1] <= LLR3_i;
		end
	else if(LLR_data_valid_i && LLR_data_ready_o && !LLR_en[3])
		begin
			LLR3[cnt+1] <= 1'b0;
		end
	else	
		begin
			for(i=1;i<N;i=i+1)
				LLR3[i] = LLR3[i];
		end

reg [7:0] LLR4 [16:1];			                    //存放第一个码字的所有信息
always @(posedge clk or negedge rst_n)
	if(!rst_n)	
		begin
			for(i=1;i<=N;i=i+1)
				LLR4[i] <= 8'd0;
		end
	else if(LLR_data_valid_i && LLR_data_ready_o && LLR_en[4])
		begin
			LLR4[cnt+1] <= LLR4_i;
		end
	else if(LLR_data_valid_i && LLR_data_ready_o && !LLR_en[4])
		begin
			LLR4[cnt+1] <= 1'b0;
		end
	else	
		begin
			for(i=1;i<N;i=i+1)
				LLR4[i] = LLR4[i];
		end

reg [7:0] LLR5 [16:1];			                    //存放第一个码字的所有信息
always @(posedge clk or negedge rst_n)
	if(!rst_n)	
		begin
			for(i=1;i<=N;i=i+1)
				LLR5[i] <= 8'd0;
		end
	else if(LLR_data_valid_i && LLR_data_ready_o && LLR_en[5])
		begin
			LLR5[cnt+1] <= LLR5_i;
		end
	else if(LLR_data_valid_i && LLR_data_ready_o && !LLR_en[5])
		begin
			LLR5[cnt+1] <= 1'b0;
		end
	else	
		begin
			for(i=1;i<N;i=i+1)
				LLR5[i] = LLR5[i];
		end

reg [7:0] LLR6 [16:1];			                    //存放第一个码字的所有信息
always @(posedge clk or negedge rst_n)
	if(!rst_n)	
		begin
			for(i=1;i<=N;i=i+1)
				LLR6[i] <= 8'd0;
		end
	else if(LLR_data_valid_i && LLR_data_ready_o && LLR_en[6])
		begin
			LLR6[cnt+1] <= LLR6_i;
		end
	else if(LLR_data_valid_i && LLR_data_ready_o && !LLR_en[6])
		begin
			LLR6[cnt+1] <= 1'b0;
		end
	else	
		begin
			for(i=1;i<N;i=i+1)
				LLR6[i] = LLR6[i];
		end
/************************************************************PE使能的控制***********************************************************************/
		
reg [5:0] PE_shift_reg;            					 //这个移位寄存器表示哪一些PE会使能
reg PE_shift_flag;
always @(posedge clk or negedge rst_n)
	if(!rst_n)
		begin
			PE_shift_flag <= 1'b0;
		end
	else if(LLR_recept_over_flag)	
		begin
			PE_shift_flag <= 1'b1;					//将PE_shift_flag拉低的时间是迭代完成的时候，还需要在思考？？？？
		end
	else
		begin
			PE_shift_flag <= PE_shift_flag;
		end
always @(posedge clk or negedge rst_n)
	if(!rst_n)
		begin
			PE_shift_reg <= 6'b000000;				//左边三个0表示左边的123个pe， 右边表示右侧的三个pe
		end
	else if(LLR_recept_over_flag)     		        //检测到开始发送数据，则更新PE_shift_reg
		begin	
			case code_num_i:	
				1：PE_shift_reg <= 6'b100_000;		//每拍仅有一个pe有效
				2：PE_shift_reg <= 6'b100_001;		//2个pe有效
				3：PE_shift_reg <= 6'b100_011;
				4: PE_shift_reg <= 6'b100_111;
				5: PE_shift_reg <= 6'b101_111; 
				6: PE_shift_reg <= 6'b111_111;
			default:
				   PE_shift_reg <= 6'b000_000;
		end
	else if(PE_shift_flag)
		begin
			PE_shift_reg <= {PE_shift_reg[0],PE_shift_reg[5:1]};
		end
	else	
		begin
			PE_shift_reg <= PE_shift_reg;
		end
		
/************************************************************R_init的控制***********************************************************************/
reg [2:0] R_cnt;							//用来确定什么时候开始进入切换R_init的信息状态
reg switch_flag;
always @(posedge clk or negedge rst_n)
	if(!rst_n)
		begin
			R_cnt <= 3'd0;
		end
	else if(!switch_flag && R_cnt == 3'd1)
		begin
			R_cnt <= 3'd0;			
		end
	else if(switch_flag && R_cnt == 3'd5)
		begin
			R_cnt <= 3'd0;
		end
	else if(PE_shift_flag)
		begin
			R_cnt <= R_cnt + 1'b1;
		end
	else	
		begin
			R_cnt <= R_cnt;
		end
		
always @(posedge clk or negedge rst_n)
	if(!rst_n)
		begin	
			switch_flag <= 1'b0;
		end
	else if(R_cnt == 3'b1 && !switch_flag)
		begin
			switch_flag <= 1'b1;
		end
	else 
		begin
			switch_flag <= switch_flag;
		end
reg [7:0] R_node_init [16:1];	
integer i;	
always @(posedge clk or negedge rst_n)
	if(!rst_n)
		begin
			for(i=1;i<=16;i=i+1)
				R_node_init[i] = 8'd0;
		end
	else if(switch_flag)
		case R_cnt:
			0:
				for(i=1;i<=16;i=i+1)
					R_node_init[i] = LLR1[i];
			1:
				for(i=1;i<=16;i=i+1)
					R_node_init[i] = LLR2[i];
			2:
				for(i=1;i<=16;i=i+1)
					R_node_init[i] = LLR3[i];
			3:
				for(i=1;i<=16;i=i+1)
					R_node_init[i] = LLR4[i];
			4:
				for(i=1;i<=16;i=i+1)
					R_node_init[i] = LLR5[i];
			5:
				for(i=1;i<=16;i=i+1)
					R_node_init[i] = LLR6[i];
			default:
				for(i=1;i<=16;i=i+1)
					R_node_init[i] = 8'd0;
		endcase
	else	
		begin
			for(i=1;i<=16;i=i+1)
				R_node_init[i] = 8'd0;			
		end
	
		

























	

 