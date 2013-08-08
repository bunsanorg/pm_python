from distutils.core import setup
from distutils.extension import Extension
from Cython.Distutils import build_ext

from os.path import join

cfg = {
    'libraries': ['bunsan_pm_compatibility'],
    'extra_compile_args': ['-std=c99']
}

ext_modules = [
    Extension('pm', [join('src', 'bunsan', 'pm.pyx')], **cfg)
]

setup(
    name = 'bunsan::pm',
    version = '0.0',
    description = 'bunsan::pm python wrapper',
    author = 'Aleksey Filippov',
    author_email = 'sarum9in@gmail.com',
    url = '',
    cmdclass = {'build_ext': build_ext},
    ext_package = 'bunsan',
    ext_modules = ext_modules
)
