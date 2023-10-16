#TODO: when tag will contain major version extract build version
execute_process(COMMAND /bin/bash "-c" "commit_id=$(git rev-parse --short HEAD); commit_tag=$(git tag --points-at $commit_id | tail -1); if [ \"$commit_tag\" != \"\" ]; then echo $commit_tag | cut -d- -f1 | cut -d. -f3-; else echo $commit_id; fi;"
	WORKING_DIRECTORY ${PROJ_DIR}
	OUTPUT_VARIABLE BUILD_VERSION
)
string(STRIP "${BUILD_VERSION}" BUILD_VERSION)

file(WRITE ${PROJ_DIR}/include/build_version.h.in
     "#ifndef BUILD_VERSION_H\n#define BUILD_VERSION_H\n\n#define RUBACKUP_BUILD \"\${BUILD_VERSION}\"\n\n#endif"
)

execute_process(COMMAND mkdir -p include
	WORKING_DIRECTORY ${PROJ_DIR}
)

configure_file(${PROJ_DIR}/include/build_version.h.in ${PROJ_DIR}/include/build_version.h)