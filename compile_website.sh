if [[ "$#" -ne 2 ]]
then
    echo "Usage: compile_website.sh source_dir destination_dir"
else
    cd $1
    git pull
    cd /nfs/cds/share/teaching
    ml Sphinx
    rm -rf $2
    sphinx-build -a $1 $2
    nfs4_setfacl -P -R -a "A:fdg:D\biol-micro-sunagawa-primary@ethz.ch:RWX" $2
    nfs4_setfacl -P -R -a "A:fd:EVERYONE@:RX" $2
fi
