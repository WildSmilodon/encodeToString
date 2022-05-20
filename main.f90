program test

    use encodeToString

    implicit none
    real(8) r,rr
    integer i,ii

    character(16) sr  ! real value encoded to string
    character(8) si  ! integer value encoded to string


    r= -234.435+sqrt(565.7)-3.5E35
    print *,"real = ",r
    sr = ets_real2string(r)
    print *,"str = ",sr
    rr = ets_string2real(sr)
    print *,"real = ",rr

    i = -1235232354
    print *,"integer = ",i
    si = ets_int2string(i)
    print *,"str = ",si
    ii = ets_string2int(si)
    print *,"integer = ",ii

end program test