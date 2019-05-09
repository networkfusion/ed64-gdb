set PATH=%PATH%;%~dp0toolchain\gcc-toolchain-mips64-win64\bin\
@echo off

cd src

md bin
md obj

IF %1.==. (
  echo. "no parameter"
  make
) ELSE (
  echo. "parameter: %1"
  make %1
)

cd..

:pause