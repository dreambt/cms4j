set timeStr=%date:~0,4%%date:~5,2%%date:~8,2%-%time:~0,2%%time:~3,2%%time:~6,2%
set backupPath="../"%timeStr%
"D:\Program Files\xampp\mysql\bin\mysqldump" -h 210.44.128.138 -ucms4j -pcms4j --default-character-set=utf8 --opt --extended-insert=false --triggers -R --hex-blob --single-transaction --max_allowed_packet=104857600 --net_buffer_length=16384 cms4j > %backupPath%cms.sql