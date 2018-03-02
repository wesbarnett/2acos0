program main

    use mpi

    implicit none
    real(8) :: r(2)
    integer :: ierr, proc_id, proc_num
    real(8), parameter :: pi = 2.0d0*dacos(0.0d0)
    integer(8) :: accept, accept_part, i, n
    character (len=64) :: arg

    if (command_argument_count() /= 1) then
        error stop "One command line argument should be passed, which is the number of iterations to perform."
    end if

    call get_command_argument(1, arg)
    read(arg,*) n

    call MPI_Init(ierr)
    call MPI_Comm_rank(MPI_COMM_WORLD, proc_id, ierr)
    call MPI_Comm_size(MPI_COMM_WORLD, proc_num, ierr)

    call random_seed()

    accept = 0
    accept_part = 0

    do i = proc_id+1, n, proc_num
        call random_number(r)
        if (r(1)**2 + r(2)**2 <= 1) accept_part = accept_part + 1
    end do

    call MPI_Reduce(accept_part, accept, 1, MPI_INTEGER, MPI_SUM, 0, MPI_COMM_WORLD, ierr)
    call MPI_Finalize(ierr)

    if (proc_id == 0) then
        write(*,'(a,f12.6)') "Calculated = ", 4.0d0 * dble(accept)/dble(n)
        write(*,'(a,f12.6)') "Actual =     ", pi
    end if

end program main
