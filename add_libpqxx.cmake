function(add_libpqxx INC_DIR LIB_PATH)
	add_library(RuBackup::libpqxx STATIC IMPORTED)

	#Try to find it in custom paths provided to cmake command
	if((NOT ${LIB_PATH}) OR (NOT ${INC_DIR}))
		message("Path to libpqxx wasn't defined. \n It will be build along with and exclusivly for this project. \n To specify custom path to the library use ${LIB_PATH} variable")
		ExternalProject_Add(pqxx_ext
		  GIT_REPOSITORY    http://10.177.32.32/env/libraries/libpqxx.git
		  GIT_TAG           6.4.8
		  SOURCE_DIR        ""
		  BUILD_IN_SOURCE   1
		  CONFIGURE_COMMAND ./configure --disable-documentation
		  BUILD_COMMAND     make
		  INSTALL_COMMAND   ""
		  TEST_COMMAND      ""
		  UPDATE_COMMAND ""
		  EXCLUDE_FROM_ALL TRUE
		)
		ExternalProject_Get_Property(pqxx_ext SOURCE_DIR)
		create_libpqxx_include_dir(${SOURCE_DIR} "include" libpqxx_include_dir)
		set_target_properties(RuBackup::libpqxx
			PROPERTIES
				INTERFACE_INCLUDE_DIRECTORIES ${libpqxx_include_dir}
				IMPORTED_LOCATION ${SOURCE_DIR}/src/.libs/libpqxx.a
		)
		add_dependencies(RuBackup::libpqxx pqxx_ext)
	else()
		set_target_properties(RuBackup::libpqxx
			PROPERTIES
				INTERFACE_INCLUDE_DIRECTORIES ${${INC_DIR}}
				IMPORTED_LOCATION ${${LIB_PATH}}
		)
	endif()
endfunction()

function(create_libpqxx_include_dir ROOT_DIR DIR_PATH INC_DIR)
	execute_process(COMMAND mkdir -p ${DIR_PATH}
		WORKING_DIRECTORY ${ROOT_DIR}
	)
	set(${INC_DIR} ${ROOT_DIR}/${DIR_PATH} PARENT_SCOPE)
endfunction()