# ex_jsch
Example code using the java jsch library to copy a file using sftp

It's an example of using the Java Bridge feature of Genero.

# Prerequisites
This example requires the jsch jar file from http://www.jcraft.com/jsch/

I tested with jsch-0.1.55.jar and the project and make file assume this exists in the project folder.

This example was written and tested using Genero 4.00 but should also work in Genero 3.20

# Args
The example is using four command line args:
* host ( host to connect to - default in makefile and 4pw is 'localhost' )
* user ( username to connect as - default in makefile and 4pw is 'neilm' )
* directory ( target directory to put the file - default in makefile and 4pw is 'tmp' )
* file ( file to copy - default makefile and 4pw is 'test.txt' )

