#!/bin/bash

systemctl start mongod
pm2 start "mongod --config /etc/mongod.conf"

# This is for Web Frontend
web_frontend_directory_path="/var/micple.com/web/frontend"

# Get the folder names and store them in an array
frontend_folder_array=($(ls -d "$web_frontend_directory_path"/*/ | xargs -n 1 basename))

for folder in "${frontend_folder_array[@]}"; do
    if [[ $folder != *backup* && $folder != *copy* && $folder != *.git* ]]; then
        (cd "${web_frontend_directory_path}/${folder}" &&
         echo "Navigate to $folder folder" &&
         pm2 start "npm run build" --name "web-${folder}")
    fi
done

# This is for Web Backend
web_backend_directory_path="/var/micple.com/web/backend"

# Get the folder names and store them in an array
backend_folder_array=($(ls -d "$web_backend_directory_path"/*/ | xargs -n 1 basename))

for folder in "${backend_folder_array[@]}"; do
    if [[ $folder != *backup* && $folder != *copy* && $folder != *.git* ]]; then
        (cd "${web_backend_directory_path}/${folder}" &&
         echo "Navigate to $folder folder" &&
         pm2 start "npm run build" --name "web-${folder}")
    fi
done

# Other paths
timeline_path="/var/micple.com/web/frontend/2-profile/timeline"
panel_backend_path="/var/micple.com/panel/backend"
default_cloud_path="/var/micple.com/default.imp/cloud"
db_backup_server="/var/micple-backup-server/host-db-backup"

deploy-somachar > /dev/null 2>&1


# Check and start builds
if [ -d "$timeline_path" ]; then
    (cd "$timeline_path" &&
     echo "Navigate to timeline folder" &&
     pm2 start "npm run build" --name "web-timeline")
fi

if [ -d "$panel_backend_path" ]; then
    (cd "$panel_backend_path" &&
     echo "Navigate to panel backend folder" &&
     pm2 start "npm run build" --name "panel-backend")
fi

if [ -d "$default_cloud_path" ]; then
    (cd "$default_cloud_path" &&
     echo "Navigate to default cloud folder" &&
     pm2 start "npm run build" --name "default-cloud")
fi

if [ -d "$db_backup_server" ]; then
    (cd "$db_backup_server" &&
     echo "Navigate to databse backup server folder" &&
     pm2 start "npm run build" --name "db-backup-server")
fi

