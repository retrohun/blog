; machine code part stored in DATA section of bootfromcom1.bas
; * Naszvadi, Peter, 2018 *
;
; nasm-compatible.
; primitive com-loader. entry point: CS:000h
;
bits 16
org 0
_start:
        cli
        mov ax,cs
        mov ss,ax
        mov sp,0FFFEh
        sti
        mov ds,ax
        mov es,ax
        mov [0FFFEh],word 0
        jmp _comstart
times 256-($-_start) db 0
_comstart:
