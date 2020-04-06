set ( MAIN_BINARY ${PROJECT} )

set ( MAIN_SOURCES )
set ( MAIN_LIBRARIES )
set ( MAIN_INCLUDES )

if (USE_LZ4)
	list( APPEND MAIN_LIBRARIES ${LZ4_LIBRARY} )
	ADD_DEFINITIONS(-DUSE_LZ4=1)
endif(USE_LZ4)

list( APPEND MAIN_INCLUDES ${CXXOPTS_INCLUDE_DIR} )

list( APPEND MAIN_INCLUDES ${CONAN_INCLUDE_DIRS_FMT} )
list( APPEND MAIN_LIBRARIES ${CONAN_LIBS_FMT} )

# Scan dir for standart source files
aux_source_directory( ${CMAKE_CURRENT_SOURCE_DIR} MAIN_SOURCES )

# Add executable target
custom_add_executable(
	"${MAIN_BINARY}"
	"${MAIN_SOURCES}"
	"${MAIN_LIBRARIES}"
	"${MAIN_INCLUDES}"
	"${BINDIR}"
)
# Add build dependecies for correct build order
if (USE_LZ4 AND NOT SYSTEM_LZ4_LIBRARY)
	add_dependencies( ${MAIN_BINARY} lz4 )
endif()

