
SOURCE=("Documents" "Pictures" "Music" "Videos" "develop")
DESTINATION="backups/desktop1"

for i in "${SOURCE[@]}"; do
    rsync -av --delete $HOME/$i 192.168.1.3:$DESTINATION/
done
