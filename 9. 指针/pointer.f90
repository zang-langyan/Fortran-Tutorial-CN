program pointerdemo
  implicit none

  integer, pointer :: p0
  integer, target :: i0 = 99, i1 = 1000

  real, pointer :: p1(:) ! 数组指针直接声明为可分配(变长)数组即可
  real, target :: r0(5) = (/ 1,2,3,4,5 /)

  procedure(f), pointer :: pf

  real, pointer :: p_r, pp_r
  real, target :: r1 = 1.5, r2 = 3.14

  ! 1. 简单的单一变量指针
  print *, "1. 简单的单一变量指针"
  print *, 'i0 = ', i0
  print *, 'i1 = ', i1
  p0 => i0
  p0 = 999 ! p0指向i0，修改p0的值，i0的值也会被修改
  print *, 'i0 = ', i0
  print *, 'i1 = ', i1
  print *, 'p0 = ', p0
  p0 => i1
  p0 = 10000 ! 此时p0指向i1，修改p0的值，i1的值也会被修改
  print *, 'i0 = ', i0
  print *, 'i1 = ', i1
  print *, 'p0 = ', p0
  print *

  ! 2. 数组指针
  print *, "2. 数组指针"
  print *, 'r0 = ', r0
  p1 => r0
  p1(1:3) = 0
  print *, 'r0 = ', r0 ! r0的前3个元素被赋值为0
  print *

  ! 3. 函数指针
  print *, "3. 函数指针"
  pf => f
  print *, 'pf(2) = ', pf(2.) ! 调用f(2.)
  pf => g
  print *, 'pf(2) = ', pf(2.) ! 调用g(2.)
  print *

  ! 4. 指针的指针
  print *, "4. 指针的指针"
  print *, 'r1 = ', r1
  print *, 'r2 = ', r2
  p_r => r1
  pp_r => p_r
  print *, 'p_r = ', p_r ! p_r指向r1
  print *, 'pp_r = ', pp_r ! pp_r指向r1
  p_r => r2
  print *, 'p_r = ', p_r ! p_r指向r2
  print *, 'pp_r = ', pp_r ! pp_r仍然指向r1
  print *

contains

  real function f(x)
    real, intent(in) :: x
    f = x**2
  end function f

  real function g(x)
    real, intent(in) :: x
    g = x**3
  end function g

end program pointerdemo