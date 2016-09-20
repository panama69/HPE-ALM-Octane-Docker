setup.xml - contains the values read by the installer tool.  this is what gets created and used.  to skip answering the questions on the screen, this could be modified directly and used and placed in the /opt/octane/conf folder.  this folder will need to be created.

From sqlplus
find oracle service use
  show parameter service;

find oracle table spaces use (https://docs.oracle.com/cd/B28359_01/server.111/b28310/tspaces014.htm)
  select * from v$tablespace
  
find oracle table owner and table space use (not really needed for octane deployment)
  select owner, table_name, tablespace_name from dba_tables where table_name='EMP';
  
find elasticsearch cluster name
  curl -XGET 'http://<es server>:9200/_cluster/health?pretty=true'
