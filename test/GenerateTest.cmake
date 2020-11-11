if( NOT MSVC )
    set( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall" )
    set( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall" )
endif()

set( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DUNIT_TEST" )
set( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DUNIT_TEST" )

set( CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/Modules/" )

find_package( CppUTest REQUIRED )

include_directories( ${CppUTest_INCLUDE_DIR} )
link_directories( ${CppUTest_LIBRARY_DIR} )

add_definitions( -DCPPUTEST_INCLUDE_DIR="${CppUTest_INCLUDE_DIR}" )
add_definitions( -DCPPUMOCKGEN_INCLUDE_DIR="${CMAKE_SOURCE_DIR}/prod/include" )

if( MSVC )
    set( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /EHsc" )
endif()

add_executable( ${PROJECT_NAME} EXCLUDE_FROM_ALL ${PROD_SRC_FILES} ${TEST_SRC_FILES} ${CMAKE_CURRENT_LIST_DIR}/TestMain.cpp )

if( DEFINED CppUTest_DEBUG_LIBRARY )
    target_link_libraries( ${PROJECT_NAME} debug ${CppUTest_DEBUG_LIBRARY} optimized ${CppUTest_LIBRARY} )
    if( DEFINED CppUTestExt_DEBUG_LIBRARY )
        target_link_libraries( ${PROJECT_NAME} debug ${CppUTestExt_DEBUG_LIBRARY} optimized ${CppUTestExt_LIBRARY} )
    endif()
else()
    target_link_libraries( ${PROJECT_NAME} ${CppUTest_LIBRARY} )
    if( DEFINED CppUTestExt_LIBRARY )
        target_link_libraries( ${PROJECT_NAME} ${CppUTestExt_LIBRARY} )
    endif()
endif()

add_dependencies( ${TARGET_NAMESPACE}build_tests ${PROJECT_NAME} )

if( CI_MODE )
    set( TEST_ARGS -ojunit -v )
else()
    set( TEST_ARGS -v )
endif()

add_test( ${PROJECT_NAME} ${PROJECT_NAME} ${TEST_ARGS} )
