CREATE OR REPLACE VIEW planet_osm_polygon AS
SELECT osm_id
-- original columns
, layer    as layer
, tags     as "tags"
, way      as "way"
, way_area as way_area
, z_order  as z_order
-- calculated columns
, osml10n_get_placename_from_tags(tags,true,false,chr(10),'de',way) as localized_name_second
, osml10n_get_placename_from_tags(tags,false,false,chr(10),'de',way) as localized_name_first
, osml10n_get_name_without_brackets_from_tags(tags,'de',way) as localized_name_without_brackets
, osml10n_get_streetname_from_tags(tags,true,false,chr(10),'de', way) as localized_streetname
, osml10n_get_country_name(tags,chr(10),'de') as country_name
, COALESCE(tags->'name:hsb',tags->'name:dsb',tags->'name') as name_hrb
, osm_tag2num(tags->'width') as "num_width"
-- hstore tag 'columns' (sorted)
, tags->'CEMT' as "CEMT"
, tags->'abandoned' AS "abandoned"
, tags->'access' as "access"
, tags->'addr:housename' as "addr:housename"
, tags->'addr:housenumber' as "addr:housenumber"
, tags->'admin_level' as "admin_level"
, tags->'aerialway' as "aerialway"
, tags->'aeroway' as "aeroway"
, tags->'amenity' as "amenity"
, tags->'area' AS "area"
, tags->'barrier' as "barrier"
, tags->'bicycle' as "bicycle"
, tags->'boundary' as "boundary"
, tags->'bridge' as "bridge"
, tags->'building' as "building"
, tags->'castle_type' AS "castle_type"
, tags->'communication:radio' AS "communication:radio"
, tags->'communication:television' AS "communication:television"
, tags->'covered' AS "covered"
, tags->'crop' as "crop"
, tags->'denomination' as "denomination"
, tags->'denotation' AS "denotation"
, tags->'disused' as "disused"
, tags->'fenced' as "fenced"
, tags->'foot' as "foot"
, tags->'generator:source' as "generator:source"
, tags->'harbour' AS "harbour"
, tags->'height' as "height"
, tags->'highway' as "highway"
, tags->'historic' as "historic"
, tags->'iata' as "iata"
, tags->'int_name' as "int_name"
, tags->'intermittent' as "intermittent"
, tags->'junction' as "junction"
, tags->'landuse' as "landuse"
, tags->'leaf_cycle' AS "leaf_cycle"
, tags->'leaf_type' as "leaf_type"
, tags->'leisure' as "leisure"
, tags->'lock' as "lock"
, tags->'man_made' as "man_made"
, tags->'memorial:type' as "memorial:type"
, tags->'military' as "military"
, tags->'motorboat' as "motorboat"
, tags->'name' as "name"
, tags->'name:de' as "name:de"
, tags->'name:en' as "name:en"
, tags->'natural' as "natural"
, tags->'office' AS "office"
, tags->'operator' as "operator"
, tags->'orchard' as "orchard"
, tags->'place' as "place"
, tags->'power' as "power"
, tags->'power_source' as "power_source"
, tags->'produce' AS "produce"
, tags->'public_transport' as "public_transport"
, tags->'railway' as "railway"
, tags->'ref' as "ref"
, tags->'region:type' as "region:type"
, tags->'religion' as "religion"
, tags->'ruins' as "ruins"
, tags->'shop' as "shop"
, tags->'site_type' AS "site_type"
, tags->'sport' as "sport"
, tags->'surface' as "surface"
, tags->'tourism' as "tourism"
, tags->'tower:type' AS "tower:type"
, tags->'trees' AS "trees"
, tags->'tunnel' as "tunnel"
, tags->'water' as "water"
, tags->'waterway' as "waterway"
, tags->'wetland' as "wetland"
, tags->'wood' as "wood"
-- after initial import add further columns below this line only
FROM planet_osm_hstore_polygon;

GRANT select ON planet_osm_polygon TO public;