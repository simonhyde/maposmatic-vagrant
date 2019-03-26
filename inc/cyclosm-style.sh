#! /bin/bash

cd /home/maposmatic/styles

git clone https://github.com/cyclosm/cyclosm-cartocss-style
cd cyclosm-cartocss-style

ln -s /home/maposmatic/shapefiles data

cd dem
for hillshade in /home/maposmatic/styles/OpenTopoMap/mapnik/dem/hillshade*
do
    ln -s $hillshade .
done
		 
sed -e 's/dbname: "osm"/dbname: "gis"/g' \
    -e 's/http:\/\/data.openstreetmapdata.com\/simplified-land-polygons-complete-3857.zip/.\/data\/simplified-land-polygons-complete-3857\/simplified_land_polygons.shp/g' \
    -e 's/http:\/\/data.openstreetmapdata.com\/land-polygons-split-3857.zip/.\/data\/land-polygons-split-3857\/land_polygons.shp/g' \
    -e 's/layer~/layer::text~/g' \
    < project.mml > cyclosm.mml

carto -a $(mapnik-config -v) --quiet cyclosm.mml > cyclosm.xml
php /vagrant/files/postprocess-style.php cyclosm.xml

cat <<EOF >> /home/maposmatic/ocitysmap/ocitysmap.styledefs
[cyclosm]
name: CyclOSM
group: Sports
description: CyclOSM style
path: /home/maposmatic/styles/cyclosm-cartocss-style/cyclosm.xml
url: http://www.osm-baustelle.de/dokuwiki/style:cyclosm
annotation: CyclOSM style

EOF

echo "  cyclosm," >> /home/maposmatic/ocitysmap/ocitysmap.styles