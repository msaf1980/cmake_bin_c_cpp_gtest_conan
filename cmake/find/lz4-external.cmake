option (USE_LZ4 "Set to TRUE to use lz4 library" OFF)
option (USE_SYSTEM_LZ4 "Set to TRUE to use system lz4 library instead of external ${LZ_VERSION}" OFF)

if (USE_LZ4)
	if (SYSTEM_LZ4_LIBRARY)
		find_library( LZ4_LIBRARY lz4)
		find_path( LZ4_INCLUDE_DIR NAMES lz4.h )
	else(SYSTEM_LZ4_LIBRARY)
		ExternalProject_Add( lz4
			URL ${LZ4_URL}
			URL_MD5 ${LZ4_MD5}
			PREFIX "${CMAKE_BINARY_DIR}/external/lz4"
			CONFIGURE_COMMAND ""
			BUILD_COMMAND make
			BUILD_IN_SOURCE 1
			TEST_COMMAND ""
			INSTALL_COMMAND make -C lib install PREFIX=${DEP_INSTALL_DIR}
		)
		ExternalProject_Get_Property( lz4 binary_dir )
		set( LZ4_LIBRARY "${DEP_INSTALL_DIR}/lib/liblz4.a" )
		set( LZ4_INCLUDE_DIR NAMES "${DEP_INSTALL_DIR}/include" )
		#set( LZ4_LIBRARY "${binary_dir}/lib/liblz4.a" )
		#set( LZ4_INCLUDE_DIR NAMES "${binary_dir}/lib" )
	endif ()

	message( STATUS "Using lz4: ${LZ4_INCLUDE_DIR} : ${LZ4_LIBRARY}" )
endif(USE_LZ4)
