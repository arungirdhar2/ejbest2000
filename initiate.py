import unittest
import data as d
import sendEmail
from fabric import Connection
import sys


class CommandTests(unittest.TestCase):
    processes = []
    server = d.server
    username = d.username
    password = d.password
    command = d.command
    msg = ""

    def tearDown(self):
        for p in self.processes:
            if p.poll() is None:
                p.terminate()

    def test_if_top_command_is_running(self):
        """
        :return:
        """
        try:
            print('server', self.server)
            print('username', self.username)
            print('password', self.password)
            c = Connection(self.server, user=d.username, connect_timeout=600, connect_kwargs={'password': self.password})
            res = c.run(self.command)
            verify = c.run("echo $?")
            print(str(verify)+"---")
            self.assertEqual(verify.stdout.strip(), "0")
            self.msg = str(res.stdout)
        except Exception as e:
            self.msg=str(e.result)

        finally:
            c.close()
            sendEmail.main("From Initiate : ", str(self.msg))


if __name__ == '__main__':
    if len(sys.argv) > 1:
        CommandTests.server = sys.argv.pop()
        CommandTests.password = sys.argv.pop()
        CommandTests.username = sys.argv.pop()
        CommandTests.command = sys.argv.pop()
    unittest.main()
