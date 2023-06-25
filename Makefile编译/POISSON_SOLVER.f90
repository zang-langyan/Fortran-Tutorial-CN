MODULE POISSON_SOLVER
USE iso_fortran_env
CONTAINS

! *********************************************************************
function iteration_2DPoisson(u,f,h,alpha) result (res_rms)
implicit none
real(real64) :: res_rms
real(real64), intent(inout) :: u(:,:)
real(real64), intent(in) :: f(:,:), h, alpha
integer :: i,j,nx,ny
real(real64) :: res

nx=size(u,1); ny=size(u,2)
res_rms = 0.

do concurrent (i=2:nx-1,j=2:ny-1)
res = (u(i,j+1)+u(i,j-1)+u(i+1,j)+u(i-1,j)-4*u(i,j))/(h**2.0) - f(i,j)
u(i,j) = u(i,j)+alpha*res*(h**2)/4.0
res_rms = res_rms + res**2
end do

res_rms = sqrt(res_rms/(nx*ny))
end function iteration_2DPoisson
! *********************************************************************

! *********************************************************************
subroutine residue_2DPoisson(u,f,h,res)
real(real64), intent(in) :: u(:,:),f(:,:),h
real(real64), intent(out):: res(:,:)
integer :: i,j,nx,ny

nx=size(u,1); ny=size(u,2)
res = 0.

do concurrent (i=2:nx-1,j=2:ny-1)
res(i,j)=(u(i,j+1)+u(i,j-1)+u(i+1,j)+u(i-1,j)-4*u(i,j))/(h**2.0)-f(i,j)
end do
    
end subroutine residue_2DPoisson
! *********************************************************************

! *********************************************************************
subroutine restrict(fine,coarse)
    real(real64), intent(in) :: fine(:,:)
    real(real64), intent(out):: coarse(:,:)
    integer :: nxf,nyf,nxc,nyc,i,j

    nxf=size(fine,1);nyf=size(fine,2)
    nxc=size(coarse,1);nyc=size(coarse,2)
    if (nxf+1/=2*nxc .or. nyf+1/=2*nyc) & 
        stop 'ERROR: grid mismatch when coarsening!'

    do concurrent (i=1:nxc,j=1:nyc)
        coarse(i,j) = fine(2*i-1,2*j-1)
    end do

end subroutine restrict
! *********************************************************************

! *********************************************************************
subroutine prolongate(coarse,fine)
    real(real64), intent(in) :: coarse(:,:)
    real(real64), intent(out):: fine(:,:)
    integer :: nxf,nyf,nxc,nyc,i,j

    nxf=size(fine,1);nyf=size(fine,2)
    nxc=size(coarse,1);nyc=size(coarse,2)
    if (nxf+1/=2*nxc .or. nyf+1/=2*nyc) & 
        stop 'ERROR: grid mismatch when prolongating!'

    do concurrent (i=1:nxc,j=1:nyc)
        fine(2*i-1,2*j-1) = coarse(i,j)
    end do

    do i=1,nxc
        do j=1,nyc-1
            fine(2*i-1,2*j) = (coarse(i,j)+coarse(i,j+1))/2.0
        end do
    end do

    do i=1,nxc-1
        fine(2*i,:) = (fine(2*i-1,:)+fine(2*i+1,:))/2.0
    end do
    
end subroutine prolongate
! *********************************************************************

! *********************************************************************
recursive function Vcycle_2DPoisson(u_f,rhs,h) result (resV)
implicit none
real(real64) resV
real(real64),intent(inout):: u_f(:,:)  ! arguments
real(real64),intent(in)   :: rhs(:,:),h
integer         :: nx,ny,nxc,nyc, i  ! local variables
real(real64),allocatable:: res_c(:,:),corr_c(:,:),res_f(:,:),corr_f(:,:)
real(real64)            :: alpha=0.7, res_rms

nx=size(u_f,1); ny=size(u_f,2)  ! must be power of 2 plus 1
if( nx-1/=2*((nx-1)/2) .or. ny-1/=2*((ny-1)/2) ) &
    stop 'ERROR:not a power of 2'
nxc=1+(nx-1)/2; nyc=1+(ny-1)/2  ! coarse grid size

if (min(nx,ny)>5) then  ! not the coarsest level

    allocate(res_f(nx,ny),corr_f(nx,ny), &
        corr_c(nxc,nyc),res_c(nxc,nyc))

    !---------- take 2 iterations on the fine grid--------------
    res_rms = iteration_2DPoisson(u_f,rhs,h,alpha) 
    res_rms = iteration_2DPoisson(u_f,rhs,h,alpha)

    !---------- restrict the residue to the coarse grid --------
    call residue_2DPoisson(u_f,rhs,h,res_f) 
    call restrict(res_f,res_c)

    !---------- solve for the coarse grid correction -----------
    corr_c = 0.  
    res_rms = Vcycle_2DPoisson(corr_c,res_c,h*2) ! *RECURSIVE CALL*

    !---- prolongate (interpolate) the correction to the fine grid 
    call prolongate(corr_c,corr_f)

    !---------- correct the fine-grid solution -----------------
    u_f = u_f - corr_f  

    !---------- two more smoothing iterations on the fine grid---
    res_rms = iteration_2DPoisson(u_f,rhs,h,alpha)
    res_rms = iteration_2DPoisson(u_f,rhs,h,alpha)

    deallocate(res_f,corr_f,res_c,corr_c)

else  

    !----- coarsest level (ny=5): iterate to get 'exact' solution

    do i = 1,100
        res_rms = iteration_2DPoisson(u_f,rhs,h,alpha)
    end do

end if

resV = res_rms   ! returns the rms. residue

end function Vcycle_2DPoisson
! *********************************************************************
END MODULE POISSON_SOLVER