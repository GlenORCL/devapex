exec  apex_instance_admin.remove_workspace(p_workspace => 'PLAY_WS' );
drop user play cascade;
drop tablespace play_data including contents and datafiles;
