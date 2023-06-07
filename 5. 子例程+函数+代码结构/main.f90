program structure
  ! ****************** 模块 ******************
  use STATS, only: pi, mean_std 
  implicit none

  integer :: n_x
  real :: x(3), y(3), dot_product, element_wise_product(3)
  real :: deriv(3)

  real, external :: norm1 ! 外部函数

  real :: data_array(5), data_mean, data_std

  x = [1,2,3]
  y = [3,2,1]
  n_x = size(x)

  ! ****************** 内部 ******************
  print *, '内部函数：'
  call vector_product(n_x, x, y, dot_product, element_wise_product)

  print *, 'x · y = ', dot_product
  print *, 'element wise product = ', element_wise_product

  print *, '||x||_2 = ', vector_norm(n_x, x)
  print *, ''

  ! ****************** 外部 ******************
  print *, '外部函数：'
  print *, '||x|| = ', norm1(n_x, x)
  print *, ''

  ! ****************** 单独文件存放 ******************
  print *, '其他文件（derivative）：'
  call derivative(x, n_x, 0.5, deriv)
  print *, deriv
  print *, ''

  ! ****************** 模块 ******************
  print *, '模块（STATS）：'
  data_array = [pi, 2*pi, 3*pi, 4*pi, 5*pi]
  call mean_std(5, data_array, data_mean, data_std)
  print *, '均值：', data_mean
  print *, '标准差：', data_std

contains

  subroutine vector_product(n,a,b,dot_pro,element_wise_pro)
    integer, intent(in) :: n
    real, intent(in) :: a(n), b(n)
    real, intent(out) :: dot_pro, element_wise_pro(n)

    integer :: i

    dot_pro = 0.
    do i = 1,n
      dot_pro = dot_pro + a(i) * b(i)
      element_wise_pro(i) = a(i) * b(i)
    end do

  end subroutine vector_product

  function vector_norm(n,vec)
    integer, intent(in) :: n
    real, intent(in) :: vec(n)
    real :: vector_norm

    vector_norm = sqrt(sum(vec**2))

  end function vector_norm

end program structure

real function norm1(n,vec)
  integer, intent(in) :: n
  real, intent(in) :: vec(n)

  norm1 = sum(abs(vec))

end function norm1
