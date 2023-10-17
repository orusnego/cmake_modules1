function(add_libaws_core LIB_PATH)
	add_library(RuBackup::libaws-cpp-sdk-core STATIC IMPORTED)

	if(NOT ${LIB_PATH})
		message("Path to libaws-cpp-sdk-core wasn't defined.\n It will be build along with and exclusivly for this project.\n To specify custom path to the library use ${LIB_PATH} variable")
		add_aws_project()
		ExternalProject_Get_Property(aws_ext SOURCE_DIR)
		create_aws_include_dir(${SOURCE_DIR} "install/include" aws_include_dir)
		set_target_properties(RuBackup::libaws-cpp-sdk-core
			PROPERTIES
				INTERFACE_INCLUDE_DIRECTORIES ${aws_include_dir}
				IMPORTED_LOCATION ${SOURCE_DIR}/aws-cpp-sdk-core/libaws-cpp-sdk-core.so
		)
		add_dependencies(RuBackup::libaws-cpp-sdk-core aws_ext)
	else()
		set_target_properties(RuBackup::libaws-cpp-sdk-core
			PROPERTIES
				#INTERFACE_INCLUDE_DIRECTORIES ${${INC_DIR}}
				IMPORTED_LOCATION ${${LIB_PATH}}
		)
	endif()
endfunction()

function(add_libaws_s3 LIB_PATH)
	add_library(RuBackup::libaws-cpp-sdk-s3 STATIC IMPORTED)

	if(NOT ${LIB_PATH})
		message("Path to libaws-cpp-sdk-core wasn't defined.\n It will be build along with and exclusivly for this project.\n To specify custom path to the library use ${LIB_PATH} variable")
		add_aws_project()
		ExternalProject_Get_Property(aws_ext SOURCE_DIR)
		create_aws_include_dir(${SOURCE_DIR} "install/include" aws_include_dir)
		set_target_properties(RuBackup::libaws-cpp-sdk-s3
			PROPERTIES
				INTERFACE_INCLUDE_DIRECTORIES ${aws_include_dir}
				IMPORTED_LOCATION ${SOURCE_DIR}/aws-cpp-sdk-s3/libaws-cpp-sdk-s3.so
		)
		add_dependencies(RuBackup::libaws-cpp-sdk-s3 aws_ext)
	else()
		set_target_properties(RuBackup::libaws-cpp-sdk-s3
			PROPERTIES
				#INTERFACE_INCLUDE_DIRECTORIES ${${INC_DIR}}
				IMPORTED_LOCATION ${${LIB_PATH}}
		)
	endif()
endfunction()

function(add_aws_project)
	if(NOT TARGET aws_ext)
		ExternalProject_Add(aws_ext
		  GIT_REPOSITORY    https://github.com/aws/aws-sdk-cpp.git
		  GIT_TAG           1.9.238
		  SOURCE_DIR        ""
		  BUILD_IN_SOURCE   1
    		  PATCH_COMMAND     wget https://github.com/orusnego/cmake_modules/blob/99c2d69a2eda516cf171ceb88007ac4e2b9dee1d/aws_changes.sh && chmod a+x ./aws_changes.sh && ./aws_changes.sh ../aws_ext
		  CONFIGURE_COMMAND cmake . -DCMAKE_INSTALL_PREFIX:PATH=install -DBUILD_ONLY=s3 -DENABLE_TESTING=OFF -DCMAKE_BUILD_TYPE=Release
		  BUILD_COMMAND     make
		  INSTALL_COMMAND   make install
		  TEST_COMMAND      ""
		  UPDATE_COMMAND    ""
		  EXCLUDE_FROM_ALL TRUE
		)
	endif()
endfunction()

function(create_aws_include_dir ROOT_DIR DIR_PATH INC_DIR)
	execute_process(COMMAND mkdir -p ${DIR_PATH}
		WORKING_DIRECTORY ${ROOT_DIR}
	)
	set(${INC_DIR} ${ROOT_DIR}/${DIR_PATH} PARENT_SCOPE)
endfunction()
