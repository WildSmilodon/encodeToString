!
! Module to encode real(8) and integer(4) to string
!
! real(8)    ---> character(16)
! integet(4) ---> character(8)
!
!
! version 1.0, May 2022, jure.ravnik@um.si
!
!
! Usage
!
! REAL(8) r
! CHARACTER(16) s
! s = ets_real2string(r)
! r = ets_string2real(s)
!
!
! INTEGER i
! CHARACTER(8) s
! s = ets_int2string(i)
! i = ets_string2int(s)
!
module encodeToString
    implicit none

    private
  
    public :: ets_real2string
    public :: ets_string2real
    public :: ets_int2string
    public :: ets_string2int

    contains


    character(16) function ets_real2string(r)
        character(64) b
        character(16) s
        real(8) r

        call real2bin(r,b)
        call bin2hex(b,s)

        ets_real2string = s
    end function

    real(8) function ets_string2real(s)
        character(64) b
        character(16) s
        real(8) r

        call hex2bin(s,b)
        call bin2real(b,r)

        ets_string2real = r
    end function   

    character(8) function ets_int2string(i)
        character(32) b
        character(8) s
        integer(4) i

        call int2bin(i,b)
        call bin2hex(b,s)

        ets_int2string = s
    end function    


    integer(4) function ets_string2int(s)
        character(32) b
        character(8) s
        integer(4) i

        call hex2bin(s,b)
        call bin2int(b,i)

        ets_string2int = i
    end function     


    ! ------------------------------------------------------------------

    subroutine bin2hex(b,h)
        character(*) b
        character(*) h
        integer i
        integer(8) j

        h = ""
        do i = 1,len_trim(b)/4
            call binary2integer(b( 1+(i-1)*4 : i*4),j)  

            if (j.lt.10) write(h,"(A,I1)") trim(h),j
            if (j.eq.10) write(h,"(A,A1)") trim(h),"A"
            if (j.eq.11) write(h,"(A,A1)") trim(h),"B"
            if (j.eq.12) write(h,"(A,A1)") trim(h),"C"
            if (j.eq.13) write(h,"(A,A1)") trim(h),"D"
            if (j.eq.14) write(h,"(A,A1)") trim(h),"E"
            if (j.eq.15) write(h,"(A,A1)") trim(h),"F"

        end do

    end subroutine

    subroutine hex2bin(h,b)

        character(*) b
        character(*) h
        integer i

        b = ""
        do i = 1,len_trim(h)

            if ( h(i:i).eq."0" ) b = trim(b) // "0000" 
            if ( h(i:i).eq."1" ) b = trim(b) // "0001" 
            if ( h(i:i).eq."2" ) b = trim(b) // "0010" 
            if ( h(i:i).eq."3" ) b = trim(b) // "0011" 
            if ( h(i:i).eq."4" ) b = trim(b) // "0100" 
            if ( h(i:i).eq."5" ) b = trim(b) // "0101" 
            if ( h(i:i).eq."6" ) b = trim(b) // "0110" 
            if ( h(i:i).eq."7" ) b = trim(b) // "0111" 
            if ( h(i:i).eq."8" ) b = trim(b) // "1000" 
            if ( h(i:i).eq."9" ) b = trim(b) // "1001" 
            if ( h(i:i).eq."A" ) b = trim(b) // "1010" 
            if ( h(i:i).eq."B" ) b = trim(b) // "1011" 
            if ( h(i:i).eq."C" ) b = trim(b) // "1100" 
            if ( h(i:i).eq."D" ) b = trim(b) // "1101" 
            if ( h(i:i).eq."E" ) b = trim(b) // "1110" 
            if ( h(i:i).eq."F" ) b = trim(b) // "1111" 

        end do

    end subroutine

    subroutine int2bin(i,b)

        character(32) b
        integer(4) i

        write(b, fmt='(B32.32)') i
    
    end subroutine

    subroutine real2bin(r,b)

        character(64) b
        real(8) r

        write(b, fmt='(B64.64)') r
    
    end subroutine

    subroutine bin2real(b,r)

        character(64) b
        real(8) r,s
        integer(8) n
        integer i

        character(1) predznak
        character(11) eskponent
        character(52) decimalke
        
        predznak = b(1:1)
        eskponent = b(2:12)
        decimalke = b(13:64)
    
        call binary2integer(eskponent,n)
        n=n-1023
    
        s = 2.0D0**n
        r = s
        do i=1,len_trim(decimalke)
            s = s / 2
            if (decimalke(i:i).eq."1") r = r + s
        end do

        if (predznak.eq."1") r=-r

    end subroutine


    subroutine binary2integer(b,i)

        integer(8) i
        integer j
        character(*) b
        integer k

        j = 2**(len_trim(b)-1)

        i=0
        do k=1,len_trim(b)
          if (b(k:k).eq."1") i=i+j
          j=j/2
        enddo

    end subroutine

    subroutine bin2int(b,i)

        integer(4) i
        character(*) b
        integer k,j

        j = 2**(len_trim(b)-1)

        i=0
        do k=1,len_trim(b)
          if (b(k:k).eq."1") i=i+j
          j=j/2
        enddo

        i = -i

    end subroutine   


end module