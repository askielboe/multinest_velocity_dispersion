program main

	use params
	use nestwrapper
	
	implicit none
	
	integer i
	double precision x
	double precision dist_in
	double precision vrel_in
	
	character*100 fnamein, distmin_in, distmax_in
	
	CALL getarg(1, fnamein)
	CALL getarg(2, nest_root)
	CALL getarg(3, distmin_in)
	CALL getarg(4, distmax_in)
	
	READ(distmin_in,*) distmin
	READ(distmax_in,*) distmax
	
	! REMEMBER TO SET THIS FOR NORMALIZATION!!!
	vrelMax = 4000.0 ! AND REMEMBER IT NEEDS TO BE CHANGED MANUALLY IN PRIORS!
	!vrelMax = 4.0 ! AND REMEMBER IT NEEDS TO BE CHANGED MANUALLY IN PRIORS!
	
	! loading data
	i = 0
	OPEN(1, FILE=fnamein, FORM="formatted")
	DO
		! code for reading until EOF
		READ(1, *, END=200) dist_in, vrel_in, x
		if (abs(vrel_in) <= vrelMax) then
			dist(i) = dist_in
			vrel(i) = vrel_in
			i = i + 1
		end if
	END DO
	200 CONTINUE
	CLOSE(1)
	
	common_var_ndata = i
	print*, "ndata = ", common_var_ndata

	!setting priors
	prob(:)			= (/ 0., 1. /)
	!weight(:)		= (/ 0., 1. /)
	
	! Velocity dispersion in units km/s
	sigma1(:)		= (/ 0., 1500. /)
	mean(:)		= (/ -100., 100. /)
	norm(:)		= (/ 0., 1./4000. /)
	
	! Velocity dispersion in units vrel/v_vir
	!sigma1(:)		= (/ 0., 2.0 /)
	!mean(:)			= (/ -4., 4. /)
	!norm(:)			= (/ 0., 1./4.0 /) ! This should be from 0. to 1./vrelMax
	
	!sigma2(:)		= (/ 0., 1500. /)

	!no parameters to wrap around
	nest_pWrap=0
	
	call nest_Sample
	stop

end