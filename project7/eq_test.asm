@256
D=A
@SP
M=D

@21
D=A
@SP
A=M
M=D
@SP
M=M+1

@21
D=A
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
@TRUE
D;JEQ
@0
D=A
@SP
A=M
M=D
@SP
M=M+1
@NEXT
0;JMP
(TRUE)
@0
D=A
D=D-1
@SP
A=M
M=D
@SP
M=M+1
(NEXT)