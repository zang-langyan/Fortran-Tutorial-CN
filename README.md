# Fortran 基础

本教程参考了包括但不限于以下网站的内容
1. https://fortran-lang.org/
2. https://www.fortran90.org/
3. https://www.nsc.liu.se/~boein/f77to90/f77to90.html#index
4. https://gcc.gnu.org/onlinedocs/gcc-4.2.4/gfortran/index.html#Top

- [Fortran 基础](#fortran-基础)
  - [一. 编译器](#一-编译器)
  - [二. Hello World](#二-hello-world)
  - [三. 标准输入和输出 (io)](#三-标准输入和输出-io)
  - [四. 基本数据类型](#四-基本数据类型)
    - [浮点数精度](#浮点数精度)
  - [五. 运算符](#五-运算符)
  - [六. 数组和字符串](#六-数组和字符串)
    - [数组](#数组)
    - [字符串](#字符串)
    - [字符串数组](#字符串数组)
  - [七. 流程控制](#七-流程控制)
    - [逻辑运算](#逻辑运算)
    - [条件语句](#条件语句)
    - [循环语句](#循环语句)
      - [序数循环](#序数循环)
      - [条件循环](#条件循环)
      - [循环控制](#循环控制)
  - [八. 函数与代码结构](#八-函数与代码结构)
    - [子例程和函数](#子例程和函数)
    - [代码结构](#代码结构)
  - [九. 面向对象 -- 类或结构体](#九-面向对象----类或结构体)
  - [十. 格式](#十-格式)
  - [十一. 文件读写](#十一-文件读写)
  - [十二. 指针](#十二-指针)
  - [十三. 并行计算](#十三-并行计算)
    - [MPI](#mpi)
    - [Coarray](#coarray)
  - [十四. 内置函数](#十四-内置函数)
    - [数值](#数值)
    - [数学](#数学)
    - [数组](#数组-1)
  - [十五. Makefile管理项目](#十五-makefile管理项目)


## 一. 编译器

在此列出一些常见的Fortran编译器（参考[fortran-lang.org](https://fortran-lang.org/zh_CN/compilers/)的列表）
本中文文档将使用 ***gfortran*** 作为其中案例的编译器。
关于 ***gfortran*** 的安装方法请参考[安装GFortran](https://fortran-lang.org/zh_CN/learn/os_setup/install_gfortran/) (https://fortran-lang.org/learn/os_setup/install_gfortran/) 或 [GNU GCC](https://gcc.gnu.org/wiki/GFortranBinaries) (https://gcc.gnu.org/wiki/GFortranBinaries) 页面的指导，选择符合你操作系统的安装方法。

**开源编译器：**

* [gfortran](https://gcc.gnu.org/fortran/): GNU Fortran 编译器，隶属于GNU Compiler Collection。[OpenCoarrays](http://www.opencoarrays.org/)是一个围绕gfortran的库和编译器包装器，以此可进行gfortran的并行编程功能
* [LLVM Flang](https://github.com/llvm/llvm-project/tree/main/flang): LLVM 的 Fortran 2018 新前端. (它是用现代 C++ 实现的，并使用面向 Fortran 的 MLIR 方言来降低到 LLVM IR。该项目正在积极开发中)
* [Current Flang](https://github.com/flang-compiler/flang): NVIDIA/PGI 商业编译器的开源编译器
* [LFortran](https://lfortran.org/) 是一种现代的、交互式的、基于 LLVM 的 Fortran 编译器

**商业编译器：**

* [Intel oneAPI](https://www.intel.com/content/www/us/en/developer/tools/oneapi/toolkits.html#gs.zhoout): 是英特尔针对 Fortran、C、 C++ 和 Python。 Intel oneAPI HPC Toolkit 提供两个 Fortran 编译器：ifx(可在Intel GPUs上运行`do concurrent`) 和 ifort(仅支持CPU) (目前版本的Intel oneAPI是免费的，可购买支持)
* [NAG](https://www.nag.com/content/nag-fortran-compiler): 最新的 NAG Fortran 编译器 版本 (7.0) 广泛支持传统和现代 Fortran 功能，包括使用 coarray 进行并行编程，以及对使用 OpenMP 进行编程的额外支持
* [NVIDIA HPC SDK](https://developer.nvidia.com/hpc-sdk): C、C++ 和 Fortran 编译器，以前的 PGI 编译器，支持使用标准 C++ 和 Fortran、OpenACC® 指令和 CUDA® 对 HPC 建模和仿真应用程序进行 GPU 加速。 GPU 加速的数学库最大限度地提高了常见 HPC 算法的性能，优化的通信库支持基于标准的多 GPU 和可扩展系统编程。
NVHPC 编译器是被免费提供的，目前编译器支持 Linux 平台和 x86_64、ppc64le 和 aarch64 架构， HPC 编译器论坛 提供社区支持。
* [AMD Optimizing C/C++ Compiler (AOCC)](https://www.amd.com/en/developer/aocc.html): 编译器系统是一个高性能、生产质量的代码生成工具。在构建和优化面向 32 位和 64 位 Linux® 平台的 C、C++ 和 Fortran 应用程序时，AOCC 环境为开发人员提供了各种选项。 AOCC 编译器系统提供高级优化、多线程和处理器支持，包括全局优化、矢量化、过程间分析、循环转换和代码生成。 AMD 还提供高度优化的库，可在使用时从每个 x86 处理器内核中提取最佳性能。 AOCC 编译器套件简化并加速了 x86 应用程序的开发和调整。
AOCC 编译器被免费提供，支持 x86_64 架构的 Linux 平台。

检查安装是否完成
```shell
$ gfortran --version
```

---
## 二. Hello World

创建一个Fortran脚本`hello_world.f90`，用你最喜欢的编辑器打开并写入下面的代码
```fortran
program hello
  ! 这是一行注释
  print *, 'Hello, World!'
end program hello
```

保存之后，在命令行中对其进行编译
```shell
$ gfortran hello_world.f90 -o hello_world
```

编译完成后，运行
```shell
$ ./hello_world
```

---------

> ℹ️ Fortran 不区分大小写，所有大写字符都会在编译之前转为小写。
> 如：`real :: VAR, var, VaR` 将导致错误，编译器会认为同一变量声明了三次

## 三. 标准输入和输出 (io)

此处介绍最基本的用法，详细的用法将在[十. 格式](#十-格式)和读写文件章节中介绍

```fortran
program read_value
  implicit none ! 添加之后所有变量必须明确声明 (可以不添加，但强烈建议添加以避免bug) - 强类型语言
  integer :: age

  print *, '请输入你的年龄: '
  read(*,*) age ! 或使用 read *, age

  write(*,*) '年龄: ', age

end program read_value
```

---
## 四. 基本数据类型

* integer 整数
* real 实数
* complex 复数
* character 字符
* logical 逻辑值

> ⚠️ **_注意:_** 在使用浮点数时，即使没有小数部分，也要记住加上小数点；如：`real :: x = 2.`；
> 如果没有小数点可能会导致编译器识别错误

每一个`program` 或 `subroutine` 或 `function` 中必须在开头先声明所有需要使用的变量，不可以在主体运算部分另起声明

```fortran
program variables
  implicit none

  integer :: count
  real :: pi
  complex :: z
  character :: char
  logical :: isOkay

  count = 10
  pi = 3.1415927
  z = (1.0, -0.5) ! 1.0 - 0.5i
  char = 'A' ! 或使用双引号 "A"
  isOkay = .true. ! 否为 .false.

end program variables
```

### 浮点数精度

32位和64位，没有声明类型时一般为32位

```fortran
program float_precision
  use, intrinsic :: iso_fortran_env, only: sp=>real32, dp=>real64
  implicit none

  real(kind=sp) :: x_32
  real(kind=dp) :: x_64

  x_32 = 1.0_sp  ! 建议总是将类型后缀加在常量后
  x_64 = 1.0_dp

end program float_precision
```

---
## 五. 运算符

* `+` 加
* `-` 减
* `*` 乘
* `/` 除
* `**` 幂

```fortran
program sphere
  implicit none

  real :: pi = 3.141592653589793238
  real :: radius
  real :: surface
  real :: volume

  print *, '输入球体半径:'
  read(*,*) radius

  surface = 4. * pi * radius**2
  volume = 4./3. * pi * radius**3

  print *, '球'
  print *, '表面积为: ', surface
  print *, '体积为: ', volume

end program sphere
```

`parameter` 代表常量，在运行过程中无法修改，类似于C/C++中的`const`，所以需要在声明时初始化
```fortran
program molar_mass
  implicit none

  real, parameter :: NaCl = 58.5 ! 氯化钠的摩尔质量为58.5g/mol
  real :: mass
  real :: mol

  print *, '输入氯化钠质量:'
  read(*,*) mass

  mol = mass / NaCl

  print *, 'NaCl'
  print *, '摩尔量为: ', mol, ' mol'

end program molar_mass
```

---
## 六. 数组和字符串

### 数组

> **注：**
>   - 数组默认从1开始序数
>   - 也可以自定义从任意位置开始序数
>   - 多维数组由前向后（维度）记录 (column major)

```fortran
program arrays
  implicit none

  ! ******************** 数组声明 ********************
  ! 1维整数数组
  integer, dimension(10) :: array1

  ! 也可以这样声明
  integer :: array2(10)

  ! 2维浮点数数组
  real, dimension(10, 10) :: array3

  ! 自定义序数
  real :: array4(0:9) ! 长度为10
  real :: array5(-5:5) ! 长度为11

  ! 可分配（动态）数组 - 变长数组
  real, allocatable :: array6(:,:)


  ! ******************** 数组初始化 ********************
  array1 = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]  ! Array constructor
  array1 = [(i, i = 1, 10)]  ! Implied do loop constructor

  ! ******************** 数组索引与切片 ********************
  array1(:) = 0  ! 将所有元素设为0
  array1(1:5) = 1  ! 将前5个元素设为1
  array2(6:) = 1  ! 将第5个元素向后的所有元素设为1
  array3(1,2:3) = 0 ! 将array3的第1行第2，3列的元素设为0
  array4(0) = 1 ! 将array4的第1个元素设为1

  ! ******************** 动态数组 ********************
  ! 分配大小
  allocate(array6(16,32)) ! 16 x 32 的数组
  deallocate(array6) ! 释放数组空间
end program arrays
```

### 字符串
```fortran
program string
  implicit none

  ! ******************** 字符串声明 ********************
  ! 定长字符串
  character(len=4) :: xing ! 姓
  character(len=5) :: ming ! 名
  character(10) :: name ! 姓名
  ! 变长字符串 (可分配字符串)
  character(:), allocatable :: first_name
  character(:), allocatable :: last_name

  ! ******************** 定长字符串 ********************
  xing = '屈'
  ming = '原'

  ! 字符串串联
  name = xing//ming

  print *, name

  ! ******************** 变长字符串 ********************
  allocate(character(4) :: first_name)
  first_name = 'yyyy'

  last_name = 'xxxxx'
  print *, first_name//' '//last_name
end program string
```

### 字符串数组
顾名思义，即存储字符串的数组
```fortran
program string_array
  implicit none
  character(len=10), dimension(2) :: keys
  character(len=10), dimension(3,2) :: vals

  keys = [character(len=10) :: "姓名", "学号"]
  vals(1,:) = [character(len=10) :: "张三", "001"]
  vals(2,:) = [character(len=10) :: "李四", "002"]
  vals(3,:) = [character(len=10) :: "王五", "003"]

  call show(keys, vals)

  contains

  subroutine show(akeys, avals)
    character(len=*), intent(in) :: akeys(:), avals(:,:)
    integer                      :: i

    print *, akeys

    do i = 1, size(avals,1)
      print *, avals(i,:)
    end do
  end subroutine show

end program string_array
```

---
## 七. 流程控制

### 逻辑运算

|关系运算符|(或)|描述|
|:---:|:---:|:---:|
|`==`|`.eq.`|是否相等|
|`/=`|`.ne.`|是否不相等|
|`>`|`.gt.`|是否大于|
|`<`|`.lt.`|是否小于|
|`>=`|`.ge.`|是否大于等于|
|`<=`|`.le.`|是否小于等于|

|逻辑运算符|描述|
|:---:|:---:|
|`.and.`|与|
|`.or.`|或|
|`.not.`|非|
|`.eqv.`|同或（前后逻辑值**相同**返回**真**）|
|`.neqv.`|异或（前后逻辑值**不同**返回**真**）|

### 条件语句

```fortran
program if_statement
  implicit none

  real :: angle 

  read *, angle

  if (angle < 90.0) then
    print *, '锐角'
  else if (angle < 180.0) then
    print *, '钝角'
  else
    print *, '什么角？'
  end if

end program if_statement
```

### 循环语句

#### 序数循环
`do` 后加上序数。如：`do i = 1,100,3`，其中`1`为起始值，`100`为结束值，`3`为步长。

```fortran
program do_statement
  implicit none

  integer :: i

  do i = 1, 10, 2
    print *, i  ! Print odd numbers
  end do

end program do_statement
```

#### 条件循环
`do while (condition)`

```fortran
program do_while_statement
  implicit none

  integer :: i = 1

  do while (i < 11)
    print *, i
    i = i + 1
  end do
  
  print *, i ! i此时为11

end program do_while_statement
```

#### 循环控制
* `cycle` - （最近的）循环进入下一个取值
* `exit` - 跳出（最近的）循环

```fortran
program cycle_prog
  implicit none

  integer :: i

  do i = 1, 10
    if (mod(i, 2) == 0) then
        cycle  ! 不再运行后面的程序，直接进入下一个i取值
    end if
    print *, i
  end do

end program cycle_prog
```

```fortran
program exit_prog
  implicit none

  integer :: i

  do i = 1, 100
    if (i > 10) then
      exit  ! 立即停止循环
    end if
    print *, i
  end do

end program exit_prog
```

在嵌套循环时，还可以给每个循环添加标签，在使用`cycle` 和 `exit` 后加上标签名即可对相应的循环产生作用
```fortran
program tag_do
  implicit none

  integer :: i, j

  outer_loop: do i = 1, 10
    inner_loop: do j = 1, 10
      if (i > 7) then
        exit outer_loop ! 退出外部循环(outer_loop)
      end if

      if ((j + i) > 10) then 
        cycle outer_loop  ! 如果j+i的值大于10，则跳过剩下的内部循环(inner_loop)，进入下一个i的取值(outer_loop)
      end if
      print *, 'I=', i, ' J=', j, ' Sum=', j + i
    end do inner_loop
  end do outer_loop

end program tag_do
```


---
## 八. 函数与代码结构

### 子例程和函数
Fortran里有两种子程序，一种是`subroutine` (子例程)，一种是`function` (函数)。

传入的参数有三种形式，`intent(in)` 只读，`intent(out)` 只写，`intent(inout)` 读写

一般来说，`function` (函数)只能有一个返回值，而`subroutine` (子例程)可以通过写入多个`intent(out)` 只写或`intent(inout)` 读写参数来拥有多个返回值

* ___子例程___ ___subroutine___ 
```fortran
subroutine vector_product(n,a,b,dot_pro,element_wise_pro)
  integer, intent(in) :: n
  real, intent(in) :: a(n), b(n)
  real, intent(out) :: dot_pro, element_wise_pro(n)

  integer :: i

  dot_pro = 0.
  do i = 1,n
    dot_pro = dot_pro + a(i) * b(i)
    element_wise_pro(i) = a(i) * b(i)
  end do

end subroutine vector_product

```

* ___函数___ ___function___ 
```fortran
function vector_norm(n,vec) result(norm)
  integer, intent(in) :: n
  real, intent(in) :: vec(n)
  real :: norm

  norm = sqrt(sum(vec**2))

end function vector_norm
```

上面这个函数还可以将`result(norm)`省去，直接用函数名代替返回变量
```fortran
function vector_norm(n,vec)
  integer, intent(in) :: n
  real, intent(in) :: vec(n)
  real :: vector_norm

  vector_norm = sqrt(sum(vec**2))

end function vector_norm
```

或者直接在`function`关键词前添加类型，对函数名进行声明
```fortran
real function vector_norm(n,vec)
  integer, intent(in) :: n
  real, intent(in) :: vec(n)

  vector_norm = sqrt(sum(vec**2))

end function vector_norm
```

### 代码结构
Fortran 里有四种方式存放子例程(`subroutine`)和函数(`function`)

__1.__ 内部(internal)函数；在`program`中使用`contains`存放函数
__2.__ 外部(external)函数；存放在`program`之外
__3.__ 单独文件存放（编译时将涉及的文件全部编译）
__4.__ 使用模块(module)管理；在`implicit none`前使用`use`加上模块名来导入模块，使用`only: ...`来导入特定的函数或变量

下面的例子在[5. 子例程+函数+代码结构](./5.%20%E5%AD%90%E4%BE%8B%E7%A8%8B%2B%E5%87%BD%E6%95%B0%2B%E4%BB%A3%E7%A0%81%E7%BB%93%E6%9E%84/)文件夹中

```fortran
! main.f90
program structure
  ! ****************** 模块 ******************
  use STATS, only: pi, mean_std 
  implicit none

  integer :: n_x
  real :: x(3), y(3), dot_product, element_wise_product(3)
  real :: deriv(3)

  real, external :: norm1 ! 外部函数

  real :: data_array(5), data_mean, data_std

  x = [1,2,3]
  y = [3,2,1]
  n_x = size(x)

  ! ****************** 内部 ******************
  print *, '内部函数：'
  call vector_product(n_x, x, y, dot_product, element_wise_product)

  print *, 'x · y = ', dot_product
  print *, 'element wise product = ', element_wise_product

  print *, '||x||_2 = ', vector_norm(n_x, x)
  print *, ''

  ! ****************** 外部 ******************
  print *, '外部函数：'
  print *, '||x|| = ', norm1(n_x, x)
  print *, ''

  ! ****************** 单独文件存放 ******************
  print *, '其他文件（derivative）：'
  call derivative(x, n_x, 0.5, deriv)
  print *, deriv
  print *, ''

  ! ****************** 模块 ******************
  print *, '模块（STATS）：'
  data_array = [pi, 2*pi, 3*pi, 4*pi, 5*pi]
  call mean_std(5, data_array, data_mean, data_std)
  print *, '均值：', data_mean
  print *, '标准差：', data_std

contains

  subroutine vector_product(n,a,b,dot_pro,element_wise_pro)
    integer, intent(in) :: n
    real, intent(in) :: a(n), b(n)
    real, intent(out) :: dot_pro, element_wise_pro(n)

    integer :: i

    dot_pro = 0.
    do i = 1,n
      dot_pro = dot_pro + a(i) * b(i)
      element_wise_pro(i) = a(i) * b(i)
    end do

  end subroutine vector_product

  function vector_norm(n,vec)
    integer, intent(in) :: n
    real, intent(in) :: vec(n)
    real :: vector_norm

    vector_norm = sqrt(sum(vec**2))

  end function vector_norm

end program structure

real function norm1(n,vec)
  integer, intent(in) :: n
  real, intent(in) :: vec(n)

  norm1 = sum(abs(vec))

end function norm1
```

```fortran
! Finite_Derivative.f90
SUBROUTINE derivative (data, ndt, h, deriv)
    integer, intent(in) :: ndt
    real   , intent(in) :: data(ndt), h
    real   , intent(out):: deriv(ndt)
    integer             :: i

    do i = 1,ndt-1
        deriv(i) = (data(i+1)-data(i))/h
    end do
    deriv(ndt) = 0.
END SUBROUTINE derivative
```

```fortran
! mean_std_module.f90
module STATS
  real, parameter :: pi = 3.141592653589293

contains

  SUBROUTINE mean_std(n,data,mean,std)
    integer, intent(in) :: n
    real   , intent(in) :: data(n)
    real   , intent(out):: mean, std
    integer :: i
    real    :: sum = 0., sum_of_squared = 0.

    do i = 1,n
        sum = sum + data(i)
        sum_of_squared = sum_of_squared + data(i) ** 2
    end do

    mean = sum / n
    std = sqrt(sum_of_squared/n - (mean ** 2))
  END SUBROUTINE mean_std

end module STATS
```

---
## 九. 面向对象 -- 类或结构体

Fortran中的类或结构体（对应C/C++中的`struct`/`class`）是以`type`关键词实现的。`type`中包含了新定义类的属性（成员变量）和方法（成员函数）。要访问/读取/使用成员变量或函数，使用`%`符号。

在类中创建成员变量时和一般的声明一样，但是创建方法时要注意，不能直接在`type`中的`contains`后定义方法，我们只能声明方法，然后在`module`的`contains`后定义方法(这类似于C/C++的头文件的目的，只是C/C++的头文件允许你直接定义)。

```fortran
module coordinates
  implicit none
  private ! 将整体设为private, 只在后续有必要的地方将方法或类型设为public
  
  public :: polar_coord ! 将polar_coord类设为public，供其他程序调用
  
  real, public :: pi = 3.141592653589793238462643383279502884197169399375105820974944592307816406286

  type polar_coord
    real :: rho, theta
  contains
    procedure, public, pass(this) :: to_euler
    procedure, public :: to_euler_func
  end type polar_coord
  
contains
  
  subroutine to_euler(euler_coord, this)
    class(polar_coord), intent(in) :: this
    real, intent(out) :: euler_coord(2)

    euler_coord(1) = this%rho * cos(this%theta)
    euler_coord(2) = this%rho * sin(this%theta)
  end subroutine to_euler

  function to_euler_func(this) result(euler_coord)
    class(polar_coord), intent(in) :: this
    real :: euler_coord(2)

    euler_coord(1) = this%rho * cos(this%theta)
    euler_coord(2) = this%rho * sin(this%theta)
  end function to_euler_func

  
end module coordinates
  
program typedemo
  use coordinates
  implicit none

  type(polar_coord) :: p(2) ! 定义一个polar_coord类型的数组p，长度为2
  real :: euler_coord(2), euler_coord_func(2)

  p(1)%rho = sqrt(2.0)
  p(1)%theta = pi / 4.0
  
  print *, "---------------------"
  print *, "p(1)"
  call p(1)%to_euler(euler_coord)
  print *, "call member subroutine:"
  print *, euler_coord

  euler_coord_func = p(1)%to_euler_func()
  print *, "call member function:"
  print *, euler_coord_func


  p(2)%rho = 2.
  p(2)%theta = pi / 3.0

  print *, "---------------------"
  print *, "p(2)"
  call p(2)%to_euler(euler_coord)
  print *, "call member subroutine:"
  print *, euler_coord

  euler_coord_func = p(2)%to_euler_func()
  print *, "call member function:"
  print *, euler_coord_func
end program typedemo
```

---
## 十. 格式

在打印或读取数据的时候，我们常常需要指定打印或读取数据的格式。例如，我们想要打印`real :: pi = 3.141592653589293`，但只想保留2位小数，我们就可以写`write(*,'(F4.2)')`。所以，之前在[标准输入和输出 (io)](#三-标准输入和输出-io)章节中见过的`read(*,*)`和`write(*,*)`中的第二个`*`就代表默认的格式，编译器会根据数据类型进行选择格式；第一个`*`代表输入或输出位置，我们将在下一章[文件读写](#十一-文件读写)中看到。(同样，`read *`和`write *`以及`print *`中的`*`也代表默认格式，如果需要明确格式则将其替换。)

格式是以字符串定义的，字符串中的格式必须以小括号包裹，如`'(A)'`。下面的表列出了不同类型的数据格式可以如何明确。

<TABLE CELLPADDING=3 BORDER=2>
     <TR ALIGN=CENTER>
          <TD COLSPAN=2> <B><I>目的</I></B>  </TD>
          <TD COLSPAN=2> <B><I>格式</I></B> </TD>
     </TR>
     <TR ALIGN=CENTER>
          <TD COLSPAN=2 ALIGN=LEFT> 读/写 <B>整数 INTEGER</B>s </TD>
          <TD> <B>I<I>w</I></B> </TD>
          <TD> <B>I<I>w.m</I></B> </TD>
     </TR>
     <TR ALIGN=CENTER>
          <TD ALIGN=LEFT ROWSPAN=4> 读/写 <B>浮点数 REAL</B>s </TD>
          <TD ALIGN=LEFT> 小数格式 </TD>
          <TD COLSPAN=2> <B>F<I>w.d</I></B> </TD>
     </TR>
     <TR ALIGN=CENTER>
          <TD ALIGN=LEFT> 指数格式 </TD>
          <TD> <B>E<I>w.d</I></B> </TD>
          <TD> <B>E<I>w.d</I>E<I>e</I></B> </TD>
     </TR>
     <TR ALIGN=CENTER>
          <TD ALIGN=LEFT> 科学计数格式 </TD>
          <TD> <B>ES<I>w.d</I></B> </TD>
          <TD> <B>ES<I>w.d</I>E<I>e</I></B> </TD>
     </TR>
     <TR ALIGN=CENTER>
          <TD ALIGN=LEFT> 工程计数格式 </TD>
          <TD> <B>EN<I>w.d</I></B> </TD>
          <TD> <B>EN<I>w.d</I>E<I>e</I></B> </TD>
     </TR>
     <TR ALIGN=CENTER>
          <TD COLSPAN=2 ALIGN=LEFT> 读/写 <B>逻辑值 LOGICAL</B>s </TD>
          <TD COLSPAN=2> <B>L<I>w</I></B> </TD>
     </TR>
     <TR ALIGN=CENTER>
          <TD COLSPAN=2 ALIGN=LEFT> 读/写 <B>字符/字符串 CHARACTER</B>s </TD>
          <TD> <B>A</B> </TD>
          <TD> <B>A<I>w</I></B> </TD>
     </TR>
     <TR ALIGN=CENTER>
          <TD ROWSPAN=3 ALIGN=LEFT> 对齐 </TD>
          <TD ALIGN=LEFT> 水平 </TD>
          <TD COLSPAN=2> <B><I>n</I>X</B> </TD>
     </TR>
     <TR ALIGN=CENTER>
          <TD ALIGN=LEFT> Tabbing </TD>
          <TD> <B>T<I>c</I></B> </TD>
          <TD> <B>TL<I>c</I></B> and <B>TR<I>c</I></B> </TD>
     </TR>
     <TR ALIGN=CENTER>
          <TD ALIGN=LEFT> 垂直 </TD>
          <TD COLSPAN=2> <B>/</B> </TD>
     </TR>
     <TR ALIGN=CENTER>
          <TD ROWSPAN=4 ALIGN=LEFT> 其他 </TD>
          <TD ALIGN=LEFT> Grouping </TD>
          <TD COLSPAN=2>  <B><I>r</I>(....)</B> </TD>
     </TR>
     <TR ALIGN=CENTER>
          <TD ALIGN=LEFT> Format Scanning Control </TD>
          <TD COLSPAN=2> <B>:</B> </TD>
     </TR>
     <TR ALIGN=CENTER>
          <TD ALIGN=LEFT> Sign Control </TD>
          <TD COLSPAN=2> <B>S</B>, <B>SP</B> and <B>SS</B> </TD>
     </TR>
     <TR ALIGN=CENTER>
          <TD ALIGN=LEFT> Blank Control </TD>
          <TD COLSPAN=2> <B>BN</B> and <B>BZ</B> </TD>
     </TR>
     <TR ALIGN=CENTER>
          <TD ALIGN=LEFT> <B>注</B> </TD>
          <TD COLSPAN=3> <B>w</B> - 宽度, <B>m</B> - 最小宽度 , <B>d</B> - 小数位数  , <B>e</B> - 指数位数</TD>
     </TR>
</TABLE>

```fortran
program format
  implicit none
  
  real :: array(10)
  character(len=6) :: text = 'String'
  
  print '(A3)', text ! 只能打印‘Str’
  print '(A6)', text ! 可以打印‘String’

  call random_number(array)
  ! 默认格式
  write(*,*) array
  
  ! 小数格式
  write(*,'(F5.3)') array
  
  ! 科学计数格式
  write(*,'(ES10.3)') array
  
end program format
```

---
## 十一. 文件读写

使用`open()`和`close()`函数来打开和关闭一个文件。首先，我们要给打开的文件指定一个编号，如`open(2,file='test.dat')`，这样我们就成功将文件绑定到编号2上。(程序运行时如果`test.dat`不存在，则程序会创建一个`test.dat`文件)。当我们完成读取或写入操作后，则使用`close(2)`来关闭程序对`test.dat`文件的读写权限。在读取文件数据时，我们用`read(2,*)`来依次读取数据(将`read(*,*)`的第一个`*`替换为文件编号)。同样的，在写入时我们用`write(2,*)`来依次写入数据。

> ⚠️ **_注意:_** 文件编号可以选择除了`5`和`6`之外的任何正整数，因为`5`和`6`分别指代了标准输出和输入

除了读写文本文件之外，我们还可以对二进制文件进行读写，只是在打开时要加上`form = unformatted`参数。

```fortran
program file
  implicit none

  real :: a(10), b(10)

  call random_number(a)

  open(99, file='data.dat')
  write(99, *) a
  close(99)

  open(99, file='data.dat')
  read(99, *) b
  close(99)

  print *, b

  open(100, file='data.bin', access='stream', form='unformatted')
  write(100) a
  close(100)

end program file
```

---
## 十二. 指针
Fortran中的指针可以指向变量和函数。在声明指针时，我们要加上`pointer`关键词，如`real, pointer :: p`。在声明被指向变量时，要加上`target`关键词，如`real, target :: a = 3.14`。在声明完成后，我们可以在主程序中用`=>`运算符对指针赋值。

指针也可以指向函数，如`procedure(functionName), pointer :: p_func`，这样`p_func`就创建了一个和`functionName`具有同样输入参数的函数指针。如果我们有多个函数且它们具有同样的输入参数(类型和数量)，则`p_func`就可以在主程序中指向任意一个函数。

指针还可以指向同一类型的指针，当指向一个指针时，当前指针会指向被指向指针所指向的目标。因此，当被指向指针改变之后，当前指针并不会跟随被指向指针改变其指向目标的地址。我们可以在下面的例子中具体看到。

```fortran
program pointerdemo
  implicit none

  integer, pointer :: p0
  integer, target :: i0 = 99, i1 = 1000

  real, pointer :: p1(:) ! 数组指针直接声明为可分配(变长)数组即可
  real, target :: r0(5) = (/ 1,2,3,4,5 /)

  procedure(f), pointer :: pf

  real, pointer :: p_r, pp_r
  real, target :: r1 = 1.5, r2 = 3.14

  ! 1. 简单的单一变量指针
  print *, "1. 简单的单一变量指针"
  print *, 'i0 = ', i0
  print *, 'i1 = ', i1
  p0 => i0
  p0 = 999 ! p0指向i0，修改p0的值，i0的值也会被修改
  print *, 'i0 = ', i0
  print *, 'i1 = ', i1
  print *, 'p0 = ', p0
  p0 => i1
  p0 = 10000 ! 此时p0指向i1，修改p0的值，i1的值也会被修改
  print *, 'i0 = ', i0
  print *, 'i1 = ', i1
  print *, 'p0 = ', p0
  print *

  ! 2. 数组指针
  print *, "2. 数组指针"
  print *, 'r0 = ', r0
  p1 => r0
  p1(1:3) = 0
  print *, 'r0 = ', r0 ! r0的前3个元素被赋值为0
  print *

  ! 3. 函数指针
  print *, "3. 函数指针"
  pf => f
  print *, 'pf(2) = ', pf(2.) ! 调用f(2.)
  pf => g
  print *, 'pf(2) = ', pf(2.) ! 调用g(2.)
  print *

  ! 4. 指针的指针
  print *, "4. 指针的指针"
  print *, 'r1 = ', r1
  print *, 'r2 = ', r2
  p_r => r1
  pp_r => p_r
  print *, 'p_r = ', p_r ! p_r指向r1
  print *, 'pp_r = ', pp_r ! pp_r指向r1
  p_r => r2
  print *, 'p_r = ', p_r ! p_r指向r2
  print *, 'pp_r = ', pp_r ! pp_r仍然指向r1
  print *

contains

  real function f(x)
    real, intent(in) :: x
    f = x**2
  end function f

  real function g(x)
    real, intent(in) :: x
    g = x**3
  end function g

end program pointerdemo
```

---
## 十三. 并行计算

Fortran中的并行计算/分布式计算有多种方式实现

1. MPI (Message-Passing-Interface) ([mpich.org](www.mpich.org), [open-mpi.org](www.open-mpi.org))
2. Coarray Fortran (GNU Fortran) ([opencoarrays.org/](http://www.opencoarrays.org/))
3. CUDA Fortran (GPUs parallel)

我们这里简单介绍一下MPI和Coarray的用法

### MPI
首先要能使用MPI来进行并行计算，需要先下载MPI - [open-mpi.org](https://www.open-mpi.org/)

创建一个名为`mpi_parallel.f90`的文件
```fortran
! mpi_parallel.f90
program mpi_parrallel
  use mpi ! 调用MPI模块
  implicit none

  integer :: ierr, num_processors, my_processor_id

  call MPI_INIT(ierr) ! 启动MPI
  call MPI_COMM_SIZE(MPI_COMM_WORLD, num_processors, ierr) ! 获取CPUs的数量
  call MPI_COMM_RANK(MPI_COMM_WORLD, my_processor_id, ierr) ! 获取当前工作的CPU编号

  print *, 'Hello from processor ', my_processor_id, ' of ', num_processors

  call MPI_FINALIZE(ierr) ! 终止MPI

end program mpi_parrallel
```

在编译时使用`mpifort`/`mpif90`/`mpif77`进行编译，其中，`mpifort`可以编译任意版本的fortran文件，`mpif90`和`mpif77`分别可以编译`.f90`和`.f77`的fortran文件。不过，`mpif90`和`mpif77`在以后的版本可能不再支持。
```shell
$ mpifort mpi_parallel.f90 -o mpi_parallel
```

在运行，必须使用`mpirun -n [number of cores]`来调用CPU。
```shell
$ mpirun -n 4 mpi_parallel 
 Hello from processor            0  of            4
 Hello from processor            1  of            4
 Hello from processor            2  of            4
 Hello from processor            3  of            4
```

### Coarray
使用Coarray首先要去[opencoarrays.org](http://www.opencoarrays.org/)下载Coarrays.

创建一个名为`coarray_parallel.f90`的文件
```fortran
program coarray_parrallel

  print *, 'Hello from processor ', this_image(), ' of ', num_images()

end program coarray_parrallel
```

和MPI类似，编译时使用`caf`，运行时使用`cafrun -n [number of cores]`

```shell
$ caf coarray_parallel.f90 -o coarray_parallel
$ cafrun -n 4 coarray_parallel
 Hello from processor            2  of            4
 Hello from processor            3  of            4
 Hello from processor            4  of            4
 Hello from processor            1  of            4
```

---
## 十四. 内置函数

Fortran中有相当多的内置函数，我在此列出一部分常用的函数供大家参考。
更加详细的清单请见[fortran-lang.org/zh_CN/learn/intrinsics/index](https://fortran-lang.org/zh_CN/learn/intrinsics/index)和[nsc.liu.se/~boein/f77to90/a5.html#section21](https://www.nsc.liu.se/~boein/f77to90/a5.html)

下面列表中的函数除非特别备注为子例程，否则都为函数类型。

### 数值

|函数名|说明|用法|
|:---:|:--:|:--:|
|`abs`|绝对值|`abs(-1.5)` $\rightarrow$ 1.5|
|`aint`|向0取整|`aint(-2.999)` $\rightarrow$ -2; `aint(2.999)` $\rightarrow$ 2|
|`anint`|四舍五入取整|`anint(-2.999)` $\rightarrow$ -3; `anint(2.4)` $\rightarrow$ 2|
|`ceiling`|向 $\infty$ 取整|`ceiling(-2.99)` $\rightarrow$ -2; `ceiling(2.4)` $\rightarrow$ 3|
|`floor`|向 $-\infty$ 取整|`floor(-2.99)` $\rightarrow$ -3; `floor(2.4)` $\rightarrow$ 2|
|`conjg`|取复数共轭|`conjg((1,2))` $\rightarrow$ (1,-2)|
|`max`|最大值|`max(1,2,3,4,5,6)` $\rightarrow$ 6|
|`min`|最小值|`min(1.0,2.0,3.0,4.0,5.0,6.0)` $\rightarrow$ 1.0|
|`mod`|取余|`mod(19,6)` $\rightarrow$ 1|
|`dot_product`|向量点乘|`dot_product([1,2],[3,3])` $\rightarrow$ 9|
|`matmul`|矩阵相乘|`C = matmul(A,B)`|

### 数学
|函数名|说明|用法|
|:---:|:--:|:--:|
|`sqrt`|平方根|`sqrt(2)` $\rightarrow$ $\sqrt{2}$|
|`exp`|指数|`exp(2)` $\rightarrow$ $e^{2}$|
|`log`|自然对数|`log(2)` $\rightarrow$ $ln(2)$|
|`log10`|底数为10的对数|`log10(2)` $\rightarrow$ $log_{10}(2)$|
|`sin`|正弦 sine|`sin(0)` $\rightarrow$ 0|
|`cos`|余弦 cosine|`cos(0)` $\rightarrow$ 1|
|`tan`|正切 tangent|`tan(0)` $\rightarrow$ 0|
|`asin`|反正弦 arcsin|`asin(theta)` $\rightarrow$ $arcsin(\theta) = sin^{-1}(\theta)$|
|`acos`|反余弦 arccos|`acos(theta)` $\rightarrow$ $arccos(\theta) = cos^{-1}(\theta)$|
|`atan`|反正切 arctan|`atan(theta)` $\rightarrow$ $arctan(\theta) = tan^{-1}(\theta)$|
|`sinh`|双曲正弦|`sinh(x)` $\rightarrow$ $sinh(x) = \dfrac{e^x - e^{-x}}{2}$|
|`cosh`|双曲余弦|`cosh(x)` $\rightarrow$ $cosh(x) = \dfrac{e^x + e^{-x}}{2}$|
|`tanh`|双曲正切|`tanh(x)` $\rightarrow$ $tanh(x) = \dfrac{e^x - e^{-x}}{e^x + e^{-x}}$|
|`random_number`(子例程)|生成 $U(0,1)$ 的随机数|`call random_number(harvest)` $\rightarrow$ harvest $\sim U(0,1)$|
|`bessel_j0`|第一类0阶贝塞尔函数 $J_0(x)$ (Bessel function of the first kind of order 0)|`bessel_j0(x)` $\rightarrow$ $J_0(x) = \sum_{m = 0}^{\infty} \dfrac{(-1)^m}{m!\Gamma(m+1)}\left( \dfrac{x}{2} \right)^{2m}$|
|`bessel_j1`|第一类1阶贝塞尔函数 $J_1(x)$ (Bessel function of the first kind of order 1)|`bessel_j1(x)` $\rightarrow$ $J_1(x) = \sum_{m = 0}^{\infty} \dfrac{(-1)^m}{m!\Gamma(m+2)}\left( \dfrac{x}{2} \right)^{2m+1}$|
|`bessel_jn`|第一类n阶贝塞尔函数 $J_n(x)$ (Bessel function of the first kind of order n)|`bessel_jn(n,x)` $\rightarrow$ $J_n(x) = \sum_{m = 0}^{\infty} \dfrac{(-1)^m}{m!\Gamma(m+n+1)}\left( \dfrac{x}{2} \right)^{2m+n}$ (注: `integer :: n`， n 为正整数)|
|`bessel_y0`|第二类0阶贝塞尔函数 $Y_0(x)$ (Bessel function of the second kind of order 0)|`bessel_y0(x)` $\rightarrow$ $Y_0(x) = \dfrac{J_0(x) - J_{-0}(x)}{sin(0)}$|
|`bessel_y1`|第二类1阶贝塞尔函数 $Y_1(x)$ (Bessel function of the second kind of order 1)|`bessel_y1(x)` $\rightarrow$ $Y_1(x) = \dfrac{J_1(x)cos(\pi) - J_{-1}(x)}{sin(\pi)}$ |
|`bessel_yn`|第二类n阶贝塞尔函数 $Y_n(x)$ (Bessel function of the second kind of order n)|`bessel_yn(n,x)` $\rightarrow$ $Y_n(x) = \dfrac{J_n(x)cos(n\pi) - J_{-n}(x)}{sin(n\pi)}$ (注: `integer :: n`， n 为整数)|
|`erf`|误差函数|`erf(x)` $\rightarrow$ $erf(x) = \dfrac{2}{\sqrt{\pi}} \int_{0}^{x}e^{-t^2}dt$ |
|`erfc`|互补误差函数| $erfc(x) = 1 - erf(x) = \dfrac{2}{\sqrt{\pi}} \int_{x}^{\infty}e^{-t^2}dt$ |
|`erfc_scaled`|指数放缩误差函数|`erfc_scaled(x)` $\rightarrow$ $erfcx(x) = e^{x^2}erfc(x) = e^{x^2} \dfrac{2}{\sqrt{\pi}} \int_{x}^{\infty}e^{-t^2}dt$|
|`gamma`| $\Gamma$ 函数|`gamma(x)` $\rightarrow$ $\Gamma(x) = (x-1)!$|
|`norm2`|2-范数|`norm2(x)` $\rightarrow$ `sqrt(sum(x**2))` $\rightarrow$ $\lVert x \rVert _2$|

### 数组
|函数名|说明|
|:---:|:--:|
|`ALL(MASK, [dim])`| 逻辑数组MASK在dim维度与门|
|`ANY(MASK, [dim])`| 逻辑数组MASK在dim维度或门|
|`COUNT(MASK, [dim])`| 逻辑数组MASK在dim维度上真的个数|
|`PRODUCT(ARRAY, [[dim], [mask]])`|数组元素积|
|`SUM(ARRAY, [[dim], [mask]])`|数组元素和|
|`SIZE(ARRAY, dim)`| 数组dim维度元素个数|
|`RESHAPE(SOURCE, SHAPE)`|数组重构|


---
## 十五. Makefile管理项目
在使用`make`之前，我们需要去[https://www.gnu.org/software/make/](https://www.gnu.org/software/make/)网站下载make。下载好之后，我们就可以通过编写`Makefile`文件来管理项目了。

在[Makefile编译](./Makefile%E7%BC%96%E8%AF%91/)文件夹中是我写好的一个计算**对流-扩散方程**的小型项目。项目结构如下所示

```bash
Makefile编译
├── FD_SCHEME.f90
├── FINITE_DERIVATIVE.f90
├── ADVECTION_DIFFUSION.f90
├── POISSON_SOLVER.f90
├── CONVECTION_DIFFUSION.f90
├── convection_diffusion_main.f90
└── Makefile
```

接着我们创建一个`Makefile`文件，在其中写入如下所示的编译规则。

```Makefile
# Disable all of make's built-in rules (similar to Fortran's implicit none)
MAKEFLAGS += --no-builtin-rules --no-builtin-variables

# configuration
FC := gfortran
LD := $(FC)
AR := ar -r
# RM := rm -f

# list of all source files
SRCS := FINITE_DERIVATIVE.f90 FD_SCHEME.f90 POISSON_SOLVER.f90 ADVECTION_DIFFUSION.f90 CONVECTION_DIFFUSION.f90
OBJS := FINITE_DERIVATIVE.o FD_SCHEME.o POISSON_SOLVER.o ADVECTION_DIFFUSION.o CONVECTION_DIFFUSION.o
LIBR := libCODF.a

PROG := convection_diffusion_main.f90
EXEC := co_df

# command line arguments
CMLA := test

.PHONY: all test run clean
all: $(EXEC)

$(EXEC): $(LIBR)
	$(LD) -o $@ $(PROG) $^

$(LIBR): $(OBJS)
	$(AR) $@ $^

$(OBJS):
	$(FC) -c $(SRCS)

# define dependencies between object files
ADVECTION_DIFFUSION.o: FINITE_DERIVATIVE.o FD_SCHEME.o

# rebuild all object files in case this Makefile changes
# $(OBJS): $(MAKEFILE_LIST)

test:
	for idx in 1 2 3 4 5; do \
		./$(EXEC) $(addsuffix .dat, $(addsuffix $$idx, $(CMLA))); \
	done

run:
	./$(EXEC) Prandtl.dat
#	./$(EXEC) Prandtl_EMPTY.dat

clean:
	$(RM) $(filter %.o, $(OBJS)) $(wildcard *.mod) $(EXEC) $(LIBR) $(wildcard *.bin)
```

要运行定义好的分支的话，就在命令行中输入`make`后面加上分支名。

- `all`分支
```bash
make
```
或
```bash
make all
```
> **注：** 在命令行中输入`make`时，make可执行文件会自动搜寻当前文件夹下的`Makefile`文件，并运行其中的`all`分支。
 
- `run`分支
```bash
make run
```

- `test`分支
```bash
make test
```

- `clean`分支
```bash
make clean
```