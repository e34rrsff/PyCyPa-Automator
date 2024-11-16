#reminders
read -p "Ensure you have created the goodUsers.txt and goodAdmin.txt files. Press any key to continue..."

#update
sudo apt update && sudo apt -y upgrade

#sort goodUsers.txt
sort goodUsers.txt >> tmp.txt
mv tmp.txt goodUsers.txt

#sort goodAdmin.txt
sort goodAdmin.txt >> tmp.txt
mv tmp.txt goodAdmin.txt

#get a list of users
cut -d: -f1 /etc/passwd | sort > users.txt

#get a list of administrators
getent group sudo | cut -d: -f4 | tr ',' '\n' | sort > admin.txt

#get a list of installed applicatons
sudo apt list --installed | cut -d/ -f1 > installed.txt

#get a list of aftermarket applications installed
comm -23 installed.txt defaultInstalled.txt > susApps.txt

#search for media files
sudo find /home -name '*.mp3' -o -name '*.mp4' -o -name '*.avi' -o -name  '*.wav' -o -name '*.ogg' > media.txt

#set up password requirements
sudo cp common-password /etc/pam.d/

#set secure passwords for all users

#get a list of all users who are not admin
comm -23 <(ls /home | tr ' ' '/n' | sort) admin.txt > notAdmin.txt
while read -r line; do
echo "CyberSecurity123*!" | sudo passwd $line --stdin
done < notAdmin.txt

#set all standard users passwords
sudo chpasswd < tempPasswd.txt
rm tempPasswd.txt

#identify not good users
cat goodUsers.txt goodAdmin.txt > allGoodUsers.txt
sort allGoodUsers.txt > tmp.txt
mv tmp.txt allGoodUsers.txt
comm -23 notAdmin.txt goodUsers.txt > badUsers.txt

#delete bad users
while read -r line; do
sudo userdel $line
done < badUsers.txt

#identify not good admin
comm -23 admin.txt goodAdmin.txt > badAdmin.txt

#delete bad admin
while read -r line; do
sudo userdel $line
done < badAdmin.txt

#clean the bashrc file
cp bashrc ~/.bashrc

#check for any aliases
comm -23 <(alias) aliases.txt > susAliases.txt

#check for any 0 uid users
awk -F: '($3 <= 0) {printf "%s:%s\n",$1,$3}' /etc/passwd > 0IDUsers.txt

#check the crontabs
sudo cp /etc/crontab ./this.crontab
sudo chmod a+rw this.crontab
sort this.crontab > tmp.txt
cp tmp.txt this.crontab
sort crontab > tmp.txt
cp tmp.txt crontab
comm -23 this.crontab crontab > susCrons.txt

#check for daemons
sort enabledDaemons.txt > tmp.txt
cp tmp.txt enabledDaemons.txt
sort runningDaemons.txt > tmp.txt
cp tmp.txt runningDaemons.txt
comm -23 <(sudo systemctl list-unit-files | grep enabled | sort) enabledDaemons.txt > susDaemons.txt
comm -23 <(sudo systemctl list-unit-files | grep running | sort) runningDaemons.txt >> susDaemons.txt

#clean resolv.conf
sudo cp resolv.conf /etc/resolv.conf

#check for open ports
sudo apt install net-tools -y
sudo netstat -plnt > susPorts.txt

#set ufw
sudo apt install ufw gufw -y
sudo ufw enable

#ensure root account is disabled
sudo cp sshd_config /etc/ssh/sshd_config
sudo systemctl restart sshd

#set up auditing
sudo apt install auditd -y
sudo systemctl enable auditd
sudo systemctl start auditd

#set up auto update
sudo apt install unattended-upgrades -y
sudo systemctl enable unattended-upgrades
sudo systemctl start unattended-upgrades

#clean the repositories
sort sources.list > tmp.txt
cp tmp.txt sources.list
sudo cp /etc/apt/sources.list ./unsorted.sources.list
sudo chmod a+rw this.sources.list
sort unsorted.sources.list > this.sources.list
comm -23 this.sources.list sources.list > susRepos.txt

#install and run a virus scan
sudo apt install clamav -y
sudo systemctl stop clamav-freshclam.service
sudo freshclam
sudo systemctl start clamav-freshclam.service
sudo clamscan -r / --infected > infected.txt

#clean apache permissions or remove if necessary
