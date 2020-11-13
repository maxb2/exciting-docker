
! Copyright (C) 2005-2010 C. Meisenbichler and C. Ambrosch-Draxl.
! This file is distributed under the terms of the GNU General Public License.
! See the file COPYING for license details.

!
!
!
!
Subroutine readprecond (ik, n, X, w)
      Use modmain
      Use modmpi
      Integer, Intent (In) :: n, ik
      Complex (8), Intent (Out) :: X (nmatmax, nmatmax)
      Real (8), Intent (Out) :: w (nmatmax)
  !local variables
      Character (256) :: filetag
      Character (256), External :: outfilenamestring
      Integer :: recl, koffset
      Inquire (IoLength=Recl) X, w
      filetag = "PRECONDMATRIX"
      If (splittfile .Or. (rank .Eq. 0)) Then
         Open (70, File=outfilenamestring(filetag, ik), Action='READ', &
        & Form='UNFORMATTED', Access='DIRECT', Recl=Recl)
         If (splittfile) Then
            koffset = ik - firstk (procofk(ik)) + 1
         Else
            koffset = ik
         End If
         X = 0
         w = 0
         Read (70, Rec=koffset) X, w
         Close (70)
      Else
         Write (*,*) "Error"
         Stop
      End If
End Subroutine readprecond
