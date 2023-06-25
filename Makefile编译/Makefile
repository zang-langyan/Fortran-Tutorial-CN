# Disable all of make's built-in rules (similar to Fortran's implicit none)
MAKEFLAGS += --no-builtin-rules --no-builtin-variables

# configuration
FC := gfortran
LD := $(FC)
AR := ar -r
# RM := rm -f

# list of all source files
SRCS := FINITE_DERIVATIVE.f90 FD_SCHEME.f90 POISSON_SOLVER.f90 ADVECTION_DIFFUSION.f90 CONVECTION_DIFFUSION.f90
OBJS := FINITE_DERIVATIVE.o FD_SCHEME.o POISSON_SOLVER.o ADVECTION_DIFFUSION.o CONVECTION_DIFFUSION.o
LIBR := libCODF.a

PROG := convection_diffusion_main.f90
EXEC := co_df

# command line arguments
CMLA := test

.PHONY: all test run clean
all: $(EXEC)

$(EXEC): $(LIBR)
	$(LD) -o $@ $(PROG) $^

$(LIBR): $(OBJS)
	$(AR) $@ $^

$(OBJS):
	$(FC) -c $(SRCS)

# define dependencies between object files
ADVECTION_DIFFUSION.o: FINITE_DERIVATIVE.o FD_SCHEME.o

# rebuild all object files in case this Makefile changes
# $(OBJS): $(MAKEFILE_LIST)

test:
	for idx in 1 2 3 4 5; do \
		./$(EXEC) $(addsuffix .dat, $(addsuffix $$idx, $(CMLA))); \
	done

run:
	./$(EXEC) Prandtl.dat
#	./$(EXEC) Prandtl_EMPTY.dat

clean:
	$(RM) $(filter %.o, $(OBJS)) $(wildcard *.mod) $(EXEC) $(LIBR) $(wildcard *.bin)