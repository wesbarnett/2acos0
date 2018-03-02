module omp_subs

    implicit none

contains

    function calc_pi(n) result(pi)

        implicit none
        integer(8) :: accept
        real(8) :: r(2), pi
        integer(8), intent(in) :: n
        integer(8) :: i

        accept = 0

        !$omp parallel do private(r,i) reduction(+:accept)
        do i = 1, n
            call random_number(r)
            if (r(1)**2 + r(2)**2 <= 1) then
                accept = accept + 1
            end if
        end do
        !$omp end parallel do

        pi = 4.0d0 * dble(accept)/dble(n)

    end function calc_pi

end module omp_subs

program main

    use omp_subs

    implicit none
    integer(8) :: n
    real(8), parameter :: pi = 2.0d0*dacos(0.0d0)
    real(8) :: mypi
    character (len=64) :: arg

    call random_seed()

    if (command_argument_count() /= 1) then
        error stop "One command line argument should be passed, which is the number of iterations to perform."
    end if

    call get_command_argument(1, arg)
    read(arg,*) n

    mypi = calc_pi(n)

    write(*,'(a,f12.6)') "Calculated = ", mypi
    write(*,'(a,f12.6)') "Actual =     ", pi

end program main
