NESTLIBDIR = ..
LIBS = -L$(NESTLIBDIR) -lnest3 $(LAPACKLIB)

OBJFILES = params.o like.o nestwrap.o main.o

all: velocity_dispersion 

%.o: %.f90
	$(FC) $(FFLAGS) -I$(NESTLIBDIR) -c $*.f90

velocity_dispersion: $(OBJFILES)
	$(FC) -o ../velocity_dispersion.o $(OBJFILES) \
	$(FFLAGS) $(LIBS)

clean:
	rm -f *.o *.mod ../velocity_dispersion.o
