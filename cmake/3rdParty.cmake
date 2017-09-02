include( ExternalProject )

add_custom_target(3rd-party)

if ( EXTRA )
    ExternalProject_Add(
        catch
        DOWNLOAD_DIR ${CMAKE_BINARY_DIR}/3rd-party/include
        DOWNLOAD_COMMAND wget --quiet https://raw.githubusercontent.com/philsquared/Catch/master/single_include/catch.hpp -O catch.hpp
        CONFIGURE_COMMAND ""
        BUILD_COMMAND ""
        INSTALL_COMMAND ""
        EXCLUDE_FROM_ALL 1
        )

    add_dependencies(3rd-party catch)
endif()

