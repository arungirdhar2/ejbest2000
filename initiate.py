import unittest
import data as d
import sendEmail
from fabric import Connection

class CommandTests(unittest.TestCase):
    processes = []

    def tearDown(self):
        for p in self.processes:
            if p.poll() is None:
                p.terminate()

    def test_if_top_command_is_running(self):
        """
        :return:
        """
        c = Connection(d.server, user=d.username, connect_timeout=600, connect_kwargs={'password': d.password})
        result = c.run(d.command)
        print(result)
        #self.assertEqual(result.stdout.strip(), d.verification)
        c.close()
        sendEmail.main("From Initiate : ",str(result))


if __name__ == '__main__':
    unittest.main()
