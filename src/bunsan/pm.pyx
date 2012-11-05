# distutils: language = c++
# distutils: libraries = bunsan_pm_compatibility
# distutils: extra_compile_args = -std=c++11


import locale

from libcpp cimport bool
from libcpp.string cimport string


cdef str _getlocale():
    return locale.getlocale()[1]

cdef bytes _encode(str s):
    return s.encode(_getlocale())

cdef str _decode(bytes s):
    return s.decode(_getlocale())


cdef extern from "bunsan/pm/compatibility/repository.hpp" namespace "bunsan::pm::compatibility":
    cdef cppclass repository:
        repository(string config) except +
        void create(string path, bool strip) except +
        void extract(string package, string path) except +
        void clean() except +


cdef class Repository(object):

    cdef repository *thisptr

    def __cinit__(self, config):
        cdef string config_ = _encode(config)
        self.thisptr = new repository(config_)

    def __dealloc__(self):
        del self.thisptr

    def create(self, path, strip=False):
        cdef string path_ = _encode(path)
        self.thisptr.create(path_, strip)

    def extract(self, package, path):
        cdef string package_ = _encode(package)
        cdef string path_ = _encode(path)
        self.thisptr.extract(package_, path_)

    def clean(self):
        self.thisptr.clean()
