# 2acos(0)

Calculates pi using a Monte Carlo method using different
parallelization libraries/protocols: serial (no parallelization),
OpenMP, MPI, and coarrays.

To compile run `make`.

The MPI implementation obviously requires an MPI library like
[OpenMPI](https://www.open-mpi.org/) or
[MPICH](https://www.mpich.org/).

The coarrays implementation additionally requires
[OpenCoarrays](http://www.opencoarrays.org/).

To run:

    ./serial 1000
    ./omp 1000
    mpiexec -n 4 ./mpi 1000
    mpiexec -n 4 ./coarrays 1000

Change `1000` to the number of iterations you want to use to calculate
pi. 
