import unittest
from health_utils import calculate_bmr

class TestHealthUtils(unittest.TestCase):
    def test_calculate_bmr_male(self):
        self.assertAlmostEqual(calculate_bmr(175, 70, 25, 'male'), 1724.05, places=1)

    def test_calculate_bmr_female(self):
        self.assertAlmostEqual(calculate_bmr(175, 70, 25, 'female'), 1528.78, places=1)

if __name__ == '__main__':
    unittest.main()
