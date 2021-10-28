DEFINT A-Z

TYPE RegistersStr
   ax AS INTEGER
   bx AS INTEGER
   cx AS INTEGER
   dx AS INTEGER
   ps AS INTEGER
   si AS INTEGER
   di AS INTEGER
   flags AS INTEGER
END TYPE

DECLARE SUB Interrupt (InterruptNr, RegistersIn AS RegistersStr, RegistersOut AS RegistersStr)
DECLARE SUB Main ()
DECLARE SUB SetBlinking (Blink)

SCREEN 0: PALETTE: WIDTH 80, 25: COLOR 7, 0: CLS

Main

SUB Main
   Blink = -1

   FOR ForeColor = 16 TO 31
      FOR BackColor = 0 TO 7
         COLOR ForeColor, BackColor
         PRINT " Press TAB. ";
      NEXT BackColor
   NEXT ForeColor

   DO
      SetBlinking Blink
      DO
         Key$ = INKEY$
      LOOP WHILE Key$ = ""

      SELECT CASE Key$
        CASE CHR$(9)
           Blink = NOT Blink
        CASE CHR$(27)
           COLOR 7, 0: CLS : END
      END SELECT
   LOOP
END SUB

SUB SetBlinking (Blink)
DIM Registers AS RegistersStr

   Registers.ax = &H1003
   Registers.bx = ABS(Blink)
   Interrupt &H10, Registers, Registers
END SUB

