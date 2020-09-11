#!/bin/sh
NOW=$(date +"%Y-%m-%d")

#1 SQL

echo -e "\n################ Report - 1 ###############\n" >> /home/Scripts/data/Report_$NOW.csv
echo -e "Active Users Report:" >> /home/Scripts/data/Report_$NOW.csv
mysql --login-path=root dbname -A -e "SELECT count(default_role_level) as Total_Users, SUM(IF(active=1,1,0)) as Total_Active_Users from dbname.table1;" -B | sed "s/'/\'/;s/\t/\",\"/g;s/^/\"/;s/$/\"/;s/\n//g" >> /home/Scripts/data/Report_$NOW.csv

#2 SQL

echo -e "\n################ Report - 2 ###############\n" >> /home/Scripts/data/Report_$NOW.csv
echo -e "Inactive Users Report:" >> /home/Scripts/data/Report_$NOW.csv
mysql --login-path=root dbname -A -e "SELECT count(default_role_level) as Total_Users, SUM(IF(active=0,1,0)) as Total_Inactive_Users from dbname.table1;" -B | sed "s/'/\'/;s/\t/\",\"/g;s/^/\"/;s/$/\"/;s/\n//g" >> /home/Scripts/data/Report_$NOW.csv

#3 SQL

echo -e "\n################ Report - 3 ###############\n" >> /home/Scripts/data/Report_$NOW.csv
mysql --login-path=root dbname -A -e "SELECT SUM(IF(active=0 and  last_seen_time < DATE_SUB( now(), INTERVAL 1 Month),1,0)) as Total_InActive_Users from dbname.table1;" -B | sed "s/'/\'/;s/\t/\",\"/g;s/^/\"/;s/$/\"/;s/\n//g" >> /home/Scripts/data/Report_$NOW.csv

#4 SQL

echo -e "\n################ Report - 4  ###############\n" >> /home/Scripts/data/Report_$NOW.csv
echo -e "Accounts to be activated Report:" >> /home/Scripts/data/Report_$NOW.csv
mysql --login-path=root dbname -A -e "select count(id) from dbname.tablename where active=0 and status = 'Invited' and login_id NOT LIKE '%gmail%';" -B | sed "s/'/\'/;s/\t/\",\"/g;s/^/\"/;s/$/\"/;s/\n//g" >> /home/Scripts/data/Report_$NOW.csv

#6 SQL

echo -e "\n################ Report - 5 ###############\n" >>  /home/Scripts/data/Report_$NOW.csv
echo -e "New Users Report:" >>  /home/Scripts/data/Report_$NOW.csv
mysql --login-path=root dbname -A -e "SELECT monthname(created_date)as Month,year(created_Date) as Year,SUM(IF(default_role_level=99,1,0)) AS Registered_Mobile_Users,
SUM(IF(default_role_level!=99,1,0)) as Registered_Web_Users,COUNT(default_role_level) as TOTAL,SUM(IF(default_role_level=99 and active=0,1,0)) AS Mobile_Inactive_Users,SUM(IF(default_role_level!=999 and active=0,1,0)) as Web_Inactive_Users,
SUM(IF(active=0,1,0)) as Total_Inactive_Count from dbname.tablename where login_id NOT LIKE '%gmail%' group by monthname(created_Date),year(created_Date);" -B | sed "s/'/\'/;s/\t/\",\"/g;s/^/\"/;s/$/\"/;s/\n//g" >> /home/Scripts/data/Report_$NOW.csv

#19 SQL

echo -e "\n################ Report -6 ###############\n" >> /home/Scripts/data/Report_$NOW.csv
echo -e "New users [ Started < 2 Weeks ] Report:" >> /home/Scripts/data/Report_$NOW.csv
mysql --login-path=root dbname -A -e "select count(id) from dbname.tablename where active=1 and date(created_date) >= (CURDATE() - 14);" -B | sed "s/'/\'/;s/\t/\",\"/g;s/^/\"/;s/$/\"/;s/\n//g" >> /home/Scripts/data/Report_$NOW.csv

#24 SQL

echo -e "\n################ Report - 7  ###############\n" >> /home/Scripts/data/Report_$NOW.csv
echo -e "Time to create Work Order Report:" >> /home/Scripts/data/Report_$NOW.csv
mysql --login-path=root dbname -A -e "select created_date,work_order_id from dbname.tablename;" -B | sed "s/'/\'/;s/\t/\",\"/g;s/^/\"/;s/$/\"/;s/\n//g" >> /home/Scripts/data/Report_$NOW.csv


#25 SQL

echo -e "\n################ Report - 8  ###############\n" >> /home/Scripts/data/Report_$NOW.csv
echo -e "Creation of Work Order Report:" >> /home/Scripts/data/Report_$NOW.csv
mysql --login-path=root dbname -A -e "select count(work_order_id) from dbname.tablename;" -B | sed "s/'/\'/;s/\t/\",\"/g;s/^/\"/;s/$/\"/;s/\n//g" >> /home/Scripts/data/Report_$NOW.csv


#26 SQL

echo -e "\n################ Report - 9 ###############\n" >> /home/Scripts/data/Report_$NOW.csv
echo -e " Report on Work Orders Approved status:" >> /home/Scripts/data/Report_$NOW.csv
mysql --login-path=root dbname -A -e "select count(work_order_id) from dbname.tablename where status='Approved';" -B | sed "s/'/\'/;s/\t/\",\"/g;s/^/\"/;s/$/\"/;s/\n//g" >> /home/Scripts/data/Report_$NOW.csv


#29 SQL

echo -e "\n################ Report - 10 ###############\n" >> /home/Scripts/data/Report_$NOW.csv
echo -e "Report on Work Orders scheduled status:" >> /home/Scripts/data/Report_$NOW.csv
mysql --login-path=root dbname -A -e "select count(work_order_id) AS Status_On_Work_Orders_Completed from dbname.tablename where status='Scheduled';" -B | sed "s/'/\'/;s/\t/\",\"/g;s/^/\"/;s/$/\"/;s/\n//g" >> /home/Scripts/data/Report_$NOW.csv

#30 SQL

echo -e "\n################ Report - 11 ###############\n" >> /home/Scripts/data/Report_$NOW.csv
echo -e "Report on Work Orders dispatched status:" >> /home/Scripts/data/Report_$NOW.csv
mysql --login-path=root dbname -A -e "select count(work_order_id) AS Status_On_Work_Orders_Dispatched from dbname.tablename where status='Dispatched';" -B | sed "s/'/\'/;s/\t/\",\"/g;s/^/\"/;s/$/\"/;s/\n//g" >> /home/Scripts/data/Report_$NOW.csv


#31 SQL

echo -e "\n################ Report - 12  ###############\n" >> /home/Scripts/data/Report_$NOW.csv
echo -e "Report on Number of tasks created status:" >> /home/Scripts/data/Report_$NOW.csv
mysql --login-path=root dbname -A -e "select count(task_id) AS No_Of_Tasks_Created from dbname.tablename;" -B | sed "s/'/\'/;s/\t/\",\"/g;s/^/\"/;s/$/\"/;s/\n//g" >> /home/Scripts/data/Report_$NOW.csv

# 32 SQL

echo -e "\n################ Report - 13  ###############\n" >> /home/Scripts/data/Report_$NOW.csv
echo -e "Report on Number of tasks Scheduled and Dispatched status:" >> /home/Scripts/data/Report_$NOW.csv
mysql --login-path=root dbname -A -e "SELECT SUM(CASE WHEN status = 'Dispatched' THEN 1 ELSE 0 END) AS Number_Of_Task_Dispatched,SUM(CASE WHEN status = 'Completed' THEN 1 ELSE 0 END) AS Number_Of_Task_Completed FROM dbname.tablename;" -B | sed "s/'/\'/;s/\t/\",\"/g;s/^/\"/;s/$/\"/;s/\n//g" >> /home/Scripts/data/Report_$NOW.csv

# 33 SQL

echo -e "\n################ Report - 14  ###############\n" >> /home/Scripts/data/Report_$NOW.csv
echo -e "Report on Number of tasks pending Approval status:" >> /home/Scripts/data/Report_$NOW.csv
mysql --login-path=root dbname -A -e "select count(task_id) AS Status_On_Task_Pending_Approval from dbname.tablename where status='Pending Approval';" -B | sed "s/'/\'/;s/\t/\",\"/g;s/^/\"/;s/$/\"/;s/\n//g" >> /home/Scripts/data/Report_$NOW.csv

# 34 SQL

echo -e "\n################ Report - 15  ###############\n" >> /home/Scripts/data/Report_$NOW.csv
echo -e "Report on Number of tasks Approved status:" >> /home/Scripts/data/Report_$NOW.csv
mysql --login-path=root dbname -A -e "select count(task_id) AS Status_On_Task_Approved from dbname.tablename where status='Approved';" -B | sed "s/'/\'/;s/\t/\",\"/g;s/^/\"/;s/$/\"/;s/\n//g" >> /home/Scripts/data/Report_$NOW.csv


# 35 SQL

echo -e "\n################ Report - 16  ###############\n" >> /home/Scripts/data/Report_$NOW.csv
echo -e "Report on Number of tasks Rejected status:" >> /home/Scripts/data/Report_$NOW.csv
mysql --login-path=root dbname -A -e "select count(task_id) AS Status_On_Task_Rejected from dbname.tablename where status='Rejected';" -B | sed "s/'/\'/;s/\t/\",\"/g;s/^/\"/;s/$/\"/;s/\n//g" >> /home/Scripts/data/Report_$NOW.csv

find /home/Scripts/data/Report_2020* -type f -mtime +10 -exec rm {} \;
