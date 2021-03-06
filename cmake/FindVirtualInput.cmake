# - Try to find the VirtualInput
# Once done this will define
#  LIBVIRTUALINPUT_FOUND - System has a virtual input
#  LIBVIRTUALINPUT_INCLUDE_DIRS - The include directories
#  LIBVIRTUALINPUT_LIBRARIES - The libraries needed to use 
#
# Copyright (C) 2016 Metrological.
#
find_package(PkgConfig)
pkg_check_modules(PC_LIBVIRTUALINPUT virtualkeyboard)

if(PC_LIBVIRTUALINPUT_FOUND)
    if(LIBVIRTUALINPUT_FIND_VERSION AND PC_LIBVIRTUALINPUT_VERSION)
        if ("${LIBVIRTUALINPUT_FIND_VERSION}" VERSION_GREATER "${PC_LIBVIRTUALINPUT_VERSION}")
            message(WARNING "Incorrect version, found ${PC_LIBVIRTUALINPUT_VERSION}, need at least ${LIBVIRTUALINPUT_FIND_VERSION}, please install correct version ${LIBVIRTUALINPUT_FIND_VERSION}")
            set(LIBVIRTUALINPUT_FOUND_TEXT "Found incorrect version")
            unset(PC_LIBVIRTUALINPUT_FOUND)
        endif()
    endif()
else()
    set(LIBVIRTUALINPUT_FOUND_TEXT "Not found")
endif()

if(PC_LIBVIRTUALINPUT_FOUND)
    find_path(
        LIBVIRTUALINPUT_INCLUDE_DIRS
        NAMES plugins/plugins.h
        HINTS ${PC_LIBVIRTUALINPUT_INCLUDEDIR} ${PC_LIBVIRTUALINPUT_INCLUDE_DIRS})

    set(LIBVIRTUALINPUT_LIBS WPEFrameworkPlugins WPEFrameworkCore WPEFrameworkTracing)
    set(LIBVIRTUALINPUT_LIBRARY )
    foreach(LIB ${LIBVIRTUALINPUT_LIBS})
        find_library(LIBVIRTUALINPUT_LIBRARY_${LIB} NAMES ${LIB}
            HINTS ${PC_LIBVIRTUALINPUT_LIBDIR} ${PC_LIBVIRTUALINPUT_LIBRARY_DIRS})
        list(APPEND LIBVIRTUALINPUT_LIBRARY ${LIBVIRTUALINPUT_LIBRARY_${LIB}})
    endforeach()

    if("${LIBVIRTUALINPUT_INCLUDE_DIRS}" STREQUAL "" OR "${LIBVIRTUALINPUT_LIBRARY}" STREQUAL "")
        set(LIBVIRTUALINPUT_FOUND_TEXT "Not found")
    else()
        set(LIBVIRTUALINPUT_FOUND_TEXT "Found")
    endif()
else()
    set(LIBVIRTUALINPUT_FOUND_TEXT "Not found")
endif()

message(STATUS "VirtualInput   : ${LIBVIRTUALINPUT_FOUND_TEXT}")
message(STATUS "  version      : ${PC_LIBVIRTUALINPUT_VERSION}")
message(STATUS "  cflags       : ${PC_LIBVIRTUALINPUT_CFLAGS}")
message(STATUS "  cflags other : ${PC_LIBVIRTUALINPUT_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_LIBVIRTUALINPUT_INCLUDE_DIRS} ${PC_LIBVIRTUALINPUT_INCLUDEDIR}")
message(STATUS "  lib dirs     : ${PC_LIBVIRTUALINPUT_LIBRARY_DIRS} ${PC_LIBVIRTUALINPUT_LIBDIR}")
message(STATUS "  include dirs : ${LIBVIRTUALINPUT_INCLUDE_DIRS}")
message(STATUS "  libs         : ${LIBVIRTUALINPUT_LIBRARY}")

set(LIBVIRTUALINPUT_DEFINITIONS ${PC_LIBVIRTUALINPUT_PLUGINS_CFLAGS_OTHER})
set(LIBVIRTUALINPUT_INCLUDE_DIR ${LIBVIRTUALINPUT_INCLUDE_DIRS})
set(LIBVIRTUALINPUT_LIBRARIES ${LIBVIRTUALINPUT_LIBRARY})
set(LIBVIRTUALINPUT_LIBRARY_DIRS ${PC_LIBVIRTUALINPUT_LIBRARY_DIRS})

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(LIBVIRTUALINPUT DEFAULT_MSG
    LIBVIRTUALINPUT_FOUND
    LIBVIRTUALINPUT_INCLUDE_DIRS
    LIBVIRTUALINPUT_LIBRARIES
    )

mark_as_advanced(LIBVIRTUALINPUT_INCLUDE_DIRS LIBVIRTUALINPUT_LIBRARIES)
