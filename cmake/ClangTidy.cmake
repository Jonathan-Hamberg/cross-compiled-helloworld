add_custom_command( OUTPUT tidy-output.txt
    COMMAND run-clang-tidy-3.8.py > tidy-output.txt
    DEPENDS ${SOURCES}
    )

add_custom_target(tidy
    DEPENDS tidy-output.txt 
    )

