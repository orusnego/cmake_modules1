list(APPEND server_package_subdirs
	rubackup_server
	utils/rb_bandwidth
	utils/rb_block_devices
	utils/rb_client_group
	utils/rb_clients
	utils/rb_cloud_task_queue
	utils/rb_clouds
	utils/rb_copy2pool
	utils/rb_global_config
	utils/rb_global_schedule
	utils/rb_inventory
	utils/rb_local_filesystems
	utils/rb_log_viewer
	utils/rb_media_servers
	utils/rb_modules
	utils/rb_notifications
	utils/rb_pools
	utils/rb_remote_replication
	utils/rb_repository
	utils/rb_strategies
	utils/rb_tape_cartriges
	utils/rb_tape_libraries
	utils/rb_task_queue
	utils/rb_tl_task_queue
	utils/rb_update
	utils/rb_user_groups
	utils/rb_users
)

list(APPEND client_package_subdirs
	rubackup_client
	rbc
	utils/rbfd
	utils/rbd
	utils/rb_archives
	utils/rb_init
	utils/rb_schedule
	utils/rb_tasks
	utils/rbcrypt
	modules/rb_module_block_device
	modules/rb_module_filesystem
	modules/rb_module_lvm
)

list(APPEND rbm_package_subdirs
	rbm
)

list(APPEND modules_package_subdirs
	modules/rb_module_aerodisk_vm
	modules/rb_module_brest_template
	modules/rb_module_brest_vm
	modules/rb_module_btrfs
	modules/rb_module_ceph_rbd
	modules/rb_module_docker_container
	modules/rb_module_docker_image
	modules/rb_module_docker_volume
	#modules/rb_module_filesystem_win
	modules/rb_module_jatoba1
	modules/rb_module_kvm
	modules/rb_module_lxd_container
	modules/rb_module_lxd_image
	modules/rb_module_mariadb101
	modules/rb_module_mongodb
	modules/rb_module_mysql57
	modules/rb_module_opennebula_template
	modules/rb_module_opennebula_vm
	modules/rb_module_oracle_dp_db
	modules/rb_module_oracle_dp_table
	modules/rb_module_oracle_rman
	modules/rb_module_postgresql10
	modules/rb_module_postgresql11
	modules/rb_module_postgresql12
	modules/rb_module_postgresql13
	modules/rb_module_postgresql9_6
	modules/rb_module_proxmox_container
	modules/rb_module_proxmox_vm
	modules/rb_module_redis
	modules/rb_module_rescue_image
	modules/rb_module_rvirt_vm
	modules/rb_module_s3_cloud_bucket
	modules/rb_module_template
	modules/rb_module_vmware
	modules/rb_module_zvirt_vm
	modules/rb_module_pg_superb
	modules/rb_module_postgresql
	modules/rb_module_ovirt
)


#==========Support functions===============

function(add_target_dependencies dest_target dependent_subdirs)
	foreach(_subdir IN LISTS ${dependent_subdirs})
		get_property(_subdir_targets DIRECTORY ${_subdir} PROPERTY BUILDSYSTEM_TARGETS)
		if(_subdir_targets)
			add_dependencies(${dest_target} ${_subdir_targets})
		endif()
	endforeach()
endfunction()

#==========Build targets setup===============

add_custom_target(rubackup_server_package ALL)
add_target_dependencies(rubackup_server_package server_package_subdirs)


add_custom_target(rubackup_client_package ALL)
add_target_dependencies(rubackup_client_package client_package_subdirs)


add_custom_target(rubackup_rbm_package ALL)
add_target_dependencies(rubackup_rbm_package rbm_package_subdirs)


add_custom_target(rubackup_modules_package ALL)
add_target_dependencies(rubackup_modules_package modules_package_subdirs)