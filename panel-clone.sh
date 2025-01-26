#!/bin/bash


 Yellow_Color='\033[0;93m';
 Green_Color='\033[0;92m';
 No_Color='\033[0m';



 if [[ "${1}" == "var" || "${1}" == "micple.com" || "${1}" == "default.imp" || "${1}" == "storage.imp" || "${1}" == "panel" || "${1}" == "campaign" || "${1}" == "web" || "${1}" == "archives" || "${1}" == "files" ]]
 then


   echo -e "${Yellow_Color}Warning!!";
   echo "Your are trying to clone with protected filename!";
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
     echo "Your are trying to clone with protected filename!";
     echo "File Name: ${folderName}";
     echo -e "File Path: ${PWD} ${No_Color}";

     exit 1;
    fi


   rm -r "${folderName}";
   echo -e "${Green_Color}Successfully removed folder: ${No_Color}${folderName}";

else

  rm -r "${1}";
  if [[ "${?}" == 0 ]]
  then

    echo -e "${Green_Color}Successfully removed folder: ${No_Color}${1}";

  else

    echo -e "${Yellow_Color}Failed to removed folder: ${No_Color}${1}";
    echo -e "${Yellow_Color}Becouse the folder doesnot exist${No_Color}!"

  fi


fi


 if [[ "$PWD" == *"web"* ]]
 then
   if [[ "$PWD" == *"backend"* ]]
    then

     git clone "ssh://root@git.micple.com:24/var/git/micple.com/backend/${1}.git"

     if [[ "${?}" == 0 ]]
     then
       echo -e "${Green_Color}Git clone has been complited successfully !!!${No_Color}";
     else

       echo -e "${Yellow_Color}Failed to clone git repository! ${No_Color}";
       exit 1;

     fi

   elif [[ "$PWD" == *"frontend"* ]]
    then

      if [[ "$PWD" == *"2-profile"* ]]
        then
          git clone "ssh://root@git.micple.com:24/var/git/micple.com/frontend/2-profile/${1}.git"
      else
          git clone "ssh://root@git.micple.com:24/var/git/micple.com/frontend/${1}.git"
      fi

     if [[ "${?}" == 0 ]]
     then
       echo -e "${Green_Color}Git clone has been complited successfully !!!${No_Color}";
     else

       echo -e "${Yellow_Color}Failed to clone git repository! ${No_Color}";
       exit 1;

     fi

   fi

 elif [[ "$PWD" == *"panel"* ]]
 then

  if [[ "$PWD" == *"frontend"* ]]
   then

     git clone "ssh://root@git.micple.com:24/var/git/panel.micple.com/frontend/${1}.git"

     if [[ "${?}" == 0 ]]
     then
       echo -e "${Green_Color}Git clone has been complited successfully !!!${No_Color}";
     else

       echo -e "${Yellow_Color}Failed to clone git repository! ${No_Color}";
       exit 1;

     fi


   else

     git clone "ssh://root@git.micple.com:24/var/git/panel.micple.com/backend/${1}.git"
     echo "clone has been complited successfully !!!"

   fi

 elif [[ "$PWD" == *"default.imp"* ]]
 then

    git clone "ssh://root@git.micple.com:24/var/git/default/${1}.git"

    if [[ "${?}" == 0 ]]
     then
       echo -e "${Green_Color}Git clone has been complited successfully !!!${No_Color}";
     else

       echo -e "${Yellow_Color}Failed to clone git repository! ${No_Color}";
       exit 1;

     fi


 fi
