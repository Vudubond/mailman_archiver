#!/bin/bash
#Made by Vu3u @github.com/Vudubond/mailman_archiver
#It truncates the mailman archives from January 1 of the current year until today on a cPanel server

# Get today's date in seconds since Epoch (January 1, 2023)
today=$(date +%s)

# Get January 01 of the current year in seconds since Epoch
january_01=$(date -d "$(date +%Y)-01-01" +%s)

# Calculate the number of days from January 01 till today
days=$(( (today - january_01) / 86400 )) # 86400 seconds in a day

#echo "Number of days from January 01 till today: $days"

echo "$days"

#Debug
#for i in `ls  /usr/local/cpanel/3rdparty/mailman/archives/private|grep -v ".mbox"|grep -v mailman`; do echo $i $days;done

for i in `ls  /usr/local/cpanel/3rdparty/mailman/archives/private|grep -v ".mbox"|grep -v mailman`; do /usr/local/cpanel/3rdparty/mailman/scripts/prune_arch -l $i -d $days;done
