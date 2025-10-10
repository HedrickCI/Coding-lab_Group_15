Group 15's Hospital Data Management Sys. On Logging and Archiving crucial data 

In the beginning this repo contained python simulators, And these python simulators contained three key datum. And then Dan said, let there be logging, and then there was "archive_logs.sh".

archive_logs.sh is our script that manages log rotation. It provides a usable, numbered menu of log files, and archives the selected current log file by moving it to the design dir, then renames the archived file with a timestamp. After it does this it creates a new empty log files so that the simulator can continue writing data. 

And Hevid (Hedrick and David) saw that this wasnt fit and said, let there be "analyze_log.sh" so that reports can be generated on the current active log data.

analyze_logs.sh is the script we made to analyze the total occurences of each unique device ID in the log, using CLI tools (awk,sort,uniq). The results include device vounts and timestamps of the first and last entries.

And so after four days of bugs, slow internet google meets and a lot of mental spiraling, we tested a reports/analysis_report.txt and it had DATA in it!

The system is organized to separate active logs, archives and reports in a tree structure where the directory hospital_data is subdivided into active logs, and three different archives for each measure, and also a generated .txt file that is the cumulative output of log analyses
