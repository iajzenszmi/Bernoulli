	.file	"bernoulli.c"
	.text
	.globl	bernoulli
	.type	bernoulli, @function
bernoulli:
.LFB26:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -40(%rbp)
	movl	%esi, -44(%rbp)
	movl	-44(%rbp), %eax
	addl	$1, %eax
	movl	%eax, %eax
	salq	$5, %rax
	movq	%rax, %rdi
	call	malloc@PLT
	movq	%rax, -8(%rbp)
	movq	$0, -24(%rbp)
	jmp	.L2
.L3:
	movq	-24(%rbp), %rax
	salq	$5, %rax
	movq	%rax, %rdx
	movq	-8(%rbp), %rax
	addq	%rdx, %rax
	movq	%rax, %rdi
	call	__gmpq_init@PLT
	addq	$1, -24(%rbp)
.L2:
	movl	-44(%rbp), %eax
	addl	$1, %eax
	movl	%eax, %eax
	cmpq	%rax, -24(%rbp)
	jb	.L3
	movl	$0, -32(%rbp)
	jmp	.L4
.L7:
	movl	-32(%rbp), %eax
	addl	$1, %eax
	movl	%eax, %edx
	movl	-32(%rbp), %eax
	salq	$5, %rax
	movq	%rax, %rcx
	movq	-8(%rbp), %rax
	addq	%rcx, %rax
	movl	$1, %esi
	movq	%rax, %rdi
	call	__gmpq_set_ui@PLT
	movl	-32(%rbp), %eax
	movl	%eax, -28(%rbp)
	jmp	.L5
.L6:
	movl	-28(%rbp), %eax
	subl	$1, %eax
	movl	%eax, %eax
	salq	$5, %rax
	movq	%rax, %rdx
	movq	-8(%rbp), %rax
	addq	%rax, %rdx
	movl	-28(%rbp), %eax
	salq	$5, %rax
	movq	%rax, %rcx
	movq	-8(%rbp), %rax
	addq	%rax, %rcx
	movl	-28(%rbp), %eax
	subl	$1, %eax
	movl	%eax, %eax
	salq	$5, %rax
	movq	%rax, %rsi
	movq	-8(%rbp), %rax
	addq	%rsi, %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	__gmpq_sub@PLT
	movl	-28(%rbp), %ecx
	movq	-40(%rbp), %rax
	movl	$1, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	__gmpq_set_ui@PLT
	movl	-28(%rbp), %eax
	subl	$1, %eax
	movl	%eax, %eax
	salq	$5, %rax
	movq	%rax, %rdx
	movq	-8(%rbp), %rax
	leaq	(%rdx,%rax), %rsi
	movl	-28(%rbp), %eax
	subl	$1, %eax
	movl	%eax, %eax
	salq	$5, %rax
	movq	%rax, %rdx
	movq	-8(%rbp), %rax
	leaq	(%rdx,%rax), %rcx
	movq	-40(%rbp), %rax
	movq	%rax, %rdx
	movq	%rcx, %rdi
	call	__gmpq_mul@PLT
	subl	$1, -28(%rbp)
.L5:
	cmpl	$0, -28(%rbp)
	jne	.L6
	addl	$1, -32(%rbp)
.L4:
	movl	-32(%rbp), %eax
	cmpl	-44(%rbp), %eax
	jbe	.L7
	movq	-8(%rbp), %rdx
	movq	-40(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	__gmpq_set@PLT
	movq	$0, -16(%rbp)
	jmp	.L8
.L9:
	movq	-16(%rbp), %rax
	salq	$5, %rax
	movq	%rax, %rdx
	movq	-8(%rbp), %rax
	addq	%rdx, %rax
	movq	%rax, %rdi
	call	__gmpq_clear@PLT
	addq	$1, -16(%rbp)
.L8:
	movl	-44(%rbp), %eax
	addl	$1, %eax
	movl	%eax, %eax
	cmpq	%rax, -16(%rbp)
	jb	.L9
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE26:
	.size	bernoulli, .-bernoulli
	.section	.rodata
.LC0:
	.string	"B(%-2u) = %44Zd / %Zd\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB27:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$96, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	leaq	-48(%rbp), %rax
	movq	%rax, %rdi
	call	__gmpq_init@PLT
	leaq	-64(%rbp), %rcx
	leaq	-80(%rbp), %rax
	movl	$0, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	__gmpz_inits@PLT
	movl	$0, -84(%rbp)
	jmp	.L11
.L14:
	movl	-84(%rbp), %edx
	leaq	-48(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	bernoulli
	movl	-44(%rbp), %eax
	testl	%eax, %eax
	js	.L12
	movl	-44(%rbp), %eax
	testl	%eax, %eax
	jle	.L13
.L12:
	leaq	-48(%rbp), %rdx
	leaq	-80(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	__gmpq_get_num@PLT
	leaq	-48(%rbp), %rdx
	leaq	-64(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	__gmpq_get_den@PLT
	leaq	-64(%rbp), %rcx
	leaq	-80(%rbp), %rdx
	movl	-84(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC0(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	__gmp_printf@PLT
.L13:
	addl	$1, -84(%rbp)
.L11:
	cmpl	$60, -84(%rbp)
	jbe	.L14
	leaq	-64(%rbp), %rcx
	leaq	-80(%rbp), %rax
	movl	$0, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	__gmpz_clears@PLT
	leaq	-48(%rbp), %rax
	movq	%rax, %rdi
	call	__gmpq_clear@PLT
	movl	$0, %eax
	movq	-8(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L16
	call	__stack_chk_fail@PLT
.L16:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE27:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
