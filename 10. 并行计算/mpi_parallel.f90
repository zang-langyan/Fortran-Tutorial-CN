program mpi_parrallel
  use mpi
  implicit none

  integer :: ierr, num_processors, my_processor_id

  call MPI_INIT(ierr)
  call MPI_COMM_SIZE(MPI_COMM_WORLD, num_processors, ierr)
  call MPI_COMM_RANK(MPI_COMM_WORLD, my_processor_id, ierr)

  print *, 'Hello from processor ', my_processor_id, ' of ', num_processors

  call MPI_FINALIZE(ierr)

end program mpi_parrallel