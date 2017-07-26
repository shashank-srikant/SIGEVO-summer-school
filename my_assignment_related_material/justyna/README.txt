# The scripts are based on:
# bowtie2gp_1_2.tar.gz written by Willam B. Langdon
# These are available from: http://www0.cs.ucl.ac.uk/staff/ucacbbl/ftp/gp-code/bowtie2gp/gp_sources

General Directory Structure
---------------------------

minisatCIT directory contains scripts used in the following work:
Using Genetic Improvement and Code Transplants to Specialise a C++ Program to a Problem Class. EuroGP 2014: 137-149
by Justyna Petke, Mark Harman, William B. Langdon, Westley Weimer

minisat-2.2.0-gi directory contains scripts that can be used for running the latest version of MiniSAT (http://minisat.se/MiniSat.html)

Testcases
---------

All testcases come from the combinatorial interaction testing domain.

When running GI, remmebr to divide the test cases into the training and testing sets.


Prerequisites
-------------

The GI framework consists of several shell scripts. You need to install gawk to run these (https://www.gnu.org/software/gawk/).

The GI frameworkis were tested on Ubuntu 16.04 with g++ version 5 compiler and CentOS Linux release 7 with gcc (GCC) 4.8.5.

The GI framework in minisat-2.2.0-gi was additionally tested on macOS Sierra with clang version 8.


Run
---

for both minisatCIT and minisat-2.2.0-gi:

first run 'make' in sources/simp

add testcases to 'testcases' directory

in order to run the framwork simply invoke RE_gp.bat:

./RE_gp.bat <seed> <population> <generations> <cpu>

for example: ./RE_gp.bat 1 6 1 1

where:

seed: random seed

population: size of each population

generations: number of generations

cpu: cpu number n taken from sources_n (could be used for multiple concurrent GI runs), you should keep it as 1, as the files modified are in sources_1


Outputs
_______

throughout the GI run the Solver_GP.C (in minisatCIT) or Solver.cc (in minisat-2.2.0-gi)  files are modified in sources_1/core/

output files are saved in sources_1 and start with "pop":

pop.000 -> initial generation

pop.xxx_0.fit5 -> output of minisat for the original code in generation xxx

pop.xxx_y.fit5 -> output of minisat for the individual y in generation xxx

pop.000_select -> individuals selected for reproduction for the next generation


Useful Info
-----------

in order to generate a particular individual, go to the sources_1 directory and run:

gawk -f ../syntax.awk -v "individual=$ind" ../Solver.bnf_GP $gen ../Solver.bnf_GP

for example:
gawk -f ../syntax.awk -v "individual=1" ../Solver.bnf_GP pop.000 ../Solver.bnf_GP

in order to run the created individual go to sources_1/simp/ and run 'make'

in order to check it's fitness

gawk -f select.awk sources_1/$gen sources_1/$gen\_0.fit5 sources_1/$gen\_$ind.fit5)

for example:
gawk -f select.awk sources_1/pop.000 sources_1/pop.000_0.fit5 sources_1/pop.000_1.fit5

note that select.awk deletes individuals with fitness less than 1200 (each test case gets 240 if it returns the same result as the original)
