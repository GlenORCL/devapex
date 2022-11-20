exec  apex_instance_admin.remove_workspace(p_workspace => 'GJM_WS' );
drop user gjm cascade;
drop tablespace gjm_data including contents and datafiles;
