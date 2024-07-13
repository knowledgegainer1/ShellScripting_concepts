



source_dir="/tmp/logs_folder"
files=$(find $source_dir -type f -mtime +14 -name "*.log")
if [ ! -d $source_dir ]
then
 echo "error folder foesnt exist so creating directoei $source_dir"
 mkdir $source_dir
fi
files_array=($files)

echo "${files_array[@]}"

# for line in "${files_array[@]}"; do
#   rm -rf "$line"
# done
# while IFS= read -r line
# do
#  rm -rf $line
# done <<< $files


# for line  in ${files[@]}
# rm -rf $line