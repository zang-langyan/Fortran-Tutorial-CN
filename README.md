# Fortran 基础

本教程参考了包括但不限于以下网站的内容
1. https://fortran-lang.org/
2. https://www.fortran90.org/
3. https://www.nsc.liu.se/~boein/f77to90/f77to90.html#index
4. https://gcc.gnu.org/onlinedocs/gcc-4.2.4/gfortran/index.html#Top

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

此处介绍最基本的用法，详细的用法将在格式和读写文件章节中介绍

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
