
# find_path(FFMPEG_INCLUDE_DIRS
#         libavcodec/avcodec.h libavfilter/avfilter.h libavformat/avformat.h
#         libavutil/avutil.h libswscale/swscale.h
#     )
# find_library(FFMPEG_LIBAVCODEC NAMES avcodec libavcodec PATH_SUFFIXES ffmpeg/libavcodec)
# find_library(FFMPEG_LIBAVFILTER NAMES avfilter libavfilter PATH_SUFFIXES ffmpeg/libavfilter)
# find_library(FFMPEG_LIBAVFORMAT NAMES avformat libavformat PATH_SUFFIXES ffmpeg/libavformat)
# find_library(FFMPEG_LIBAVUTIL NAMES avutil libavutil PATH_SUFFIXES ffmpeg/libavutil)
# find_library(FFMPEG_LIBSWSCALE NAMES swscale libswscale PATH_SUFFIXES ffmpeg/libswscale)
# find_library(FFMPEG_LIBSWRESAMPLE NAMES NAMES swresample libswresample
#                 PATH_SUFFIXES ffmpeg/libswresample)

# # print paths
# message(STATUS "FFMPEG_INCLUDE_DIRS: ${FFMPEG_INCLUDE_DIRS}")
# message(STATUS "FFMPEG_LIBAVCODEC: ${FFMPEG_LIBAVCODEC}")
# message(STATUS "FFMPEG_LIBAVFILTER: ${FFMPEG_LIBAVFILTER}")
# message(STATUS "FFMPEG_LIBAVFORMAT: ${FFMPEG_LIBAVFORMAT}")
# message(STATUS "FFMPEG_LIBAVUTIL: ${FFMPEG_LIBAVUTIL}")
# message(STATUS "FFMPEG_LIBSWSCALE: ${FFMPEG_LIBSWSCALE}")
# message(STATUS "FFMPEG_LIBSWRESAMPLE: ${FFMPEG_LIBSWRESAMPLE}")

cmake_minimum_required(VERSION 3.16)

set(CMAKE_OSX_ARCHITECTURES "arm64" CACHE STRING "" FORCE)

# static -----------------------------------
project(
    tryffmpeg
    VERSION 1.0
    LANGUAGES CXX C
)

# set architecture arm64
# set(CMAKE_APPLE_SILICON_PROCESSOR "arm64")

SET(FFMPEG_ROOT ${CMAKE_SOURCE_DIR}/ffmpeg)

add_executable(${PROJECT_NAME} main.cpp)

add_compile_options("-std=c++11") # .. -pthread required only at link time


# verbose
set(CMAKE_VERBOSE_MAKEFILE ON)

# [add dependencies]
# target_include_directories(${PROJECT_NAME} PUBLIC ${X11_INCLUDE_DIRS} ${GLEW_INCLUDE_DIRS} ${PYTHON_INCLUDE_DIRS} ${NUMPY_INCLUDE_DIR})
# target_include_directories(${PROJECT_NAME} PUBLIC ${VA_INCLUDE_DIRS} ${VADRM_INCLUDE_DIRS} ${VAX11_INCLUDE_DIRS})

# # target_link_libraries(${PROJECT_NAME} ${GL_LIBS})
# target_link_libraries(${PROJECT_NAME} ${X11_LIBRARIES} ${GLEW_LIBRARIES} ${ALSA_LIBRARIES} ${PYTHON_LIBRARIES})
# target_link_libraries(${PROJECT_NAME} "pthread")
# target_link_libraries(${PROJECT_NAME} ${VA_LIBRARIES} ${VADRM_LIBRARIES} ${VAX11_LIBRARIES})

# [add openssl dependencies]
# target_link_libraries(${PROJECT_NAME} ${OPENSSL_LIBRARIES})

message("FFMPEG  ROOT: ${FFMPEG_ROOT}")

target_include_directories(${PROJECT_NAME} PUBLIC "${FFMPEG_ROOT}") # ffmpeg header files are referred in the code with the directory name
  
target_link_libraries(
    ${PROJECT_NAME} 
    PRIVATE
    "${FFMPEG_ROOT}/libavfilter/libavfilter.a" 
    "${FFMPEG_ROOT}/libavformat/libavformat.a" 
    "${FFMPEG_ROOT}/libavcodec/libavcodec.a" 
    "${FFMPEG_ROOT}/libavutil/libavutil.a" 
    "${FFMPEG_ROOT}/libswscale/libswscale.a" 
    "${FFMPEG_ROOT}/libswresample/libswresample.a"
)

if (APPLE) 
target_link_libraries(${PROJECT_NAME} 
    PRIVATE 
    # "-framework Cocoa" 
    "-framework CoreVideo"
    "-framework VideoDecodeAcceleration"
    "-framework CoreFoundation"
    "-framework CoreMedia"
    "-framework VideoToolbox"
    # "-framework IOKit" 
    # "-framework QuartzCore"
)


endif ()
    
# target_link_libraries(${PROJECT_NAME} "vda") # could this fix the missing "vaUnmapBuffer", etc. crap?
# target_link_libraries(${PROJECT_NAME} "rt")
# target_link_libraries(${PROJECT_NAME} "-Wl,--allow-multiple-definition" "-Wl,-Bsymbolic" "-Wl,--start-group" "-Wl,--whole-archive")

# target_link_libraries(${PROJECT_NAME} ":libliveMedia.a" ":libgroupsock.a" ":libBasicUsageEnvironment.a" ":libUsageEnvironment.a")
# target_link_libraries(${PROJECT_NAME} ":libavfilter.a" ":libavformat.a" ":libavcodec.a" ":libavutil.a" ":libswscale.a" ":libswresample.a")

# target_link_libraries(${PROJECT_NAME} "-Wl,--no-whole-archive" "-Wl,--end-group")