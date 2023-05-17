merge_config() {
    echo "$(cat .github/outputs/all_changed_files.json)"
    for d in ./config/$1/* ; do
        echo "in the directory: $d"
        for f in $d/* ; do
        prefix="./"
        pf=${f#"$prefix"}
        echo "the processed file: $pf"
        isInArray=$(jq -e --arg file "$pf" '.|any(. == $file)' .github/outputs/all_changed_files.json)
        echo "isInArray: $isInArray"
        if [[ $isInArray == false ]];then
            echo "$pf not in changed files => removing"
            rm -f $f
        fi
        done
        suffix="/"
        sf=${d%"$suffix"}
        echo "the processed directory: $sf"
        if [[ "$sf" == *"developerApp"* ]];then
            jq -s 'reduce .[] as $item ({}; . * $item)' $d/* > "$sf.json" || continue
        else
            jq -s 'reduce inputs as $i (.; .list += $i.list) | flatten' $d/* > "$sf.json" || continue
        fi
    done
}

merge_config "$1"
