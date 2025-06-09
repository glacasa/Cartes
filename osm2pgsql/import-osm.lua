# https://osm2pgsql.org/examples/poi-db/

local pois = osm2pgsql.define_table({
    name = "pois",
    ids = { type = 'any', type_column = 'osm_type', id_column = 'osm_id' },
    columns = {
        { column = 'name' },
        { column = 'class', not_null = true },
        { column = 'subclass' },
        { column = 'opening_hours'},
        { column = 'tags', type = 'jsonb' },
        { column = 'geom', type = 'point', not_null = true }
     },
     indexes = {
        { column = 'geom', method = 'gist' }
     }
})



function process_poi(object, geom)
    if object.tags.name then
        local a = {
            name = object.tags.name,
            opening_hours = object.tags.opening_hours,
            tags = object.tags,
            geom = geom
        }

        if object.tags.amenity then
            a.class = 'amenity'
            a.subclass = object.tags.amenity
        elseif object.tags.shop then
            a.class = 'shop'
            a.subclass = object.tags.shop
        else
            return
        end

        pois:insert(a)
    end
end

function osm2pgsql.process_node(object)
    process_poi(object, object:as_point())
end

function osm2pgsql.process_way(object)
    if object.is_closed and object.tags.building then
        process_poi(object, object:as_polygon():centroid())
    end
end