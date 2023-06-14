module coordinates
  implicit none
  private ! 将整体设为private, 只在后续有必要的地方将方法或类型设为public
  
  public :: polar_coord ! 将polar_coord类设为public，供其他程序调用
  
  real, public :: pi = 3.141592653589793238462643383279502884197169399375105820974944592307816406286

  type polar_coord
    real :: rho, theta
  contains
    procedure, public, pass(this) :: to_euler
    procedure, public :: to_euler_func
  end type polar_coord
  
contains
  
  subroutine to_euler(euler_coord, this)
    class(polar_coord), intent(in) :: this
    real, intent(out) :: euler_coord(2)

    euler_coord(1) = this%rho * cos(this%theta)
    euler_coord(2) = this%rho * sin(this%theta)
  end subroutine to_euler

  function to_euler_func(this) result(euler_coord)
    class(polar_coord), intent(in) :: this
    real :: euler_coord(2)

    euler_coord(1) = this%rho * cos(this%theta)
    euler_coord(2) = this%rho * sin(this%theta)
  end function to_euler_func

  
end module coordinates
  
program typedemo
  use coordinates
  implicit none

  type(polar_coord) :: p(2) ! 定义一个polar_coord类型的数组p，长度为2
  real :: euler_coord(2), euler_coord_func(2)

  p(1)%rho = sqrt(2.0)
  p(1)%theta = pi / 4.0
  
  print *, "---------------------"
  print *, "p(1)"
  call p(1)%to_euler(euler_coord)
  print *, "call member subroutine:"
  print *, euler_coord

  euler_coord_func = p(1)%to_euler_func()
  print *, "call member function:"
  print *, euler_coord_func


  p(2)%rho = 2.
  p(2)%theta = pi / 3.0

  print *, "---------------------"
  print *, "p(2)"
  call p(2)%to_euler(euler_coord)
  print *, "call member subroutine:"
  print *, euler_coord

  euler_coord_func = p(2)%to_euler_func()
  print *, "call member function:"
  print *, euler_coord_func
end program typedemo