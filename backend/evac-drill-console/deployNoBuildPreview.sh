# deployPreview.sh
cp -r ../../console/build/web/ public
firebase hosting:channel:deploy $1 --expires 12h