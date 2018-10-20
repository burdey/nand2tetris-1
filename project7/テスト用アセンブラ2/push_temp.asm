//じゅんび
@256
D=A
@SP
M=D
// R=7に21を入れておく
@21
D=A
@R7
M=D
// ここまで準備
@R5
D=A
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
