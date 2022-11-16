set define '^' verify on
set concat on
set concat .
 
Rem
Rem    Title:  rm_apex_base.sql
Rem
Rem    Description:  This script will cleanup all objects created by script apex_base.sql
Rem
Rem    Notes:  It is assumed that this script is run as a DBA user.
Rem
Rem            **** THIS SCRIPT IS DESTRUCTIVE **** - It will drop tablespaces, data files, workspaces, schemas, etc.
Rem

column foo1 new_val LOG1
select 'rm_apex_base_'||to_char(sysdate,'YYYY-MM-DD_HH24-MI-SS')||'.log' as foo1 from sys.dual;
spool ^LOG1
 
 
timing start "Remove all workspaces, schemas and tablespaces"
 
--
-- Step 1:  Remove the APEX Workspaces
--
--
begin
    apex_instance_admin.remove_workspace(
        p_workspace      => 'GJM_WS' );
end;
/
 
--
-- Step 2:  Drop the database users
--
--
drop user gjm cascade;
 
--
-- Step 3:  Drop the tablespaces 
--
--
drop tablespace gjm_data including contents and datafiles;

timing stop
spool off