program sphere
  implicit none

  real, parameter :: pi = 3.1415926535897932384626433832795
  real :: radius, surface, volume

  print *, "输入球体半径："
  read *, radius

  surface = 4. * pi * radius**2
  volume = 4./3. * pi * radius**3

  print *, "球体表面积：", surface
  print *, "球体体积：", volume

end program sphere