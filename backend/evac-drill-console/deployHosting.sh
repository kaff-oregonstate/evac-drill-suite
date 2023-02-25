# deployHosting.sh
cd ../../console
flutter build web --dart2js-optimization O4
cd ../backend/evac-drill-console
cp -r ../../console/build/web/ public
firebase deploy --only hosting