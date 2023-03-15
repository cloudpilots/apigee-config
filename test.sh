gcloud secrets list --project=cpl-apigee-ng --format=json > secrets.json
jq -c '.[].name' secrets.json > processed-secrets.json 

while read line; do
    # do stuff with $i
    echo $line
    prefix="projects/329187474656/secrets/"
    suffix="\""
    foo=${line#"$prefix"}
    secret=$(echo $foo | awk -F $prefix '{print $2}' | awk -F $suffix '{print $1}')
    echo $secret
    secretValue=$(gcloud secrets versions access latest --project=cpl-apigee-ng --secret=$secret)
    echo $secretValue
    file_name=$(grep -lrw "$secret" ./config)
    yq -i -o=json '(.[].entry[] | select(.value == '\"${secret}\"') | .value)='\"${secretValue}\"'' ${file_name}

done < ./processed-secrets.json

# for d in */ ; do
#     echo "$d"
#     suffix="/"
#     sf=${d%"$suffix"}
#     jq -s 'reduce inputs as $i (.; .list += $i.list) | flatten' $d/* > "$sf.json"
# done

