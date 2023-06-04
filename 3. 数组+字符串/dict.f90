program dict
  implicit none

  character(len=20), dimension(2) :: keys
  character(len=20), dimension(3,2) :: vals

  keys = [character(len=20) :: '姓名', '学号']
  vals(1,:) = [character(len=20) :: '张三', '001']
  vals(2,:) = [character(len=20) :: '李四', '002']
  vals(3,:) = [character(len=20) :: '王五', '003']

  print *, keys
  print *, vals(1,:)
  print *, vals(2,:)
  print *, vals(3,:)

end program dict