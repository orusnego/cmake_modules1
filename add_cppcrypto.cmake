function(add_libcppcrypto INC_DIR LIB_PATH)
	add_library(RuBackup::libcppcrypto STATIC IMPORTED)

	#TODO
	if("${TARGET_OS}" STREQUAL "astra_novorossiysk")
		#Add some custome build configuration
	endif()

	#Try to find it in custom paths provided to cmake command
	if((NOT ${LIB_PATH}) OR (NOT ${INC_DIR}))
		message("Path to libcppcrypto or libcppcrypto headers wasn't defined.\n It will be build along with and exclusivly for this project.\n To specify custom path to the library use ${LIB_PATH} and ${INC_DIR} variables")

		if (${TARGET_OS} MATCHES windows_server_2016)
			set(build_command make UNAME=Cygwin)
			set(binary_name cygcppcrypto.0.dll)
		else()
			set(build_command make)
			set(binary_name libcppcrypto.a)
		endif()

		ExternalProject_Add(cppcrypto_ext
		  GIT_REPOSITORY    http://10.177.32.32/env/libraries/cppcrypto.git
		  GIT_TAG           master
		  SOURCE_DIR        ""
		  BUILD_IN_SOURCE   1
		  CONFIGURE_COMMAND ""
		  BUILD_COMMAND     ${build_command}
		  INSTALL_COMMAND   ${build_command} PREFIX=\${PWD} install
		  TEST_COMMAND      ""
		  UPDATE_COMMAND ""
		  EXCLUDE_FROM_ALL TRUE
		)
		ExternalProject_Get_Property(cppcrypto_ext SOURCE_DIR)
		create_cppcrypto_include_dir(${SOURCE_DIR} "include" cppcrypto_include_dir)
		create_cppcrypto_include_dir(${SOURCE_DIR} "include/cppcrypto" cppcrypto_include_internal_dir)
		set_target_properties(RuBackup::libcppcrypto
			PROPERTIES
				INTERFACE_INCLUDE_DIRECTORIES "${cppcrypto_include_dir};${cppcrypto_include_internal_dir}"
				IMPORTED_LOCATION ${SOURCE_DIR}/${binary_name}
		)
		add_dependencies(RuBackup::libcppcrypto cppcrypto_ext)
	else()
		set_target_properties(RuBackup::libcppcrypto
			PROPERTIES
				INTERFACE_INCLUDE_DIRECTORIES ${${INC_DIR}}
				IMPORTED_LOCATION ${${LIB_PATH}}
		)
	endif()
endfunction()

function(create_cppcrypto_include_dir ROOT_DIR DIR_PATH INC_DIR)
	execute_process(COMMAND mkdir -p ${DIR_PATH}
		WORKING_DIRECTORY ${ROOT_DIR}
	)
	set(${INC_DIR} ${ROOT_DIR}/${DIR_PATH} PARENT_SCOPE)
endfunction()
