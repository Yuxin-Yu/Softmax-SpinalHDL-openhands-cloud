# SpinalHDL Softmax 实现

这个项目使用SpinalHDL实现了Softmax函数的硬件版本，包含完整的测试套件和演示程序。

## 项目结构

```
├── build.sbt                       # SBT构建配置
├── src/
│   ├── main/scala/
│   │   ├── Softmax.scala           # Softmax核心实现
│   │   ├── SoftmaxMain.scala       # 基础版本Verilog生成程序
│   │   ├── SoftmaxDemo.scala       # 基础版本演示程序
│   │   ├── SoftmaxAxiLite.scala    # AXI-Lite接口版本实现
│   │   └── SoftmaxAxiLiteDemo.scala # AXI-Lite版本演示程序
│   └── test/scala/
│       ├── SoftmaxTest.scala       # 基础版本测试套件
│       └── SoftmaxAxiLiteTest.scala # AXI-Lite版本测试套件
├── rtl/
│   ├── SoftmaxTop.v               # 基础版本Verilog代码
│   └── SoftmaxAxiLiteTop.v        # AXI-Lite版本Verilog代码
└── README.md                      # 项目说明
```

## 功能特性

### 两种实现版本

#### 1. 基础版本 (`Softmax.scala`)
- **数据格式**: 16位定点数 (8位整数部分 + 8位小数部分)
- **向量大小**: 4个元素 (可配置)
- **状态机设计**: 6个状态实现完整的Softmax计算流程
- **指数近似**: 使用简化的泰勒级数近似exp函数
- **流水线处理**: 支持连续输入处理
- **接口**: 简单的valid/ready握手协议

#### 2. AXI-Lite版本 (`SoftmaxAxiLite.scala`)
- **标准接口**: 完整的AXI-Lite 4.0接口
- **寄存器映射**: 清晰的内存映射寄存器
- **SoC集成**: 易于集成到ARM/RISC-V SoC系统
- **CPU访问**: 支持CPU直接读写控制
- **状态监控**: 实时状态和控制寄存器
- **软复位**: 支持软件复位功能

### 状态机流程

1. **IDLE**: 等待输入数据
2. **FIND_MAX**: 找到输入向量的最大值
3. **SUB_MAX**: 从每个元素减去最大值 (数值稳定性)
4. **EXP_CALC**: 计算每个元素的指数近似值
5. **SUM_EXP**: 计算所有指数值的和
6. **DIV_CALC**: 执行归一化除法
7. **DONE**: 输出结果

### 配置参数

```scala
case class SoftmaxConfig(
  dataWidth: Int = 16,      // 数据位宽
  vectorSize: Int = 4,      // 输入向量大小
  fracWidth: Int = 8        // 小数部分位宽
)
```

## 使用方法

### 1. 编译项目

```bash
sbt compile
```

### 2. 生成Verilog代码

#### 基础版本
```bash
sbt "runMain SoftmaxMain"
```
生成的Verilog文件位于 `rtl/SoftmaxTop.v`

#### AXI-Lite版本
```bash
sbt "runMain SoftmaxAxiLiteVerilog"
```
生成的Verilog文件位于 `rtl/SoftmaxAxiLiteTop.v`

### 3. 运行测试

#### 基础版本测试
```bash
sbt "testOnly SoftmaxTest"
```

#### AXI-Lite版本测试
```bash
sbt "testOnly SoftmaxAxiLiteTest"
```

#### 运行所有测试
```bash
sbt test
```

测试包括：
- 基本功能测试 (递增输入)
- 负值处理测试
- 相等值处理测试
- AXI-Lite寄存器访问测试
- 软复位功能测试

### 4. 运行演示程序

#### 基础版本演示
```bash
sbt "runMain SoftmaxDemo"
```

#### AXI-Lite版本演示
```bash
sbt "runMain SoftmaxAxiLiteDemo"
```

## 接口说明

### 基础版本接口

#### 输入端口
- `io_input_0` ~ `io_input_3`: 4个17位输入 (SFix格式)
- `io_valid_in`: 输入有效信号
- `clk`: 时钟信号
- `resetn`: 低电平有效复位信号

#### 输出端口
- `io_output_0` ~ `io_output_3`: 4个16位输出 (UInt格式)
- `io_valid_out`: 输出有效信号
- `io_ready`: 准备接收新输入信号

### AXI-Lite版本接口

#### AXI-Lite信号
- **写地址通道**: `aw_valid`, `aw_ready`, `aw_payload_addr[11:0]`, `aw_payload_prot[2:0]`
- **写数据通道**: `w_valid`, `w_ready`, `w_payload_data[31:0]`, `w_payload_strb[3:0]`
- **写响应通道**: `b_valid`, `b_ready`, `b_payload_resp[1:0]`
- **读地址通道**: `ar_valid`, `ar_ready`, `ar_payload_addr[11:0]`, `ar_payload_prot[2:0]`
- **读数据通道**: `r_valid`, `r_ready`, `r_payload_data[31:0]`, `r_payload_resp[1:0]`

#### 寄存器映射
- **0x00**: 控制寄存器 (bit[0]: start, bit[1]: reset, bit[31]: busy)
- **0x04**: 状态寄存器 (bit[0]: done, bit[1]: ready)
- **0x10-0x1C**: 输入数据寄存器 (input[0] ~ input[3])
- **0x20-0x2C**: 输出数据寄存器 (output[0] ~ output[3])

## 性能特点

### 精度分析

- **相等输入**: 完美精度 (误差 = 0)
- **一般输入**: 平均误差约 5-6%
- **数值稳定**: 通过减去最大值避免溢出

### 硬件资源

- **状态机**: 3位状态寄存器
- **计数器**: 3位计数器
- **存储**: 4个输入寄存器 + 4个中间结果寄存器
- **运算**: 加法器、减法器、简化除法器

### 时序特性

- **延迟**: 约20-30个时钟周期 (取决于向量大小)
- **吞吐量**: 每个计算周期处理一个向量
- **频率**: 支持高频率运行 (具体取决于目标器件)

## 设计考虑

### 1. 数值稳定性

通过减去输入向量的最大值来避免指数函数的数值溢出，这是Softmax函数的标准数值稳定技术。

### 2. 硬件友好的近似

使用简化的指数近似算法，避免复杂的浮点运算，适合FPGA实现。

### 3. 可配置设计

通过配置参数可以调整数据位宽、向量大小等，适应不同的应用需求。

### 4. 流水线友好

状态机设计支持连续输入处理，可以实现高吞吐量的数据处理。

## 应用场景

### 基础版本适用场景
- **FPGA加速卡**: 直接集成到数据流处理管道
- **专用AI芯片**: 作为神经网络推理的组件
- **高性能计算**: 需要最大吞吐量的场景

### AXI-Lite版本适用场景
- **ARM SoC系统**: Zynq、Zynq UltraScale+等平台
- **RISC-V SoC**: 支持AXI总线的RISC-V处理器系统
- **嵌入式AI**: 需要CPU控制的边缘AI应用
- **原型验证**: 便于软件调试和验证的系统

## 扩展可能

1. **更高精度**: 增加数据位宽或改进指数近似算法
2. **更大向量**: 支持更大的输入向量大小
3. **流水线优化**: 实现更深层次的流水线设计
4. **多通道**: 支持并行处理多个向量

## 依赖项

- Scala 2.12.18
- SpinalHDL 1.10.2a
- SBT 1.11.3
- Verilator 5.006 (用于仿真)
- Java 17

## 许可证

本项目仅用于学习和演示目的。