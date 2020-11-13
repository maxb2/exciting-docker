!
!
!
! Copyright (C) 2002-2005 J. K. Dewhurst, S. Sharma and C. Ambrosch-Draxl.
! This file is distributed under the terms of the GNU General Public License.
! See the file COPYING for license details.
!
!BOP
! !ROUTINE: olpistl
! !INTERFACE:
!
!
Subroutine olpistln (overlap, ngp, igpig, vgpc)
! !USES:
      Use modmain
      Use modfvsystem
! !INPUT/OUTPUT PARAMETERS:
!   ngp   : number of G+p-vectors (in,integer)
!   igpig : index from G+p-vectors to G-vectors (in,integer(ngkmax))
!   v     : input vector to which O is applied if tapp is .true., otherwise
!           not referenced (in,complex(nmatmax))
!   o     : O applied to v if tapp is .true., otherwise it is the overlap
!         : matrix in packed form (inout,complex(npmatmax))
! !DESCRIPTION:
!   Computes the interstitial contribution to the overlap matrix for the APW
!   basis functions. The overlap is given by
!   $$ O^{\rm I}({\bf G+k,G'+k})=\tilde{\Theta}({\bf G-G'}), $$
!   where $\tilde{\Theta}$ is the characteristic function. See routine
!   {\tt gencfun}.
!
! !REVISION HISTORY:
!   Created April 2003 (JKD)
!EOP
!BOC
      Implicit None
! arguments
      Type (HermitianMatrix), Intent (Inout) :: overlap
      Integer, Intent (In) :: ngp
      Integer, Intent (In) :: igpig (ngkmax)
      Real (8), Intent (In) :: vgpc (3, ngkmax)
!
!
! local variables
      Integer :: i, j, k, iv (3), ig
      real (8) :: t1, alpha, a2
      Complex (8) zt1
      Parameter (alpha=1d0 / 137.03599911d0, a2=0.5d0*alpha**2)
!
! calculate the matrix elements


!      if (input%groundstate%ValenceRelativity.eq.'lkh') then
       if (h1on) then
!       if (.false.) then
        Do j = 1, ngp
          Do i = 1, j
            iv (:) = ivg (:, igpig(i)) - ivg (:, igpig(j))
            ig = ivgig (iv(1), iv(2), iv(3))
            If ((ig .Gt. 0) .And. (ig .Le. ngvec)) Then
              t1 = 0.5d0 * a2*dot_product (vgpc(:, i), vgpc(:, j))
              zt1=t1*m2effig(ig)+cfunig(ig)
              Call Hermitianmatrix_indexedupdate (overlap, j, i, zt1)
            End If
          End Do
        End Do
!      endif
      else

!$omp parallel default(shared) &
!$omp  private(iv,ig,i,j)
!$omp do
        Do j = 1, ngp
          Do i = 1, j
            iv (:) = ivg (:, igpig(i)) - ivg (:, igpig(j))
            ig = ivgig (iv(1), iv(2), iv(3))
            If ((ig .Gt. 0) .And. (ig .Le. ngvec)) Then
              Call Hermitianmatrix_indexedupdate (overlap, j, i, cfunig(ig))
            End If
          End Do
        End Do
!$omp end do
!$omp end parallel
      endif
      Return
End Subroutine
!EOC
