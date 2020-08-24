#!/bin/bash

KEPT_DIR=$PWD
YEAR=$(date +'%Y')

echo Project name?
read PROJECT_NAME


echo Project description?
read PROJECT_DESCRIPTION

echo Maintainer?
read PROJECT_MAINTAINER

echo Mainteiner email?
read EMAIL_MAINTAINER

echo Installation directory "["${KEPT_DIR}"]"?
read INSTALL_DIR


if [ -z "$INSTALL_DIR" ]; then
	INSTALL_DIR=$KEPT_DIR
fi

echo Creating folder structure for project \"$PROJECT_NAME\" in \"$INSTALL_DIR\"...
cd $INSTALL_DIR
mkdir $PROJECT_NAME
cd $PROJECT_NAME
mkdir doc src build out examples
mkdir out/share
mkdir out/demo


# --- BEGIN: Creating INSTALL ---
echo "${PROJECT_NAME} - ${PROJECT_DESCRIPTION}
Installation from CMake (Multiplatform)
---------------------------------------
Navigate to the project. An out-of-source build is recommended however not mandatory. To do this, create and enter a 'build' directory. 'cmake ..' should create a 'Makefile' or '.sln' there. A 'make' or 'build' should make output '${PROJECT_NAME}' appear in ./out/ correspondent directory." > INSTALL
# --- END: Creating INSTALL ---


# --- BEGIN: Creating AUTHORS ---
echo "${PROJECT_NAME} - ${PROJECT_DESCRIPTION}
Authors
-------
Main maintainer is ${PROJECT_MAINTAINER} <${EMAIL_MAINTAINER}>" > AUTHORS
# --- END: Creating AUTHORS ---



cd src
echo "//
// ${PROJECT_NAME}:main.cpp
//
// Author: ${PROJECT_MAINTAINER} <${EMAIL_MAINTAINER}>, (C) ${YEAR}
//
// This program is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 2 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
//
#include <iostream>
#include \"${PROJECT_NAME}.h\"
int main(int argc, char *argv[]) {
  return 0;
}
" > main.cpp

# --- END: Creating src/main.cpp ---

# --- BEGIN: Creating src/${PROJECT_NAME}.cpp ---
cd src
echo "//
// ${PROJECT_NAME}.cpp
//
// Author: ${PROJECT_MAINTAINER} <${EMAIL_MAINTAINER}>, (C) ${YEAR}
//
// This program is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 2 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
//
#include \"${PROJECT_NAME}.hpp\"
" > ${PROJECT_NAME}.cpp
cd ..
# --- END: Creating src/${PROJECT_NAME}.cpp ---

# --- BEGIN: Creating src/${PROJECT_NAME}.cpp ---
cd src
echo "//
// ${PROJECT_NAME}.hpp
//
// Author: ${PROJECT_MAINTAINER} <${EMAIL_MAINTAINER}>, (C) ${YEAR}
//
// This program is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 2 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
//
" > ${PROJECT_NAME}.hpp
echo "#pragma once" >> ${PROJECT_NAME}.hpp 

rm temp

cd ..
# --- END: Creating src/${PROJECT_NAME}.hpp ---



# --- BEGIN: Creating CMakeLists.txt ---

echo "#
CMAKE_MINIMUM_REQUIRED (VERSION 2.6)
set(CMAKE_BUILD_TYPE Debug)
set(KEYWORD $PROJECT_NAME)

# Start a project
project(\${KEYWORD})

add_subdirectory(src)
add_subdirectory(examples)
add_subdirectory(doc)
" > CMakeLists.txt


# --- END: Creating CMakeLists.txt ---

# --- BEGIN: Creating src/CMakeLists.txt ---

echo "#

add_library(ex_lib
  SHARED
  ${PROJECT_NAME}.cpp)

add_executable (mainDemo main.cpp) 

install(PROGRAMS ${CMAKE_CURRENT_BINARY_DIR}/mainDemo
  DESTINATION bin
  RENAME ${CMAKE_PROJECT_NAME}-mainDemo)

file(
	GLOB 
	headers
	*.hpp
)

install(FILES ${headers}
  DESTINATION include/${CMAKE_PROJECT_NAME})



include_directories (${CMAKE_SOURCE_DIR}/src)

file(
	GLOB 
	usage_examples
	*.cpp
)

foreach(f ${usage_examples})
  get_filename_component(exampleName ${f} NAME_WE) 
  add_executable (${exampleName} ${f}) 
  target_link_libraries(${exampleName} ex_lib)
  install(PROGRAMS ${CMAKE_CURRENT_BINARY_DIR}/${exampleName}
    DESTINATION bin
    RENAME ${CMAKE_PROJECT_NAME}-${exampleName})
endforeach(f)

" > src/CMakeLists.txt


# --- END: Creating src/CMakeLists.txt ---




# --- BEGIN: Creating doc/CMakeLists.txt ---

echo "#
find_package(Doxygen)
if(NOT DOXYGEN_FOUND)
    message("Doxygen not found, I will not generate/install the documentation")
else()
   configure_file(Doxyfile.in Doxyfile)

   set(DOXYGEN_INPUT ${CMAKE_BINARY_DIR}/doc/Doxyfile)
   set(DOXYGEN_OUTPUT ${APIDOC_DIR}/html/index.html)

   add_custom_target(doc ALL
     COMMAND ${CMAKE_COMMAND} -E echo_append "Building API Documentation..."
     COMMAND ${DOXYGEN_EXECUTABLE} ${DOXYGEN_INPUT} > /dev/null
     COMMAND ${CMAKE_COMMAND} -E echo "Done."
     )

  install(DIRECTORY ${CMAKE_BINARY_DIR}/doc/html 
          DESTINATION share/doc/${CMAKE_PROJECT_NAME})

endif()

" > doc/CMakeLists.txt


# --- END: Creating doc/CMakeLists.txt ---