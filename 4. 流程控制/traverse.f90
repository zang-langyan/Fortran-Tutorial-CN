program traverse
  implicit none

  real :: x(5,10)
  integer :: i,j

  call random_number(x)

  row: do i = 1,5
    col: do j = 1,10
      if (x(i,j) > 0.5) then
        print *, "位置(", i, j, ") 的值", x(i,j)
        cycle row
      end if  
    end do col
  end do row

end program traverse