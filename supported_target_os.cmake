function(check_target_os)
	list(APPEND supported_os_targets
		ubuntu_18.04
		ubuntu_20.04
		altlinux_10
		altlinux_9
		altlinux_8
		astra_1.7
		astra_1.6
		centos7
		centos8
		debian_10
		#oracle_linux
		redos_7.3
		windows_server_2016
		#mac
	)

	if((NOT TARGET_OS) OR (NOT ${TARGET_OS} IN_LIST supported_os_targets))
		message( FATAL_ERROR "Please specify correct TARGET_OS variable to run the build.
	  Available values are: ${supported_os_targets}
	  Example: cmake -DTARGET_OS=ubuntu_18.04 .")
	endif()
endfunction()