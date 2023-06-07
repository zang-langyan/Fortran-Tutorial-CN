MODULE STATS
  real, parameter :: pi = 3.141592653589293

CONTAINS

  SUBROUTINE mean_std(n,data,mean,std)
    integer, intent(in) :: n
    real   , intent(in) :: data(n)
    real   , intent(out):: mean, std
    integer :: i
    real    :: sum = 0., sum_of_squared = 0.

    do i = 1,n
        sum = sum + data(i)
        sum_of_squared = sum_of_squared + data(i) ** 2
    end do

    mean = sum / n
    std = sqrt(sum_of_squared/n - (mean ** 2))
  END SUBROUTINE mean_std

END MODULE STATS