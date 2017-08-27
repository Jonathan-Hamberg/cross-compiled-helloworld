cmake_minimum_required(VERSION 3.6.2)

project ( cross )

set ( SOURCES
    main.cpp
    )

add_executable ( cross ${SOURCES} )

# Documentation.

find_package(Doxygen)

if ( ${DOXYGEN_FOUND} )

    set(DOXYGEN_GENERATE_HTML YES)
    set(DOXYGEN_GENERATE_MAN NO)
    set(DOXYGEN_GENERATE_LATEX NO)
    set(DOXYGEN_JAVADOC_AUTOBRIEF YES)
    set(DOXYGEN_EXTRACT_ALL YES)

    doxygen_add_docs(
        doxygen
        ${CMAKE_SOURCE_DIR}
        )
else()
    message ( "Doxygen executable was not found. Please install Doxygen to create the documentation." )
endif()
