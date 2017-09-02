cmake_minimum_required(VERSION 3.6.2)

project ( cross )

set(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)
option(EXTRA "Build extra features for desktop. e.g. catch test, Doxygen" OFF)

include ( 3rdParty )

if ( EXTRA )
    include ( Doxygen )
endif()

include_directories( ${CMAKE_BINARY_DIR}/3rd-party/include )

add_executable ( cmain c_main.c )

add_executable( cppmain cpp_main.cpp)

if ( EXTRA )
    add_executable ( cross-test test.cpp )

    set_target_properties(cross-test PROPERTIES
        COMPILE_FLAGS -Wno-psabi
        )
endif()


