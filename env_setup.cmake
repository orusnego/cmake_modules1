include(add_libpq)
include(add_cppcrypto)
include(add_libaws)
include(add_libpqxx)
include(add_libacl)
include(add_libparsec)
include(add_oracle)
include(add_liblzma)
include(add_qt5)
include(add_libyaml_cpp)
include(add_vix_disklib)
include(ExternalProject)

macro(env_setup)
	set(_raw_args ${ARGN})
	foreach(_arg IN LISTS _raw_args)
		list(APPEND _args ${_arg})
	endforeach()

	#Add Boost
	list(APPEND boost_components
		system
		filesystem
		thread
		serialization
		chrono
		locale
		program_options
		json
	)
	foreach(_comp IN LISTS boost_components)
		if(Boost::${_comp} IN_LIST _args)
			set(Boost_USE_STATIC_LIBS ON)
			find_package(Boost 1.78 COMPONENTS ${_comp} REQUIRED)
		endif()
	endforeach()

	#Add OpenSSL
	list(APPEND openssl_components
		Crypto
		SSL
	)
	foreach(_comp IN LISTS openssl_components)
		if(OpenSSL::${_comp} IN_LIST _args)
			find_package(OpenSSL COMPONENTS ${_comp} REQUIRED)
		endif()
	endforeach()

	#Add libcppcrypto
	#TODO: Add check for yasm package
	if(RuBackup::libcppcrypto IN_LIST _args)
		add_libcppcrypto(LIBCPPCRYPTO_INC_DIR LIBCPPCRYPTO_BIN_PATH)
	endif()

	#Add libpq
	#Check if it was already added by top level project
	if(RuBackup::libpq IN_LIST _args)
		add_libpq(LIBPQ_INC_DIR LIBPQ_BIN_PATH)
	endif()

	#Add libpqxx
	if(RuBackup::libpqxx IN_LIST _args)
		add_libpqxx(LIBPQXX_INC_DIR LIBPQXX_BIN_PATH)
	endif()

	#Add AWS
	if(RuBackup::libaws-cpp-sdk-core IN_LIST _args)
		add_libaws_core(LIBAWS_CPP_SDK_CORE_INC_DIR LIBAWS_CPP_SDK_CORE_BIN_PATH)
#  		if(${TARGET_OS} MATCHES debian_10)
#			fix_curl()
#		endif()  		
	endif()
	if(RuBackup::libaws-cpp-sdk-s3 IN_LIST _args)
		add_libaws_s3(LIBAWS_CPP_SDK_S3_INC_DIR LIBAWS_CPP_SDK_S3_BIN_PATH)
	endif()

	#Add ACL
	if(RuBackup::libacl IN_LIST _args)
		add_libacl()
	endif()

	#Add Liblzma
	if(RuBackup::liblzma IN_LIST _args)
		add_liblzma(LIBLZMA_INC_DIR LIBLZMA_BIN_PATH)
	endif()

	#Add Libyamp_cpp
	if(RuBackup::libyaml_cpp IN_LIST _args)
		add_libyaml_cpp(LIBYAML_CPP_INC_DIR LIBYAML_CPP_BIN_PATH)
	endif()

	# Add libparsec
	if(RuBackup::libparsec IN_LIST _args)
		add_libparsec()
	endif()

	#Add QT
	list(APPEND qt_components
		Core
		Gui
		Widgets
		Network
		Sql
		LinguistTools
	)

	#TODO: temporary solution
	if(${TARGET_OS} MATCHES astra_1.7)
		list(APPEND qt_components
			Qml
			Quick
			Test
		)
	endif()

	foreach(_comp IN LISTS qt_components)
		if(Qt5::${_comp} IN_LIST _args)
			find_package(Qt5 COMPONENTS ${_comp} REQUIRED)
		endif()
	endforeach()

	#Add RuBackup QT
	add_qt()
# 	if(${TARGET_OS} MATCHES debian_10)
#		fix_qt()
#	endif()

	#Add LibXml2
	if(LibXml2::LibXml2 IN_LIST _args)
		find_package(LibXml2 REQUIRED)
	endif()

	#Add Oracle
	if ((RuBackup::libocci IN_LIST _args) OR
		(RuBackup::libclntshcore IN_LIST _args) OR
		(RuBackup::libclntsh IN_LIST _args))
		add_oracle_libs(ORACLE_BIN_PATH)
	endif()
	if(RuBackup::oracle_headers IN_LIST _args)
		add_oracle_headers(ORACLE_INC_DIR)
	endif()

	#Add vix disk lib
	if(RuBackup::vix_disklib IN_LIST _args)
		add_vix_disklib()
	endif()
endmacro()
