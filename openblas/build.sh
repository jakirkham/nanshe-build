# Depending on our platform, shared libraries end with either .so or .dylib
if [[ `uname` == 'Darwin' ]]; then
    DYLIB_EXT=dylib
else
    DYLIB_EXT=so
fi

if [[ `uname` == 'Darwin' ]]; then
    CXXFLAGS="${CXXFLAGS} -stdlib=libc++"
    CXX_LDFLAGS="${LDFLAGS} -stdlib=libc++"
else
    CXXFLAGS="${CXXFLAGS}"
    CXX_LDFLAGS="${LDFLAGS}"
fi

make DYNAMIC_ARCH=1 BINARY=${ARCH} NO_LAPACK=0 NO_AFFINITY=1 NUM_THREADS=1 -j${CPU_COUNT}
make install PREFIX=$PREFIX

ln -fs $PREFIX/lib/libopenblas.a $PREFIX/lib/libblas.a
ln -fs $PREFIX/lib/libopenblas.a $PREFIX/lib/liblapack.a

ln -fs $PREFIX/lib/libopenblas.$DYLIB_EXT $PREFIX/lib/libblas.$DYLIB_EXT
ln -fs $PREFIX/lib/libopenblas.$DYLIB_EXT $PREFIX/lib/liblapack.$DYLIB_EXT
