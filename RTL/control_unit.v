// module: Control
// Function: Generates the control signals for each one of the datapath resources

module control_unit(
      input  wire [5:0] opcode,
      output reg  [1:0] alu_op,
      output reg        reg_dst,
      output reg        branch,
      output reg        mem_read,
      output reg        mem_2_reg,
      output reg        mem_write,
      output reg        alu_src,
      output reg        reg_write,
      output reg        jump
   );

   //The opcode for these instructions can be found on the MIPS reference at the beginning of the textbook (Green cardboard page)
   parameter integer ALU_R      = 6'h0;
   parameter integer ADDI       = 6'h8;
   parameter integer BRANCH_EQ  = 6'h4;
   parameter integer JUMP       = 6'h2;
   parameter integer LOAD_WORD  = 6'h23;
   parameter integer STORE_WORD = 6'h2B;

   parameter [2:0] ADD_OPCODE     = 3'd0; //we hebben dit van 2 naar 3 veranderd en dit geldt ook voor sub en r 
   parameter [2:0] SUB_OPCODE     = 3'd1;
   parameter [2:0] R_TYPE_OPCODE  = 3'd2;
   parameter [2:0] S_TYPE_OPCODE  = 3'd3;  // nieuw
   parameter [2:0] I_TYPE_OPCODE  = 3'd4;  //nieuw

  


   //The behavior of the control unit can be found in Chapter 4, Figure 4.18

   always@(*)begin

      case(opcode)
         ALU_R:begin
            reg_dst   = 1'b1;
            alu_src   = 1'b0;
            mem_2_reg = 1'b0;
            reg_write = 1'b1;
            mem_read  = 1'b0;
            mem_write = 1'b0;
            branch    = 1'b0;
            alu_op    = R_TYPE_OPCODE;
            jump      = 1'b0;
         end
    
	// Declare the control signals for each one of the instructions
       
       ADDI:begin //vanaf hier tot aan DEFAULT is allemaal nieuw 
	    reg_dst   = 1'b1;
            alu_src   = 1'b0;
            mem_2_reg = 1'b0;
            reg_write = 1'b1;
            mem_read  = 1'b0;
            mem_write = 1'b0;
            branch    = 1'b0;
            alu_op    = R_TYPE_OPCODE;
            jump      = 1'b0;
	end

	BRANCH_EQ:begin
	    reg_dst   = 1'b0;
            alu_src   = 1'b0;
            mem_2_reg = 1'b0;
            reg_write = 1'b0;
            mem_read  = 1'b0;
            mem_write = 1'b0;
            branch    = 1'b1;
            alu_op    = R_TYPE_OPCODE;
            jump      = 1'b0;
	end

        JUMP:begin
	    reg_dst   = 1'b1;
            alu_src   = 1'b0;
            mem_2_reg = 1'b0;
            reg_write = 1'b1;
            mem_read  = 1'b0;
            mem_write = 1'b0;
            branch    = 1'b0;
            alu_op    = R_TYPE_OPCODE;
            jump      = 1'b0;
	end
	    
	LOAD_WORD:begin
	    reg_dst   = 1'b1;
            alu_src   = 1'b1;
            mem_2_reg = 1'b1;
            reg_write = 1'b1;
            mem_read  = 1'b1;
            mem_write = 1'b0;
            branch    = 1'b0;
            alu_op    = I_TYPE_OPCODE;
            jump      = 1'b0;
	end

	STORE_WORD:begin
	    reg_dst   = 1'b0;
            alu_src   = 1'b1;
            mem_2_reg = 1'b0;
            reg_write = 1'b0;
            mem_read  = 1'b0;
            mem_write = 1'b1;
            branch    = 1'b0;
            alu_op    = S_TYPE_OPCODE;
            jump      = 1'b0;
	end

	
         default:begin
            reg_dst   = 1'b0; 
            alu_src   = 1'b0;
            mem_2_reg = 1'b0;
            reg_write = 1'b0;
            mem_read  = 1'b0;
            mem_write = 1'b0;
            branch    = 1'b0;
            alu_op    = R_TYPE_OPCODE;
            jump      = 1'b0;
         end
      endcase
   end

endmodule


