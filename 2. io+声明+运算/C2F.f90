program C2F
  implicit none

  real :: c, f

  print *, "输入摄氏度："
  read *, c

  f = 1.8 * c + 32.0

  print *, "华氏度：", f
end program C2F