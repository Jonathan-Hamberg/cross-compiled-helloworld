Please install the following packages on the host system.
- ninja-build
- gcc-arm-linux-gnueabihf
- g++-arm-linux-gnueabihf
- binutils-arm-linux-gnueabihf

Requirements
- apt install ninja-build gcc-arm-linux-gnueabihf g++-arm-linux-gnueabihf binutils-arm-linux-gnueabihf
- Install latest version of cmake from sounce for Doxygen support.
- Cross compile libstdc++ using the same version as the gcc cross compiler.

If Desktop Compile CMake from source for newest version.
The newest version is required for integrated doxygen support.
Otherwise install with package manager.


Use the populate.sh script to generate the build files for the project.
Ninja build files are generated to build the source.
Ninja is similar to make but better.

- Generate all build targets with extras
    - ./populate.sh -e
- Generate only native targets without extras
    - ./populate.sh -n
- Generate only crosss targets without extras.
    - ./populate.sh -a
- Build all targets
    - ./populate.sh -b


# Cross Platform Toolchain Instructions
In order to sucessfully compile unit tests the libstdc++ must be compiled from the source.

Download the version of gcc that is the same as the cross compiler gcc version. https://gcc.gnu.org/mirrors.html
The gcc download contains the libstdc++ library.

tar -xvf filename.tar.xz
cd filename
mkdir build && cd build
../libstdc++-v3/configure --host=arm-linux-gnueabihf --prefix=/tools --disable-multilib --disable-nls --disable-libstdcxx-threads --disable-libstdcxx-pch
make
cd src/.libs
scp libstdc++.so** hostname:/usr/arm-linux-gnueabihf/lib

The runtime path of the compiled executable will point to the folder above.
