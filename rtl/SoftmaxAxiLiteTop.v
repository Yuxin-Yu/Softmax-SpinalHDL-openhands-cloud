// Generator : SpinalHDL v1.10.2a    git head : a348a60b7e8b6a455c72e1536ec3d74a2ea16935
// Component : SoftmaxAxiLiteTop
// Git hash  : f0eff3e5a2d8420c8b0da69ef274550e6f843ba8

`timescale 1ns/1ps

module SoftmaxAxiLiteTop (
  input  wire          io_axiLite_aw_valid,
  output wire          io_axiLite_aw_ready,
  input  wire [11:0]   io_axiLite_aw_payload_addr,
  input  wire [2:0]    io_axiLite_aw_payload_prot,
  input  wire          io_axiLite_w_valid,
  output wire          io_axiLite_w_ready,
  input  wire [31:0]   io_axiLite_w_payload_data,
  input  wire [3:0]    io_axiLite_w_payload_strb,
  output wire          io_axiLite_b_valid,
  input  wire          io_axiLite_b_ready,
  output wire [1:0]    io_axiLite_b_payload_resp,
  input  wire          io_axiLite_ar_valid,
  output wire          io_axiLite_ar_ready,
  input  wire [11:0]   io_axiLite_ar_payload_addr,
  input  wire [2:0]    io_axiLite_ar_payload_prot,
  output wire          io_axiLite_r_valid,
  input  wire          io_axiLite_r_ready,
  output wire [31:0]   io_axiLite_r_payload_data,
  output wire [1:0]    io_axiLite_r_payload_resp,
  input  wire          clk,
  input  wire          reset
);

  wire                softmaxAxiLite_1_io_axiLite_aw_ready;
  wire                softmaxAxiLite_1_io_axiLite_w_ready;
  wire                softmaxAxiLite_1_io_axiLite_b_valid;
  wire       [1:0]    softmaxAxiLite_1_io_axiLite_b_payload_resp;
  wire                softmaxAxiLite_1_io_axiLite_ar_ready;
  wire                softmaxAxiLite_1_io_axiLite_r_valid;
  wire       [31:0]   softmaxAxiLite_1_io_axiLite_r_payload_data;
  wire       [1:0]    softmaxAxiLite_1_io_axiLite_r_payload_resp;

  SoftmaxAxiLite softmaxAxiLite_1 (
    .io_axiLite_aw_valid        (io_axiLite_aw_valid                             ), //i
    .io_axiLite_aw_ready        (softmaxAxiLite_1_io_axiLite_aw_ready            ), //o
    .io_axiLite_aw_payload_addr (io_axiLite_aw_payload_addr[11:0]                ), //i
    .io_axiLite_aw_payload_prot (io_axiLite_aw_payload_prot[2:0]                 ), //i
    .io_axiLite_w_valid         (io_axiLite_w_valid                              ), //i
    .io_axiLite_w_ready         (softmaxAxiLite_1_io_axiLite_w_ready             ), //o
    .io_axiLite_w_payload_data  (io_axiLite_w_payload_data[31:0]                 ), //i
    .io_axiLite_w_payload_strb  (io_axiLite_w_payload_strb[3:0]                  ), //i
    .io_axiLite_b_valid         (softmaxAxiLite_1_io_axiLite_b_valid             ), //o
    .io_axiLite_b_ready         (io_axiLite_b_ready                              ), //i
    .io_axiLite_b_payload_resp  (softmaxAxiLite_1_io_axiLite_b_payload_resp[1:0] ), //o
    .io_axiLite_ar_valid        (io_axiLite_ar_valid                             ), //i
    .io_axiLite_ar_ready        (softmaxAxiLite_1_io_axiLite_ar_ready            ), //o
    .io_axiLite_ar_payload_addr (io_axiLite_ar_payload_addr[11:0]                ), //i
    .io_axiLite_ar_payload_prot (io_axiLite_ar_payload_prot[2:0]                 ), //i
    .io_axiLite_r_valid         (softmaxAxiLite_1_io_axiLite_r_valid             ), //o
    .io_axiLite_r_ready         (io_axiLite_r_ready                              ), //i
    .io_axiLite_r_payload_data  (softmaxAxiLite_1_io_axiLite_r_payload_data[31:0]), //o
    .io_axiLite_r_payload_resp  (softmaxAxiLite_1_io_axiLite_r_payload_resp[1:0] ), //o
    .clk                        (clk                                             ), //i
    .reset                      (reset                                           )  //i
  );
  assign io_axiLite_aw_ready = softmaxAxiLite_1_io_axiLite_aw_ready;
  assign io_axiLite_w_ready = softmaxAxiLite_1_io_axiLite_w_ready;
  assign io_axiLite_b_valid = softmaxAxiLite_1_io_axiLite_b_valid;
  assign io_axiLite_b_payload_resp = softmaxAxiLite_1_io_axiLite_b_payload_resp;
  assign io_axiLite_ar_ready = softmaxAxiLite_1_io_axiLite_ar_ready;
  assign io_axiLite_r_valid = softmaxAxiLite_1_io_axiLite_r_valid;
  assign io_axiLite_r_payload_data = softmaxAxiLite_1_io_axiLite_r_payload_data;
  assign io_axiLite_r_payload_resp = softmaxAxiLite_1_io_axiLite_r_payload_resp;

endmodule

module SoftmaxAxiLite (
  input  wire          io_axiLite_aw_valid,
  output wire          io_axiLite_aw_ready,
  input  wire [11:0]   io_axiLite_aw_payload_addr,
  input  wire [2:0]    io_axiLite_aw_payload_prot,
  input  wire          io_axiLite_w_valid,
  output wire          io_axiLite_w_ready,
  input  wire [31:0]   io_axiLite_w_payload_data,
  input  wire [3:0]    io_axiLite_w_payload_strb,
  output wire          io_axiLite_b_valid,
  input  wire          io_axiLite_b_ready,
  output wire [1:0]    io_axiLite_b_payload_resp,
  input  wire          io_axiLite_ar_valid,
  output wire          io_axiLite_ar_ready,
  input  wire [11:0]   io_axiLite_ar_payload_addr,
  input  wire [2:0]    io_axiLite_ar_payload_prot,
  output wire          io_axiLite_r_valid,
  input  wire          io_axiLite_r_ready,
  output wire [31:0]   io_axiLite_r_payload_data,
  output wire [1:0]    io_axiLite_r_payload_resp,
  input  wire          clk,
  input  wire          reset
);
  localparam ControlState_IDLE = 2'd0;
  localparam ControlState_PROCESSING = 2'd1;
  localparam ControlState_DONE = 2'd2;

  wire       [20:0]   softmax_1_io_input_0;
  wire       [20:0]   softmax_1_io_input_1;
  wire       [20:0]   softmax_1_io_input_2;
  wire       [20:0]   softmax_1_io_input_3;
  reg                 softmax_1_io_valid_in;
  wire       [19:0]   softmax_1_io_output_0;
  wire       [19:0]   softmax_1_io_output_1;
  wire       [19:0]   softmax_1_io_output_2;
  wire       [19:0]   softmax_1_io_output_3;
  wire                softmax_1_io_valid_out;
  wire                softmax_1_io_ready;
  wire       [19:0]   _zz_io_input_0;
  wire       [19:0]   _zz_io_input_1;
  wire       [19:0]   _zz_io_input_2;
  wire       [19:0]   _zz_io_input_3;
  wire       [19:0]   _zz_outputRegs_0;
  wire       [19:0]   _zz_outputRegs_1;
  wire       [19:0]   _zz_outputRegs_2;
  wire       [19:0]   _zz_outputRegs_3;
  wire                axiLiteCtrl_readErrorFlag;
  wire                axiLiteCtrl_writeErrorFlag;
  wire                axiLiteCtrl_readHaltRequest;
  wire                axiLiteCtrl_writeHaltRequest;
  wire                axiLiteCtrl_writeJoinEvent_valid;
  wire                axiLiteCtrl_writeJoinEvent_ready;
  wire                axiLiteCtrl_writeOccur;
  reg        [1:0]    axiLiteCtrl_writeRsp_resp;
  wire                axiLiteCtrl_writeJoinEvent_translated_valid;
  wire                axiLiteCtrl_writeJoinEvent_translated_ready;
  wire       [1:0]    axiLiteCtrl_writeJoinEvent_translated_payload_resp;
  wire                _zz_axiLiteCtrl_writeJoinEvent_translated_ready;
  wire                _zz_axiLiteCtrl_writeJoinEvent_translated_ready_1;
  wire                _zz_io_axiLite_b_valid;
  reg                 _zz_io_axiLite_b_valid_1;
  reg        [1:0]    _zz_io_axiLite_b_payload_resp;
  wire                axiLiteCtrl_readDataStage_valid;
  wire                axiLiteCtrl_readDataStage_ready;
  wire       [11:0]   axiLiteCtrl_readDataStage_payload_addr;
  wire       [2:0]    axiLiteCtrl_readDataStage_payload_prot;
  reg                 io_axiLite_ar_rValid;
  wire                axiLiteCtrl_readDataStage_fire;
  reg        [11:0]   io_axiLite_ar_rData_addr;
  reg        [2:0]    io_axiLite_ar_rData_prot;
  reg        [31:0]   axiLiteCtrl_readRsp_data;
  reg        [1:0]    axiLiteCtrl_readRsp_resp;
  wire                _zz_io_axiLite_r_valid;
  wire       [11:0]   axiLiteCtrl_readAddressMasked;
  wire       [11:0]   axiLiteCtrl_writeAddressMasked;
  wire                axiLiteCtrl_readOccur;
  reg        [31:0]   inputRegs_0;
  reg        [31:0]   inputRegs_1;
  reg        [31:0]   inputRegs_2;
  reg        [31:0]   inputRegs_3;
  reg        [31:0]   outputRegs_0;
  reg        [31:0]   outputRegs_1;
  reg        [31:0]   outputRegs_2;
  reg        [31:0]   outputRegs_3;
  reg                 start;
  reg                 softReset;
  reg                 busy;
  reg                 done;
  wire       [31:0]   ctrlRegRead;
  wire       [31:0]   statusRegRead;
  reg                 _zz_start;
  reg                 _zz_softReset;
  reg        [31:0]   inputRegs_0_driver;
  reg        [31:0]   inputRegs_1_driver;
  reg        [31:0]   inputRegs_2_driver;
  reg        [31:0]   inputRegs_3_driver;
  reg        [1:0]    controlState_1;
  reg                 start_regNext;
  wire                startPulse;
  wire                when_SoftmaxAxiLite_l109;
  wire                when_SoftmaxAxiLite_l129;
  `ifndef SYNTHESIS
  reg [79:0] controlState_1_string;
  `endif


  assign _zz_io_input_0 = inputRegs_0[19 : 0];
  assign _zz_io_input_1 = inputRegs_1[19 : 0];
  assign _zz_io_input_2 = inputRegs_2[19 : 0];
  assign _zz_io_input_3 = inputRegs_3[19 : 0];
  assign _zz_outputRegs_0 = softmax_1_io_output_0;
  assign _zz_outputRegs_1 = softmax_1_io_output_1;
  assign _zz_outputRegs_2 = softmax_1_io_output_2;
  assign _zz_outputRegs_3 = softmax_1_io_output_3;
  Softmax softmax_1 (
    .io_input_0   (softmax_1_io_input_0[20:0] ), //i
    .io_input_1   (softmax_1_io_input_1[20:0] ), //i
    .io_input_2   (softmax_1_io_input_2[20:0] ), //i
    .io_input_3   (softmax_1_io_input_3[20:0] ), //i
    .io_output_0  (softmax_1_io_output_0[19:0]), //o
    .io_output_1  (softmax_1_io_output_1[19:0]), //o
    .io_output_2  (softmax_1_io_output_2[19:0]), //o
    .io_output_3  (softmax_1_io_output_3[19:0]), //o
    .io_valid_in  (softmax_1_io_valid_in      ), //i
    .io_valid_out (softmax_1_io_valid_out     ), //o
    .io_ready     (softmax_1_io_ready         ), //o
    .clk          (clk                        ), //i
    .reset        (reset                      )  //i
  );
  `ifndef SYNTHESIS
  always @(*) begin
    case(controlState_1)
      ControlState_IDLE : controlState_1_string = "IDLE      ";
      ControlState_PROCESSING : controlState_1_string = "PROCESSING";
      ControlState_DONE : controlState_1_string = "DONE      ";
      default : controlState_1_string = "??????????";
    endcase
  end
  `endif

  assign axiLiteCtrl_readErrorFlag = 1'b0;
  assign axiLiteCtrl_writeErrorFlag = 1'b0;
  assign axiLiteCtrl_readHaltRequest = 1'b0;
  assign axiLiteCtrl_writeHaltRequest = 1'b0;
  assign axiLiteCtrl_writeOccur = (axiLiteCtrl_writeJoinEvent_valid && axiLiteCtrl_writeJoinEvent_ready);
  assign axiLiteCtrl_writeJoinEvent_valid = (io_axiLite_aw_valid && io_axiLite_w_valid);
  assign io_axiLite_aw_ready = axiLiteCtrl_writeOccur;
  assign io_axiLite_w_ready = axiLiteCtrl_writeOccur;
  assign axiLiteCtrl_writeJoinEvent_translated_valid = axiLiteCtrl_writeJoinEvent_valid;
  assign axiLiteCtrl_writeJoinEvent_ready = axiLiteCtrl_writeJoinEvent_translated_ready;
  assign axiLiteCtrl_writeJoinEvent_translated_payload_resp = axiLiteCtrl_writeRsp_resp;
  assign _zz_axiLiteCtrl_writeJoinEvent_translated_ready = (! axiLiteCtrl_writeHaltRequest);
  assign axiLiteCtrl_writeJoinEvent_translated_ready = (_zz_axiLiteCtrl_writeJoinEvent_translated_ready_1 && _zz_axiLiteCtrl_writeJoinEvent_translated_ready);
  assign _zz_axiLiteCtrl_writeJoinEvent_translated_ready_1 = (! _zz_io_axiLite_b_valid_1);
  assign _zz_io_axiLite_b_valid = _zz_io_axiLite_b_valid_1;
  assign io_axiLite_b_valid = _zz_io_axiLite_b_valid;
  assign io_axiLite_b_payload_resp = _zz_io_axiLite_b_payload_resp;
  assign axiLiteCtrl_readDataStage_fire = (axiLiteCtrl_readDataStage_valid && axiLiteCtrl_readDataStage_ready);
  assign io_axiLite_ar_ready = (! io_axiLite_ar_rValid);
  assign axiLiteCtrl_readDataStage_valid = io_axiLite_ar_rValid;
  assign axiLiteCtrl_readDataStage_payload_addr = io_axiLite_ar_rData_addr;
  assign axiLiteCtrl_readDataStage_payload_prot = io_axiLite_ar_rData_prot;
  assign _zz_io_axiLite_r_valid = (! axiLiteCtrl_readHaltRequest);
  assign axiLiteCtrl_readDataStage_ready = (io_axiLite_r_ready && _zz_io_axiLite_r_valid);
  assign io_axiLite_r_valid = (axiLiteCtrl_readDataStage_valid && _zz_io_axiLite_r_valid);
  assign io_axiLite_r_payload_data = axiLiteCtrl_readRsp_data;
  assign io_axiLite_r_payload_resp = axiLiteCtrl_readRsp_resp;
  always @(*) begin
    if(axiLiteCtrl_writeErrorFlag) begin
      axiLiteCtrl_writeRsp_resp = 2'b10;
    end else begin
      axiLiteCtrl_writeRsp_resp = 2'b00;
    end
  end

  always @(*) begin
    if(axiLiteCtrl_readErrorFlag) begin
      axiLiteCtrl_readRsp_resp = 2'b10;
    end else begin
      axiLiteCtrl_readRsp_resp = 2'b00;
    end
  end

  always @(*) begin
    axiLiteCtrl_readRsp_data = 32'h0;
    case(axiLiteCtrl_readAddressMasked)
      12'h0 : begin
        axiLiteCtrl_readRsp_data[31 : 0] = ctrlRegRead;
      end
      12'h004 : begin
        axiLiteCtrl_readRsp_data[31 : 0] = statusRegRead;
      end
      12'h010 : begin
        axiLiteCtrl_readRsp_data[31 : 0] = inputRegs_0_driver;
      end
      12'h014 : begin
        axiLiteCtrl_readRsp_data[31 : 0] = inputRegs_1_driver;
      end
      12'h018 : begin
        axiLiteCtrl_readRsp_data[31 : 0] = inputRegs_2_driver;
      end
      12'h01c : begin
        axiLiteCtrl_readRsp_data[31 : 0] = inputRegs_3_driver;
      end
      12'h020 : begin
        axiLiteCtrl_readRsp_data[31 : 0] = outputRegs_0;
      end
      12'h024 : begin
        axiLiteCtrl_readRsp_data[31 : 0] = outputRegs_1;
      end
      12'h028 : begin
        axiLiteCtrl_readRsp_data[31 : 0] = outputRegs_2;
      end
      12'h02c : begin
        axiLiteCtrl_readRsp_data[31 : 0] = outputRegs_3;
      end
      default : begin
      end
    endcase
  end

  assign axiLiteCtrl_readAddressMasked = (axiLiteCtrl_readDataStage_payload_addr & (~ 12'h003));
  assign axiLiteCtrl_writeAddressMasked = (io_axiLite_aw_payload_addr & (~ 12'h003));
  assign axiLiteCtrl_readOccur = (io_axiLite_r_valid && io_axiLite_r_ready);
  assign ctrlRegRead = {busy,{29'h0,{softReset,start}}};
  assign statusRegRead = {30'h0,{softmax_1_io_ready,done}};
  assign softmax_1_io_input_0 = {{1{_zz_io_input_0[19]}}, _zz_io_input_0};
  assign softmax_1_io_input_1 = {{1{_zz_io_input_1[19]}}, _zz_io_input_1};
  assign softmax_1_io_input_2 = {{1{_zz_io_input_2[19]}}, _zz_io_input_2};
  assign softmax_1_io_input_3 = {{1{_zz_io_input_3[19]}}, _zz_io_input_3};
  assign startPulse = (start_regNext && (! start));
  always @(*) begin
    softmax_1_io_valid_in = 1'b0;
    case(controlState_1)
      ControlState_IDLE : begin
      end
      ControlState_PROCESSING : begin
        if(softmax_1_io_ready) begin
          softmax_1_io_valid_in = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  assign when_SoftmaxAxiLite_l109 = (start && (! softReset));
  assign when_SoftmaxAxiLite_l129 = ((! start) || softReset);
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      _zz_io_axiLite_b_valid_1 <= 1'b0;
      io_axiLite_ar_rValid <= 1'b0;
      start <= 1'b0;
      softReset <= 1'b0;
      busy <= 1'b0;
      done <= 1'b0;
      controlState_1 <= ControlState_IDLE;
    end else begin
      if((axiLiteCtrl_writeJoinEvent_translated_valid && _zz_axiLiteCtrl_writeJoinEvent_translated_ready)) begin
        _zz_io_axiLite_b_valid_1 <= 1'b1;
      end
      if((_zz_io_axiLite_b_valid && io_axiLite_b_ready)) begin
        _zz_io_axiLite_b_valid_1 <= 1'b0;
      end
      if(io_axiLite_ar_valid) begin
        io_axiLite_ar_rValid <= 1'b1;
      end
      if(axiLiteCtrl_readDataStage_fire) begin
        io_axiLite_ar_rValid <= 1'b0;
      end
      start <= _zz_start;
      softReset <= _zz_softReset;
      busy <= (controlState_1 != ControlState_IDLE);
      done <= (controlState_1 == ControlState_DONE);
      case(controlState_1)
        ControlState_IDLE : begin
          if(when_SoftmaxAxiLite_l109) begin
            controlState_1 <= ControlState_PROCESSING;
          end
        end
        ControlState_PROCESSING : begin
          if(softmax_1_io_valid_out) begin
            controlState_1 <= ControlState_DONE;
          end
        end
        default : begin
          if(when_SoftmaxAxiLite_l129) begin
            controlState_1 <= ControlState_IDLE;
          end
        end
      endcase
      if(softReset) begin
        controlState_1 <= ControlState_IDLE;
      end
    end
  end

  always @(posedge clk) begin
    if(_zz_axiLiteCtrl_writeJoinEvent_translated_ready_1) begin
      _zz_io_axiLite_b_payload_resp <= axiLiteCtrl_writeJoinEvent_translated_payload_resp;
    end
    if(io_axiLite_ar_ready) begin
      io_axiLite_ar_rData_addr <= io_axiLite_ar_payload_addr;
      io_axiLite_ar_rData_prot <= io_axiLite_ar_payload_prot;
    end
    inputRegs_0 <= inputRegs_0_driver;
    inputRegs_1 <= inputRegs_1_driver;
    inputRegs_2 <= inputRegs_2_driver;
    inputRegs_3 <= inputRegs_3_driver;
    start_regNext <= start;
    case(controlState_1)
      ControlState_IDLE : begin
      end
      ControlState_PROCESSING : begin
        if(softmax_1_io_valid_out) begin
          outputRegs_0 <= {12'd0, _zz_outputRegs_0};
          outputRegs_1 <= {12'd0, _zz_outputRegs_1};
          outputRegs_2 <= {12'd0, _zz_outputRegs_2};
          outputRegs_3 <= {12'd0, _zz_outputRegs_3};
        end
      end
      default : begin
      end
    endcase
    case(axiLiteCtrl_writeAddressMasked)
      12'h0 : begin
        if(axiLiteCtrl_writeOccur) begin
          _zz_start <= io_axiLite_w_payload_data[0];
          _zz_softReset <= io_axiLite_w_payload_data[1];
        end
      end
      12'h010 : begin
        if(axiLiteCtrl_writeOccur) begin
          inputRegs_0_driver <= io_axiLite_w_payload_data[31 : 0];
        end
      end
      12'h014 : begin
        if(axiLiteCtrl_writeOccur) begin
          inputRegs_1_driver <= io_axiLite_w_payload_data[31 : 0];
        end
      end
      12'h018 : begin
        if(axiLiteCtrl_writeOccur) begin
          inputRegs_2_driver <= io_axiLite_w_payload_data[31 : 0];
        end
      end
      12'h01c : begin
        if(axiLiteCtrl_writeOccur) begin
          inputRegs_3_driver <= io_axiLite_w_payload_data[31 : 0];
        end
      end
      default : begin
      end
    endcase
  end


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

  reg        [20:0]   _zz_when_Softmax_l111;
  wire       [1:0]    _zz_when_Softmax_l111_1;
  reg        [20:0]   _zz_maxValue;
  wire       [1:0]    _zz_maxValue_1;
  wire       [1:0]    _zz__zz_1;
  reg        [20:0]   _zz__zz_shiftedValues_0;
  wire       [1:0]    _zz__zz_shiftedValues_0_1;
  wire       [1:0]    _zz__zz_2;
  reg        [20:0]   _zz__zz_when_Softmax_l80;
  wire       [1:0]    _zz__zz_when_Softmax_l80_1;
  wire       [20:0]   _zz__zz_when_Softmax_l82;
  wire       [20:0]   _zz__zz_when_Softmax_l82_1;
  wire       [47:0]   _zz__zz_when_Softmax_l82_3;
  wire       [23:0]   _zz__zz_when_Softmax_l82_3_1;
  wire       [23:0]   _zz__zz_when_Softmax_l82_3_2;
  wire       [59:0]   _zz__zz_when_Softmax_l82_4;
  wire       [23:0]   _zz__zz_when_Softmax_l82_4_1;
  wire       [71:0]   _zz__zz_when_Softmax_l82_5;
  wire       [23:0]   _zz__zz_when_Softmax_l82_5_1;
  wire       [23:0]   _zz__zz_when_Softmax_l82_6;
  wire       [23:0]   _zz__zz_when_Softmax_l82_6_1;
  wire       [23:0]   _zz__zz_when_Softmax_l82_6_2;
  wire       [23:0]   _zz__zz_when_Softmax_l82_6_3;
  wire       [23:0]   _zz__zz_when_Softmax_l82_6_4;
  wire       [23:0]   _zz__zz_when_Softmax_l82_6_5;
  wire       [23:0]   _zz__zz_when_Softmax_l82_6_6;
  wire       [34:0]   _zz__zz_when_Softmax_l82_6_7;
  wire       [23:0]   _zz__zz_when_Softmax_l82_6_8;
  wire       [45:0]   _zz__zz_when_Softmax_l82_6_9;
  wire       [57:0]   _zz__zz_when_Softmax_l82_6_10;
  wire       [23:0]   _zz__zz_when_Softmax_l82_6_11;
  wire       [55:0]   _zz__zz_when_Softmax_l82_6_12;
  wire       [67:0]   _zz__zz_when_Softmax_l82_6_13;
  wire       [23:0]   _zz__zz_when_Softmax_l82_6_14;
  wire       [65:0]   _zz__zz_when_Softmax_l82_6_15;
  wire       [77:0]   _zz__zz_when_Softmax_l82_6_16;
  wire       [71:0]   _zz__zz_when_Softmax_l82_6_17;
  wire       [83:0]   _zz__zz_when_Softmax_l82_6_18;
  wire       [23:0]   _zz__zz_when_Softmax_l82_6_19;
  wire       [14:0]   _zz_when_Softmax_l82_7;
  wire       [14:0]   _zz_when_Softmax_l82_8;
  wire       [43:0]   _zz__zz_expValues_0;
  wire       [43:0]   _zz__zz_expValues_0_1;
  wire       [31:0]   _zz__zz_expValues_0_2;
  wire       [31:0]   _zz__zz_expValues_0_3;
  wire       [23:0]   _zz__zz_expValues_0_4;
  wire       [19:0]   _zz__zz_expValues_0_5;
  wire       [21:0]   _zz_sumExp;
  reg        [19:0]   _zz_sumExp_1;
  wire       [1:0]    _zz_sumExp_2;
  wire       [1:0]    _zz__zz_3;
  wire       [43:0]   _zz__zz_outputReg_0;
  wire       [31:0]   _zz__zz_outputReg_0_1;
  reg        [19:0]   _zz__zz_outputReg_0_2;
  wire       [1:0]    _zz__zz_outputReg_0_3;
  wire       [31:0]   _zz__zz_outputReg_0_4;
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
  wire                when_Softmax_l109;
  wire                when_Softmax_l111;
  wire                when_Softmax_l121;
  wire       [3:0]    _zz_1;
  wire       [20:0]   _zz_shiftedValues_0;
  wire                when_Softmax_l131;
  wire       [3:0]    _zz_2;
  wire       [20:0]   _zz_when_Softmax_l80;
  reg        [19:0]   _zz_expValues_0;
  wire                when_Softmax_l80;
  wire       [20:0]   _zz_when_Softmax_l82;
  wire       [19:0]   _zz_when_Softmax_l82_1;
  wire       [20:0]   _zz_when_Softmax_l82_2;
  wire       [35:0]   _zz_when_Softmax_l82_3;
  wire       [47:0]   _zz_when_Softmax_l82_4;
  wire       [59:0]   _zz_when_Softmax_l82_5;
  wire       [23:0]   _zz_when_Softmax_l82_6;
  wire                when_Softmax_l82;
  wire       [19:0]   _zz_expValues_0_1;
  wire                when_Softmax_l142;
  wire                when_Softmax_l152;
  wire       [3:0]    _zz_3;
  wire       [43:0]   _zz_outputReg_0;
  `ifndef SYNTHESIS
  reg [63:0] state_1_string;
  `endif


  assign _zz_when_Softmax_l111_1 = counter[1:0];
  assign _zz_maxValue_1 = counter[1:0];
  assign _zz__zz_1 = counter[1:0];
  assign _zz__zz_shiftedValues_0_1 = counter[1:0];
  assign _zz__zz_2 = counter[1:0];
  assign _zz__zz_when_Softmax_l80_1 = counter[1:0];
  assign _zz__zz_when_Softmax_l82 = (when_Softmax_l80 ? _zz__zz_when_Softmax_l82_1 : _zz_when_Softmax_l80);
  assign _zz__zz_when_Softmax_l82_1 = (- _zz_when_Softmax_l80);
  assign _zz__zz_when_Softmax_l82_3 = (_zz__zz_when_Softmax_l82_3_1 * _zz__zz_when_Softmax_l82_3_2);
  assign _zz__zz_when_Softmax_l82_3_1 = {3'd0, _zz_when_Softmax_l82_2};
  assign _zz__zz_when_Softmax_l82_3_2 = {3'd0, _zz_when_Softmax_l82_2};
  assign _zz__zz_when_Softmax_l82_4 = (_zz_when_Softmax_l82_3 * _zz__zz_when_Softmax_l82_4_1);
  assign _zz__zz_when_Softmax_l82_4_1 = {3'd0, _zz_when_Softmax_l82_2};
  assign _zz__zz_when_Softmax_l82_5 = (_zz_when_Softmax_l82_4 * _zz__zz_when_Softmax_l82_5_1);
  assign _zz__zz_when_Softmax_l82_5_1 = {3'd0, _zz_when_Softmax_l82_2};
  assign _zz__zz_when_Softmax_l82_6 = (_zz__zz_when_Softmax_l82_6_1 + _zz__zz_when_Softmax_l82_6_11);
  assign _zz__zz_when_Softmax_l82_6_1 = (_zz__zz_when_Softmax_l82_6_2 + _zz__zz_when_Softmax_l82_6_8);
  assign _zz__zz_when_Softmax_l82_6_2 = (_zz__zz_when_Softmax_l82_6_3 + _zz__zz_when_Softmax_l82_6_6);
  assign _zz__zz_when_Softmax_l82_6_3 = (_zz__zz_when_Softmax_l82_6_4 + _zz__zz_when_Softmax_l82_6_5);
  assign _zz__zz_when_Softmax_l82_6_4 = {4'd0, _zz_when_Softmax_l82_1};
  assign _zz__zz_when_Softmax_l82_6_5 = {3'd0, _zz_when_Softmax_l82_2};
  assign _zz__zz_when_Softmax_l82_6_7 = (_zz_when_Softmax_l82_3 >>> 1'd1);
  assign _zz__zz_when_Softmax_l82_6_6 = _zz__zz_when_Softmax_l82_6_7[23:0];
  assign _zz__zz_when_Softmax_l82_6_9 = (_zz__zz_when_Softmax_l82_6_10 >>> 4'd12);
  assign _zz__zz_when_Softmax_l82_6_8 = _zz__zz_when_Softmax_l82_6_9[23:0];
  assign _zz__zz_when_Softmax_l82_6_10 = (_zz_when_Softmax_l82_4 * 10'h2ab);
  assign _zz__zz_when_Softmax_l82_6_12 = (_zz__zz_when_Softmax_l82_6_13 >>> 4'd12);
  assign _zz__zz_when_Softmax_l82_6_11 = _zz__zz_when_Softmax_l82_6_12[23:0];
  assign _zz__zz_when_Softmax_l82_6_13 = (_zz_when_Softmax_l82_5 * 8'hab);
  assign _zz__zz_when_Softmax_l82_6_15 = (_zz__zz_when_Softmax_l82_6_16 >>> 4'd12);
  assign _zz__zz_when_Softmax_l82_6_14 = _zz__zz_when_Softmax_l82_6_15[23:0];
  assign _zz__zz_when_Softmax_l82_6_16 = (_zz__zz_when_Softmax_l82_6_17 * 6'h22);
  assign _zz__zz_when_Softmax_l82_6_17 = (_zz__zz_when_Softmax_l82_6_18 >>> 4'd12);
  assign _zz__zz_when_Softmax_l82_6_18 = (_zz_when_Softmax_l82_5 * _zz__zz_when_Softmax_l82_6_19);
  assign _zz__zz_when_Softmax_l82_6_19 = {3'd0, _zz_when_Softmax_l82_2};
  assign _zz_when_Softmax_l82_7 = (_zz_when_Softmax_l82_1 >>> 3'd5);
  assign _zz_when_Softmax_l82_8 = _zz_when_Softmax_l82_6[14:0];
  assign _zz__zz_expValues_0 = (_zz__zz_expValues_0_1 / _zz__zz_expValues_0_3);
  assign _zz__zz_expValues_0_1 = ({12'd0,_zz__zz_expValues_0_2} <<< 4'd12);
  assign _zz__zz_expValues_0_2 = {12'd0, _zz_when_Softmax_l82_1};
  assign _zz__zz_expValues_0_3 = {8'd0, _zz_when_Softmax_l82_6};
  assign _zz__zz_expValues_0_4 = {4'd0, _zz_expValues_0_1};
  assign _zz__zz_expValues_0_5 = _zz_when_Softmax_l82_6[19:0];
  assign _zz_sumExp = {2'd0, _zz_sumExp_1};
  assign _zz_sumExp_2 = counter[1:0];
  assign _zz__zz_3 = counter[1:0];
  assign _zz__zz_outputReg_0 = ({12'd0,_zz__zz_outputReg_0_1} <<< 4'd12);
  assign _zz__zz_outputReg_0_1 = {12'd0, _zz__zz_outputReg_0_2};
  assign _zz__zz_outputReg_0_3 = counter[1:0];
  assign _zz__zz_outputReg_0_4 = {10'd0, sumExp};
  always @(*) begin
    case(_zz_when_Softmax_l111_1)
      2'b00 : _zz_when_Softmax_l111 = inputReg_0;
      2'b01 : _zz_when_Softmax_l111 = inputReg_1;
      2'b10 : _zz_when_Softmax_l111 = inputReg_2;
      default : _zz_when_Softmax_l111 = inputReg_3;
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
    case(_zz__zz_when_Softmax_l80_1)
      2'b00 : _zz__zz_when_Softmax_l80 = shiftedValues_0;
      2'b01 : _zz__zz_when_Softmax_l80 = shiftedValues_1;
      2'b10 : _zz__zz_when_Softmax_l80 = shiftedValues_2;
      default : _zz__zz_when_Softmax_l80 = shiftedValues_3;
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
  assign when_Softmax_l109 = (counter < 3'b011);
  assign when_Softmax_l111 = ($signed(maxValue) < $signed(_zz_when_Softmax_l111));
  assign when_Softmax_l121 = (counter < 3'b100);
  assign _zz_1 = ({3'd0,1'b1} <<< _zz__zz_1);
  assign _zz_shiftedValues_0 = ($signed(_zz__zz_shiftedValues_0) - $signed(maxValue));
  assign when_Softmax_l131 = (counter < 3'b100);
  assign _zz_2 = ({3'd0,1'b1} <<< _zz__zz_2);
  assign _zz_when_Softmax_l80 = _zz__zz_when_Softmax_l80;
  assign when_Softmax_l80 = _zz_when_Softmax_l80[20];
  assign _zz_when_Softmax_l82 = _zz__zz_when_Softmax_l82;
  assign _zz_when_Softmax_l82_1 = 20'h01000;
  assign _zz_when_Softmax_l82_2 = ((21'h008000 < _zz_when_Softmax_l82) ? 21'h008000 : _zz_when_Softmax_l82);
  assign _zz_when_Softmax_l82_3 = (_zz__zz_when_Softmax_l82_3 >>> 4'd12);
  assign _zz_when_Softmax_l82_4 = (_zz__zz_when_Softmax_l82_4 >>> 4'd12);
  assign _zz_when_Softmax_l82_5 = (_zz__zz_when_Softmax_l82_5 >>> 4'd12);
  assign _zz_when_Softmax_l82_6 = (_zz__zz_when_Softmax_l82_6 + _zz__zz_when_Softmax_l82_6_14);
  assign when_Softmax_l82 = (_zz_when_Softmax_l82_7 < _zz_when_Softmax_l82_8);
  always @(*) begin
    if(when_Softmax_l80) begin
      if(when_Softmax_l82) begin
        _zz_expValues_0 = _zz__zz_expValues_0[19:0];
      end else begin
        _zz_expValues_0 = 20'h00001;
      end
    end else begin
      _zz_expValues_0 = ((_zz__zz_expValues_0_4 < _zz_when_Softmax_l82_6) ? _zz_expValues_0_1 : _zz__zz_expValues_0_5);
    end
  end

  assign _zz_expValues_0_1 = 20'hfffff;
  assign when_Softmax_l142 = (counter < 3'b100);
  assign when_Softmax_l152 = (counter < 3'b100);
  assign _zz_3 = ({3'd0,1'b1} <<< _zz__zz_3);
  assign _zz_outputReg_0 = (_zz__zz_outputReg_0 / _zz__zz_outputReg_0_4);
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
          if(when_Softmax_l109) begin
            counter <= (counter + 3'b001);
          end else begin
            counter <= 3'b000;
            state_1 <= State_SUB_MAX;
          end
        end
        State_SUB_MAX : begin
          if(when_Softmax_l121) begin
            counter <= (counter + 3'b001);
          end else begin
            counter <= 3'b000;
            state_1 <= State_EXP_CALC;
          end
        end
        State_EXP_CALC : begin
          if(when_Softmax_l131) begin
            counter <= (counter + 3'b001);
          end else begin
            counter <= 3'b000;
            state_1 <= State_SUM_EXP;
          end
        end
        State_SUM_EXP : begin
          if(when_Softmax_l142) begin
            counter <= (counter + 3'b001);
          end else begin
            counter <= 3'b000;
            state_1 <= State_DIV_CALC;
          end
        end
        State_DIV_CALC : begin
          if(when_Softmax_l152) begin
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
        if(when_Softmax_l109) begin
          if(when_Softmax_l111) begin
            maxValue <= _zz_maxValue;
          end
        end
      end
      State_SUB_MAX : begin
        if(when_Softmax_l121) begin
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
        if(when_Softmax_l131) begin
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
        if(when_Softmax_l142) begin
          sumExp <= (sumExp + _zz_sumExp);
        end
      end
      State_DIV_CALC : begin
        if(when_Softmax_l152) begin
          if(_zz_3[0]) begin
            outputReg_0 <= _zz_outputReg_0[19:0];
          end
          if(_zz_3[1]) begin
            outputReg_1 <= _zz_outputReg_0[19:0];
          end
          if(_zz_3[2]) begin
            outputReg_2 <= _zz_outputReg_0[19:0];
          end
          if(_zz_3[3]) begin
            outputReg_3 <= _zz_outputReg_0[19:0];
          end
        end
      end
      default : begin
      end
    endcase
  end


endmodule
