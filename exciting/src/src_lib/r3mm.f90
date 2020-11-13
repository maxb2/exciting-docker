!
!
!
! Copyright (C) 2002-2005 J. K. Dewhurst, S. Sharma and C. Ambrosch-Draxl.
! This file is distributed under the terms of the GNU Lesser General Public
! License. See the file COPYING for license details.
!
!BOP
! !ROUTINE: r3mm
! !INTERFACE:
!
!
Subroutine r3mm (a, b, c)
! !INPUT/OUTPUT PARAMETERS:
!   a : input matrix 1 (in,real(3,3))
!   b : input matrix 2 (in,real(3,3))
!   c : output matrix (out,real(3,3))
! !DESCRIPTION:
!   Multiplies two real $3\times 3$ matrices.
!
! !REVISION HISTORY:
!   Created April 2003 (JKD)
!EOP
!BOC
      Implicit None
! arguments
      Real (8), Intent (In) :: a (3, 3)
      Real (8), Intent (In) :: b (3, 3)
      Real (8), Intent (Out) :: c (3, 3)
      c (1, 1) = a (1, 1) * b (1, 1) + a (1, 2) * b (2, 1) + a (1, 3) * &
     & b (3, 1)
      c (2, 1) = a (2, 1) * b (1, 1) + a (2, 2) * b (2, 1) + a (2, 3) * &
     & b (3, 1)
      c (3, 1) = a (3, 1) * b (1, 1) + a (3, 2) * b (2, 1) + a (3, 3) * &
     & b (3, 1)
      c (1, 2) = a (1, 1) * b (1, 2) + a (1, 2) * b (2, 2) + a (1, 3) * &
     & b (3, 2)
      c (2, 2) = a (2, 1) * b (1, 2) + a (2, 2) * b (2, 2) + a (2, 3) * &
     & b (3, 2)
      c (3, 2) = a (3, 1) * b (1, 2) + a (3, 2) * b (2, 2) + a (3, 3) * &
     & b (3, 2)
      c (1, 3) = a (1, 1) * b (1, 3) + a (1, 2) * b (2, 3) + a (1, 3) * &
     & b (3, 3)
      c (2, 3) = a (2, 1) * b (1, 3) + a (2, 2) * b (2, 3) + a (2, 3) * &
     & b (3, 3)
      c (3, 3) = a (3, 1) * b (1, 3) + a (3, 2) * b (2, 3) + a (3, 3) * &
     & b (3, 3)
      Return
End Subroutine
!EOC
