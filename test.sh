gcloud secrets list --project=cpl-apigee-ng --format=json > secrets.json
SECRETS=$(gcloud secrets list --project=cpl-apigee-ng --format=json)
jq -c '.[].name' secrets.json | while read i; do
    # do stuff with $i
    prefix="projects/329187474656/secrets/"
    secret=${i#"$prefix"}
    echo $secret
    # gcloud secrets versions access latest --secret=$$secret
done
# for d in */ ; do
#     echo "$d"
#     suffix="/"
#     sf=${d%"$suffix"}
#     jq -s 'reduce inputs as $i (.; .list += $i.list) | flatten' $d/* > "$sf.json"
# done

