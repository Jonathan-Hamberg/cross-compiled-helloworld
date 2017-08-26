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
    exit 0
fi

# Configure the cmake build generator options.
GENERATOR="-GNinja"

# Configure the release build options.
RELEASE="-DCMAKE_BUILD_TYPE=Release"

# Configure the cross compilation options.
CROSS_ARGS=""

# Generate the build files.
if [ $CLEAN ] ; then
    echo "Deleting the build/ directory"

    # Remove the build files.
    rm -rf build/
else
    # Create the debug build directories.
    mkdir -p build/debug

    if [ $CROSS ] ; then
        mkdir -p build/cross-debug
    fi

    if [ ! -f build/debug/build.ninja ] ; then
        cmake -H. -Bbuild/debug $GENERATOR
    fi

    if [ ! -f build/cross-debug/build.ninja ] ; then
        cmake -H. -Bbuild/cross-debug $GENERATOR $CROSS_ARGS
    fi

    if [[ $FAST -ne 1 ]] ; then
        # Create the release build directories.
        mkdir -p build/release
        mkdir -p build/cross-release

        if [ ! -f "build/release/build.ninja" ] ; then
            cmake -H. -Bbuild/release $GENERATOR $RELEASE
        fi

        if [ ! -f "build/cross-release/build.ninja" ] ; then
            cmake -H. -Bbuild/cross-release $GENERATOR $CROSS_ARGS $RELEASE
        fi
    fi
fi

# Build the code.
if [ $BUILD ] ; then
    echo "Building build/debug"
    cmake --build build/debug

    echo "Building build/release"
    cmake --build build/release

    echo "Building build/cross-debug"
    cmake --build build/cross-debug

    echo "Building build/cross-release"
    cmake --build build/cross-release
fi
