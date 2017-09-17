cmake_minimum_required(VERSION 3.6.2)

project ( cross )

set(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)
option(EXTRA "Build extra features for desktop. e.g. catch test, Doxygen" OFF)
option(CROSS_COMPILE "Cross compiling the code." OFF)

include ( 3rdParty )

if ( EXTRA )
    include ( Doxygen )
endif()

include_directories( ${CMAKE_BINARY_DIR}/3rd-party/include )

add_executable ( cmain c_main.c )

add_executable( cppmain cpp_main.cpp)

set(CMAKE_INSTALL_PREFIX "${CMAKE_BINARY_DIR}")

install(TARGETS cmain cppmain
    RUNTIME DESTINATION bin
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib/stati
    )

if ( CROSS_COMPILE )
        set(CMAKE_SKIP_BUILD_RPATH false)
        set(CMAKE_BUILD_WITH_INSTALL_RPATH false)
        set(CMAKE_INSTALL_RPATH "/usr/arm-linux-gnueabihf/lib")
        set(CMAKE_INSTALL_RPATH_USE_LINK_PATH false)

        set_target_properties(cmain cppmain
        PROPERTIES INSTALL_RPATH "/usr/arm-linux-gnueabihf/lib"
        )
endif()

if ( EXTRA )
    add_executable ( cross-test test.cpp )

    install(TARGETS cross-test
        DESTINATION bin
        )

    set_target_properties(cross-test PROPERTIES
        COMPILE_FLAGS -Wno-psabi
        )
endif()


