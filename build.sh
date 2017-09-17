#!/bin/bash
for i in "$@"
do
case $i in
    -h|--help)
    HELP=1
    ;;
    -c|--clean)
    CLEAN=1
    ;;
    -f|--fast)
    FAST=1
    ;;
    -b|--build)
    BUILD=1
    ;;
    -a|--arm)
    ARM=1
    ;;
    -n|--native)
    NATIVE=1
    ;;
    -e|--extra)
    EXTRA=1
    ;;
    *)
    echo "populate.sh: unrecognized option '$1'"
    echo "Try 'populate.sh --help' for more information"
    ;;
esac
done

# Print the help documentation.
if [ $HELP ] ; then
    echo "This script generates the build files for the project."
    echo "The build system is configured for local and cross compile targets."
    echo "Build files are located in the build/ directory."
    echo "  -h|--help   Prints this help command."
    echo "  -c|--clean  Deletes the build directory."
    echo "  -f|--fast   Only generates debug build files and not release build files."
    echo "  -b|--build  Builds the source code."
    echo "  -a|--arm    Builds the cross compilation arm targets."
    echo "  -n|--native Build the native targets."
    echo "  -e|--extra  Include extra features supported by the desktop.  e.g. catch, doxygen"
    exit 0
fi

# Configure the cmake build generator options.
GENERATOR="-GNinja -DCMAKE_EXPORT_COMPILE_COMMANDS=ON"

if [ $EXTRA ] ; then
    GENERATOR=$GENERATOR" -DEXTRA=ON"
fi

# Configure the release build options.
RELEASE="-DCMAKE_BUILD_TYPE=Release"

# Configure the cross compilation options.
CROSS_ARGS="-DCMAKE_TOOLCHAIN_FILE=cmake/arm-gcc-toolchain.cmake -DCROSS_COMPILE=ON"

# If neither native or arm specified generate both.
if [ ! $NATIVE ] && [ ! $ARM ] && [ ! $BUILD ] ; then
    NATIVE=1
    ARM=1
fi

# Generate the build files.
if [ $CLEAN ] ; then
    echo "Deleting the build/ directory"

    # Remove the build files.
    rm -rf build/
else

    # Create the debug native files.
    if [ $NATIVE ] ; then
        mkdir -p build/debug

        if [ ! -f build/debug/build.ninja ] ; then
            cmake -H. -Bbuild/debug $GENERATOR $EXTRA_ARGS
            ninja -C build/debug 3rd-party
        fi
    fi

    # Generate the debug arm files.
    if [ $ARM ] ; then
        mkdir -p build/arm-debug

        if [ ! -f build/arm-debug/build.ninja ] ; then
            cmake -H. -Bbuild/arm-debug $GENERATOR $CROSS_ARGS
            ninja -C build/arm-debug 3rd-party
        fi
    fi

    if [[ $FAST -ne 1 ]] ; then

        # Generate the release native build files.
        if [ $NATIVE ] ; then
            mkdir -p build/release

            if [ ! -f "build/release/build.ninja" ] ; then
                cmake -H. -Bbuild/release $GENERATOR $RELEASE $EXTRA_ARGS
                ninja -C build/release 3rd-party
            fi
        fi

        # Generate the release arm build files.
        if [ $ARM ] ; then
            mkdir -p build/arm-release

            if [ ! -f "build/arm-release/build.ninja" ] && [ $ARM ] ; then
                cmake -H. -Bbuild/arm-release $GENERATOR $CROSS_ARGS $RELEASE
                ninja -C build/arm-release 3rd-party
            fi
        fi
    fi
fi

# Build the code.
if [ $BUILD ] ; then

    if [ -d build/debug ] ; then
        echo "Building build/debug"
        cmake --build build/debug
    fi

    if [ -d build/release ] ; then
        echo "Building build/release"
        cmake --build build/release
    fi

    if [ -d build/arm-debug ] ; then
        echo "Building build/arm-debug"
        cmake --build build/arm-debug
    fi

    if [ -d build/arm-release ] ; then
        echo "Building build/arm-release"
        cmake --build build/arm-release
    fi
fi
