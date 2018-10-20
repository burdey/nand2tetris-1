    // ↓R13に LCL+index を保存
    @LCL
    D=M
    @0
    D=D+A
    @R13
    M=D
    // ↑R13に LCL+index を保存
    // ↓R13の位置にスタックから値を格納
    @SP
    M=M-1
    A=M
    D=M
    @R13
    A=M
    M=D
