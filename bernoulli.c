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
