program main

    implicit none
    real(8) :: r(2)
    integer(8) :: accept, i, n
    real(8), parameter :: pi = 2.0d0*dacos(0.0d0)
    character (len=64) :: arg

    call random_seed()

    if (command_argument_count() /= 1) then
        error stop "One command line argument should be passed, which is the number of iterations to perform."
    end if

    call get_command_argument(1, arg)
    read(arg,*) n

    accept = 0

    !$omp parallel do private(r,i) reduction(+:accept)
    do i = 1, n
        call random_number(r)
        if (r(1)**2 + r(2)**2 <= 1) accept = accept + 1
    end do
    !$omp end parallel do

    write(*,'(a,f12.6)') "Calculated = ", 4.0d0 * dble(accept)/dble(n)
    write(*,'(a,f12.6)') "Actual =     ", pi

end program main
