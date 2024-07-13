



source_dir="/tmp/logs_folder"
files=$(find . -type f -mtime +14 -name "*.log")
if [ ! -d $source_dir ]
then
 echo "error folder foesnt exit"
 exit 1
fi


when IFS=read -r line
do
rm -rf $line
done <<< $files