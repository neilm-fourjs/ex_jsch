
import com.jcraft.jsch.*;

public class testjsch {

	public static void main(String[] args) {
		try {
			JSch l_ssh = new JSch();
			System.out.println("Load SSH key");
			l_ssh.addIdentity("~/.ssh/id_rsa");
			System.out.println("getSession");
			Session l_sess = l_ssh.getSession("neilm","localhost",22);
			l_sess.setConfig("StrictHostKeyChecking", "no");
			System.out.println("Connect the session");
			l_sess.connect();
			System.out.println("openChannel");
			ChannelSftp l_chan = (ChannelSftp) l_sess.openChannel("sftp");
			System.out.println("Connect");
			l_chan.connect();
			if ( ! l_chan.isConnected() ) {
				System.out.println("Not Connected");
				System.exit(-1);
			}
			System.out.println("Change Directory");
			l_chan.cd("tmp");
			System.out.println("Put main.42m to remote tmp/ ...");
			l_chan.put("main.42m", "main.42m");
		} catch (Exception e) {
			e.printStackTrace();
			System.exit(-1);
		}
		System.out.println("Finished.");
		System.exit(0);
	}
	
}
