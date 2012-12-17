NESTLIBDIR = ..
LIBS = -L$(NESTLIBDIR) -lnest3 $(LAPACKLIB)

OBJFILES = params.o like.o nestwrap.o main.o

all: gravredshift 

%.o: %.f90
	$(FC) $(FFLAGS) -I$(NESTLIBDIR) -c $*.f90

gravredshift: $(OBJFILES)
	$(FC) -o ../gravredshift.o $(OBJFILES) \
	$(FFLAGS) $(LIBS)

clean:
	rm -f *.o *.mod ../gravredshift.o
