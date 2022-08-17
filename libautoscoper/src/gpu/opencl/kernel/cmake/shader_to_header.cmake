# This cmake script takes a shader filename and outputs a header containing
# the shader GLSL code as an escaped hexadecimal characters list

# Construct the variable name from the shader name
get_filename_component(SHADER_NAME ${SHADER_FILENAME} NAME_WE)

# Construct the header filename
set(HEADER_FILENAME "${SHADER_NAME}.cl.h")

MESSAGE(STATUS "Converting ${SHADER_FILENAME} to ${OUTPUT_FOLDER}/${HEADER_FILENAME}")

# Read as hex the content of the shader file, and put it into the
# SHADER_BINARY_DATA variable
file(READ ${SHADER_FILENAME} SHADER_BINARY_DATA HEX)

## Prefix each hex digit by \x
string(REGEX REPLACE "(..)" "0x\\1, " SHADER_BINARY_DATA "${SHADER_BINARY_DATA}")

# Jump to next line each 72 characters
string(REGEX REPLACE
"(........................................................................)"
"  \\1\n" SHADER_BINARY_DATA "${SHADER_BINARY_DATA}")

# Replace empty double quotes set (if needed)
string(REGEX REPLACE "\n    \"\"" "" SHADER_BINARY_DATA "${SHADER_BINARY_DATA}")

# set the edit warning message to be inserted in the header
SET(EDIT_WARNING "This file is autogenerated, please do not edit")

# Finally, generate the shader header based on the template
configure_file(${CMAKE_SOURCE_DIR}/gpu/opencl/kernel/cmake/shader_templ.h.in ${OUTPUT_FOLDER}/${HEADER_FILENAME})
