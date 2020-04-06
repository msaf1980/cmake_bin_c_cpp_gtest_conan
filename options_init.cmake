option(TEST      "Build tests" ON)
option(BENCH     "Build benchmarks" OFF)
option(ASAN      "Adds sanitize flags" OFF)
option(TSAN      "Adds thread sanitize flags" OFF)
option(PROFILE   "Enable profiling with gperftools" OFF)
option(DEBUGINFO "Add debug info" ON)

set(CMAKE_BUILD_TYPE ${CMAKE_BUILD_TYPE}
    CACHE STRING "Choose the type of build: None Debug Release Coverage ASan ASanDbg MemSan MemSanDbg TSan TSanDbg"
    FORCE)

if(SANITIZE)
	set(TSANITIZE OFF)
endif()

if(BENCH)
	set(TEST ON)
endif()

set (CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set (CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set (CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

set (DEP_INSTALL_DIR ${CMAKE_BINARY_DIR}/builddep)
if (NOT EXISTS ${DEP_INSTALL_DIR} )
	file( MAKE_DIRECTORY ${DEP_INSTALL_DIR} )
endif()
