function(add_vix_disklib)
    add_library(RuBackup::vix_disklib SHARED IMPORTED)

    set(binary_name libvixDiskLib.so)

    ExternalProject_Add(vix_disklib_ext
      GIT_REPOSITORY    http://10.177.32.32/env/libraries/vix_disk_lib.git
      GIT_TAG           master
      SOURCE_DIR        ""
      BUILD_IN_SOURCE   1
      CONFIGURE_COMMAND ""
      BUILD_COMMAND     ""
      INSTALL_COMMAND   ""
      TEST_COMMAND      ""
      EXCLUDE_FROM_ALL TRUE
    )
    ExternalProject_Get_Property(vix_disklib_ext SOURCE_DIR)
    create_vix_disklib_include_dir(${SOURCE_DIR} "include" vix_disklib_include_dir)

    #===================================================================================================================

    list(APPEND VIX_LIBRARY_ARTIFACTS "${SOURCE_DIR}/lib64")

    add_custom_target(vix_disklib_ext_artifacts
            COMMAND /bin/bash "-c" "echo \"${VIX_LIBRARY_ARTIFACTS}\" > vix_library_artifacts"
            COMMAND /bin/bash "-c" "sed -i \"s/;/\\n/g\" vix_library_artifacts"
            WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
            VERBATIM
    )

    add_dependencies(RuBackup::vix_disklib vix_disklib_ext_artifacts)

    execute_process(
            COMMAND
            bash -c "> vix_library_artifacts"
            WORKING_DIRECTORY
            ${CMAKE_CURRENT_SOURCE_DIR}
    )

    #===================================================================================================================

    set_target_properties(RuBackup::vix_disklib
        PROPERTIES
            INTERFACE_INCLUDE_DIRECTORIES ${vix_disklib_include_dir}
            IMPORTED_LOCATION ${SOURCE_DIR}/lib64/${binary_name}
    )
    add_dependencies(RuBackup::vix_disklib vix_disklib_ext)

    target_link_directories(RuBackup::vix_disklib
        INTERFACE
            ${SOURCE_DIR}/lib64/
    )

endfunction()

function(create_vix_disklib_include_dir ROOT_DIR DIR_PATH INC_DIR)
    execute_process(COMMAND mkdir -p ${DIR_PATH}
            WORKING_DIRECTORY ${ROOT_DIR}
            )
    set(${INC_DIR} ${ROOT_DIR}/${DIR_PATH} PARENT_SCOPE)
endfunction()
