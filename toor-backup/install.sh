echo "BACKUP"
COMMAND="toor-backup"
FILES=("toor-backup.sh")
DLINK=("$HOME/.toor-backup")

# Install package
#sudo apt install rsync &> /dev/null 

# Setup cron job
declare -a CRONJOBS
CRONJOBS=(`crontab -l 2>/dev/null | awk '{print $6}'`)

# Check if job exists
jobexists='FALSE'
for i in ${CRONJOBS[@]}; do 
    if [[ "${DLINK[@]:0:10}" == "$i" ]]; then
        jobexists='TRUE'
    fi
done

if [[ "$jobexists" == 'FALSE' ]]; then
    echo "     * Setting up cron job ${DLINK[@]:0:10}"
    (crontab -l 2>/dev/null; echo "0 23 * * * $HOME/.toor-backup") | crontab -
else
    echo "     * Cron job already setup"
fi

