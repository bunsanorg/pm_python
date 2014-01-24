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
        repository(string config) nogil except +
        void create(string path, bool strip) nogil except +
        void extract(string package, string path) nogil except +
        void clean_cache() nogil except +

cdef extern from "bunsan/pm/compatibility/repository.hpp" namespace "bunsan::pm::compatibility::repository":
    void initialize_cache(string path) nogil except +


cdef class Repository(object):

    cdef repository *thisptr

    def __cinit__(self, str config):
        cdef string config_ = _encode(config)
        with nogil:
            self.thisptr = new repository(config_)

    def __dealloc__(self):
        with nogil:
            del self.thisptr

    def create(self, str path, bool strip=False):
        cdef string path_ = _encode(path)
        with nogil:
            self.thisptr.create(path_, strip)

    def extract(self, str package, str path):
        cdef string package_ = _encode(package)
        cdef string path_ = _encode(path)
        with nogil:
            self.thisptr.extract(package_, path_)

    @staticmethod
    def initialize_cache(str config):
        cdef string config_ = _encode(config)
        with nogil:
            initialize_cache(config_)

    def clean_cache(self):
        with nogil:
            self.thisptr.clean_cache()
