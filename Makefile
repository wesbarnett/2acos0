all:
	gfortran -o serial serial.f90
	gfortran -o omp omp.f90 -fopenmp
	mpifort -o mpi mpi.f90
	mpifort -o coarray coarray.f90 -lcaf_mpi -fcoarray=lib
