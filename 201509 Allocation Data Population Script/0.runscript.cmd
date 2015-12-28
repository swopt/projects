echo off
set server="[server]\[instance]"
set dbase=[database]
set usr=[dbusername]
set pwd=[dbpassword]

REM Windows Authentication Method. Please specify server and dbase parameters above.
sqlcmd -S %server% -d %dbase%  -E -i "%cd%/1.define_FIFO_function.sql" -o "%cd%/result-1.log"
type result-1.log
sqlcmd -S %server% -d %dbase%  -E -i "%cd%/2.prepare_tempdata_doc.sql" -o "%cd%/result-2.log"
type result-2.log
sqlcmd -S %server% -d %dbase%  -E -i "%cd%/3.prepare_tempdata_tran.sql" -o "%cd%/result-3.log"
type result-3.log
REM Uncomment following 2 lines to insert into actual tables. Proceed with caution.
REM sqlcmd -S %server% -d %dbase%  -E -i "%cd%/4.insert_into_actual_tables.sql" -o "%cd%/result-4.log"
REM type result-4.log
sqlcmd -S %server% -d %dbase%  -E -i "%cd%/5.cleanup.sql" -o "%cd%/result-5.log"
type result-5.log

REM SQL Authentication Method. Plese specify usr，pwd，server,dbase parameters above.
REM sqlcmd -S %server% -d %dbase%  -U %usr% -P %pwd% -i "%cd%/1.define_FIFO_function.sql" -o "%cd%/result-1.log"
REM type result-1.log
REM sqlcmd -S %server% -d %dbase%  -U %usr% -P %pwd% -i "%cd%/2.prepare_tempdata_doc.sql" -o "%cd%/result-2.log"
REM type result-2.log
REM sqlcmd -S %server% -d %dbase%  -U %usr% -P %pwd% -i "%cd%/3.prepare_tempdata_tran.sql" -o "%cd%/result-3.log"
REM type result-3.log
REM REM Uncomment following 2 lines to insert into actual tables. Proceed with caution.
REM REM sqlcmd -S %server% -d %dbase%  -U %usr% -P %pwd% -i "%cd%/4.insert_into_actual_tables.sql" -o "%cd%/result-4.log"
REM REM type result-4.log
REM sqlcmd -S %server% -d %dbase%  -U %usr% -P %pwd% -i "%cd%/5.cleanup.sql" -o "%cd%/result-5.log"
REM type result-5.log
pause