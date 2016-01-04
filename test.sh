for d in share/lair/*; do
    if [ -d $d ]; then
        for e in $d/*; do
            echo $e #>> debian/install
        done
    else
        echo $d #>> debian/install
    fi
done