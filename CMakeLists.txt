cmake_minimum_required(VERSION 3.6.2)

project ( cross )

set(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)

include ( 3rdParty )
include ( Doxygen )

include_directories( ${CMAKE_BINARY_DIR}/3rd-party/include )


set ( SOURCES
    main.c
    )

add_executable ( cross ${SOURCES} )

add_executable ( cross-test test.cpp )

