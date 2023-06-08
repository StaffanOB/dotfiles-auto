
SOURCE="$HOME/tmp/dir2/"
DESTINATION="$HOME/tmp/dir1/"
rsync -av --delete --dry-run $SOURCE $DESTINATION
