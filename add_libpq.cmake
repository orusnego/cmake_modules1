function(add_libpq INC_DIR LIB_PATH)
	add_library(RuBackup::libpq STATIC IMPORTED)

	#Try to find it in custom paths provided to cmake command
	if(NOT ${LIB_PATH})
		message("Path to libpq wasn't defined. \n It will be build along with and exclusivly for this project. \n To specify custom path to the library use ${LIB_PATH} variable")
		ExternalProject_Add(pq_ext
		  GIT_REPOSITORY    http://10.177.32.32/env/utils/postgresql-10.0.git
		  GIT_TAG           master
		  SOURCE_DIR        ""
		  BUILD_IN_SOURCE   1
		  CONFIGURE_COMMAND ./configure --with-openssl --without-readline
		  BUILD_COMMAND     cd src/interfaces/libpq && make libpq.a
		  INSTALL_COMMAND   ""
		  TEST_COMMAND      ""
		  UPDATE_COMMAND ""
		  EXCLUDE_FROM_ALL TRUE
		)
		ExternalProject_Get_Property(pq_ext SOURCE_DIR)
		set_target_properties(RuBackup::libpq
			PROPERTIES
				#INTERFACE_INCLUDE_DIRECTORIES ${SOURCE_DIR}
				IMPORTED_LOCATION ${SOURCE_DIR}/src/interfaces/libpq/libpq.a
		)
		add_dependencies(RuBackup::libpq pq_ext)
	else()
		set_target_properties(RuBackup::libpq
			PROPERTIES
				#INTERFACE_INCLUDE_DIRECTORIES ${${INC_DIR}}
				IMPORTED_LOCATION ${${LIB_PATH}}
		)
	endif()
endfunction()
