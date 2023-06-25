MODULE ADVECTION_DIFFUSION
USE iso_fortran_env
USE FINITE_DERIVATIVE
USE FD_SCHEME
CONTAINS

! ******************************************************************
SUBROUTINE VELOCITY(Stream,dx,dy,Vx,Vy)
! INPUTS: 
!   Stream(ny,nx)   - stream function at grid points
!   dx,dy           - spacing at x,y direction
! OUTPUTS:
!   Vx(ny,nx)       - velocity at x direction
!   Vy(ny,nx)       - velocity at y direction

real(real64),intent(in)::Stream(:,:),dx,dy
real(real64),intent(out),dimension(size(Stream,1),size(Stream,2))::Vx,Vy
integer :: nx,ny,i,j

nx = size(Stream,2)
ny = size(Stream,1)

do i=1,nx
    call CENTERED_FD(Stream(:,i),dy,Vx(:,i))
end do

do j=1,ny
    call CENTERED_FD(Stream(j,:),dx,Vy(j,:))
end do
Vy = -Vy

END SUBROUTINE VELOCITY
! ******************************************************************

! ******************************************************************
SUBROUTINE ADVECTION(T,dx,dy,Vx,Vy,AD_out)
! INPUTS: 
!   T(ny,nx)        - temperature state
!   Vx(ny,nx)       - velocity at x direction
!   Vy(ny,nx)       - velocity at y direction
!   dx,dy           - spacing at x,y direction
! OUTPUTS:
!   AD_out(ny,nx)   - velocity * gradient_T

real(real64),intent(in) ::T(:,:),dx,dy
real(real64),intent(in),dimension(size(T,1),size(T,2))::Vx,Vy
real(real64),intent(out)::AD_out(size(T,1),size(T,2))
integer :: nx,ny,i,j
real(real64),dimension(size(T,1),size(T,2)):: VT_x, VT_y

nx = size(T,2)
ny = size(T,1)

do j=1,ny
    call UPWIND_FD(Vx(j,:),T(j,:),dx,VT_x(j,:))
end do

do i=1,nx
    call UPWIND_FD(Vy(:,i),T(:,i),dy,VT_y(:,i))
end do

AD_out = VT_x+VT_y

END SUBROUTINE ADVECTION
! ******************************************************************

! ******************************************************************
SUBROUTINE DIFFUSION(T,dx,dy,DF_out)
! INPUTS: 
!   T(ny,nx)        - temperature state
!   dx,dy           - spacing at x,y direction
! OUTPUTS:
!   DF_out(ny,nx)   - second derivative of T

real(real64),intent(in) ::T(:,:),dx,dy
real(real64),intent(out)::DF_out(size(T,1),size(T,2))
integer :: nx,ny,i,j
real(real64),dimension(size(T,1),size(T,2))::T_x,T_y

nx = size(T,2)
ny = size(T,1)

do j=1,ny
    call SECOND_CENTERED_FD(T(j,:),dx,T_x(j,:))
end do

do i=1,nx
    call SECOND_CENTERED_FD(T(:,i),dy,T_y(:,i))
end do

DF_out = T_x+T_y

END SUBROUTINE DIFFUSION
! ******************************************************************

! ******************************************************************
SUBROUTINE ADVECTION_DIFFUSION_2D( &
    Lx,Ly,nx,ny,k,end_time,a_diff,a_advect, &
    T_init,Stream, & ! initial state and stream
    T & ! output
)
! INPUTS: 
!   Lx,Ly           - x & y domain
!   nx,ny           - grid points
!   k               - kappa
!   end_time        - end time of the whole process
!   a_diff,a_advect - parameters for time step
!   T_init(ny,nx)   - initial temperature state
!   Stream(ny,nx)   - stream function at grid points
! OUTPUTS:
!   T(ny,nx)        - temparature state at end_time

integer, intent(in) :: nx,ny
real(real64), intent(in) :: Lx,Ly,k,end_time,a_diff,a_advect
real(real64), intent(in) :: T_init(ny,nx), Stream(ny,nx)
real(real64), intent(out):: T(ny,nx)
real(real64) :: dx,dy,dt,dt_diff,dt_advect
integer :: total_time_steps
integer :: t_idx
real(real64) :: Vx(ny,nx),Vy(ny,nx)
real(real64) :: T_temp(ny,nx)
real(real64) :: AD(ny,nx), DF(ny,nx)

dx = Lx/(nx-1)
dy = Ly/(ny-1)

call VELOCITY(Stream,dx,dy,Vx,Vy)

dt_diff = a_diff*min(dx,dy)**2/k
dt_advect = a_advect*min(dx/maxval(Vx),dy/maxval(Vy))
dt = min(dt_diff,dt_advect)

total_time_steps = floor(end_time/dt)

T_temp = T_init
do t_idx=1,total_time_steps
    call ADVECTION(T_temp,dx,dy,Vx,Vy,AD)
    call DIFFUSION(T_temp,dx,dy,DF)
    T = T_temp + dt*(k*DF-AD)
    ! Boundary Conditions:
    ! dT/dx = 0, T(1,:) = T(ny,:) = 0
    T(1,:) = 1.
    T(ny,:) = 0.
    T(:,1) = T(:,2)
    T(:,nx) = T(:,nx-1)
    
    T_temp = T
end do

END SUBROUTINE ADVECTION_DIFFUSION_2D
! ******************************************************************
END MODULE ADVECTION_DIFFUSION