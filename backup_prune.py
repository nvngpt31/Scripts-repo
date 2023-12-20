#!/usr/bin/python3
# -*- coding: utf-8 -*-

# importing required modules
import os
import time
import logging
import stat

logging.basicConfig(level=logging.INFO, filename="/opt/backup.log", filemode="a", format="%(asctime)s - %(levelname)s - %(message)s")

#folder to clear from
dir_path = "/var/lib/mysqlbackups"
#No of days before which the files are to be deleted
limit_days = 21

treshold = time.time() - limit_days*86400
entries = os.listdir(dir_path)
for fname in entries:
    creation_time = os.stat(os.path.join(dir_path,fname)).st_ctime
    if creation_time < treshold:
        logging.info(f"The file is going to delete {(os.path.join(dir_path,fname))}")
        logging.info(f"file stat {time.gmtime(os.path.getmtime(os.path.join(dir_path,fname)))}")
        os.remove(os.path.join(dir_path,fname))