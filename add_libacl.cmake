list(APPEND libacl_os_list
    "ubuntu_18.04"
    "ubuntu_20.04"
    "astra_1.7"
    "astra_1.6"
    "centos7"
    "centos8"
    "redos_7.3"
    "altlinux_10"
    "altlinux_9"
    "altlinux_8"
)

function(add_libacl)
    if("${TARGET_OS}" IN_LIST libacl_os_list)
        unset(LIBACL_PATH CACHE)
        find_library(LIBACL_PATH acl)
        if(NOT LIBACL_PATH)
            message( FATAL_ERROR "libacl.so cannot be found")
        else()
            add_library(RuBackup::libacl SHARED IMPORTED)
            set_target_properties(RuBackup::libacl
                    PROPERTIES
                    IMPORTED_LOCATION ${LIBACL_PATH}
            )
        endif()
    endif()
endfunction()