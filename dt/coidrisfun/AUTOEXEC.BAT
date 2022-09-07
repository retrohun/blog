[autoexec]
@echo off
mount c .
c:
idris -clkint 8 -root idris.0
exit
