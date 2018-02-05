cmake_minimum_required(VERSION 2.8)

execute_process (COMMAND ${CMAKE_CURRENT_LIST_DIR}/utils/install_hooks.sh)
set(build_dir ${CMAKE_CURRENT_LIST_DIR}/build)

if(NOT EXISTS ${build_dir})
  file(MAKE_DIRECTORY ${build_dir})
endif()

execute_process(
  COMMAND ${CMAKE_COMMAND} ..
  WORKING_DIRECTORY ${build_dir}
  RESULT_VARIABLE test_result
)
if(${test_result})
  message(FATAL_ERROR "configure failed")
endif()

execute_process(
  COMMAND ${CMAKE_COMMAND} --build .
  WORKING_DIRECTORY ${build_dir}
  RESULT_VARIABLE test_result
)
if(${test_result})
  message(FATAL_ERROR "build failed")
endif()

execute_process(
  COMMAND ctest -VV
  WORKING_DIRECTORY ${build_dir}
  RESULT_VARIABLE test_result
)
if(${test_result})
  message(FATAL_ERROR "test failed")
endif()
