	.file	"test.c"
	.text
	.globl	fact
	.def	fact;	.scl	2;	.type	32;	.endef
	.seh_proc	fact
fact:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movl	%ecx, 16(%rbp)
	cmpl	$0, 16(%rbp)
	je	.L2
	movl	16(%rbp), %eax
	subl	$1, %eax
	movl	%eax, %ecx
	call	fact
	imull	16(%rbp), %eax
	jmp	.L4
.L2:
	movl	$1, %eax
.L4:
	addq	$32, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC0:
	.ascii "fact(%d) = %d\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$48, %rsp
	.seh_stackalloc	48
	.seh_endprologue
	call	__main
	movl	$5, -4(%rbp)
	movl	-4(%rbp), %eax
	movl	%eax, %ecx
	call	fact
	movl	%eax, %edx
	movl	-4(%rbp), %eax
	movl	%edx, %r8d
	movl	%eax, %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	movl	$0, %eax
	addq	$48, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.ident	"GCC: (Rev3, Built by MSYS2 project) 9.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
