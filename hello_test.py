import hello
import unittest

class HelloTestCase(unittest.TestCase):
    def test_hello(self):
        hello_response = hello.hello()
        self.assertEqual(hello.hello(), 'Hello World!')


if __name__ == '__main__':
    unittest.main()
