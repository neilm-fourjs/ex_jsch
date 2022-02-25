-- A Java Bridge example using the JSch library to sftp a file
--
-- The defaults in the makefile and project mean this code is effectively just doing:
-- RUN "scp test.txt localhost:tmp/"

IMPORT os

IMPORT JAVA com.jcraft.jsch.JSch
IMPORT JAVA com.jcraft.jsch.Session
IMPORT JAVA com.jcraft.jsch.ChannelSftp

CONSTANT C_OVERWRITE = 0
CONSTANT C_RESUME    = 1
CONSTANT C_APPEND    = 2

MAIN
	DEFINE l_sess   Session
	DEFINE l_ssh    JSch
	DEFINE l_chan   ChannelSftp
	DEFINE l_user   STRING
	DEFINE l_dir    STRING
	DEFINE l_file   STRING
	DEFINE l_hostIp STRING
	DEFINE l_port   INTEGER

	LET l_hostIp = base.Application.getArgument(1)
	LET l_user   = base.Application.getArgument(2)
	LET l_port   = 22
	LET l_dir    = base.Application.getArgument(3)
	LET l_file   = base.Application.getArgument(4)

	IF NOT os.Path.exists(l_file) THEN
		DISPLAY SFMT("Local file %1 doesn't exist!", l_file)
		EXIT PROGRAM -1
	END IF

	LET l_ssh = com.jcraft.jsch.JSch.create() -- instantiate the JSch object
	CALL l_ssh.addIdentity("~/.ssh/id_rsa");  -- I'm using ssh keys rather than a password.
	CALL l_ssh.getSession(l_user, l_hostIp, l_port) RETURNING l_sess

	CALL l_sess.setConfig("StrictHostKeyChecking", "no") -- probably not needed.
	TRY
		DISPLAY SFMT("Connect to %1 as user %2 ...", l_hostIp, l_user)
		CALL l_sess.connect()
	CATCH
		DISPLAY SFMT("Connect failed to %1 as user %2, Status %3", l_hostIp, l_user, STATUS)
		EXIT PROGRAM -1
	END TRY

	DISPLAY "Open fstp"
	LET l_chan = CAST(l_sess.openChannel("sftp") AS ChannelSftp)
	CALL l_chan.connect()
	IF l_chan.isConnected() THEN
		TRY
			DISPLAY SFMT("Change remote directory to '%1'", l_dir)
			CALL l_chan.cd(l_dir)
		CATCH
			DISPLAY SFMT("Failed to 'cd %1'", l_dir)
			EXIT PROGRAM -1
		END TRY
	ELSE
		DISPLAY "not connected"
		EXIT PROGRAM -1
	END IF

	DISPLAY "Local PWD: ", l_chan.lpwd(), " Remote PWD: ", l_chan.pwd()
	TRY
		DISPLAY SFMT("Put %1 to remote %2/%3 ...", l_file, l_dir, l_file)
		CALL l_chan.put(l_file, l_file, C_OVERWRITE)
	CATCH
		DISPLAY "Failed! ", STATUS
		EXIT PROGRAM -1
	END TRY
	DISPLAY "Done."

END MAIN
