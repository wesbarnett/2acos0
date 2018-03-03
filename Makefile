FFLAGS = -Wall -O3

all:
	gfortran -o serial serial.f90 ${FFLAGS}
	gfortran -o omp omp.f90 -fopenmp ${FFLAGS}
	mpifort -o mpi mpi.f90 ${FFLAGS}
	mpifort -o coarray coarray.f90 -lcaf_mpi -fcoarray=lib ${FFLAGS}
clean:
	rm -v *.mod serial omp mpi coarray
