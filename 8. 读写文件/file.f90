program file
  implicit none

  real :: a(10), b(10)

  call random_number(a)

  open(99, file='data.csv')
  write(99, *) a
  close(99)

  open(98, file='data.dat')
  read(98, *) b
  close(98)

  print *, "b: ", b

  open(100, file='data.bin', access='stream', form='unformatted')
  write(100) a
  close(100)

end program file