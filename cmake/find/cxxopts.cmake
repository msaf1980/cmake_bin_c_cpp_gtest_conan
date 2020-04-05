option (USE_INTERNAL_CXXOPTS_LIBRARY "Set to OFF to use system lz4 library instead of bundled" ON)

if (NOT EXISTS "${CMAKE_SOURCE_DIR}/contrib/cxxopts/include/cxxopts.hpp")
    if (USE_INTERNAL_CXXOPTS_LIBRARY)
       message (WARNING "submodule contrib/cxxopts is missing. to fix try run: \n git submodule update --init --recursive")
       set (USE_INTERNAL_CXXOPTS_LIBRARY 0)
    endif ()
    set (MISSING_INTERNAL_CXXOPTS_LIBRARY 1)
endif ()

if (NOT USE_INTERNAL_CXXOPTS_LIBRARY)
    find_library (CXXOPTS_LIBRARY cxxopts)
    find_path (CXXOPTS_INCLUDE_DIR NAMES cxxopts.hpp PATHS ${CXXOPTS_INCLUDE_PATHS})
endif ()

if (CXXOPTS_LIBRARY AND CXXOPTS_INCLUDE_DIR)
elseif (NOT MISSING_INTERNAL_CXXOPTS_LIBRARY)
    set (CXXOPTS_INCLUDE_DIR ${CMAKE_SOURCE_DIR}/contrib/cxxopts/include)
    set (USE_INTERNAL_CXXOPTS_LIBRARY 1)
    set (CXXOPTS_LIBRARY cxxopts)
endif ()

message (STATUS "Using cxxopts: ${CXXOPTS_INCLUDE_DIR} : ${CXXOPTS_LIBRARY}")
