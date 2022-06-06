
drop database link server_pc;

create database link server_pc
 connect to system identified by "123456"
 using '(DESCRIPTION =
       (ADDRESS_LIST =
         (ADDRESS = (PROTOCOL = TCP)
		 (HOST = 192.168.134.131)
		 (PORT = 1623))
       )
       (CONNECT_DATA =
         (SID = XE)
       )
     )'
;  
