#!/usr/bin/env bash

PROJECT_PROJECTION="{ "path": .path_with_namespace, "git": .ssh_url_to_repo }"

if [ -z "$GITLAB_PATH" ]; then
    echo "Please set the environment variable GITLAB_PATH"
    exit 1
fi

if [ -z "$GITLAB_PRIVATE_TOKEN" ]; then
    echo "Please set the environment variable GITLAB_PRIVATE_TOKEN"
    exit 1
fi

FILENAME="repos.json"

# clean up any old files since we'll now be appending to the file
[ -e $FILENAME  ] && rm $FILENAME

PAGE_COUNTER=1
while true; do
    echo "Reading page $PAGE_COUNTER"

    CURL_OUT=$(curl -s -k "${GITLAB_PATH}/api/v4/projects?private_token=$GITLAB_PRIVATE_TOKEN&per_page=999&page=$PAGE_COUNTER")
    if [ "$CURL_OUT" == "[]" ]; then break; fi


    echo $CURL_OUT | jq --raw-output --compact-output ".[] | $PROJECT_PROJECTION" >> "$FILENAME"
    let PAGE_COUNTER++
done

CURR_DIR=$(pwd)
while read repo; do
    THEPATH=$(echo "$repo" | jq -r ".path")
    GIT=$(echo "$repo" | jq -r ".git")
    if [ ! -d "$THEPATH" ]; then
        echo "Cloning $THEPATH ( $GIT )"
        mkdir -p "$THEPATH"
        cd "$THEPATH"
        cd ..
        git clone "$GIT" --quiet &
        cd "$CURR_DIR"
    else
        echo "Pulling $THEPATH"
        cd "$THEPATH"
        git pull --quiet &
        cd "$CURR_DIR"
    fi
done < "$FILENAME"
