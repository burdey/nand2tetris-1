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
// LCL+2に11を入れておく
@31
D=A
@302
M=D
// ここまで準備
@LCL
D=M
@2 // index
D=D+A
@R13
M=D
// R13にtempの指す位置が格納された。
@R13
A=M
D=M

@SP
A=M
M=D
@SP
M=M+1
