function(add_libyaml_cpp INC_DIR LIB_PATH)
    add_library(RuBackup::libyaml_cpp STATIC IMPORTED)

    #Try to find it in custom paths provided to cmake command
    if((NOT ${LIB_PATH}) OR (NOT ${INC_DIR}))
        message("Path to libyaml_cpp or libyaml_cpp headers wasn't defined.\n It will be build along with and exclusivly for this project.\n To specify custom path to the library use ${LIB_PATH} and ${INC_DIR} variables")

        set(binary_name libyaml-cpp.a)

        ExternalProject_Add(libyaml_cpp_ext
          GIT_REPOSITORY    http://10.177.32.32/env/libraries/yaml_cpp.git
          GIT_TAG           master
          SOURCE_DIR        ""
          BUILD_IN_SOURCE   1
          CONFIGURE_COMMAND cmake . -DCMAKE_INSTALL_PREFIX:PATH=install -DCMAKE_INSTALL_LIBDIR:PATH=lib
          BUILD_COMMAND     make
          INSTALL_COMMAND   make install
          TEST_COMMAND      ""
          UPDATE_COMMAND ""
          EXCLUDE_FROM_ALL TRUE
        )
        ExternalProject_Get_Property(libyaml_cpp_ext SOURCE_DIR)
        create_libyaml_cpp_include_dir(${SOURCE_DIR} "install/include" libyaml_cpp_include_dir)
        set_target_properties(RuBackup::libyaml_cpp
            PROPERTIES
                INTERFACE_INCLUDE_DIRECTORIES "${libyaml_cpp_include_dir}"
                IMPORTED_LOCATION ${SOURCE_DIR}/install/lib/${binary_name}
        )
        add_dependencies(RuBackup::libyaml_cpp libyaml_cpp_ext)
    else()
        set_target_properties(RuBackup::libyaml_cpp
            PROPERTIES
                INTERFACE_INCLUDE_DIRECTORIES ${${INC_DIR}}
                IMPORTED_LOCATION ${${LIB_PATH}}
        )
    endif()
endfunction()

function(create_libyaml_cpp_include_dir ROOT_DIR DIR_PATH INC_DIR)
    execute_process(COMMAND mkdir -p ${DIR_PATH}
        WORKING_DIRECTORY ${ROOT_DIR}
    )
    set(${INC_DIR} ${ROOT_DIR}/${DIR_PATH} PARENT_SCOPE)
endfunction()
