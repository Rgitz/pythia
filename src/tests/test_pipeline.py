from src.pipelines import master_pipeline
import subprocess
import os

'''
TEST FROM SRC
'''
class test_master_pipeline():
    def test_no_directory():
        print(os.getcwd())
        os.chdir('pipelines')
        dir_ = os.getcwd()
        file_ = os.path.join(dir_, "master_pipeline.py")
        result = subprocess.run([file_])
        assert result.returncode == 2

    def test_no_features():
        dir_ = os.getcwd()
        file_ = os.path.join(dir_, "master_pipeline.py")
        result = subprocess.run([file_, "dir"])
        assert result.returncode == 1

    def test_no_algorithms():
        dir_ = os.getcwd()
        file_ = os.path.join(dir_, "master_pipeline.py")
        result = subprocess.run([file_, "dir", "-c"])
        assert result.returncode == 3

    def test_successful_run():
        dir_ = os.getcwd()
        file_ = os.path.join(dir_, "master_pipeline.py")
        result = subprocess.run([file_, "dir", "-c", "-s"])
        assert result.returncode == 0