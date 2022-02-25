# ex_jsch
Example code using the java jsch library to copy a file using sftp

# Prerequisite
This example requires the jsch jar file from http://www.jcraft.com/jsch/

I tested with jsch-0.1.55.jar and the project and make file assume this exists in the project folder.

# Args
The example is using four command line args:
* host ( host to connect to - default in makefile and 4pw is 'localhost' )
* user ( username to connect as - default in makefile and 4pw is 'neilm' )
* directory ( target directory to put the file - default in makefile and 4pw is 'tmp' )
* file ( file to copy - default makefile and 4pw is 'test.txt' )

