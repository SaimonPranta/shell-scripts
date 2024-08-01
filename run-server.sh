!/bin/bash

# Define the directory path
directory_path="/var/micple.com/panel/frontend"

# Get the folder names and store them in an array
folder_array=($(ls -d $directory_path/*/ | xargs -n 1 basename))
 
for folder in "${folder_array[@]}"; do
   
  if [[ $folder != *backup* ]];
  then
    cd "${directory_path}/${folder}"
    echo "Navigate to $folder folder"
    echo "i am login as: $(whoami)"
    pm2 start "npm run build" --name "panel-${folder}"

    cd ../
   fi
done
