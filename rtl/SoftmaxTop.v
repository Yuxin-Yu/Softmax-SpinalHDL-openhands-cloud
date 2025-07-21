// Generator : SpinalHDL v1.10.2a    git head : a348a60b7e8b6a455c72e1536ec3d74a2ea16935
// Component : SoftmaxTop

`timescale 1ns/1ps

module SoftmaxTop (
  input  wire [16:0]   io_input_0,
  input  wire [16:0]   io_input_1,
  input  wire [16:0]   io_input_2,
  input  wire [16:0]   io_input_3,
  output wire [15:0]   io_output_0,
  output wire [15:0]   io_output_1,
  output wire [15:0]   io_output_2,
  output wire [15:0]   io_output_3,
  input  wire          io_valid_in,
  output wire          io_valid_out,
  output wire          io_ready,
  input  wire          clk,
  input  wire          resetn
);

  wire       [15:0]   softmax_1_io_output_0;
  wire       [15:0]   softmax_1_io_output_1;
  wire       [15:0]   softmax_1_io_output_2;
  wire       [15:0]   softmax_1_io_output_3;
  wire                softmax_1_io_valid_out;
  wire                softmax_1_io_ready;

  Softmax softmax_1 (
    .io_input_0   (io_input_0[16:0]           ), //i
    .io_input_1   (io_input_1[16:0]           ), //i
    .io_input_2   (io_input_2[16:0]           ), //i
    .io_input_3   (io_input_3[16:0]           ), //i
    .io_output_0  (softmax_1_io_output_0[15:0]), //o
    .io_output_1  (softmax_1_io_output_1[15:0]), //o
    .io_output_2  (softmax_1_io_output_2[15:0]), //o
    .io_output_3  (softmax_1_io_output_3[15:0]), //o
    .io_valid_in  (io_valid_in                ), //i
    .io_valid_out (softmax_1_io_valid_out     ), //o
    .io_ready     (softmax_1_io_ready         ), //o
    .clk          (clk                        ), //i
    .resetn       (resetn                     )  //i
  );
  assign io_output_0 = softmax_1_io_output_0;
  assign io_output_1 = softmax_1_io_output_1;
  assign io_output_2 = softmax_1_io_output_2;
  assign io_output_3 = softmax_1_io_output_3;
  assign io_valid_out = softmax_1_io_valid_out;
  assign io_ready = softmax_1_io_ready;

endmodule

module Softmax (
  input  wire [16:0]   io_input_0,
  input  wire [16:0]   io_input_1,
  input  wire [16:0]   io_input_2,
  input  wire [16:0]   io_input_3,
  output wire [15:0]   io_output_0,
  output wire [15:0]   io_output_1,
  output wire [15:0]   io_output_2,
  output wire [15:0]   io_output_3,
  input  wire          io_valid_in,
  output wire          io_valid_out,
  output wire          io_ready,
  input  wire          clk,
  input  wire          resetn
);
  localparam State_IDLE = 3'd0;
  localparam State_FIND_MAX = 3'd1;
  localparam State_SUB_MAX = 3'd2;
  localparam State_EXP_CALC = 3'd3;
  localparam State_SUM_EXP = 3'd4;
  localparam State_DIV_CALC = 3'd5;
  localparam State_DONE = 3'd6;

  reg        [16:0]   _zz_when_Softmax_l86;
  wire       [1:0]    _zz_when_Softmax_l86_1;
  reg        [16:0]   _zz_maxValue;
  wire       [1:0]    _zz_maxValue_1;
  wire       [1:0]    _zz__zz_1;
  reg        [16:0]   _zz__zz_shiftedValues_0;
  wire       [1:0]    _zz__zz_shiftedValues_0_1;
  wire       [1:0]    _zz__zz_2;
  reg        [16:0]   _zz__zz_when_Softmax_l57;
  wire       [1:0]    _zz__zz_when_Softmax_l57_1;
  wire       [16:0]   _zz__zz_when_Softmax_l59_1;
  wire       [15:0]   _zz__zz_expValues_0;
  wire       [15:0]   _zz__zz_expValues_0_1;
  wire       [17:0]   _zz_sumExp;
  reg        [15:0]   _zz_sumExp_1;
  wire       [1:0]    _zz_sumExp_2;
  wire       [1:0]    _zz__zz_3;
  wire       [23:0]   _zz__zz_outputReg_0;
  reg        [15:0]   _zz__zz_outputReg_0_1;
  wire       [1:0]    _zz__zz_outputReg_0_2;
  reg        [2:0]    state_1;
  reg        [2:0]    counter;
  reg        [16:0]   inputReg_0;
  reg        [16:0]   inputReg_1;
  reg        [16:0]   inputReg_2;
  reg        [16:0]   inputReg_3;
  reg        [16:0]   maxValue;
  reg        [16:0]   shiftedValues_0;
  reg        [16:0]   shiftedValues_1;
  reg        [16:0]   shiftedValues_2;
  reg        [16:0]   shiftedValues_3;
  reg        [15:0]   expValues_0;
  reg        [15:0]   expValues_1;
  reg        [15:0]   expValues_2;
  reg        [15:0]   expValues_3;
  reg        [17:0]   sumExp;
  reg        [15:0]   outputReg_0;
  reg        [15:0]   outputReg_1;
  reg        [15:0]   outputReg_2;
  reg        [15:0]   outputReg_3;
  wire                when_Softmax_l84;
  wire                when_Softmax_l86;
  wire                when_Softmax_l96;
  wire       [3:0]    _zz_1;
  wire       [16:0]   _zz_shiftedValues_0;
  wire                when_Softmax_l106;
  wire       [3:0]    _zz_2;
  wire       [16:0]   _zz_when_Softmax_l57;
  reg        [15:0]   _zz_expValues_0;
  wire       [16:0]   _zz_when_Softmax_l59;
  wire                when_Softmax_l57;
  wire       [16:0]   _zz_when_Softmax_l59_1;
  wire       [15:0]   _zz_expValues_0_1;
  wire       [16:0]   _zz_expValues_0_2;
  wire                when_Softmax_l59;
  wire                when_Softmax_l117;
  wire                when_Softmax_l127;
  wire       [3:0]    _zz_3;
  wire       [23:0]   _zz_outputReg_0;
  `ifndef SYNTHESIS
  reg [63:0] state_1_string;
  `endif


  assign _zz_when_Softmax_l86_1 = counter[1:0];
  assign _zz_maxValue_1 = counter[1:0];
  assign _zz__zz_1 = counter[1:0];
  assign _zz__zz_shiftedValues_0_1 = counter[1:0];
  assign _zz__zz_2 = counter[1:0];
  assign _zz__zz_when_Softmax_l57_1 = counter[1:0];
  assign _zz__zz_when_Softmax_l59_1 = ((~ _zz_when_Softmax_l59) + 17'h00001);
  assign _zz__zz_expValues_0 = _zz_expValues_0_2[15:0];
  assign _zz__zz_expValues_0_1 = _zz_expValues_0_2[15:0];
  assign _zz_sumExp = {2'd0, _zz_sumExp_1};
  assign _zz_sumExp_2 = counter[1:0];
  assign _zz__zz_3 = counter[1:0];
  assign _zz__zz_outputReg_0 = ({8'd0,_zz__zz_outputReg_0_1} <<< 4'd8);
  assign _zz__zz_outputReg_0_2 = counter[1:0];
  always @(*) begin
    case(_zz_when_Softmax_l86_1)
      2'b00 : _zz_when_Softmax_l86 = inputReg_0;
      2'b01 : _zz_when_Softmax_l86 = inputReg_1;
      2'b10 : _zz_when_Softmax_l86 = inputReg_2;
      default : _zz_when_Softmax_l86 = inputReg_3;
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
    case(_zz__zz_when_Softmax_l57_1)
      2'b00 : _zz__zz_when_Softmax_l57 = shiftedValues_0;
      2'b01 : _zz__zz_when_Softmax_l57 = shiftedValues_1;
      2'b10 : _zz__zz_when_Softmax_l57 = shiftedValues_2;
      default : _zz__zz_when_Softmax_l57 = shiftedValues_3;
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
    case(_zz__zz_outputReg_0_2)
      2'b00 : _zz__zz_outputReg_0_1 = expValues_0;
      2'b01 : _zz__zz_outputReg_0_1 = expValues_1;
      2'b10 : _zz__zz_outputReg_0_1 = expValues_2;
      default : _zz__zz_outputReg_0_1 = expValues_3;
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
  assign when_Softmax_l84 = (counter < 3'b011);
  assign when_Softmax_l86 = ($signed(maxValue) < $signed(_zz_when_Softmax_l86));
  assign when_Softmax_l96 = (counter < 3'b100);
  assign _zz_1 = ({3'd0,1'b1} <<< _zz__zz_1);
  assign _zz_shiftedValues_0 = ($signed(_zz__zz_shiftedValues_0) - $signed(maxValue));
  assign when_Softmax_l106 = (counter < 3'b100);
  assign _zz_2 = ({3'd0,1'b1} <<< _zz__zz_2);
  assign _zz_when_Softmax_l57 = _zz__zz_when_Softmax_l57;
  assign _zz_when_Softmax_l59 = _zz_when_Softmax_l57;
  assign when_Softmax_l57 = _zz_when_Softmax_l57[16];
  assign _zz_when_Softmax_l59_1 = (when_Softmax_l57 ? _zz__zz_when_Softmax_l59_1 : _zz_when_Softmax_l59);
  assign _zz_expValues_0_1 = 16'h0100;
  assign _zz_expValues_0_2 = _zz_when_Softmax_l59_1;
  assign when_Softmax_l59 = (_zz_when_Softmax_l59_1 < 17'h00100);
  always @(*) begin
    if(when_Softmax_l57) begin
      if(when_Softmax_l59) begin
        _zz_expValues_0 = (_zz_expValues_0_1 - _zz__zz_expValues_0);
      end else begin
        _zz_expValues_0 = 16'h0001;
      end
    end else begin
      _zz_expValues_0 = (_zz_expValues_0_1 + _zz__zz_expValues_0_1);
    end
  end

  assign when_Softmax_l117 = (counter < 3'b100);
  assign when_Softmax_l127 = (counter < 3'b100);
  assign _zz_3 = ({3'd0,1'b1} <<< _zz__zz_3);
  assign _zz_outputReg_0 = (_zz__zz_outputReg_0 / sumExp);
  always @(posedge clk) begin
    if(!resetn) begin
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
          if(when_Softmax_l84) begin
            counter <= (counter + 3'b001);
          end else begin
            counter <= 3'b000;
            state_1 <= State_SUB_MAX;
          end
        end
        State_SUB_MAX : begin
          if(when_Softmax_l96) begin
            counter <= (counter + 3'b001);
          end else begin
            counter <= 3'b000;
            state_1 <= State_EXP_CALC;
          end
        end
        State_EXP_CALC : begin
          if(when_Softmax_l106) begin
            counter <= (counter + 3'b001);
          end else begin
            counter <= 3'b000;
            state_1 <= State_SUM_EXP;
          end
        end
        State_SUM_EXP : begin
          if(when_Softmax_l117) begin
            counter <= (counter + 3'b001);
          end else begin
            counter <= 3'b000;
            state_1 <= State_DIV_CALC;
          end
        end
        State_DIV_CALC : begin
          if(when_Softmax_l127) begin
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
        if(when_Softmax_l84) begin
          if(when_Softmax_l86) begin
            maxValue <= _zz_maxValue;
          end
        end
      end
      State_SUB_MAX : begin
        if(when_Softmax_l96) begin
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
        if(when_Softmax_l106) begin
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
          sumExp <= 18'h0;
        end
      end
      State_SUM_EXP : begin
        if(when_Softmax_l117) begin
          sumExp <= (sumExp + _zz_sumExp);
        end
      end
      State_DIV_CALC : begin
        if(when_Softmax_l127) begin
          if(_zz_3[0]) begin
            outputReg_0 <= _zz_outputReg_0[15:0];
          end
          if(_zz_3[1]) begin
            outputReg_1 <= _zz_outputReg_0[15:0];
          end
          if(_zz_3[2]) begin
            outputReg_2 <= _zz_outputReg_0[15:0];
          end
          if(_zz_3[3]) begin
            outputReg_3 <= _zz_outputReg_0[15:0];
          end
        end
      end
      default : begin
      end
    endcase
  end


endmodule
