makefile-heaven
===============

a rapid makefile configuration utility


This set of files lets the user to quickly setup a makefile based project. The goal is to have a quick way to start a project but still have a human-readable makefile in the end.

For this purpose we separate a standard makefile in to 3 separate files:


makefile                  : a very simple file which contains project and author information + some true/false flags to 
                            set project options.
static-variables.makefile : generates variables that will be used in the rules.
flags.makefile            : expands true/false flags entered in the simple 'makefile' and generates actual flags that 
                            will be passed to the compiler.
rules.makefile            : contains all the rules that you may want to do in a project.





