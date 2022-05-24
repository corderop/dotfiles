#!/bin/bash

create_symbol_link () {
    ln -s $1 $2
}

list_of_folders () {
    ls -d */
}

get_lenght_of_json_array () {
    $1 | jq '. | length'
}

get_element_of_array () {
    $1 | jq ".[$2]"
}

get_value_from_array_by_key () {
    $1 | jq ".$2"
}

json_dotfile_file_exists () {
    test -f .dotfiles.json
}
