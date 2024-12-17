#!/bin/bash

# Function to extract information from config file
extract_info() {
    local -A info_dict
    while IFS= read -r line; do
        if [[ $line =~ ^bind ]]; then
            binding=$(echo "$line" | sed 's/bind //g' | cut -d',' -f2-)
            action=$(echo "$line" | sed 's/bind //g' | cut -d',' -f3-)
            mod_key=$(echo "$line" | sed 's/bind //g' | cut -d',' -f1 | tr -d ':' )

            info_dict[$binding]="$mod_key|$action"
        fi
    done < $HOME/.config/hypr/configs/keybinds.conf

    # Print extracted information
    for binding in "${!info_dict[@]}"; do
        echo "Binding: $binding"
        key=${info_dict[$binding]}
        mod_key=$(echo "$key" | cut -d'|' -f1)
        action=$(echo "$key" | cut -d'|' -f2-)

        if [[ -z $mod_key ]]; then
            mod_key="N/A"
        fi

        echo "  Mod key: $mod_key"
        echo "  Action: $action"
        echo "  Script/Command: N/A"
        echo ""
    done
}

# Call function to extract information from config file
extract_info
