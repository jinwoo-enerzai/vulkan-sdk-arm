# adapted from: https://vulkan.lunarg.com/issue/view/66adac57aa8cf92bbcfd1eb1

# Define our host system
set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR aarch64)
set(CMAKE_CROSSCOMPILING 1)
set(CMAKE_SYSTEM_VERSION 1)

set(CROSS_PREFIX "aarch64-linux-gnu")
set(CURRENT_COMPILER_VERSION "-12")

# Define the cross compiler locations
if(NOT TOOLCHAIN_ROOT_DIR) # If the toolchain directory is not passed via command line
    set(TOOLCHAIN_ROOT_DIR /usr/${CROSS_PREFIX})
endif()

# Check if the cross compiler is installed
if(NOT EXISTS "${TOOLCHAIN_ROOT_DIR}")
    message(FATAL_ERROR "\
 ARM toolchain is not installed.\n\
 On debian based systems it can be installed by the commands\n\
     sudo apt-get install g{cc,++}-aarch64-linux-gnu\n\
 Or you can specify its location by specifying it via -DTOOLCHAIN_ROOT_DIR=")
endif()

include_directories(include ${TOOLCHAIN_ROOT_DIR}/local/include)

# Define our compilers
set(CMAKE_C_COMPILER ${CROSS_PREFIX}-gcc${CURRENT_COMPILER_VERSION})
set(CMAKE_CXX_COMPILER ${CROSS_PREFIX}-g++${CURRENT_COMPILER_VERSION})

# Define the sysroot
set(CMAKE_FIND_ROOT_PATH ${TOOLCHAIN_ROOT_DIR})
message(STATUS "Searching for ARM toolchain in: ${CMAKE_FIND_ROOT_PATH}")

# Use our definitions for compiler tools
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# Search for libraries and headers in the target directories only
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

set(ASM aarch64-linux-gnu-as)
