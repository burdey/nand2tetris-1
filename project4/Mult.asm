// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], R1, and R2, respectively.)

// Put your code here.
  @result
  M=0
  @count
  M=0
(LOOP)
  @R0
  D=M
  @count
  D=D-M
  @END
  D; JEQ
  @R1
  D=M
  @result
  M=D+M
  @count
  M=M+1
  @LOOP
  0; JMP
(END)
  @result
  D=M
  @R2
  M=D
  @ENDLOOP
  0, JMP
(ENDLOOP)
  @ENDLOOP
  0; JMP
