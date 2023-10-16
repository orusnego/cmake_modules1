#Extract major,minor and patch versions from tag
execute_process(COMMAND /bin/bash "-c" "commit_id=$(git rev-parse --short HEAD); commit_tag=$(git tag --points-at $commit_id | tail -1); if [ \"$commit_tag\" != \"\" ]; then echo $commit_tag | cut -d. -f1; else echo 0; fi;"
	WORKING_DIRECTORY ${PROJ_DIR}
	OUTPUT_VARIABLE MAJOR_VERSION
)
execute_process(COMMAND /bin/bash "-c" "commit_id=$(git rev-parse --short HEAD); commit_tag=$(git tag --points-at $commit_id | tail -1); if [ \"$commit_tag\" != \"\" ]; then echo $commit_tag | cut -d. -f2; else echo 1; fi;"
	WORKING_DIRECTORY ${PROJ_DIR}
	OUTPUT_VARIABLE MINOR_VERSION
)
execute_process(COMMAND /bin/bash "-c" "commit_id=$(git rev-parse --short HEAD); commit_tag=$(git tag --points-at $commit_id | tail -1); if [ \"$commit_tag\" != \"\" ]; then echo $commit_tag | cut -d. -f3; else echo $commit_id; fi;"
	WORKING_DIRECTORY ${PROJ_DIR}
	OUTPUT_VARIABLE PATCH_VERSION
)

string(STRIP "${MAJOR_VERSION}" MAJOR_VERSION)
string(STRIP "${MINOR_VERSION}" MINOR_VERSION)
string(STRIP "${PATCH_VERSION}" PATCH_VERSION)

file(WRITE ${PROJ_DIR}/include/component_version.h.in
     "#ifndef COMPONENT_VERSION_H\n#define COMPONENT_VERSION_H\n\n#define MAJOR_VERSION \"\${MAJOR_VERSION}\"\n#define MINOR_VERSION \"\${MINOR_VERSION}\"\n#define PATCH_VERSION \"\${PATCH_VERSION}\"\n\n#endif"
)

execute_process(COMMAND mkdir -p include
	WORKING_DIRECTORY ${PROJ_DIR}
)

configure_file(${PROJ_DIR}/include/component_version.h.in ${PROJ_DIR}/include/component_version.h)