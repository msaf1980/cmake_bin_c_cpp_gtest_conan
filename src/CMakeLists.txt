set ( MAIN_BINARY ${PROJECT} )

set ( MAIN_SOURCES )
set ( MAIN_LIBRARIES )

if (USE_LZ4)
	list( APPEND MAIN_LIBRARIES ${LZ4_LIBRARY} )
	ADD_DEFINITIONS(-DUSE_LZ4=1)
endif(USE_LZ4)

include_directories( ${CXXOPTS_INCLUDE_DIR} )

include_directories( ${CONAN_INCLUDE_DIRS_FMT} )
list( APPEND MAIN_LIBRARIES ${CONAN_LIBS_FMT} )

# Scan dir for standart source files
aux_source_directory( ${CMAKE_CURRENT_SOURCE_DIR} MAIN_SOURCES )

# Add executable target
add_executable( ${MAIN_BINARY} ${MAIN_SOURCES} )
# Add build dependecies for correct build order
if (USE_LZ4 AND NOT SYSTEM_LZ4_LIBRARY)
	add_dependencies( ${MAIN_BINARY} lz4 )
endif()
#target_include_directories( ${BINARY} ${DIR_INCLUDES} )
if(MAIN_LIBRARIES)
	target_link_libraries ( ${MAIN_BINARY} ${MAIN_LIBRARIES} )
endif()

INSTALL( TARGETS ${MAIN_BINARY} DESTINATION ${BINDIR} )
