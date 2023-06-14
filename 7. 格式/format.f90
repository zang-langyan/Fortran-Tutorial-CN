program format
  implicit none
  
  real :: array(10)
  character(len=6) :: text = 'String'
  
  print '(A3)', text ! 只能打印‘Str’
  print '(A6)', text ! 可以打印‘String’

  call random_number(array)
  ! 默认格式
  write(*,*) array
  
  ! 小数格式
  write(*,'(10F10.3)') array
  
  ! 科学计数格式
  write(*,'(ES10.3)') array
  
end program format