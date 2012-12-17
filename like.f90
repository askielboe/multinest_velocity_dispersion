module like

	use params
	use utils1
	implicit none
	
	contains
	
	!=======================================================================
	
	subroutine slikelihood(Cube,slhood)
		
		implicit none
		
		double precision Cube(nest_nPar),slhood
		
		integer i
		
		slhood = 0d0
		
		Cube(1) = prob(1) + (prob(2) - prob(1)) * Cube(1)
		!Cube(2) = weight(1) + (weight(2) - weight(1)) * Cube(2)
		Cube(2) = sigma1(1) + (sigma1(2) - sigma1(1)) * Cube(2)
		!Cube(4) = sigma2(1) + (sigma2(2) - sigma2(1)) * Cube(4)
		Cube(3) = mean(1) + (mean(2) - mean(1)) * Cube(3)
		Cube(4) = norm(1) + (norm(2) - norm(1)) * Cube(4)
		
		! Normalization condition for background function
		!slope = (1./8000.-Cube(4))/4000.
	
		! Velocity dispersion in units vrel/v_vir
		slope = (1./(vrelMax*2.)-Cube(4))/vrelMax		
		
		slhood = 0d0
		
		do i=1,common_var_ndata
		!========================= Two Gaussians ====================================
		!	if (distmin < dist(i) .AND. dist(i) < distmax) then
		!	slhood	= slhood + log(Cube(1) * (&
		!				&							Cube(2)			* exp(-(vrel(i)-Cube(3))**2./(2*Cube(2)**2.))/(S2P*Cube(2))&
		!				&						+ 	(1.-Cube(2))	* exp(-(vrel(i)-Cube(3))**2./(2*Cube(4)**2.))/(S2P*Cube(4))&
		!				&						)&
		!				& + (1.-Cube(1)) * (slope*(vrel(i)+4000.)+Cube(4)))
		!	end if
		!========================= Single Gaussian ====================================
			if (distmin < dist(i) .AND. dist(i) < distmax) then
			slhood	= slhood + log(Cube(1) * (&
						&							exp(-(vrel(i)-Cube(3))**2./(2*Cube(2)**2.))/(S2P*Cube(2))&
						&						)&
						& + (1.-Cube(1)) * (slope*(vrel(i)+vrelMax)+Cube(4)))
			end if
		end do
	
	end subroutine slikelihood
	
	!=======================================================================

end module like
