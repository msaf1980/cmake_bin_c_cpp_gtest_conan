cmake_minimum_required( VERSION 3.5 )

# Options can be turned on and off by providing cmake with a -DOPTIONNAME=ON (or OFF) argument.
# For example, to turn off benchmarks, and use sanitize flags in a DEBUG build:
#    cmake .. -DCMAKE_BUILD_TYPE=DEBUG -DBENCH=OFF -DSANITIZE=ON

# Add test files with filenames <NAME>_test.cpp or <NAME>_test.c into test dir
# Add bench files with filenames <NAME>_bench.cpp or <NAME>_bench.c into test dir

# Override install prefix with CMAKE_INSTALL_PREFIX
# Override bin dir with BINDIR
# Override lib dir with LIBDIR

# Put tests and benchmarks into DIR_TESTS dirs
# Tests by glob *_test.cpp *_test.c
# Benchmarks by glob *_bench.cpp *_bench.c

set( SUB_DIRS src )
set( DIR_INCLUDES include )
set( DIR_TESTS test )
set( DIR_TESTS_TOOLS tools )
set( DIR_DEP dep )
set( DIR_SCRIPT cmake )
set( DIR_PRESCRIPT cmake_pre )

set( BINDIR bin )
set( LIBDIR lib )

set ( PROJECT hello )

include(${CMAKE_SOURCE_DIR}/options_init.cmake)

# Include cmake prescript from cmake dir
file(GLOB cmakeFiles ${DIR_PRESCRIPT}/*.cmake)
foreach(cmakeFile ${cmakeFiles})
	message("INCLUDE ${cmakeFile}")
	INCLUDE(${cmakeFile})
endforeach(cmakeFile)

project( ${PROJECT} )

################################################################################
# Conan
if(EXISTS "${CMAKE_SOURCE_DIR}/conan_load.cmake")
include(${CMAKE_SOURCE_DIR}/conan_load.cmake)
endif()
################################################################################

set( LZ4_VERSION 1.9.2 )
set( LZ4_URL https://github.com/lz4/lz4/archive/v${LZ4_VERSION}.tar.gz )
set( LZ4_MD5 3898c56c82fb3d9455aefd48db48eaad )


file(GLOB cmakeFiles ${DIR_SCRIPT}/*.cmake)
foreach(cmakeFile ${cmakeFiles})
	message("INCLUDE ${cmakeFile}")
	INCLUDE(${cmakeFile})
endforeach(cmakeFile)


if ( DEFINED DIR_INCLUDES )
	# Includes in separate directory, also include dependecies headers
	include_directories( ${DIR_INCLUDES} ${DEP_INSTALL_DIR}/include )
endif()

if(DEFINED ENV{DEVENV})
	set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
endif()

#foreach ( dir IN LISTS SUB_DIRS )
#	file(GLOB files  ${SUB_DIRS}/*.cmake)
#	foreach(f ${files})
#		message("add ${f}")
#		INCLUDE( ${f} )
#	endforeach(f)
#endforeach()

foreach ( dir IN LISTS SUB_DIRS )
	message("add ${dir}")
	add_subdirectory( ${dir} )
endforeach()

if (TEST)
	enable_testing()
	if ( DEFINED DIR_TESTS )
		#set enable testing
		foreach ( dir IN LISTS DIR_TESTS )
			message("add test ${dir}")
			add_subdirectory( ${dir} )
		endforeach()
	endif()

	if ( DEFINED DIR_TESTS_TOOLS )
		#set enable testing
		foreach ( dir IN LISTS DIR_TESTS_TOOLS )
			message("add tools from ${dir}")
			file(GLOB cmakeFiles ${dir}/*.cmake)
			foreach(cmakeFile ${cmakeFiles})
				message("INCLUDE ${cmakeFile}")
				INCLUDE(${cmakeFile})
			endforeach(cmakeFile)
		endforeach()
	endif()
endif() # END TEST

include(${CMAKE_SOURCE_DIR}/options_print.cmake)
