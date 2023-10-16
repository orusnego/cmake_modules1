function(add_oracle_libs LIB_PATH)
	add_library(RuBackup::libocci SHARED IMPORTED)
	add_library(RuBackup::libclntshcore SHARED IMPORTED)
	add_library(RuBackup::libclntsh SHARED IMPORTED)

	#Try to find it in custom paths provided to cmake command
	if(NOT ${LIB_PATH})
		message("Path to oracle libs wasn't defined. \n It will be downloaded along with and exclusivly for this project. \n To specify custom path to the library use ${LIB_PATH} variable")
		ExternalProject_Add(oracle_libs_ext
			URL					https://download.oracle.com/otn_software/linux/instantclient/216000/instantclient-basic-linux.x64-21.6.0.0.0dbru.zip
			CONFIGURE_COMMAND	""
			BUILD_COMMAND		""
			INSTALL_COMMAND		""
			TEST_COMMAND		""
			UPDATE_COMMAND		""
			EXCLUDE_FROM_ALL	TRUE
		)
		ExternalProject_Get_Property(oracle_libs_ext SOURCE_DIR)
		set_target_properties(RuBackup::libocci
			PROPERTIES
				IMPORTED_LOCATION ${SOURCE_DIR}/libocci.so
		)
		add_dependencies(RuBackup::libocci oracle_libs_ext)

		set_target_properties(RuBackup::libclntshcore
			PROPERTIES
				IMPORTED_LOCATION ${SOURCE_DIR}/libclntshcore.so
		)
		add_dependencies(RuBackup::libclntshcore oracle_libs_ext)

		set_target_properties(RuBackup::libclntsh
			PROPERTIES
				IMPORTED_LOCATION ${SOURCE_DIR}/libclntsh.so
				IMPORTED_LINK_DEPENDENT_LIBRARIES ${SOURCE_DIR}/libnnz21.so
		)
		add_dependencies(RuBackup::libclntsh oracle_libs_ext)
	else()
		set_target_properties(RuBackup::libocci
			PROPERTIES
				IMPORTED_LOCATION ${${LIB_PATH}}/libocci.so
		)

		set_target_properties(RuBackup::libclntshcore
			PROPERTIES
				IMPORTED_LOCATION ${${LIB_PATH}}/libclntshcore.so
		)

		set_target_properties(RuBackup::libclntsh
			PROPERTIES
				IMPORTED_LOCATION ${${LIB_PATH}}/libclntsh.so
				IMPORTED_LINK_DEPENDENT_LIBRARIES ${SOURCE_DIR}/libnnz21.so
		)
	endif()
endfunction()


function(add_oracle_headers INC_DIR)
	add_library(oracle_headers INTERFACE)
	add_library(RuBackup::oracle_headers ALIAS oracle_headers)

	#Try to find it in custom paths provided to cmake command
	if((NOT ${LIB_PATH}) OR (NOT ${INC_DIR}))
		message("Path to oracle headers wasn't defined. \n It will be downloaded along with and exclusivly for this project. \n To specify custom path to the headers use ${INC_DIR} variable")
		ExternalProject_Add(oracle_headers_ext
			URL					https://download.oracle.com/otn_software/linux/instantclient/216000/instantclient-sdk-linux.x64-21.6.0.0.0dbru.zip
			CONFIGURE_COMMAND	""
			BUILD_COMMAND		""
			INSTALL_COMMAND		""
			TEST_COMMAND		""
			UPDATE_COMMAND		""
			EXCLUDE_FROM_ALL	TRUE
		)
		ExternalProject_Get_Property(oracle_headers_ext SOURCE_DIR)
		target_include_directories(oracle_headers
		INTERFACE
			${SOURCE_DIR}/sdk/include
		)
		add_dependencies(oracle_headers oracle_headers_ext)
	endif()
endfunction()