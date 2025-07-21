// Generator : SpinalHDL v1.10.2a    git head : a348a60b7e8b6a455c72e1536ec3d74a2ea16935
// Component : SoftmaxTopDSP48E1
// Git hash  : 8e9f4bba49c17035003f75211570db0b83f7bedf

`timescale 1ns/1ps

module SoftmaxTopDSP48E1 (
  input  wire [20:0]   io_input_0,
  input  wire [20:0]   io_input_1,
  input  wire [20:0]   io_input_2,
  input  wire [20:0]   io_input_3,
  output wire [19:0]   io_output_0,
  output wire [19:0]   io_output_1,
  output wire [19:0]   io_output_2,
  output wire [19:0]   io_output_3,
  input  wire          io_valid_in,
  output wire          io_valid_out,
  output wire          io_ready,
  input  wire          clk,
  input  wire          reset
);

  wire       [19:0]   softmax_1_io_output_0;
  wire       [19:0]   softmax_1_io_output_1;
  wire       [19:0]   softmax_1_io_output_2;
  wire       [19:0]   softmax_1_io_output_3;
  wire                softmax_1_io_valid_out;
  wire                softmax_1_io_ready;

  Softmax softmax_1 (
    .io_input_0   (io_input_0[20:0]           ), //i
    .io_input_1   (io_input_1[20:0]           ), //i
    .io_input_2   (io_input_2[20:0]           ), //i
    .io_input_3   (io_input_3[20:0]           ), //i
    .io_output_0  (softmax_1_io_output_0[19:0]), //o
    .io_output_1  (softmax_1_io_output_1[19:0]), //o
    .io_output_2  (softmax_1_io_output_2[19:0]), //o
    .io_output_3  (softmax_1_io_output_3[19:0]), //o
    .io_valid_in  (io_valid_in                ), //i
    .io_valid_out (softmax_1_io_valid_out     ), //o
    .io_ready     (softmax_1_io_ready         ), //o
    .clk          (clk                        ), //i
    .reset        (reset                      )  //i
  );
  assign io_output_0 = softmax_1_io_output_0;
  assign io_output_1 = softmax_1_io_output_1;
  assign io_output_2 = softmax_1_io_output_2;
  assign io_output_3 = softmax_1_io_output_3;
  assign io_valid_out = softmax_1_io_valid_out;
  assign io_ready = softmax_1_io_ready;

endmodule

module Softmax (
  input  wire [20:0]   io_input_0,
  input  wire [20:0]   io_input_1,
  input  wire [20:0]   io_input_2,
  input  wire [20:0]   io_input_3,
  output wire [19:0]   io_output_0,
  output wire [19:0]   io_output_1,
  output wire [19:0]   io_output_2,
  output wire [19:0]   io_output_3,
  input  wire          io_valid_in,
  output wire          io_valid_out,
  output wire          io_ready,
  input  wire          clk,
  input  wire          reset
);
  localparam State_IDLE = 3'd0;
  localparam State_FIND_MAX = 3'd1;
  localparam State_SUB_MAX = 3'd2;
  localparam State_EXP_CALC = 3'd3;
  localparam State_SUM_EXP = 3'd4;
  localparam State_DIV_CALC = 3'd5;
  localparam State_DONE = 3'd6;

  reg        [20:0]   _zz_when_Softmax_l170;
  wire       [1:0]    _zz_when_Softmax_l170_1;
  reg        [20:0]   _zz_maxValue;
  wire       [1:0]    _zz_maxValue_1;
  wire       [1:0]    _zz__zz_1;
  reg        [20:0]   _zz__zz_shiftedValues_0;
  wire       [1:0]    _zz__zz_shiftedValues_0_1;
  wire       [1:0]    _zz__zz_2;
  reg        [20:0]   _zz__zz_when_Softmax_l136;
  wire       [1:0]    _zz__zz_when_Softmax_l136_1;
  wire       [20:0]   _zz__zz_when_Softmax_l138;
  wire       [20:0]   _zz__zz_when_Softmax_l138_1;
  wire       [47:0]   _zz__zz_when_Softmax_l138_4;
  wire       [42:0]   _zz__zz_when_Softmax_l138_4_1;
  wire       [42:0]   _zz__zz_when_Softmax_l138_4_2;
  wire       [24:0]   _zz__zz_when_Softmax_l138_4_3;
  wire       [17:0]   _zz__zz_when_Softmax_l138_4_4;
  wire       [47:0]   _zz__zz_when_Softmax_l138_6;
  wire       [42:0]   _zz__zz_when_Softmax_l138_6_1;
  wire       [42:0]   _zz__zz_when_Softmax_l138_6_2;
  wire       [24:0]   _zz__zz_when_Softmax_l138_6_3;
  wire       [17:0]   _zz__zz_when_Softmax_l138_6_4;
  wire       [47:0]   _zz__zz_when_Softmax_l138_8;
  wire       [42:0]   _zz__zz_when_Softmax_l138_8_1;
  wire       [42:0]   _zz__zz_when_Softmax_l138_8_2;
  wire       [24:0]   _zz__zz_when_Softmax_l138_8_3;
  wire       [17:0]   _zz__zz_when_Softmax_l138_8_4;
  wire       [47:0]   _zz__zz_when_Softmax_l138_10;
  wire       [42:0]   _zz__zz_when_Softmax_l138_10_1;
  wire       [42:0]   _zz__zz_when_Softmax_l138_10_2;
  wire       [24:0]   _zz__zz_when_Softmax_l138_10_3;
  wire       [17:0]   _zz__zz_when_Softmax_l138_10_4;
  wire       [47:0]   _zz__zz_when_Softmax_l138_11;
  wire       [42:0]   _zz__zz_when_Softmax_l138_11_1;
  wire       [42:0]   _zz__zz_when_Softmax_l138_11_2;
  wire       [24:0]   _zz__zz_when_Softmax_l138_11_3;
  wire       [17:0]   _zz__zz_when_Softmax_l138_11_4;
  wire       [9:0]    _zz__zz_when_Softmax_l138_11_5;
  wire       [47:0]   _zz__zz_when_Softmax_l138_12;
  wire       [42:0]   _zz__zz_when_Softmax_l138_12_1;
  wire       [42:0]   _zz__zz_when_Softmax_l138_12_2;
  wire       [24:0]   _zz__zz_when_Softmax_l138_12_3;
  wire       [17:0]   _zz__zz_when_Softmax_l138_12_4;
  wire       [7:0]    _zz__zz_when_Softmax_l138_12_5;
  wire       [47:0]   _zz__zz_when_Softmax_l138_13;
  wire       [42:0]   _zz__zz_when_Softmax_l138_13_1;
  wire       [42:0]   _zz__zz_when_Softmax_l138_13_2;
  wire       [24:0]   _zz__zz_when_Softmax_l138_13_3;
  wire       [35:0]   _zz__zz_when_Softmax_l138_13_4;
  wire       [17:0]   _zz__zz_when_Softmax_l138_13_5;
  wire       [5:0]    _zz__zz_when_Softmax_l138_13_6;
  wire       [23:0]   _zz__zz_when_Softmax_l138_14;
  wire       [23:0]   _zz__zz_when_Softmax_l138_14_1;
  wire       [23:0]   _zz__zz_when_Softmax_l138_14_2;
  wire       [23:0]   _zz__zz_when_Softmax_l138_14_3;
  wire       [23:0]   _zz__zz_when_Softmax_l138_14_4;
  wire       [23:0]   _zz__zz_when_Softmax_l138_14_5;
  wire       [23:0]   _zz__zz_when_Softmax_l138_14_6;
  wire       [34:0]   _zz__zz_when_Softmax_l138_14_7;
  wire       [23:0]   _zz__zz_when_Softmax_l138_14_8;
  wire       [35:0]   _zz__zz_when_Softmax_l138_14_9;
  wire       [23:0]   _zz__zz_when_Softmax_l138_14_10;
  wire       [35:0]   _zz__zz_when_Softmax_l138_14_11;
  wire       [23:0]   _zz__zz_when_Softmax_l138_14_12;
  wire       [35:0]   _zz__zz_when_Softmax_l138_14_13;
  wire       [14:0]   _zz_when_Softmax_l138_15;
  wire       [14:0]   _zz_when_Softmax_l138_16;
  wire       [43:0]   _zz__zz_expValues_0_1;
  wire       [31:0]   _zz__zz_expValues_0_1_1;
  wire       [31:0]   _zz__zz_expValues_0_1_2;
  wire       [23:0]   _zz__zz_expValues_0;
  wire       [19:0]   _zz__zz_expValues_0_2;
  wire       [21:0]   _zz_sumExp;
  reg        [19:0]   _zz_sumExp_1;
  wire       [1:0]    _zz_sumExp_2;
  wire       [43:0]   _zz__zz_outputReg_0;
  wire       [31:0]   _zz__zz_outputReg_0_1;
  reg        [19:0]   _zz__zz_outputReg_0_2;
  wire       [1:0]    _zz__zz_outputReg_0_3;
  wire       [31:0]   _zz__zz_outputReg_0_4;
  wire       [1:0]    _zz__zz_3;
  reg        [2:0]    state_1;
  reg        [2:0]    counter;
  reg        [20:0]   inputReg_0;
  reg        [20:0]   inputReg_1;
  reg        [20:0]   inputReg_2;
  reg        [20:0]   inputReg_3;
  reg        [20:0]   maxValue;
  reg        [20:0]   shiftedValues_0;
  reg        [20:0]   shiftedValues_1;
  reg        [20:0]   shiftedValues_2;
  reg        [20:0]   shiftedValues_3;
  reg        [19:0]   expValues_0;
  reg        [19:0]   expValues_1;
  reg        [19:0]   expValues_2;
  reg        [19:0]   expValues_3;
  reg        [21:0]   sumExp;
  reg        [19:0]   outputReg_0;
  reg        [19:0]   outputReg_1;
  reg        [19:0]   outputReg_2;
  reg        [19:0]   outputReg_3;
  wire                when_Softmax_l168;
  wire                when_Softmax_l170;
  wire                when_Softmax_l180;
  wire       [3:0]    _zz_1;
  wire       [20:0]   _zz_shiftedValues_0;
  wire                when_Softmax_l190;
  wire       [3:0]    _zz_2;
  wire       [20:0]   _zz_when_Softmax_l136;
  reg        [19:0]   _zz_expValues_0;
  wire                when_Softmax_l136;
  wire       [20:0]   _zz_when_Softmax_l138;
  wire       [19:0]   _zz_when_Softmax_l138_1;
  wire       [20:0]   _zz_when_Softmax_l138_2;
  wire       [23:0]   _zz_when_Softmax_l138_3;
  (* use_dsp = "yes" *) wire       [47:0]   _zz_when_Softmax_l138_4;
  wire       [35:0]   _zz_when_Softmax_l138_5;
  (* use_dsp = "yes" *) wire       [47:0]   _zz_when_Softmax_l138_6;
  wire       [35:0]   _zz_when_Softmax_l138_7;
  (* use_dsp = "yes" *) wire       [47:0]   _zz_when_Softmax_l138_8;
  wire       [35:0]   _zz_when_Softmax_l138_9;
  (* use_dsp = "yes" *) wire       [47:0]   _zz_when_Softmax_l138_10;
  (* use_dsp = "yes" *) wire       [47:0]   _zz_when_Softmax_l138_11;
  (* use_dsp = "yes" *) wire       [47:0]   _zz_when_Softmax_l138_12;
  (* use_dsp = "yes" *) wire       [47:0]   _zz_when_Softmax_l138_13;
  wire       [23:0]   _zz_when_Softmax_l138_14;
  wire                when_Softmax_l138;
  (* use_dsp = "yes" *) wire       [43:0]   _zz_expValues_0_1;
  wire       [19:0]   _zz_expValues_0_2;
  wire                when_Softmax_l201;
  wire                when_Softmax_l211;
  (* use_dsp = "yes" *) wire       [43:0]   _zz_outputReg_0;
  wire       [3:0]    _zz_3;
  wire       [43:0]   _zz_outputReg_0_1;
  `ifndef SYNTHESIS
  reg [63:0] state_1_string;
  `endif


  assign _zz_when_Softmax_l170_1 = counter[1:0];
  assign _zz_maxValue_1 = counter[1:0];
  assign _zz__zz_1 = counter[1:0];
  assign _zz__zz_shiftedValues_0_1 = counter[1:0];
  assign _zz__zz_2 = counter[1:0];
  assign _zz__zz_when_Softmax_l136_1 = counter[1:0];
  assign _zz__zz_when_Softmax_l138 = (when_Softmax_l136 ? _zz__zz_when_Softmax_l138_1 : _zz_when_Softmax_l136);
  assign _zz__zz_when_Softmax_l138_1 = (- _zz_when_Softmax_l136);
  assign _zz__zz_when_Softmax_l138_4_1 = _zz__zz_when_Softmax_l138_4_2;
  assign _zz__zz_when_Softmax_l138_4 = {5'd0, _zz__zz_when_Softmax_l138_4_1};
  assign _zz__zz_when_Softmax_l138_4_2 = (_zz__zz_when_Softmax_l138_4_3 * _zz__zz_when_Softmax_l138_4_4);
  assign _zz__zz_when_Softmax_l138_4_3 = {1'd0, _zz_when_Softmax_l138_3};
  assign _zz__zz_when_Softmax_l138_4_4 = _zz_when_Softmax_l138_3[17:0];
  assign _zz__zz_when_Softmax_l138_6_1 = _zz__zz_when_Softmax_l138_6_2;
  assign _zz__zz_when_Softmax_l138_6 = {5'd0, _zz__zz_when_Softmax_l138_6_1};
  assign _zz__zz_when_Softmax_l138_6_2 = (_zz__zz_when_Softmax_l138_6_3 * _zz__zz_when_Softmax_l138_6_4);
  assign _zz__zz_when_Softmax_l138_6_3 = _zz_when_Softmax_l138_5[24:0];
  assign _zz__zz_when_Softmax_l138_6_4 = _zz_when_Softmax_l138_3[17:0];
  assign _zz__zz_when_Softmax_l138_8_1 = _zz__zz_when_Softmax_l138_8_2;
  assign _zz__zz_when_Softmax_l138_8 = {5'd0, _zz__zz_when_Softmax_l138_8_1};
  assign _zz__zz_when_Softmax_l138_8_2 = (_zz__zz_when_Softmax_l138_8_3 * _zz__zz_when_Softmax_l138_8_4);
  assign _zz__zz_when_Softmax_l138_8_3 = _zz_when_Softmax_l138_7[24:0];
  assign _zz__zz_when_Softmax_l138_8_4 = _zz_when_Softmax_l138_3[17:0];
  assign _zz__zz_when_Softmax_l138_10_1 = _zz__zz_when_Softmax_l138_10_2;
  assign _zz__zz_when_Softmax_l138_10 = {5'd0, _zz__zz_when_Softmax_l138_10_1};
  assign _zz__zz_when_Softmax_l138_10_2 = (_zz__zz_when_Softmax_l138_10_3 * _zz__zz_when_Softmax_l138_10_4);
  assign _zz__zz_when_Softmax_l138_10_3 = _zz_when_Softmax_l138_9[24:0];
  assign _zz__zz_when_Softmax_l138_10_4 = _zz_when_Softmax_l138_3[17:0];
  assign _zz__zz_when_Softmax_l138_11_1 = _zz__zz_when_Softmax_l138_11_2;
  assign _zz__zz_when_Softmax_l138_11 = {5'd0, _zz__zz_when_Softmax_l138_11_1};
  assign _zz__zz_when_Softmax_l138_11_2 = (_zz__zz_when_Softmax_l138_11_3 * _zz__zz_when_Softmax_l138_11_4);
  assign _zz__zz_when_Softmax_l138_11_3 = _zz_when_Softmax_l138_7[24:0];
  assign _zz__zz_when_Softmax_l138_11_5 = 10'h2ab;
  assign _zz__zz_when_Softmax_l138_11_4 = {8'd0, _zz__zz_when_Softmax_l138_11_5};
  assign _zz__zz_when_Softmax_l138_12_1 = _zz__zz_when_Softmax_l138_12_2;
  assign _zz__zz_when_Softmax_l138_12 = {5'd0, _zz__zz_when_Softmax_l138_12_1};
  assign _zz__zz_when_Softmax_l138_12_2 = (_zz__zz_when_Softmax_l138_12_3 * _zz__zz_when_Softmax_l138_12_4);
  assign _zz__zz_when_Softmax_l138_12_3 = _zz_when_Softmax_l138_9[24:0];
  assign _zz__zz_when_Softmax_l138_12_5 = 8'hab;
  assign _zz__zz_when_Softmax_l138_12_4 = {10'd0, _zz__zz_when_Softmax_l138_12_5};
  assign _zz__zz_when_Softmax_l138_13_1 = _zz__zz_when_Softmax_l138_13_2;
  assign _zz__zz_when_Softmax_l138_13 = {5'd0, _zz__zz_when_Softmax_l138_13_1};
  assign _zz__zz_when_Softmax_l138_13_2 = (_zz__zz_when_Softmax_l138_13_3 * _zz__zz_when_Softmax_l138_13_5);
  assign _zz__zz_when_Softmax_l138_13_4 = (_zz_when_Softmax_l138_10 >>> 4'd12);
  assign _zz__zz_when_Softmax_l138_13_3 = _zz__zz_when_Softmax_l138_13_4[24:0];
  assign _zz__zz_when_Softmax_l138_13_6 = 6'h22;
  assign _zz__zz_when_Softmax_l138_13_5 = {12'd0, _zz__zz_when_Softmax_l138_13_6};
  assign _zz__zz_when_Softmax_l138_14 = (_zz__zz_when_Softmax_l138_14_1 + _zz__zz_when_Softmax_l138_14_10);
  assign _zz__zz_when_Softmax_l138_14_1 = (_zz__zz_when_Softmax_l138_14_2 + _zz__zz_when_Softmax_l138_14_8);
  assign _zz__zz_when_Softmax_l138_14_2 = (_zz__zz_when_Softmax_l138_14_3 + _zz__zz_when_Softmax_l138_14_6);
  assign _zz__zz_when_Softmax_l138_14_3 = (_zz__zz_when_Softmax_l138_14_4 + _zz__zz_when_Softmax_l138_14_5);
  assign _zz__zz_when_Softmax_l138_14_4 = {4'd0, _zz_when_Softmax_l138_1};
  assign _zz__zz_when_Softmax_l138_14_5 = {3'd0, _zz_when_Softmax_l138_2};
  assign _zz__zz_when_Softmax_l138_14_7 = (_zz_when_Softmax_l138_5 >>> 1'd1);
  assign _zz__zz_when_Softmax_l138_14_6 = _zz__zz_when_Softmax_l138_14_7[23:0];
  assign _zz__zz_when_Softmax_l138_14_9 = (_zz_when_Softmax_l138_11 >>> 4'd12);
  assign _zz__zz_when_Softmax_l138_14_8 = _zz__zz_when_Softmax_l138_14_9[23:0];
  assign _zz__zz_when_Softmax_l138_14_11 = (_zz_when_Softmax_l138_12 >>> 4'd12);
  assign _zz__zz_when_Softmax_l138_14_10 = _zz__zz_when_Softmax_l138_14_11[23:0];
  assign _zz__zz_when_Softmax_l138_14_13 = (_zz_when_Softmax_l138_13 >>> 4'd12);
  assign _zz__zz_when_Softmax_l138_14_12 = _zz__zz_when_Softmax_l138_14_13[23:0];
  assign _zz_when_Softmax_l138_15 = (_zz_when_Softmax_l138_1 >>> 3'd5);
  assign _zz_when_Softmax_l138_16 = _zz_when_Softmax_l138_14[14:0];
  assign _zz__zz_expValues_0_1 = ({12'd0,_zz__zz_expValues_0_1_1} <<< 4'd12);
  assign _zz__zz_expValues_0_1_1 = {12'd0, _zz_when_Softmax_l138_1};
  assign _zz__zz_expValues_0_1_2 = {8'd0, _zz_when_Softmax_l138_14};
  assign _zz__zz_expValues_0 = {4'd0, _zz_expValues_0_2};
  assign _zz__zz_expValues_0_2 = _zz_when_Softmax_l138_14[19:0];
  assign _zz_sumExp = {2'd0, _zz_sumExp_1};
  assign _zz_sumExp_2 = counter[1:0];
  assign _zz__zz_outputReg_0 = ({12'd0,_zz__zz_outputReg_0_1} <<< 4'd12);
  assign _zz__zz_outputReg_0_1 = {12'd0, _zz__zz_outputReg_0_2};
  assign _zz__zz_outputReg_0_3 = counter[1:0];
  assign _zz__zz_outputReg_0_4 = {10'd0, sumExp};
  assign _zz__zz_3 = counter[1:0];
  always @(*) begin
    case(_zz_when_Softmax_l170_1)
      2'b00 : _zz_when_Softmax_l170 = inputReg_0;
      2'b01 : _zz_when_Softmax_l170 = inputReg_1;
      2'b10 : _zz_when_Softmax_l170 = inputReg_2;
      default : _zz_when_Softmax_l170 = inputReg_3;
    endcase
  end

  always @(*) begin
    case(_zz_maxValue_1)
      2'b00 : _zz_maxValue = inputReg_0;
      2'b01 : _zz_maxValue = inputReg_1;
      2'b10 : _zz_maxValue = inputReg_2;
      default : _zz_maxValue = inputReg_3;
    endcase
  end

  always @(*) begin
    case(_zz__zz_shiftedValues_0_1)
      2'b00 : _zz__zz_shiftedValues_0 = inputReg_0;
      2'b01 : _zz__zz_shiftedValues_0 = inputReg_1;
      2'b10 : _zz__zz_shiftedValues_0 = inputReg_2;
      default : _zz__zz_shiftedValues_0 = inputReg_3;
    endcase
  end

  always @(*) begin
    case(_zz__zz_when_Softmax_l136_1)
      2'b00 : _zz__zz_when_Softmax_l136 = shiftedValues_0;
      2'b01 : _zz__zz_when_Softmax_l136 = shiftedValues_1;
      2'b10 : _zz__zz_when_Softmax_l136 = shiftedValues_2;
      default : _zz__zz_when_Softmax_l136 = shiftedValues_3;
    endcase
  end

  always @(*) begin
    case(_zz_sumExp_2)
      2'b00 : _zz_sumExp_1 = expValues_0;
      2'b01 : _zz_sumExp_1 = expValues_1;
      2'b10 : _zz_sumExp_1 = expValues_2;
      default : _zz_sumExp_1 = expValues_3;
    endcase
  end

  always @(*) begin
    case(_zz__zz_outputReg_0_3)
      2'b00 : _zz__zz_outputReg_0_2 = expValues_0;
      2'b01 : _zz__zz_outputReg_0_2 = expValues_1;
      2'b10 : _zz__zz_outputReg_0_2 = expValues_2;
      default : _zz__zz_outputReg_0_2 = expValues_3;
    endcase
  end

  `ifndef SYNTHESIS
  always @(*) begin
    case(state_1)
      State_IDLE : state_1_string = "IDLE    ";
      State_FIND_MAX : state_1_string = "FIND_MAX";
      State_SUB_MAX : state_1_string = "SUB_MAX ";
      State_EXP_CALC : state_1_string = "EXP_CALC";
      State_SUM_EXP : state_1_string = "SUM_EXP ";
      State_DIV_CALC : state_1_string = "DIV_CALC";
      State_DONE : state_1_string = "DONE    ";
      default : state_1_string = "????????";
    endcase
  end
  `endif

  assign io_ready = (state_1 == State_IDLE);
  assign io_valid_out = (state_1 == State_DONE);
  assign io_output_0 = outputReg_0;
  assign io_output_1 = outputReg_1;
  assign io_output_2 = outputReg_2;
  assign io_output_3 = outputReg_3;
  assign when_Softmax_l168 = (counter < 3'b011);
  assign when_Softmax_l170 = ($signed(maxValue) < $signed(_zz_when_Softmax_l170));
  assign when_Softmax_l180 = (counter < 3'b100);
  assign _zz_1 = ({3'd0,1'b1} <<< _zz__zz_1);
  assign _zz_shiftedValues_0 = ($signed(_zz__zz_shiftedValues_0) - $signed(maxValue));
  assign when_Softmax_l190 = (counter < 3'b100);
  assign _zz_2 = ({3'd0,1'b1} <<< _zz__zz_2);
  assign _zz_when_Softmax_l136 = _zz__zz_when_Softmax_l136;
  assign when_Softmax_l136 = _zz_when_Softmax_l136[20];
  assign _zz_when_Softmax_l138 = _zz__zz_when_Softmax_l138;
  assign _zz_when_Softmax_l138_1 = 20'h01000;
  assign _zz_when_Softmax_l138_2 = ((21'h008000 < _zz_when_Softmax_l138) ? 21'h008000 : _zz_when_Softmax_l138);
  assign _zz_when_Softmax_l138_3 = {3'd0, _zz_when_Softmax_l138_2};
  assign _zz_when_Softmax_l138_4 = _zz__zz_when_Softmax_l138_4;
  assign _zz_when_Softmax_l138_5 = (_zz_when_Softmax_l138_4 >>> 4'd12);
  assign _zz_when_Softmax_l138_6 = _zz__zz_when_Softmax_l138_6;
  assign _zz_when_Softmax_l138_7 = (_zz_when_Softmax_l138_6 >>> 4'd12);
  assign _zz_when_Softmax_l138_8 = _zz__zz_when_Softmax_l138_8;
  assign _zz_when_Softmax_l138_9 = (_zz_when_Softmax_l138_8 >>> 4'd12);
  assign _zz_when_Softmax_l138_10 = _zz__zz_when_Softmax_l138_10;
  assign _zz_when_Softmax_l138_11 = _zz__zz_when_Softmax_l138_11;
  assign _zz_when_Softmax_l138_12 = _zz__zz_when_Softmax_l138_12;
  assign _zz_when_Softmax_l138_13 = _zz__zz_when_Softmax_l138_13;
  assign _zz_when_Softmax_l138_14 = (_zz__zz_when_Softmax_l138_14 + _zz__zz_when_Softmax_l138_14_12);
  assign when_Softmax_l138 = (_zz_when_Softmax_l138_15 < _zz_when_Softmax_l138_16);
  assign _zz_expValues_0_1 = (_zz__zz_expValues_0_1 / _zz__zz_expValues_0_1_2);
  always @(*) begin
    if(when_Softmax_l136) begin
      if(when_Softmax_l138) begin
        _zz_expValues_0 = _zz_expValues_0_1[19:0];
      end else begin
        _zz_expValues_0 = 20'h00001;
      end
    end else begin
      _zz_expValues_0 = ((_zz__zz_expValues_0 < _zz_when_Softmax_l138_14) ? _zz_expValues_0_2 : _zz__zz_expValues_0_2);
    end
  end

  assign _zz_expValues_0_2 = 20'hfffff;
  assign when_Softmax_l201 = (counter < 3'b100);
  assign when_Softmax_l211 = (counter < 3'b100);
  assign _zz_outputReg_0 = (_zz__zz_outputReg_0 / _zz__zz_outputReg_0_4);
  assign _zz_3 = ({3'd0,1'b1} <<< _zz__zz_3);
  assign _zz_outputReg_0_1 = _zz_outputReg_0;
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      state_1 <= State_IDLE;
      counter <= 3'b000;
    end else begin
      case(state_1)
        State_IDLE : begin
          if(io_valid_in) begin
            counter <= 3'b000;
            state_1 <= State_FIND_MAX;
          end
        end
        State_FIND_MAX : begin
          if(when_Softmax_l168) begin
            counter <= (counter + 3'b001);
          end else begin
            counter <= 3'b000;
            state_1 <= State_SUB_MAX;
          end
        end
        State_SUB_MAX : begin
          if(when_Softmax_l180) begin
            counter <= (counter + 3'b001);
          end else begin
            counter <= 3'b000;
            state_1 <= State_EXP_CALC;
          end
        end
        State_EXP_CALC : begin
          if(when_Softmax_l190) begin
            counter <= (counter + 3'b001);
          end else begin
            counter <= 3'b000;
            state_1 <= State_SUM_EXP;
          end
        end
        State_SUM_EXP : begin
          if(when_Softmax_l201) begin
            counter <= (counter + 3'b001);
          end else begin
            counter <= 3'b000;
            state_1 <= State_DIV_CALC;
          end
        end
        State_DIV_CALC : begin
          if(when_Softmax_l211) begin
            counter <= (counter + 3'b001);
          end else begin
            state_1 <= State_DONE;
          end
        end
        default : begin
          state_1 <= State_IDLE;
        end
      endcase
    end
  end

  always @(posedge clk) begin
    case(state_1)
      State_IDLE : begin
        if(io_valid_in) begin
          inputReg_0 <= io_input_0;
          inputReg_1 <= io_input_1;
          inputReg_2 <= io_input_2;
          inputReg_3 <= io_input_3;
          maxValue <= io_input_0;
        end
      end
      State_FIND_MAX : begin
        if(when_Softmax_l168) begin
          if(when_Softmax_l170) begin
            maxValue <= _zz_maxValue;
          end
        end
      end
      State_SUB_MAX : begin
        if(when_Softmax_l180) begin
          if(_zz_1[0]) begin
            shiftedValues_0 <= _zz_shiftedValues_0;
          end
          if(_zz_1[1]) begin
            shiftedValues_1 <= _zz_shiftedValues_0;
          end
          if(_zz_1[2]) begin
            shiftedValues_2 <= _zz_shiftedValues_0;
          end
          if(_zz_1[3]) begin
            shiftedValues_3 <= _zz_shiftedValues_0;
          end
        end
      end
      State_EXP_CALC : begin
        if(when_Softmax_l190) begin
          if(_zz_2[0]) begin
            expValues_0 <= _zz_expValues_0;
          end
          if(_zz_2[1]) begin
            expValues_1 <= _zz_expValues_0;
          end
          if(_zz_2[2]) begin
            expValues_2 <= _zz_expValues_0;
          end
          if(_zz_2[3]) begin
            expValues_3 <= _zz_expValues_0;
          end
        end else begin
          sumExp <= 22'h0;
        end
      end
      State_SUM_EXP : begin
        if(when_Softmax_l201) begin
          sumExp <= (sumExp + _zz_sumExp);
        end
      end
      State_DIV_CALC : begin
        if(when_Softmax_l211) begin
          if(_zz_3[0]) begin
            outputReg_0 <= _zz_outputReg_0_1[19:0];
          end
          if(_zz_3[1]) begin
            outputReg_1 <= _zz_outputReg_0_1[19:0];
          end
          if(_zz_3[2]) begin
            outputReg_2 <= _zz_outputReg_0_1[19:0];
          end
          if(_zz_3[3]) begin
            outputReg_3 <= _zz_outputReg_0_1[19:0];
          end
        end
      end
      default : begin
      end
    endcase
  end


endmodule
