program molar_mass
  implicit none

  real, parameter :: NaCl = 58.5 ! 氯化钠的摩尔质量为58.5g/mol
  real :: mass
  real :: mol

  print *, '输入氯化钠质量:'
  read(*,*) mass

  mol = mass / NaCl

  print *, 'NaCl'
  print *, '摩尔量为: ', mol, ' mol'

end program molar_mass