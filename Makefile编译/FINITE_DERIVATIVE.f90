MODULE FINITE_DERIVATIVE
USE iso_fortran_env
CONTAINS

SUBROUTINE FORWARD_FD(data,h,deriv)
    real(real64), intent(in) :: data(:),h
    real(real64), intent(out):: deriv(size(data))
    integer :: n,i

    n = size(data)
    do i=1,n-1
        deriv(i) = (data(i+1)-data(i))/h
    end do
    deriv(n) = 0.
END SUBROUTINE FORWARD_FD

SUBROUTINE BACKWARD_FD(data,h,deriv)
    real(real64), intent(in) :: data(:),h
    real(real64), intent(out):: deriv(size(data))
    integer :: n,i
    
    n = size(data)
    deriv(1) = 0.
    do i=2,n
        deriv(i) = (data(i)-data(i-1))/h
    end do
END SUBROUTINE BACKWARD_FD

SUBROUTINE CENTERED_FD(data,h,deriv)
    real(real64), intent(in) :: data(:),h
    real(real64), intent(out):: deriv(size(data))
    integer :: n,i
    
    n = size(data)
    deriv(1) = 0.
    do i=2,n-1
        deriv(i) = (data(i+1)-data(i-1))/(2*h)
    end do
    deriv(n) = 0.
END SUBROUTINE CENTERED_FD

SUBROUTINE SECOND_FORWARD_FD(data,h,deriv)
    real(real64), intent(in) :: data(:),h
    real(real64), intent(out):: deriv(size(data))
    integer :: n,i

    n = size(data)
    deriv = 0.
    do i=1,n-2
        deriv(i) = (data(i+2)-2.0*data(i+1)+data(i))/(h**2.0)
    end do
END SUBROUTINE SECOND_FORWARD_FD

SUBROUTINE SECOND_BACKWARD_FD(data,h,deriv)
    real(real64), intent(in) :: data(:),h
    real(real64), intent(out):: deriv(size(data))
    integer :: n,i

    n = size(data)
    deriv = 0.
    do i=3,n
        deriv(i) = (data(i)-2.0*data(i-1)+data(i-2))/(h**2.0)
    end do
END SUBROUTINE SECOND_BACKWARD_FD

SUBROUTINE SECOND_CENTERED_FD(data,h,deriv)
    real(real64), intent(in) :: data(:),h
    real(real64), intent(out):: deriv(size(data))
    integer :: n,i

    n = size(data)
    deriv = 0.
    do i=2,n-1
        deriv(i) = (data(i+1)-2.0*data(i)+data(i-1))/(h**2.0)
    end do
END SUBROUTINE SECOND_CENTERED_FD

END MODULE FINITE_DERIVATIVE