include (ExternalProject)


set (DEPENDENCIES)
list (APPEND DEPENDENCIES TIFF)
include(${PROJECT_SOURCE_DIR}/Superbuild/External_LIBTIFF.cmake)
list (APPEND DEPENDENCIES GLEW)
include(${PROJECT_SOURCE_DIR}/Superbuild/External_GLEW.cmake)

ExternalProject_Add (Autoscoper
  DEPENDS ${DEPENDENCIES}
  SOURCE_DIR ${PROJECT_SOURCE_DIR}
  CMAKE_ARGS -DAutoscoper_SUPERBUILD=OFF -DBUILD_WITH_CUDA=${BUILD_WITH_CUDA}
  INSTALL_COMMAND ""
  BINARY_DIR ${CMAKE_BINARY_DIR}
)
