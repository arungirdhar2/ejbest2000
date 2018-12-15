import unittest
import data as d
import sendEmail
from fabric import Connection


class CommandTests(unittest.TestCase):
    processes = []
    msg =""
    def tearDown(self):
        for p in self.processes:
            if p.poll() is None:
                p.terminate()

    def test_if_top_command_is_running(self):
        """
        :return:
        """
        try:
            c = Connection(d.server, user=d.username, connect_timeout=600, connect_kwargs={'password': d.password})
            res = c.run(d.command)
            verify = c.run("echo $?")
            print(str(verify)+"---")
            self.assertEqual(verify.stdout.strip(), "0")
            msg = str(res.stdout)
        except Exception as e:
            msg=str(e.result)
        finally:
            c.close()
            sendEmail.main("From Initiate : ",str(msg))


if __name__ == '__main__':
    unittest.main()
