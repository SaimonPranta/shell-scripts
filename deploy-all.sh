#!/bin/bash

Yellow_Color='\033[0;93m'
Green_Color='\033[0;92m'
No_Color='\033[0m'

for item in *; do

    clone "${item}"
    if [[ "${?}" == 0 ]]; then
        echo -e "${Green_Color}Clone script executed successfully ${No_Color}"
        deploy "${item}"
        if [[ "${?}" == 0 ]]; then
            echo -e "${Green_Color}Deploy script executed successfully ${No_Color}"
        else
            echo -e "${Yellow_Color}Failed to execute deploy script! ${No_Color}"
        fi

    else
        echo -e "${Yellow_Color}Failed to execute clone script! ${No_Color}"
    fi
done
