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
// ここまで準備
// push return-address
@RET
D=A
@SP
A=M
M=D
@SP
M=M+1
// push LCL
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
// push ARG
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
// push THIS
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
// push THAT
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// ARG=SP-n-5
@3
// @#{index}
D=A
@5
D=D+A
@SP
D=M-D
@ARG
M=D
// LCL=SP
@SP
D=M
@LCL
M=D
// goto f
@LOOP
0; JMP
(RET)
(LOOP)
