# deployHostingNoBuild.sh
cp -r ../../console/build/web/ public
firebase deploy --only hosting