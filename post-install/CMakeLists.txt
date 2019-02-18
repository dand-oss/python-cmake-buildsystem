cmake_minimum_required(VERSION 3.10.0)
project(post-install CXX)
include(asv_cmake_defaults)

set(instloc "${CMAKE_INSTALL_PREFIX}")
set(wloc "${CMAKE_SOURCE_DIR}")
set(iscript "${wloc}/run_py_ver.py")
install(CODE
    "execute_process(COMMAND python ${iscript} ${instloc} setup_py_env.py ${instloc} WORKING_DIRECTORY ${wloc})")
