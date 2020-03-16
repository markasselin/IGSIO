IF(vtkAddon_DIR)
  # vtkAddon has been built already
  FIND_PACKAGE(vtkAddon REQUIRED NO_MODULE)
  MESSAGE(STATUS "Using vtkAddon available at: ${vtkAddon_DIR}")
  SET(IGSIO_vtkAddon_DIR ${vtkAddon_DIR})
ELSE()

  IF (NOT vtkAddon_INSTALL_BIN_DIR)
    set(vtkAddon_INSTALL_BIN_DIR ${IGSIO_INSTALL_BIN_DIR})
  ENDIF()
  IF (NOT vtkAddon_INSTALL_LIB_DIR)
    set(vtkAddon_INSTALL_LIB_DIR ${IGSIO_INSTALL_LIB_DIR})
  ENDIF()

  ExternalProject_Add( vtkAddon
    PREFIX ${PLUS_IGSIO_PREFIX_DIR}
    "${PLUSBUILD_EXTERNAL_PROJECT_CUSTOM_COMMANDS}"
    SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/vtkAddon"
    BINARY_DIR "${CMAKE_BINARY_DIR}/vtkAddon-bin"
    #--Configure step-------------
    CMAKE_ARGS
      ${ep_common_args}
      -DEXECUTABLE_OUTPUT_PATH:PATH=${${PROJECT_NAME}_INSTALL_BIN_DIR}
      -DCMAKE_RUNTIME_OUTPUT_DIRECTORY:PATH=${vtkAddon_INSTALL_BIN_DIR}
      -DCMAKE_LIBRARY_OUTPUT_DIRECTORY:PATH=${vtkAddon_INSTALL_LIB_DIR}
      -DCMAKE_ARCHIVE_OUTPUT_DIRECTORY:PATH=${vtkAddon_INSTALL_LIB_DIR}
      -DCMAKE_MACOSX_RPATH:BOOL=${CMAKE_MACOSX_RPATH}

      -DCMAKE_CXX_FLAGS:STRING=${ep_common_cxx_flags}
      -DCMAKE_C_FLAGS:STRING=${ep_common_c_flags}
      -DBUILD_SHARED_LIBS:BOOL=${BUILD_SHARED_LIBS}

      -DVTK_DIR:PATH=${VTK_DIR}
      -DvtkAddon_INSTALL_BIN_DIR:PATH=${vtkAddon_INSTALL_BIN_DIR}
      -DvtkAddon_INSTALL_LIB_DIR:PATH=${vtkAddon_INSTALL_LIB_DIR}

    #--Build step-----------------
    BUILD_ALWAYS 1
    #--Install step-----------------
    INSTALL_COMMAND ""
    DEPENDS ${IGSIO_DEPENDENCIES}
    )

  SET(IGSIO_vtkAddon_DIR "${CMAKE_BINARY_DIR}/vtkAddon-bin")
ENDIF()
