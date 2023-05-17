# gcloud secrets list --project=cpl-apigee-ng --format=json > secrets.json
# jq -c '.[].name' secrets.json > processed-secrets.json 

# while read line; do
#     # do stuff with $i
#     echo $line
#     prefix="projects/329187474656/secrets/"
#     suffix="\""
#     foo=${line#"$prefix"}
#     secret=$(echo $foo | awk -F $prefix '{print $2}' | awk -F $suffix '{print $1}')
#     echo $secret
#     secretValue=$(gcloud secrets versions access latest --project=cpl-apigee-ng --secret=$secret)
#     echo $secretValue
#     file_name=$(grep -lrw "$secret" ./config)
#     yq -i -o=json '(.[].entry[] | select(.value == '\"${secret}\"') | .value)='\"${secretValue}\"'' ${file_name}

# done < ./processed-secrets.json

merge_config() {
    for d in ./config/$1/* ; do
        echo "in the directory: $d"
        for f in $d/* ; do
        prefix="./"
        pf=${f#"$prefix"}
        echo "the processed file: $pf"
        isInArray=$(cat changed_files.json | jq '. | index("$pf") != null')
        echo "$(cat changed_files.json)"
        echo "isInArray: $isInArray"
        if [[ $isInArray ]];then
            echo "$pf not in changed files => removing"
            # rm -f $f
        fi
        done
        # suffix="/"
        # sf=${d%"$suffix"}
        # echo "the processed directory: $sf"
        # if [[ "$sf" == *"developerApp"* ]];then
        #     jq -s 'reduce .[] as $item ({}; . * $item)' $d/* > "$sf.json"
        # else
        #     jq -s 'reduce inputs as $i (.; .list += $i.list) | flatten' $d/* > "$sf.json"
        # fi
    done
}

merge_config "$1"
####
# export_projects() {
#     for i in "$1"/*; do
#         if [ -d "$i" ]; then
#             export_projects "$i"
#         elif [ -f "$i" ]; then
#             echo $i
#             jq -s 'reduce inputs as $i (.; .list += $i.list) | flatten' $i > "$i.json"
#         fi
#     done
# }

# export_projects "$1"
