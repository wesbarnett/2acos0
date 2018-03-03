# π

Calculates π using a [Monte
Carlo method](https://en.wikipedia.org/wiki/Monte_Carlo_method) using
different parallelization libraries/protocols: serial (no
parallelization),
[OpenMP](https://gcc.gnu.org/onlinedocs/gfortran/OpenMP.html), MPI,
and [coarrays](https://gcc.gnu.org/wiki/CoarrayLib).

## Compilation

To compile run `make`.

## Requirements

The MPI implementation obviously requires an MPI library like
[OpenMPI](https://www.open-mpi.org/) or
[MPICH](https://www.mpich.org/).

The coarrays implementation additionally requires
[OpenCoarrays](http://www.opencoarrays.org/).

## Running

To run:

    ./serial 1000
    ./omp 1000
    mpiexec -n 4 ./mpi 1000
    mpiexec -n 4 ./coarrays 1000

Change `1000` to the number of iterations you want to use to calculate
pi. 
