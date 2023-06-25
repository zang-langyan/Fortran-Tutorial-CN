PROGRAM CO_DF_2D_MAIN
USE CONVECTION_DIFFUSION
IMPLICIT NONE

integer :: nx = 257, ny = 65
real(real64) :: Lx = 4., Ly = 1.
real(real64) :: k = 1., Ra = 1.e6, Pr = 0.0001
real(real64) :: err = 1.e-3
real(real64) :: total_time = 0.1
real(real64) :: a_dif = 0.28, a_adv = 0.4
real(real64), allocatable :: T_init(:,:)
character(len = 10) :: Tinit

real(real64), allocatable :: T(:,:), W(:,:), Psi(:,:)

character(len=50) :: input_file = 'Prandtl.dat', suffix
character(len=50) :: T_fname, W_fname, Psi_fname
namelist /inputs/ nx,ny,Lx,Ly,k,Ra,Pr,err,total_time,a_dif,a_adv,Tinit

if (command_argument_count()>0) &
    call get_command_argument(1,input_file)
open(10,file=input_file,status='old')
read(10,inputs)
close(10)

Lx = Ly/(ny-1)*(nx-1)

allocate(T_init(ny,nx),T(ny,nx),W(ny,nx),Psi(ny,nx))

! Initialize T
if (Tinit == 'cosine') then
    call COSINE_T(Lx,Ly,nx,ny,T_init)
else 
    call RANDOM_T(T_init)
end if

if (input_file(1:4) == 'test') then
    suffix = input_file(1:5)
    T_fname = 'T_' // TRIM(suffix) //'.bin'
    W_fname = 'W_' // TRIM(suffix) //'.bin'
    Psi_fname = 'Psi_' // TRIM(suffix) //'.bin'
else
    T_fname = 'T.bin'
    W_fname = 'W.bin'
    Psi_fname = 'Psi.bin'
end if

! -------------------------------------------------------------------
!     Calling Convection-Diffsion Subroutine
! -------------------------------------------------------------------
call CONVECTION_DIFFUSION_2D(Lx,Ly,nx,ny,k,Ra,Pr,a_dif,a_adv, &
err,total_time,T_init,T,W,Psi, &
record_all=.False., & ! record all
fname_suffix=suffix &
) 
! -------------------------------------------------------------------
open(20,file=T_fname,form='unformatted',access='stream')
open(21,file=W_fname,form='unformatted',access='stream')
open(22,file=Psi_fname,form='unformatted',access='stream')
write(20) T
write(21) W
write(22) Psi
close(20)
close(21)
close(22)

deallocate(T,T_init,Psi,W)

CONTAINS

SUBROUTINE RANDOM_T(T_out)
    real(real64), intent(out) :: T_out(:,:)
    integer :: npx,npy

    npy = size(T_out,1)
    npx = size(T_out,2)

    call random_number(T_out)
    T_out(1,:) = 1.
    T_out(npy,:) = 0.
    T_out(:,1) = T_out(:,2)
    T_out(:,npx) = T_out(:,npx-1)
END SUBROUTINE RANDOM_T

SUBROUTINE COSINE_T(xmax,ymax,npx,npy,T_out)
    real(real64), intent(in) :: xmax,ymax
    integer, intent(in) :: npx,npy
    real(real64), intent(out) :: T_out(npy,npx)
    real(real64) :: dx,dy,x
    integer :: x_idx,y_idx
    real(real64), parameter :: PI = 16*ATAN(1./5.) - 4*ATAN(1./239.)

    dx = xmax/(npx-1)
    dy = ymax/(npy-1)

    T_out = 0.

    do x_idx=2,npx-1
        do y_idx=2,npy-1
            x = (x_idx-1)*dx/xmax
            T_out(y_idx,x_idx) = 0.5*(1.+cos(3.*PI*x))
        end do
    end do
    T_out(1,:) = 1.
    T_out(:,1) = T_out(:,2)
    T_out(:,npx) = T_out(:,npx-1)

END SUBROUTINE COSINE_T

END PROGRAM CO_DF_2D_MAIN