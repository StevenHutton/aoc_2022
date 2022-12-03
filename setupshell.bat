@echo off

d:

cd projects\jai\aoc_2022

git pull

start /max c:\4coder\4ed.exe
start /max C:\remedybg\remedybg.exe open-session "aoc_2022.rdbg"

call build.bat