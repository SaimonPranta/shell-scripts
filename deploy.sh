#!/bin/bash

 Yellow_Color='\033[0;93m';
 Green_Color='\033[0;92m';
 No_Color='\033[0m';

 if [[ "${1}" == "var" || "${1}" == "micple.com" || "${1}" == "default.imp" || "${1}" == "storage.imp" || "${1}" == "panel" || "${1}" == "campaign" || "${1}" == "web" || "${1}" == "archives" || "${1}" == "files" ]]
 then

   echo -e "${Yellow_Color}Warning!!";
   echo "Your are trying to deply in protected filename!";
   echo "File Name: ${1}";
   echo -e "File Path: ${PWD} ${No_Color}";

   exit 1;
 fi

 if [[ "${1}" == *"/"* ]]
 then

   folderName=${1##*\/};

    if [[ "${folderName}" == "var" || "${folderName}" == "micple.com" || "${folderName}" == "default.imp" || "${folderName}" == "storage.imp" || "${folderName}" == "panel" || "${folderName}" == "campaign" || "${folderName}" == "web" || "${folderName}" == "archives" || "${folderName}" == "files" ]]
    then

     echo -e "${Yellow_Color}Warning!!";
     echo "You are trying to deploy in protected folder!";
     echo "File Name: ${folderName}";
     echo -e "File Path: ${PWD} ${No_Color}";

     exit 1;
    fi

   echo "echo the file of (${PWD}${1})";
   cd "${PWD}${1}";


 else

  cd "${1}"

 fi




 if [[ $? -ne 0 ]]
 then
  echo -e "${Yellow_Color}This folder doesn't exist! ${No_Color}";
  exit 1
 fi


 if test -a "package.json"
 then
   npm install --force;
   echo -e "${Green_Color}Node Modules install Complited successfully ${No_Color}";
 else
    echo "${Yellow_Color}Didn't find any package.json file and failed to install Node Modules! ${No_Color}";
 fi



 if [[ "$PWD" == *"web"* ]]
 then
   if [[ "$PWD" == *"backend"* ]]
    then
     pm2 delete "web-backend-${1}";
     pm2 start "npm run build" --name "web-backend-${1}";

   elif [[ "$PWD" == *"frontend"* ]]
    then
      if [[ "$PWD" == *"timeline" && -e "node_modules/quill/dist/quill.snow.css" ]]
       then
          rm -r "node_modules/quill/dist/quill.snow.css"
          touch "node_modules/quill/dist/quill.snow.css"
       fi
      pm2 delete "web-${1}";
      pm2 start "npm run build" --name "web-${1}";


   fi

 elif [[ "$PWD" == *"panel"* ]]
 then

  if [[ "$PWD" == *"frontend"* ]]
   then
      pm2 delete "panel-${1}";
      pm2 start "npm run build" --name "panel-${1}";

   else
      pm2 delete "panel-${1}";
      pm2 start "npm run build" --name "panel-${1}";
   fi

 elif [[ "$PWD" == *"default.imp"* ]]
 then

      pm2 delete "default-${1}";
      pm2 start "npm run build" --name "default-${1}";


 fi

 cd ..