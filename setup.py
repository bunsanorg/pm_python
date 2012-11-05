from distutils.core import setup
from distutils.extension import Extension
from Cython.Build import cythonize

from os.path import join

setup(
    name = 'bunsan::pm',
    version = '0.0',
    description = 'bunsan::pm python wrapper',
    author = 'Aleksey Filippov',
    author_email = 'sarum9in@gmail.com',
    url = 'https://github.com/sarum9in/bunsan_pm_python',
    ext_package = 'bunsan',
    ext_modules = cythonize('src/bunsan/pm.pyx')
)
