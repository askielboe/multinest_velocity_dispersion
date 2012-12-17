module params
implicit none

!=======================================================================
! ! ! ! ! ! ! ! ! ! ! ! ! ! Constants ! ! ! ! ! ! ! ! ! ! ! ! ! !
	! Sqrt(2*Pi)
	double precision S2P
	parameter ( S2P = 2.5066282746310005 )

!=======================================================================
! ! ! ! ! ! ! ! ! ! ! ! ! ! Data Parameters ! ! ! ! ! ! ! ! ! ! ! ! ! !
	integer common_var_ndata
	common common_var_ndata
	
	!integer ndata
	!parameter ( ndata = 52337 )
	
	integer maxNData
	parameter ( maxNData = 1e6 ) ! Make arrays large enough to store any number of points.
	
	double precision dist(maxNData)
	double precision vrel(maxNData)
	
	double precision distmin, distmax
	!parameter ( distmin = 0.0 )
	!parameter ( distmax = 1.1 )

!=======================================================================
! ! ! ! ! ! ! ! ! ! ! ! ! ! Model Parameters ! ! ! ! ! ! ! ! ! ! ! ! ! !

	!dimensionality
		integer sdim
		parameter( sdim = 4 )
	
	! PRIORS
	!probability of membership
		double precision prob(2)
	
	!weight of gaussians (to preserve normalization)
		!double precision weight(2)
	
	!sigma of the Gaussians
		double precision sigma1(2)
		!double precision sigma2(2)
	
	!mean of the gaussians (same for both gaussians)
		double precision mean(2)
	
	!normalization of linear function
		double precision norm(2)
	
	! Static Parameters
	!slope of linear function
		double precision slope
	! Range of velocities
		double precision vrelMax
!=======================================================================
! ! ! ! ! ! ! ! ! ! ! Parameters for Nested Sampler ! ! ! ! ! ! ! ! ! ! 
	
	!whether to do multimodal sampling
	logical nest_mmodal 
	parameter(nest_mmodal=.true.)

	!sample with constant efficiency
	logical nest_ceff
	parameter(nest_ceff=.false.)

	!max no. of live points
	integer nest_nlive
	parameter(nest_nlive=500)

	!tot no. of parameters, should be sdim in most cases but if you need to
	!store some additional parameters with the actual parameters then
	!you need to pass them through the likelihood routine
	integer nest_nPar 
	parameter(nest_nPar=sdim)

	!seed for nested sampler, -ve means take it from sys clock
	integer nest_rseed 
	parameter(nest_rseed=-1)

	!evidence tolerance factor
	double precision nest_tol 
	parameter(nest_tol=0.01)

	!enlargement factor reduction parameter
	double precision nest_efr
	parameter(nest_efr=0.5d0)

	!root for saving posterior files
	character*100 nest_root
	!parameter(nest_root='chains/ackley-')

	!after how many iterations feedback is required & the output files should be updated
	!note: posterior files are updated & dumper routine is called after every updInt*10 iterations
	integer nest_updInt
	parameter(nest_updInt=1000)

	!null evidence (set it to very high negative no. if null evidence is unknown)
	double precision nest_Ztol
	parameter(nest_Ztol=-1.d90)

	!max modes expected, for memory allocation
	integer nest_maxModes 
	parameter(nest_maxModes=10)

	!no. of parameters to cluster (for mode detection)
	integer nest_nClsPar
	parameter(nest_nClsPar=2)

	!whether to resume from a previous run
	logical nest_resume
	parameter(nest_resume=.false.)

	!whether to write output files
	logical nest_outfile
	parameter(nest_outfile=.true.)

	!initialize MPI routines?, relevant only if compiling with MPI
	!t to F if you want your main program to handle MPI initialization
	logical nest_initMPI
	parameter(nest_initMPI=.true.)

	!points with loglike < nest_logZero will be ignored by MultiNest
	double precision nest_logZero
	parameter(nest_logZero=-huge(1d0))

	!max no. of iterations, a non-positive value means infinity. MultiNest will terminate if either it 
	!one max no. of iterations or convergence criterion (defined through nest_tol) has been satisfied
	integer nest_maxIter
	parameter(nest_maxIter=0)

	!parameters to wrap around (0 is F & non-zero T)
	integer nest_pWrap(sdim)

	!feedback on the sampling progress?
	logical nest_fb 
	parameter(nest_fb=.true.)
!=======================================================================

end module params
