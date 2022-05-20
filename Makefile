PROGRAM = testEncodeToString
VERSION = 1.0

MODOBJECTS = mod_encodeToString.o
OBJECTSFIX =  
OBJECTSF90 = main.o

INST = $(HOME)/bin
LINS = .
SRCF = .
HOST = $(shell hostname)

# compiler
FC = gfortran

# Debug version    
#OPT = -g -fbounds-check -Wall -fcheck=all
#OPDE= d
# Optimized version
OPT = -O3
OPDE= o  

# options
FCOPTS = -ffixed-line-length-132  -fcray-pointer -cpp  

LDOPTO = 


all: mod fixed f90
	$(FC) -o $(LINS)/$(PROGRAM) $(FCOPTS) $(MODOBJECTS) $(OBJECTSF90) $(OBJECTSFIX) $(LDOPTO)
	

mod: $(MODOBJECTS)
fixed: $(OBJECTSFIX)
f90: $(OBJECTSF90)

clean:
	 rm -f *.o *.mod .#*

$(OBJECTSFIX): %.o: $(SRCF)/%.f
	 $(FC) $(FCOPTS) $(OPT) -c $<

$(OBJECTSF90): %.o: $(SRCF)/%.f90
	 $(FC) $(FCOPTS) $(OPT) -c $<

$(MODOBJECTS): %.o: $(SRCF)/%.f90
	 $(FC) $(FCOPTS) $(OPT) -c $<	 


install:
	cp $(LINS)/$(PROGRAM) $(INST)/$(PROGRAM)-$(VERSION)-$(OPDE)
	 
#
# Instalacija BLAS in LAPAC knjiznic
# sudo apt-get update
# sudo apt-get install libblas-dev liblapack-dev
#	 
