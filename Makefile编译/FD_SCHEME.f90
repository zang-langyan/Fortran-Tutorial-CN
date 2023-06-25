MODULE FD_SCHEME
USE iso_fortran_env
CONTAINS

SUBROUTINE UPWIND_FD(a,u,h,deriv)
    real(real64), intent(in) :: u(:), h
    real(real64), intent(in) :: a(size(u))
    real(real64), intent(out):: deriv(size(u))
    integer :: n

    n = size(u)
    deriv = 0.

    if (a(1) < 0.) then
        deriv(1) = a(1) * (u(2)-u(1))/h
    end if

    do i = 2,n-1
        if (a(i) < 0.) then
            deriv(i) = a(i) * (u(i+1)-u(i))/h
        else if (a(i) > 0.) then
            deriv(i) = a(i) * (u(i)-u(i-1))/h
        end if
    end do

    if (a(n) > 0.) then
        deriv(n) = a(n) * (u(n)-u(n-1))/h
    end if
END SUBROUTINE UPWIND_FD

SUBROUTINE DOWNWIND_FD(a,u,h,deriv)
    real(real64), intent(in) :: u(:), h
    real(real64), intent(in) :: a(size(u))
    real(real64), intent(out):: deriv(size(u))
    integer :: n
    
    n = size(u)
    deriv = 0.

    if (a(1) > 0.) then
        deriv(1) = a(1) * (u(2)-u(1))/h
    end if
    
    do i = 2,n-1
        if (a(i) > 0.) then
            deriv(i) = a(i) * (u(i+1)-u(i))/h
        else if (a(i) < 0.) then
            deriv(i) = a(i) * (u(i)-u(i-1))/h
        end if
    end do
    
    if (a(n) < 0.) then
        deriv(n) = a(n) * (u(n)-u(n-1))/h
    end if
END SUBROUTINE DOWNWIND_FD

END MODULE FD_SCHEME