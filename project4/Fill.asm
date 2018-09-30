// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed.
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.
(MAINLOOP)
  @KBD
  D = M
  @WHITE
  D; JEQ
  @color
  M=0
  @PAINT
  0;JMP
(WHITE)
  @color
  M=1
  @PAINT
  0; JMP
(PAINT)
  @8192
  D=A
  @count
  M=D
  @SCREEN
  D=A
  @i
  M=D
  @color
  D=M-1
  @i
  A=M
  M=D
  @count
  M=M-1
(PLOOP)
  @color
  D=M-1
  @i
  M=M+1
  A=M
  M=D
  @count
  M=M-1
  D=M
  @PLOOP
  D;JNE
  @MAINLOOP
  0; JMP
