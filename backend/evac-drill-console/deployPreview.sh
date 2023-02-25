# deployPreview.sh
cd ../../console
flutter build web --dart2js-optimization O4
cd ../backend/evac-drill-console
cp -r ../../console/build/web/ public
firebase hosting:channel:deploy $1 --expires 12h