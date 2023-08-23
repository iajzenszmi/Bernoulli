# Bernoulli
https://en.wikipedia.org/wiki/Bernoulli_distribution
Bernoulli
(14:31 ian@ian-Aspire-One-753 ~) > gcc bernoulli.c -lm -lgmp
(14:32 ian@ian-Aspire-One-753 ~) > ./a.out
B(0 ) =                                            1 / 1
B(1 ) =                                           -1 / 2
B(2 ) =                                            1 / 6
B(4 ) =                                           -1 / 30
B(6 ) =                                            1 / 42
B(8 ) =                                           -1 / 30
B(10) =                                            5 / 66
B(12) =                                         -691 / 2730
B(14) =                                            7 / 6
B(16) =                                        -3617 / 510
B(18) =                                        43867 / 798
B(20) =                                      -174611 / 330
B(22) =                                       854513 / 138
B(24) =                                   -236364091 / 2730
B(26) =                                      8553103 / 6
B(28) =                                 -23749461029 / 870
B(30) =                                8615841276005 / 14322
B(32) =                               -7709321041217 / 510
B(34) =                                2577687858367 / 6
B(36) =                        -26315271553053477373 / 1919190
B(38) =                             2929993913841559 / 6
B(40) =                       -261082718496449122051 / 13530
B(42) =                       1520097643918070802691 / 1806
B(44) =                     -27833269579301024235023 / 690
B(46) =                     596451111593912163277961 / 282
B(48) =                -5609403368997817686249127547 / 46410
B(50) =                  495057205241079648212477525 / 66
B(52) =              -801165718135489957347924991853 / 1590
B(54) =             29149963634884862421418123812691 / 798
B(56) =          -2479392929313226753685415739663229 / 870
B(58) =          84483613348880041862046775994036021 / 354
B(60) = -1215233140483755572040304994079820246041491 / 56786730
(14:32 ian@ian-Aspire-One-753 ~) > gcc bernoulli.c -lm -lgmp -o bernoulli
(14:33 ian@ian-Aspire-One-753 ~) > ./bernoulli
B(0 ) =                                            1 / 1
B(1 ) =                                           -1 / 2
B(2 ) =                                            1 / 6
B(4 ) =                                           -1 / 30
B(6 ) =                                            1 / 42
B(8 ) =                                           -1 / 30
B(10) =                                            5 / 66
B(12) =                                         -691 / 2730
B(14) =                                            7 / 6
B(16) =                                        -3617 / 510
B(18) =                                        43867 / 798
B(20) =                                      -174611 / 330
B(22) =                                       854513 / 138
B(24) =                                   -236364091 / 2730
B(26) =                                      8553103 / 6
B(28) =                                 -23749461029 / 870
B(30) =                                8615841276005 / 14322
B(32) =                               -7709321041217 / 510
B(34) =                                2577687858367 / 6
B(36) =                        -26315271553053477373 / 1919190
B(38) =                             2929993913841559 / 6
B(40) =                       -261082718496449122051 / 13530
B(42) =                       1520097643918070802691 / 1806
B(44) =                     -27833269579301024235023 / 690
B(46) =                     596451111593912163277961 / 282
B(48) =                -5609403368997817686249127547 / 46410
B(50) =                  495057205241079648212477525 / 66
B(52) =              -801165718135489957347924991853 / 1590
B(54) =             29149963634884862421418123812691 / 798
B(56) =          -2479392929313226753685415739663229 / 870
B(58) =          84483613348880041862046775994036021 / 354
B(60) = -1215233140483755572040304994079820246041491 / 56786730
(14:33 ian@ian-Aspire-One-753 ~) > cat bernoulli.c
//*=={{header|C}}==
//{{libheader|GMP}}
//<syntaxhighlight lang="c">
#include <stdlib.h>
#include <gmp.h>

#define mpq_for(buf, op, n)\
    do {\
        size_t i;\
        for (i = 0; i < (n); ++i)\
            mpq_##op(buf[i]);\
    } while (0)

void bernoulli(mpq_t rop, unsigned int n)
{
    unsigned int m, j;
    mpq_t *a = malloc(sizeof(mpq_t) * (n + 1));
    mpq_for(a, init, n + 1);

    for (m = 0; m <= n; ++m) {
        mpq_set_ui(a[m], 1, m + 1);
        for (j = m; j > 0; --j) {
            mpq_sub(a[j-1], a[j], a[j-1]);
            mpq_set_ui(rop, j, 1);
            mpq_mul(a[j-1], a[j-1], rop);
        }
    }

    mpq_set(rop, a[0]);
    mpq_for(a, clear, n + 1);
    free(a);
}

int main(void)
{
    mpq_t rop;
    mpz_t n, d;
    mpq_init(rop);
    mpz_inits(n, d, NULL);

    unsigned int i;
    for (i = 0; i <= 60; ++i) {
        bernoulli(rop, i);
        if (mpq_cmp_ui(rop, 0, 1)) {
            mpq_get_num(n, rop);
            mpq_get_den(d, rop);
            gmp_printf("B(%-2u) = %44Zd / %Zd\n", i, n, d);
        }
    }

    mpz_clears(n, d, NULL);
    mpq_clear(rop);
    return 0;
}
/*</syntaxhighlight>
{{out}}
<pre>
B(0 ) =                                            1 / 1
B(1 ) =                                           -1 / 2
B(2 ) =                                            1 / 6
B(4 ) =                                           -1 / 30
B(6 ) =                                            1 / 42
B(8 ) =                                           -1 / 30
B(10) =                                            5 / 66
B(12) =                                         -691 / 2730
B(14) =                                            7 / 6
B(16) =                                        -3617 / 510
B(18) =                                        43867 / 798
B(20) =                                      -174611 / 330
B(22) =                                       854513 / 138
B(24) =                                   -236364091 / 2730
B(26) =                                      8553103 / 6
B(28) =                                 -23749461029 / 870
B(30) =                                8615841276005 / 14322
B(32) =                               -7709321041217 / 510
B(34) =                                2577687858367 / 6
B(36) =                        -26315271553053477373 / 1919190
B(38) =                             2929993913841559 / 6
B(40) =                       -261082718496449122051 / 13530
B(42) =                       1520097643918070802691 / 1806
B(44) =                     -27833269579301024235023 / 690
B(46) =                     596451111593912163277961 / 282
B(48) =                -5609403368997817686249127547 / 46410
B(50) =                  495057205241079648212477525 / 66
B(52) =              -801165718135489957347924991853 / 1590
B(54) =             29149963634884862421418123812691 / 798
B(56) =          -2479392929313226753685415739663229 / 870
B(58) =          84483613348880041862046775994036021 / 354
B(60) = -1215233140483755572040304994079820246041491 / 56786730
</pre>
*/
(14:34 ian@ian-Aspire-One-753 ~) > cat bernoulli.c
//*=={{header|C}}==
//{{libheader|GMP}}
//<syntaxhighlight lang="c">
#include <stdlib.h>
#include <gmp.h>

#define mpq_for(buf, op, n)\
    do {\
        size_t i;\
        for (i = 0; i < (n); ++i)\
            mpq_##op(buf[i]);\
    } while (0)

void bernoulli(mpq_t rop, unsigned int n)
{
    unsigned int m, j;
    mpq_t *a = malloc(sizeof(mpq_t) * (n + 1));
    mpq_for(a, init, n + 1);

    for (m = 0; m <= n; ++m) {
        mpq_set_ui(a[m], 1, m + 1);
        for (j = m; j > 0; --j) {
            mpq_sub(a[j-1], a[j], a[j-1]);
            mpq_set_ui(rop, j, 1);
            mpq_mul(a[j-1], a[j-1], rop);
        }
    }

    mpq_set(rop, a[0]);
    mpq_for(a, clear, n + 1);
    free(a);
}

int main(void)
{
    mpq_t rop;
    mpz_t n, d;
    mpq_init(rop);
    mpz_inits(n, d, NULL);

    unsigned int i;
    for (i = 0; i <= 60; ++i) {
        bernoulli(rop, i);
        if (mpq_cmp_ui(rop, 0, 1)) {
            mpq_get_num(n, rop);
            mpq_get_den(d, rop);
            gmp_printf("B(%-2u) = %44Zd / %Zd\n", i, n, d);
        }
    }

    mpz_clears(n, d, NULL);
    mpq_clear(rop);
    return 0;
}
/*</syntaxhighlight>
{{out}}
<pre>
B(0 ) =                                            1 / 1
B(1 ) =                                           -1 / 2
B(2 ) =                                            1 / 6
B(4 ) =                                           -1 / 30
B(6 ) =                                            1 / 42
B(8 ) =                                           -1 / 30
B(10) =                                            5 / 66
B(12) =                                         -691 / 2730
B(14) =                                            7 / 6
B(16) =                                        -3617 / 510
B(18) =                                        43867 / 798
B(20) =                                      -174611 / 330
B(22) =                                       854513 / 138
B(24) =                                   -236364091 / 2730
B(26) =                                      8553103 / 6
B(28) =                                 -23749461029 / 870
B(30) =                                8615841276005 / 14322
B(32) =                               -7709321041217 / 510
B(34) =                                2577687858367 / 6
B(36) =                        -26315271553053477373 / 1919190
B(38) =                             2929993913841559 / 6
B(40) =                       -261082718496449122051 / 13530
B(42) =                       1520097643918070802691 / 1806
B(44) =                     -27833269579301024235023 / 690
B(46) =                     596451111593912163277961 / 282
B(48) =                -5609403368997817686249127547 / 46410
B(50) =                  495057205241079648212477525 / 66
B(52) =              -801165718135489957347924991853 / 1590
B(54) =             29149963634884862421418123812691 / 798
B(56) =          -2479392929313226753685415739663229 / 870
B(58) =          84483613348880041862046775994036021 / 354
B(60) = -1215233140483755572040304994079820246041491 / 56786730
</pre>
*/
(14:34 ian@ian-Aspire-One-753 ~) > sloccount bernoulli.c
Have a non-directory at the top, so creating directory top_dir
Adding /home/ian/bernoulli.c to top_dir
Categorizing files.
Finding a working MD5 command....
Found a working MD5 command.
Computing results.


SLOC	Directory	SLOC-by-Language (Sorted)
44      top_dir         ansic=44


Totals grouped by language (dominant language first):
ansic:           44 (100.00%)




Total Physical Source Lines of Code (SLOC)                = 44
Development Effort Estimate, Person-Years (Person-Months) = 0.01 (0.09)
 (Basic COCOMO model, Person-Months = 2.4 * (KSLOC**1.05))
Schedule Estimate, Years (Months)                         = 0.08 (1.00)
 (Basic COCOMO model, Months = 2.5 * (person-months**0.38))
Estimated Average Number of Developers (Effort/Schedule)  = 0.09
Total Estimated Cost to Develop                           = $ 1,017
 (average salary = $56,286/year, overhead = 2.40).
SLOCCount, Copyright (C) 2001-2004 David A. Wheeler
SLOCCount is Open Source Software/Free Software, licensed under the GNU GPL.
SLOCCount comes with ABSOLUTELY NO WARRANTY, and you are welcome to
redistribute it under certain conditions as specified by the GNU GPL license;
see the documentation for details.
Please credit this data as "generated using David A. Wheeler's 'SLOCCount'."
(14:34 ian@ian-Aspire-One-753 ~) > gcc bernoulli.c -S
(15:01 ian@ian-Aspire-One-753 ~) > cat bernoulli.c -S
cat: invalid option -- 'S'
Try 'cat --help' for more information.
(15:01 ian@ian-Aspire-One-753 ~) > cat bernoulli.s
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
(15:01 ian@ian-Aspire-One-753 ~) > gfortran bernoulli.s -o bernoullis
/usr/bin/ld: /tmp/ccco7kTD.o: in function `bernoulli':
bernoulli.c:(.text+0x4b): undefined reference to `__gmpq_init'
/usr/bin/ld: bernoulli.c:(.text+0x90): undefined reference to `__gmpq_set_ui'
/usr/bin/ld: bernoulli.c:(.text+0xe3): undefined reference to `__gmpq_sub'
/usr/bin/ld: bernoulli.c:(.text+0xfa): undefined reference to `__gmpq_set_ui'
/usr/bin/ld: bernoulli.c:(.text+0x137): undefined reference to `__gmpq_mul'
/usr/bin/ld: bernoulli.c:(.text+0x168): undefined reference to `__gmpq_set'
/usr/bin/ld: bernoulli.c:(.text+0x18c): undefined reference to `__gmpq_clear'
/usr/bin/ld: /tmp/ccco7kTD.o: in function `main':
bernoulli.c:(.text+0x1d5): undefined reference to `__gmpq_init'
/usr/bin/ld: bernoulli.c:(.text+0x1f2): undefined reference to `__gmpz_inits'
/usr/bin/ld: bernoulli.c:(.text+0x22d): undefined reference to `__gmpq_get_num'
/usr/bin/ld: bernoulli.c:(.text+0x240): undefined reference to `__gmpq_get_den'
/usr/bin/ld: bernoulli.c:(.text+0x261): undefined reference to `__gmp_printf'
/usr/bin/ld: bernoulli.c:(.text+0x288): undefined reference to `__gmpz_clears'
/usr/bin/ld: bernoulli.c:(.text+0x294): undefined reference to `__gmpq_clear'
collect2: error: ld returned 1 exit status
(15:09 ian@ian-Aspire-One-753 ~) > gfortran bernoulli.s -o bernoullis -lm -lgmp
(15:09 ian@ian-Aspire-One-753 ~) > ./bernoullis
B(0 ) =                                            1 / 1
B(1 ) =                                           -1 / 2
B(2 ) =                                            1 / 6
B(4 ) =                                           -1 / 30
B(6 ) =                                            1 / 42
B(8 ) =                                           -1 / 30
B(10) =                                            5 / 66
B(12) =                                         -691 / 2730
B(14) =                                            7 / 6
B(16) =                                        -3617 / 510
B(18) =                                        43867 / 798
B(20) =                                      -174611 / 330
B(22) =                                       854513 / 138
B(24) =                                   -236364091 / 2730
B(26) =                                      8553103 / 6
B(28) =                                 -23749461029 / 870
B(30) =                                8615841276005 / 14322
B(32) =                               -7709321041217 / 510
B(34) =                                2577687858367 / 6
B(36) =                        -26315271553053477373 / 1919190
B(38) =                             2929993913841559 / 6
B(40) =                       -261082718496449122051 / 13530
B(42) =                       1520097643918070802691 / 1806
B(44) =                     -27833269579301024235023 / 690
B(46) =                     596451111593912163277961 / 282
B(48) =                -5609403368997817686249127547 / 46410
B(50) =                  495057205241079648212477525 / 66
B(52) =              -801165718135489957347924991853 / 1590
B(54) =             29149963634884862421418123812691 / 798
B(56) =          -2479392929313226753685415739663229 / 870
B(58) =          84483613348880041862046775994036021 / 354
B(60) = -1215233140483755572040304994079820246041491 / 56786730
