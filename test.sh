for d in */ ; do
    echo "$d"
    suffix="/"
    sf=${d%"$suffix"}
    jq -s 'reduce inputs as $i (.; .list += $i.list) | flatten' $d/* > "$sf.json"
done

