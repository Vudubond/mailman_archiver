#!/bin/bash
#Made by Orlando @Clausweb SRL
#Face truncate la arhivele de mailman de la 1 ianuarie anul curent pana la data de azi

# Check if the file exists
if [ -f "/usr/local/cpanel/3rdparty/mailman/scripts/prune_arch" ]; then
    echo "File /usr/local/cpanel/3rdparty/mailman/scripts/prune_arch found."
else
    echo -e "Error: File /usr/local/cpanel/3rdparty/mailman/scripts/prune_arch not found.\nDownload script using:\nsudo -u mailman wget -Nnv https://raw.githubusercontent.com/Vudubond/mailman_archiver/main/prune_arch -P /usr/local/cpanel/3rdparty/mailman/scripts/;chmod 0755 /usr/local/cpanel/3rdparty/mailman/scripts/prune_arch;"
    exit 1
fi

# Get today's date in seconds since Epoch (January 1, 2023)
today=$(date +%s)

# Get January 01 of the current year in seconds since Epoch
january_01=$(date -d "$(date +%Y)-01-01" +%s)

# Calculate the number of days from January 01 till today
days=$(( (today - january_01) / 86400 )) # 86400 seconds in a day

#echo "Number of days from January 01 till today: $days"

#echo "$days"

#Debug
#for i in `ls  /usr/local/cpanel/3rdparty/mailman/archives/private|grep -v ".mbox"|grep -v mailman`; do echo $i $days;done

for i in `ls  /usr/local/cpanel/3rdparty/mailman/archives/private|grep -v ".mbox"|grep -v mailman`; do sudo -u mailman /usr/local/cpanel/3rdparty/mailman/scripts/prune_arch -l $i -d $days;done
