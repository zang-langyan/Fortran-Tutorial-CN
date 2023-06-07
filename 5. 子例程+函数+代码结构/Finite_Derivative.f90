SUBROUTINE derivative (data, ndt, h, deriv)
    integer, intent(in) :: ndt
    real   , intent(in) :: data(ndt), h
    real   , intent(out):: deriv(ndt)
    integer             :: i

    do i = 1,ndt-1
        deriv(i) = (data(i+1)-data(i))/h
    end do
    deriv(ndt) = 0.
END SUBROUTINE derivative

SUBROUTINE derivative2 (data, ndt, h, deriv)
    integer, intent(in) :: ndt
    real   , intent(in) :: data(ndt), h
    real   , intent(out):: deriv(ndt)
    integer             :: i
    
    deriv(1) = 0.
    do i = 2,ndt-1
        deriv(i) = (data(i+1)-2.0*data(i)+data(i-1))/(h**2.0)
    end do
    deriv(ndt) = 0.
END SUBROUTINE derivative2