module coarray_subs

    implicit none

contains

    function calc_pi(n) result(pi)

        use opencoarrays, only: co_sum

        implicit none
        integer(8), save, codimension[*] :: accept
        real(8) :: r(2), pi
        integer(8), intent(in) :: n
        integer(8) :: i

        accept = 0

        do i = this_image(), n, num_images()
            call random_number(r)
            if (r(1)**2 + r(2)**2 <= 1) then
                accept = accept + 1
            end if
        end do

        sync all

        call co_sum(accept, 1)
        pi = 4.0d0 * dble(accept)/dble(n)

    end function calc_pi

end module coarray_subs

program main

    use coarray_subs

    implicit none
    real(8), parameter :: pi = 2.0d0*dacos(0.0d0)
    integer(8) ::  n
    character (len=64) :: arg
    real(8) :: mypi

    call random_seed()

    critical

    if (command_argument_count() /= 1 .and. this_image() == 1) then
        error stop "One command line argument should be passed, which is the number of iterations to perform."
    end if

    call get_command_argument(1, arg)
    read(arg,*) n

    end critical

    mypi = calc_pi(n)

    if (this_image() == 1) then
        write(*,'(a,f12.6)') "Calculated = ", mypi
        write(*,'(a,f12.6)') "Actual =     ", pi
    end if

end program main
