Please install the following packages on the host system.
- ninja-build
- gcc-arm-linux-gnueabihf
- g++-arm-linux-gnueabihf
- binutils-arm-linux-gnueabihf

If Desktop Compile CMake from source for newest verios.
The newest version is required for integrated doxygen support.
Otherwise install with package manager.

# TODO may need to get older version of cross compiler files to be compatible with the Beagle Bone

Use the populate.sh script to generate the build files for the project.
Ninja build files are generated to build the source.
Ninja is similar to make but better.

- Generate all build targets with extras
    - ./populate.sh -e
- Generate only native targets without extras
    - ./populate.sh -n
- Generate only crosss targets without extras.
i   - ./populate.sh -a
- Build all targets
i   - ./populate.sh -b
