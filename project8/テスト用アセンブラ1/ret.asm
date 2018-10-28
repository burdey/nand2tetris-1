//じゅんび
@256
D=A
@SP
M=D
//じゅんび
@300
D=A
@LCL
M=D
//じゅんび
@400
D=A
@ARG
M=D
// SP-1に123を入れておく
@123
D=A
@255
M=D
// LCL-5に111を入れておく
@111
D=A
@295
M=D
// ここまで準備
@LCL
D=M
@R13
M=D
// R13にLCLが入った。
@LCL
D=M
@5
D=D-A
@R14
M=D
// R14にリターンアドレスが入った。
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
