#define CATCH_CONFIG_MAIN
#include "catch.hpp"
#include <vector>

TEST_CASE( "vectors can be sized and resized", "[vector]")
{
    std::vector<int> v(5);

    REQUIRE( v.size() == 5 );
    REQUIRE( v.capacity() >= 5 );

    SECTION( "resizing bigger changes size and capacity" )
    {
        v.resize( 10 );

        REQUIRE( v.size() == 10 );
        REQUIRE( v.capacity() >= 10 );
    }


    SECTION( "resizing smaller changes size but not capacity" )
    {
        v.resize( 0 );

        REQUIRE( v.size() == 0);
        REQUIRE( v.capacity() >= 5);
    }

    SECTION( "reserving bigger chages capacity but not size")
    {
        v.reserve(10);

        REQUIRE( v.size() == 5);
        REQUIRE( v.capacity() >= 10);
    }

}
