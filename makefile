# Automatic Makefile made by make4js by N.J.M.

CLASSPATH=.:./jsch-0.1.55.jar
fgl_obj1 =  \
	 ex_jsch.$(4GLOBJ)

fgl_frm1 = 

#depend::
#	echo "making depends";  cd lib ; ./link_lib

ARG1=localhost
ARG2=neilm
ARG3=tmp
ARG4=test.txt
PRG1=ex_jsch.42r

EXTRA_TARGETS=testjsch.class 

include ./Make_fjs.inc

runj: testjsch.class
	java testjsch
