program test

    use encodeToString

    implicit none
    real(8) r,rr,err
    integer i,j,ii,n,m,erri

    character(16) sr  ! real value encoded to string
    character(8) si  ! integer value encoded to string


    call random_seed()
    
    err = 0.0D0
    do i=1,1000
        call random_number(r)
        r = 2.0D6 * (r - 0.5D0)
        sr = ets_real2string(r)
        rr = ets_string2real(sr)
        err = err + abs(rr-r)
    end do
    print *,"err = ",err

    erri = 0.0D0
    n = -1000000
    m = +1000000
    do j=1,1000
        call random_number(r)
        i = n + FLOOR((m+1-n)*r)
        si = ets_int2string(i)
        ii = ets_string2int(si)
        erri = erri + abs(ii-i)
    end do
    print *,"erri = ",erri

end program test