CREATE OR REPLACE FUNCTION is_landuse_overlay(type TEXT)
RETURNS BOOLEAN AS $$
BEGIN
	RETURN type IN ('wetland', 'marsh', 'swamp', 'bog', 'mud', 'tidalflat', 'national_park', 'nature_reserve', 'protected_area');
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE VIEW landuse_overlay_z5 AS
    SELECT id AS osm_id, type, geometry
    FROM osm_landuse_polygon_subdivided_gen0
    WHERE is_landuse_overlay(type) AND area > 300000000;

CREATE OR REPLACE VIEW landuse_overlay_z6 AS
    SELECT id AS osm_id, type, geometry
    FROM osm_landuse_polygon_subdivided_gen0
    WHERE is_landuse_overlay(type) AND area > 100000000;

CREATE OR REPLACE VIEW landuse_overlay_z7 AS
    SELECT id AS osm_id, type, geometry
    FROM osm_landuse_polygon_subdivided_gen0
    WHERE is_landuse_overlay(type) AND area > 20000000;

CREATE OR REPLACE VIEW landuse_overlay_z8 AS
    SELECT id AS osm_id, type, geometry
    FROM osm_landuse_polygon_subdivided_gen0
    WHERE is_landuse_overlay(type) AND area > 6000000;

CREATE OR REPLACE VIEW landuse_overlay_z9 AS
    SELECT id AS osm_id, type, geometry
    FROM osm_landuse_polygon_subdivided_gen0
    WHERE is_landuse_overlay(type) AND area > 2000000;

CREATE OR REPLACE VIEW landuse_overlay_z10 AS
    SELECT id AS osm_id, type, geometry
    FROM osm_landuse_polygon_subdivided_gen0
    WHERE is_landuse_overlay(type) AND area > 500000;

CREATE OR REPLACE VIEW landuse_overlay_z11toz12 AS
    SELECT id AS osm_id, type, geometry
    FROM osm_landuse_polygon_subdivided_gen1
    WHERE is_landuse_overlay(type);

CREATE OR REPLACE VIEW landuse_overlay_z13toz14 AS
    SELECT id AS osm_id, type, geometry
    FROM osm_landuse_polygon_subdivided
    WHERE is_landuse_overlay(type);

CREATE OR REPLACE VIEW landuse_overlay_layer AS (
    SELECT osm_id FROM landuse_overlay_z5
    UNION
    SELECT osm_id FROM landuse_overlay_z6
    UNION
    SELECT osm_id FROM landuse_overlay_z7
    UNION
    SELECT osm_id FROM landuse_overlay_z8
    UNION
    SELECT osm_id FROM landuse_overlay_z9
    UNION
    SELECT osm_id FROM landuse_overlay_z10
    UNION
    SELECT osm_id FROM landuse_overlay_z11toz12
    UNION
    SELECT osm_id FROM landuse_overlay_z13toz14
);
