
-- Boilerplate to support localized strings if intllib mod is installed.
local S;
if (minetest.get_modpath("intllib")) then
    dofile(minetest.get_modpath("intllib").."/intllib.lua");
    S = intllib.Getter(minetest.get_current_modname());
else
    S = function ( s ) return s; end
end

minetest.register_node("survival_hazards:toxic_waste_flowing", {
	description = S("Toxic Waste Flowing");
	inventory_image = minetest.inventorycube("survival_hazards_waste.png");
	drawtype = "flowingliquid";
	tiles = { "survival_hazards_waste.png" };
	special_tiles = {
		{
			image="survival_hazards_waste_flw_anim.png",
			backface_culling=false,
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=3.3}
		},
		{
			image="survival_hazards_waste_flw_anim.png",
			backface_culling=true,
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=3.3}
		},
	};
	paramtype = "light",
	walkable = false;
	pointable = false;
	diggable = false;
	buildable_to = true;
	drop = "";
	liquidtype = "flowing";
	liquid_alternative_flowing = "survival_hazards:toxic_waste_flowing";
	liquid_alternative_source = "survival_hazards:toxic_waste_source";
	liquid_viscosity = 1;
	damage_per_second = 2;
	post_effect_color = { a=192, r=128, g=255, b=128};
	groups = { liquid=2; not_in_creative_inventory=1 };
})

minetest.register_node("survival_hazards:toxic_waste_source", {
	description = S("Toxic Waste Source");
	inventory_image = minetest.inventorycube("survival_hazards_waste.png");
	drawtype = "liquid";
	tiles = { "survival_hazards_waste.png" };
	special_tiles = {{
        image="survival_hazards_waste_src_anim.png",
        backface_culling=false,
        animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=3.3}
	}};
	paramtype = "light",
	walkable = false;
	pointable = false;
	diggable = false;
	buildable_to = true;
	drop = "";
	liquidtype = "source";
	liquid_alternative_flowing = "survival_hazards:toxic_waste_flowing";
	liquid_alternative_source = "survival_hazards:toxic_waste_source";
	liquid_viscosity = 1;
	damage_per_second = 2;
	post_effect_color = { a=192, r=128, g=255, b=128};
	groups = { liquid=2 };
})

bucket.register_liquid(
	"survival_hazards:toxic_waste_source",
	"survival_hazards:toxic_waste_flowing",
	"survival_hazards:bucket_toxic_waste",
	"survival_hazards_bucket_waste.png",
	S("Toxic Waste Bucket")
);

survival.hazards.register_liquid("survival_hazards:toxic_waste", {
    damage = 2;
});
