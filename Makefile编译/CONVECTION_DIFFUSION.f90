MODULE CONVECTION_DIFFUSION
USE iso_fortran_env
USE FINITE_DERIVATIVE
USE POISSON_SOLVER
USE ADVECTION_DIFFUSION
IMPLICIT NONE

CONTAINS

! ***************************************************************************
SUBROUTINE CONVECTION_DIFFUSION_2D( &
    Lx,Ly,nx,ny,k,Ra,Pr,a_dif,a_adv,tol,end_time, &
    T_init, &
    T, W, Psi, &
    record_all, fname_suffix &
)
! INPUTS: 
!   Lx,Ly           - x & y domain
!   nx,ny           - grid points (nx-1 and ny-1 must be a power of 2)
!                     e.g. nx = 257, ny = 65 => nx-1=2^8, ny-1=2^6
!   k               - kappa
!   Ra              - Rayleigh number
!   Pr              - Prandtl number
!   a_diff,a_advect - parameters for time step
!   tol             - tolerence for Poisson solver
!   end_time        - end time of the whole process
!   T_init(ny,nx)   - initial temperature state
! OUTPUTS:
!   T(ny,nx)        - temparature state at end_time
!   W(ny,nx)        - vorticity at grid points
!   Psi(ny,nx)      - stream function at grid points
! OPTIONAL ARGUMENTS:
!   record_all      - .True. then write T and Psi to file through time
!   fname_suffix    - file name suffix for all data through time record
!                     if not specified, 'T_all.bin' and 'Psi_all.bin' 
!                     will be used
real(real64), intent(in) :: Lx,Ly,k,Ra,Pr,end_time
integer, intent(in) :: nx,ny
real(real64), intent(in) :: a_dif,a_adv,tol
real(real64), intent(in) :: T_init(ny,nx)
real(real64), intent(out) :: T(ny,nx),W(ny,nx),Psi(ny,nx)
logical, optional :: record_all
logical           :: record_all_flag
character(len=50), optional :: fname_suffix
character(len=50) :: Tfname, Wfname, Psifname

real(real64) :: T_temp(ny,nx)

real(real64) :: dx,dy
real(real64) :: dt,dt_dif,dt_adv
real(real64) :: current_time

real(real64) :: dT_dx(ny,nx)
real(real64) :: res(ny,nx),f_rms,res_rms
real(real64) :: Vx(ny,nx), Vy(ny,nx), max_v

real(real64) :: AD(ny,nx), DF(ny,nx), AD_W(ny,nx), DF_W(ny,nx)

integer :: j,t_idx=0

T_temp = T_init
T = T_init
dx = Lx/(nx-1)
dy = Ly/(ny-1)

dt_dif = a_dif*min(dx,dy)**2/max(Pr,k)
dt = dt_dif

! check if record T through time
if (.Not. present(record_all)) then
    record_all_flag = .False.
else
    record_all_flag = record_all
end if

! -------------- Iterate until end time --------------
W = 0.
Psi = 0.

! ------------ File Configuration (Start) --------------
if (record_all_flag) then
    if (.Not. present(fname_suffix)) then
        Tfname = 'T_all.bin'
        Wfname = 'W_all.bin'
        Psifname = 'Psi_all.bin'
    else 
        Tfname = 'T_all_'// TRIM(fname_suffix) //'.bin'
        Wfname = 'W_all_'// TRIM(fname_suffix) //'.bin'
        Psifname = 'Psi_all_'// TRIM(fname_suffix) //'.bin'
    end if
    open(97,file=Wfname,form='unformatted',access='stream')
    open(98,file=Tfname,form='unformatted',access='stream')
    open(99,file=Psifname,form='unformatted',access='stream')
    write(97) W
    write(98) T
    write(99) Psi
end if

! Open a file for velocity record
if ((.Not. present(fname_suffix)) .Or. (fname_suffix(1:4)/='test')) then
    open(100,file='maxv.bin',form='unformatted',access='stream')
else 
    open(100,file='maxv_'// TRIM(fname_suffix) //'.bin',&
    form='unformatted',access='stream')
end if
! ------------ File Configuration (End) --------------

current_time = 0.
do while (current_time < end_time)

    do j=1,ny
        call CENTERED_FD(T(j,:),dx,dT_dx(j,:))
    end do

    ! W_t = W_(t-1) + dt*(Pr*d2W - advection(W) - Ra*Pr*dTdx)
    call ADVECTION(W,dx,dy,Vx,Vy,AD_W)
    call DIFFUSION(W,dx,dy,DF_W)
    W = W + dt*(Pr*DF_W - AD_W - Ra*Pr*dT_dx)

    ! W -> Psi
    call residue_2DPoisson(Psi,W,dy,res)
    res_rms = sqrt(sum(res**2)/(nx*ny))
    f_rms = sqrt(sum(W**2)/(nx*ny))
    do while(res_rms/f_rms >= tol)
        res_rms = Vcycle_2DPoisson(Psi,W,dy)
    end do

    ! Psi -> velocity
    call VELOCITY(Psi,dx,dy,Vx,Vy)
    ! record maximum velocity through time
    max_v = max(maxval(Vx),maxval(Vy))
    write(100) current_time,max_v

    ! dt
    if (maxval(Vx) == 0. .Or. maxval(Vy) == 0.) then
        dt = dt_dif
    else
        dt_adv = a_adv*min(dx/maxval(Vx),dy/maxval(Vy))
        dt = min(dt_dif,dt_adv)
    end if

    ! Advection_Diffusion
    call ADVECTION(T_temp,dx,dy,Vx,Vy,AD)
    call DIFFUSION(T_temp,dx,dy,DF)
    T = T_temp + dt*(k*DF - AD)
    ! Boundary Conditions:
    ! dT/dx = 0, T(1,:) = T(ny,:) = 0
    T(1,:) = 1.
    T(ny,:) = 0.
    T(:,1) = T(:,2)
    T(:,nx) = T(:,nx-1)

    ! Update T
    T_temp = T

    ! record T through time
    if (record_all_flag) then
        write(97) W
        write(98) T
        write(99) Psi
    end if

    current_time = current_time + dt
    t_idx = t_idx + 1

    ! Progress 
    write(*,*) 'Current Iteration: ', t_idx, 'Current Time: ', current_time
end do

if (record_all) then
    close(97)
    close(98)
    close(99)
end if

! close velocity record
close(100)

END SUBROUTINE CONVECTION_DIFFUSION_2D
! ***************************************************************************

! ***************************************************************************
END MODULE CONVECTION_DIFFUSION