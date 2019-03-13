// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (lin64) Build 2258646 Thu Jun 14 20:02:38 MDT 2018
// Date        : Sat Mar  9 18:38:35 2019
// Host        : HERO-VI running 64-bit Ubuntu 18.04.2 LTS
// Command     : write_verilog -mode funcsim -nolib -force -file
//               /home/jack/Documents/Git/riscvsoc_sim/riscvsoc/vivado/riscvcpu-vivado/riscvcpu-vivado.sim/sim_1/impl/func/xsim/seg_wishbone_tb_func_impl.v
// Design      : seg_top
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* ECO_CHECKSUM = "4cfad497" *) 
(* NotValidForBitStream *)
module seg_top
   (CLK1MHZ,
    CPU_RESETN,
    CA,
    CB,
    CC,
    CD,
    CE,
    CF,
    CG,
    DP,
    AN);
  input CLK1MHZ;
  input CPU_RESETN;
  output CA;
  output CB;
  output CC;
  output CD;
  output CE;
  output CF;
  output CG;
  output DP;
  output [7:0]AN;

  wire [7:0]AN;
  wire [7:0]AN_OBUF;
  wire CA;
  wire CA_OBUF;
  wire CB;
  wire CC;
  wire CD;
  wire CD_OBUF;
  wire CE;
  wire CE_OBUF;
  wire CF;
  wire CF_OBUF;
  wire CG;
  wire CG_OBUF;
  wire CLK1MHZ;
  wire CLK1MHZ_IBUF;
  wire CLK1MHZ_IBUF_BUFG;
  wire CPU_RESETN;
  wire CPU_RESETN_IBUF;
  wire DP;
  wire reset;
  wire NLW_seg_STB_I_UNCONNECTED;
  wire NLW_seg_WE_I_UNCONNECTED;
  wire [31:0]NLW_seg_DAT_I_UNCONNECTED;
  wire [31:0]NLW_seg_DAT_O_UNCONNECTED;
  wire [6:6]NLW_seg_O_anode_UNCONNECTED;
  wire [4:4]NLW_seg_O_cathode_UNCONNECTED;

  OBUF \AN_OBUF[0]_inst 
       (.I(AN_OBUF[0]),
        .O(AN[0]));
  OBUF \AN_OBUF[1]_inst 
       (.I(AN_OBUF[1]),
        .O(AN[1]));
  OBUF \AN_OBUF[2]_inst 
       (.I(AN_OBUF[2]),
        .O(AN[2]));
  OBUF \AN_OBUF[3]_inst 
       (.I(AN_OBUF[3]),
        .O(AN[3]));
  OBUF \AN_OBUF[4]_inst 
       (.I(AN_OBUF[4]),
        .O(AN[4]));
  OBUF \AN_OBUF[5]_inst 
       (.I(AN_OBUF[5]),
        .O(AN[5]));
  OBUF \AN_OBUF[6]_inst 
       (.I(AN_OBUF[6]),
        .O(AN[6]));
  OBUF \AN_OBUF[7]_inst 
       (.I(AN_OBUF[7]),
        .O(AN[7]));
  OBUF CA_OBUF_inst
       (.I(CA_OBUF),
        .O(CA));
  OBUF CB_OBUF_inst
       (.I(AN_OBUF[6]),
        .O(CB));
  OBUF CC_OBUF_inst
       (.I(1'b0),
        .O(CC));
  OBUF CD_OBUF_inst
       (.I(CD_OBUF),
        .O(CD));
  OBUF CE_OBUF_inst
       (.I(CE_OBUF),
        .O(CE));
  OBUF CF_OBUF_inst
       (.I(CF_OBUF),
        .O(CF));
  OBUF CG_OBUF_inst
       (.I(CG_OBUF),
        .O(CG));
  BUFG CLK1MHZ_IBUF_BUFG_inst
       (.I(CLK1MHZ_IBUF),
        .O(CLK1MHZ_IBUF_BUFG));
  IBUF CLK1MHZ_IBUF_inst
       (.I(CLK1MHZ),
        .O(CLK1MHZ_IBUF));
  IBUF CPU_RESETN_IBUF_inst
       (.I(CPU_RESETN),
        .O(CPU_RESETN_IBUF));
  OBUF DP_OBUF_inst
       (.I(1'b1),
        .O(DP));
  (* CLOCKFREQ = "1000000" *) 
  seg_wishbone seg
       (.CLK_I(CLK1MHZ_IBUF_BUFG),
        .DAT_I(NLW_seg_DAT_I_UNCONNECTED[31:0]),
        .DAT_O(NLW_seg_DAT_O_UNCONNECTED[31:0]),
        .O_anode({AN_OBUF[7],NLW_seg_O_anode_UNCONNECTED[6],AN_OBUF[5:0]}),
        .O_cathode({CA_OBUF,AN_OBUF[6],NLW_seg_O_cathode_UNCONNECTED[4],CD_OBUF,CE_OBUF,CF_OBUF,CG_OBUF}),
        .RST_I(reset),
        .STB_I(NLW_seg_STB_I_UNCONNECTED),
        .WE_I(NLW_seg_WE_I_UNCONNECTED));
  LUT1 #(
    .INIT(2'h1)) 
    seg_i_1
       (.I0(CPU_RESETN_IBUF),
        .O(reset));
endmodule

(* CLOCKFREQ = "1000000" *) 
module seg_wishbone
   (CLK_I,
    RST_I,
    DAT_I,
    STB_I,
    WE_I,
    DAT_O,
    O_cathode,
    O_anode);
  input CLK_I;
  input RST_I;
  input [31:0]DAT_I;
  input STB_I;
  input WE_I;
  output [31:0]DAT_O;
  output [6:0]O_cathode;
  output [7:0]O_anode;

  wire CLK_I;
  wire [2:0]LED_activating_counter;
  wire [7:0]O_anode;
  wire [6:0]O_cathode;
  wire RST_I;
  wire \refresh_counter[0]_i_2_n_0 ;
  wire \refresh_counter_reg[0]_i_1_n_0 ;
  wire \refresh_counter_reg[0]_i_1_n_4 ;
  wire \refresh_counter_reg[0]_i_1_n_5 ;
  wire \refresh_counter_reg[0]_i_1_n_6 ;
  wire \refresh_counter_reg[0]_i_1_n_7 ;
  wire \refresh_counter_reg[12]_i_1_n_6 ;
  wire \refresh_counter_reg[12]_i_1_n_7 ;
  wire \refresh_counter_reg[4]_i_1_n_0 ;
  wire \refresh_counter_reg[4]_i_1_n_4 ;
  wire \refresh_counter_reg[4]_i_1_n_5 ;
  wire \refresh_counter_reg[4]_i_1_n_6 ;
  wire \refresh_counter_reg[4]_i_1_n_7 ;
  wire \refresh_counter_reg[8]_i_1_n_0 ;
  wire \refresh_counter_reg[8]_i_1_n_4 ;
  wire \refresh_counter_reg[8]_i_1_n_5 ;
  wire \refresh_counter_reg[8]_i_1_n_6 ;
  wire \refresh_counter_reg[8]_i_1_n_7 ;
  wire \refresh_counter_reg_n_0_[0] ;
  wire \refresh_counter_reg_n_0_[10] ;
  wire \refresh_counter_reg_n_0_[1] ;
  wire \refresh_counter_reg_n_0_[2] ;
  wire \refresh_counter_reg_n_0_[3] ;
  wire \refresh_counter_reg_n_0_[4] ;
  wire \refresh_counter_reg_n_0_[5] ;
  wire \refresh_counter_reg_n_0_[6] ;
  wire \refresh_counter_reg_n_0_[7] ;
  wire \refresh_counter_reg_n_0_[8] ;
  wire \refresh_counter_reg_n_0_[9] ;
  wire [2:0]\NLW_refresh_counter_reg[0]_i_1_CO_UNCONNECTED ;
  wire [3:0]\NLW_refresh_counter_reg[12]_i_1_CO_UNCONNECTED ;
  wire [3:2]\NLW_refresh_counter_reg[12]_i_1_O_UNCONNECTED ;
  wire [2:0]\NLW_refresh_counter_reg[4]_i_1_CO_UNCONNECTED ;
  wire [2:0]\NLW_refresh_counter_reg[8]_i_1_CO_UNCONNECTED ;

  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'h01)) 
    \O_anode[0]_INST_0 
       (.I0(LED_activating_counter[2]),
        .I1(LED_activating_counter[0]),
        .I2(LED_activating_counter[1]),
        .O(O_anode[0]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'h04)) 
    \O_anode[1]_INST_0 
       (.I0(LED_activating_counter[2]),
        .I1(LED_activating_counter[0]),
        .I2(LED_activating_counter[1]),
        .O(O_anode[1]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'h04)) 
    \O_anode[2]_INST_0 
       (.I0(LED_activating_counter[0]),
        .I1(LED_activating_counter[1]),
        .I2(LED_activating_counter[2]),
        .O(O_anode[2]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'h08)) 
    \O_anode[3]_INST_0 
       (.I0(LED_activating_counter[1]),
        .I1(LED_activating_counter[0]),
        .I2(LED_activating_counter[2]),
        .O(O_anode[3]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'h04)) 
    \O_anode[4]_INST_0 
       (.I0(LED_activating_counter[0]),
        .I1(LED_activating_counter[2]),
        .I2(LED_activating_counter[1]),
        .O(O_anode[4]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'h08)) 
    \O_anode[5]_INST_0 
       (.I0(LED_activating_counter[2]),
        .I1(LED_activating_counter[0]),
        .I2(LED_activating_counter[1]),
        .O(O_anode[5]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'h80)) 
    \O_anode[7]_INST_0 
       (.I0(LED_activating_counter[1]),
        .I1(LED_activating_counter[2]),
        .I2(LED_activating_counter[0]),
        .O(O_anode[7]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'hBC)) 
    \O_cathode[0]_INST_0 
       (.I0(LED_activating_counter[0]),
        .I1(LED_activating_counter[2]),
        .I2(LED_activating_counter[1]),
        .O(O_cathode[0]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'h9C)) 
    \O_cathode[1]_INST_0 
       (.I0(LED_activating_counter[0]),
        .I1(LED_activating_counter[2]),
        .I2(LED_activating_counter[1]),
        .O(O_cathode[1]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'hDF)) 
    \O_cathode[2]_INST_0 
       (.I0(LED_activating_counter[0]),
        .I1(LED_activating_counter[2]),
        .I2(LED_activating_counter[1]),
        .O(O_cathode[2]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'h9F)) 
    \O_cathode[3]_INST_0 
       (.I0(LED_activating_counter[0]),
        .I1(LED_activating_counter[2]),
        .I2(LED_activating_counter[1]),
        .O(O_cathode[3]));
  LUT3 #(
    .INIT(8'h08)) 
    \O_cathode[5]_INST_0 
       (.I0(LED_activating_counter[1]),
        .I1(LED_activating_counter[2]),
        .I2(LED_activating_counter[0]),
        .O(O_cathode[5]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'h9B)) 
    \O_cathode[6]_INST_0 
       (.I0(LED_activating_counter[0]),
        .I1(LED_activating_counter[2]),
        .I2(LED_activating_counter[1]),
        .O(O_cathode[6]));
  LUT1 #(
    .INIT(2'h1)) 
    \refresh_counter[0]_i_2 
       (.I0(\refresh_counter_reg_n_0_[0] ),
        .O(\refresh_counter[0]_i_2_n_0 ));
  FDCE #(
    .INIT(1'b0)) 
    \refresh_counter_reg[0] 
       (.C(CLK_I),
        .CE(1'b1),
        .CLR(RST_I),
        .D(\refresh_counter_reg[0]_i_1_n_7 ),
        .Q(\refresh_counter_reg_n_0_[0] ));
  CARRY4 \refresh_counter_reg[0]_i_1 
       (.CI(1'b0),
        .CO({\refresh_counter_reg[0]_i_1_n_0 ,\NLW_refresh_counter_reg[0]_i_1_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\refresh_counter_reg[0]_i_1_n_4 ,\refresh_counter_reg[0]_i_1_n_5 ,\refresh_counter_reg[0]_i_1_n_6 ,\refresh_counter_reg[0]_i_1_n_7 }),
        .S({\refresh_counter_reg_n_0_[3] ,\refresh_counter_reg_n_0_[2] ,\refresh_counter_reg_n_0_[1] ,\refresh_counter[0]_i_2_n_0 }));
  FDCE #(
    .INIT(1'b0)) 
    \refresh_counter_reg[10] 
       (.C(CLK_I),
        .CE(1'b1),
        .CLR(RST_I),
        .D(\refresh_counter_reg[8]_i_1_n_5 ),
        .Q(\refresh_counter_reg_n_0_[10] ));
  FDCE #(
    .INIT(1'b0)) 
    \refresh_counter_reg[11] 
       (.C(CLK_I),
        .CE(1'b1),
        .CLR(RST_I),
        .D(\refresh_counter_reg[8]_i_1_n_4 ),
        .Q(LED_activating_counter[0]));
  FDCE #(
    .INIT(1'b0)) 
    \refresh_counter_reg[12] 
       (.C(CLK_I),
        .CE(1'b1),
        .CLR(RST_I),
        .D(\refresh_counter_reg[12]_i_1_n_7 ),
        .Q(LED_activating_counter[1]));
  CARRY4 \refresh_counter_reg[12]_i_1 
       (.CI(\refresh_counter_reg[8]_i_1_n_0 ),
        .CO(\NLW_refresh_counter_reg[12]_i_1_CO_UNCONNECTED [3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_refresh_counter_reg[12]_i_1_O_UNCONNECTED [3:2],\refresh_counter_reg[12]_i_1_n_6 ,\refresh_counter_reg[12]_i_1_n_7 }),
        .S({1'b0,1'b0,LED_activating_counter[2:1]}));
  FDCE #(
    .INIT(1'b0)) 
    \refresh_counter_reg[13] 
       (.C(CLK_I),
        .CE(1'b1),
        .CLR(RST_I),
        .D(\refresh_counter_reg[12]_i_1_n_6 ),
        .Q(LED_activating_counter[2]));
  FDCE #(
    .INIT(1'b0)) 
    \refresh_counter_reg[1] 
       (.C(CLK_I),
        .CE(1'b1),
        .CLR(RST_I),
        .D(\refresh_counter_reg[0]_i_1_n_6 ),
        .Q(\refresh_counter_reg_n_0_[1] ));
  FDCE #(
    .INIT(1'b0)) 
    \refresh_counter_reg[2] 
       (.C(CLK_I),
        .CE(1'b1),
        .CLR(RST_I),
        .D(\refresh_counter_reg[0]_i_1_n_5 ),
        .Q(\refresh_counter_reg_n_0_[2] ));
  FDCE #(
    .INIT(1'b0)) 
    \refresh_counter_reg[3] 
       (.C(CLK_I),
        .CE(1'b1),
        .CLR(RST_I),
        .D(\refresh_counter_reg[0]_i_1_n_4 ),
        .Q(\refresh_counter_reg_n_0_[3] ));
  FDCE #(
    .INIT(1'b0)) 
    \refresh_counter_reg[4] 
       (.C(CLK_I),
        .CE(1'b1),
        .CLR(RST_I),
        .D(\refresh_counter_reg[4]_i_1_n_7 ),
        .Q(\refresh_counter_reg_n_0_[4] ));
  CARRY4 \refresh_counter_reg[4]_i_1 
       (.CI(\refresh_counter_reg[0]_i_1_n_0 ),
        .CO({\refresh_counter_reg[4]_i_1_n_0 ,\NLW_refresh_counter_reg[4]_i_1_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\refresh_counter_reg[4]_i_1_n_4 ,\refresh_counter_reg[4]_i_1_n_5 ,\refresh_counter_reg[4]_i_1_n_6 ,\refresh_counter_reg[4]_i_1_n_7 }),
        .S({\refresh_counter_reg_n_0_[7] ,\refresh_counter_reg_n_0_[6] ,\refresh_counter_reg_n_0_[5] ,\refresh_counter_reg_n_0_[4] }));
  FDCE #(
    .INIT(1'b0)) 
    \refresh_counter_reg[5] 
       (.C(CLK_I),
        .CE(1'b1),
        .CLR(RST_I),
        .D(\refresh_counter_reg[4]_i_1_n_6 ),
        .Q(\refresh_counter_reg_n_0_[5] ));
  FDCE #(
    .INIT(1'b0)) 
    \refresh_counter_reg[6] 
       (.C(CLK_I),
        .CE(1'b1),
        .CLR(RST_I),
        .D(\refresh_counter_reg[4]_i_1_n_5 ),
        .Q(\refresh_counter_reg_n_0_[6] ));
  FDCE #(
    .INIT(1'b0)) 
    \refresh_counter_reg[7] 
       (.C(CLK_I),
        .CE(1'b1),
        .CLR(RST_I),
        .D(\refresh_counter_reg[4]_i_1_n_4 ),
        .Q(\refresh_counter_reg_n_0_[7] ));
  FDCE #(
    .INIT(1'b0)) 
    \refresh_counter_reg[8] 
       (.C(CLK_I),
        .CE(1'b1),
        .CLR(RST_I),
        .D(\refresh_counter_reg[8]_i_1_n_7 ),
        .Q(\refresh_counter_reg_n_0_[8] ));
  CARRY4 \refresh_counter_reg[8]_i_1 
       (.CI(\refresh_counter_reg[4]_i_1_n_0 ),
        .CO({\refresh_counter_reg[8]_i_1_n_0 ,\NLW_refresh_counter_reg[8]_i_1_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\refresh_counter_reg[8]_i_1_n_4 ,\refresh_counter_reg[8]_i_1_n_5 ,\refresh_counter_reg[8]_i_1_n_6 ,\refresh_counter_reg[8]_i_1_n_7 }),
        .S({LED_activating_counter[0],\refresh_counter_reg_n_0_[10] ,\refresh_counter_reg_n_0_[9] ,\refresh_counter_reg_n_0_[8] }));
  FDCE #(
    .INIT(1'b0)) 
    \refresh_counter_reg[9] 
       (.C(CLK_I),
        .CE(1'b1),
        .CLR(RST_I),
        .D(\refresh_counter_reg[8]_i_1_n_6 ),
        .Q(\refresh_counter_reg_n_0_[9] ));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
