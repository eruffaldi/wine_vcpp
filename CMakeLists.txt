
set(MSVC_INCREMENTAL_DEFAULT OFF)

add_executable(min min.cpp)
if(WIN32)
    set_target_properties(min PROPERTIES LINK_FLAGS "/INCREMENTAL:NO")
endif()
