(SimpleFunction.test)
  @ARG
  D=M
  @0
  D=D+A
  @R13
  M=D
  // R13にsegment+indexの指す位置が格納された。
  @R13
  A=M
  D=M
  @ARG
  D=M
  @1
  D=D+A
  @R13
  M=D
  // R13にsegment+indexの指す位置が格納された。
  @R13
  A=M
  D=M
  @LCL
  D=M
  @0
  D=D+A
  @R13
  M=D
  // R13にsegment+indexの指す位置が格納された。
  @R13
  A=M
  D=M
        @SP
        A=M
        M=D
        @SP
        M=M+1
  @LCL
  D=M
  @1
  D=D+A
  @R13
  M=D
  // R13にsegment+indexの指す位置が格納された。
  @R13
  A=M
  D=M
        @SP
        A=M
        M=D
        @SP
        M=M+1
        @SP
        M=M-1
        A=M
        D=M
        @SP
        M=M-1
        A=M
        D=D+M
        M=D
        @SP
        M=M+1
        @SP
        M=M-1
        A=M
        D=M
        D=!D
        M=D
        @SP
        M=M+1
  @ARG
  D=M
  @0
  D=D+A
  @R13
  M=D
  // R13にsegment+indexの指す位置が格納された。
  @R13
  A=M
  D=M
        @SP
        A=M
        M=D
        @SP
        M=M+1
        @SP
        M=M-1
        A=M
        D=M
        @SP
        M=M-1
        A=M
        D=D+M
        M=D
        @SP
        M=M+1
  @ARG
  D=M
  @1
  D=D+A
  @R13
  M=D
  // R13にsegment+indexの指す位置が格納された。
  @R13
  A=M
  D=M
        @SP
        A=M
        M=D
        @SP
        M=M+1
        @SP
        M=M-1
        A=M
        D=M
        @SP
        M=M-1
        A=M
        D=M-D
        M=D
        @SP
        M=M+1
      // FRAME=LCL
      @LCL
      D=M
      @R13
      M=D
      // R13にLCLが入った。
      // RET=*(FRAME-5)
      @LCL
      D=M
      @5
      D=D-A
      A=D
      D=M
      @R14
      M=D
      // R14にリターンアドレスが入った。
      // *ARG=POP()
      // ARGの位置にスタックから結果を格納
      @SP
      M=M-1
      A=M
      D=M
      @ARG
      A=M
      M=D
      // SP=ARG+1
      @ARG
      D=M
      @SP
      M=D+1
      // THAT=*(FRAME-1)
      @R13
      D=M
      @1
      D=D-A
      A=D
      D=M
      @THAT
      M=D
      // THIS=*(FRAME-2)
      @R13
      D=M
      @2
      D=D-A
      A=D
      D=M
      @THIS
      M=D
      // ARG=*(FRAME-3)
      @R13
      D=M
      @3
      D=D-A
      A=D
      D=M
      @ARG
      M=D
      // LCL=*(FRAME-4)
      @R13
      D=M
      @4
      D=D-A
      A=D
      D=M
      @LCL
      M=D
      // GOTO RET
      @R14
      A=M
      0; JMP
