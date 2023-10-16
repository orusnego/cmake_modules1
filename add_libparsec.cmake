list(APPEND libparsec_os_list
    "astra_1.7"
    "astra_1.6"
)


function(add_libparsec)
    if("${TARGET_OS}" IN_LIST libparsec_os_list)
        unset(LIBPARSECBASE_PATH CACHE)
        find_library(LIBPARSECBASE_PATH parsec-base)
        if(NOT LIBPARSECBASE_PATH)
            message( FATAL_ERROR "parsec-base.so cannot be found")
        endif()

        add_library(RuBackup::parsec-base SHARED IMPORTED)
        set_target_properties(RuBackup::parsec-base
                PROPERTIES
                IMPORTED_LOCATION ${LIBPARSECBASE_PATH}
        )

        unset(LIBPARSECCAP_PATH CACHE)
        find_library(LIBPARSECCAP_PATH parsec-cap)
        if(NOT LIBPARSECCAP_PATH)
            message( FATAL_ERROR "parsec-cap.so cannot be found")
        endif()
        add_library(RuBackup::parsec-cap SHARED IMPORTED)
        set_target_properties(RuBackup::parsec-cap
                PROPERTIES
                IMPORTED_LOCATION ${LIBPARSECCAP_PATH}
        )

        unset(LIBPARSECMAC_PATH CACHE)
        find_library(LIBPARSECMAC_PATH parsec-mac)
        if(NOT LIBPARSECMAC_PATH)
            message( FATAL_ERROR "parsec-mac.so cannot be found")
        endif()
        add_library(RuBackup::parsec-mac SHARED IMPORTED)
        set_target_properties(RuBackup::parsec-mac
                PROPERTIES
                IMPORTED_LOCATION ${LIBPARSECMAC_PATH}
        )
    endif()
endfunction()
