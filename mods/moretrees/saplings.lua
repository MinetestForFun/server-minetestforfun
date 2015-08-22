-- sapling growth

for i in ipairs(moretrees.treelist) do
	local treename = moretrees.treelist[i][1]
	local tree_model = treename.."_model"
	local tree_biome = treename.."_biome"

	if treename ~= "birch" and treename ~= "spruce" and treename ~= "fir" and treename ~= "jungletree" then

		biome_lib:dbg(dump(moretrees[tree_biome].surface))
		biome_lib:grow_plants({
			grow_delay = moretrees.sapling_interval,
			grow_chance = moretrees.sapling_chance,
			grow_plant = "moretrees:"..treename.."_sapling",
			grow_nodes = moretrees[tree_biome].surface,
			grow_function = moretrees[tree_model],
		})

		biome_lib:grow_plants({
			grow_delay = 2,
			grow_chance = 30,
			grow_plant = "moretrees:"..treename.."_sapling_ongen",
			grow_nodes = moretrees[tree_biome].surface,
			grow_function = moretrees[tree_model],
		})

	end
end

biome_lib:grow_plants({
	grow_delay = moretrees.sapling_interval,
	grow_chance = moretrees.sapling_chance,
	grow_plant = "moretrees:birch_sapling",
	grow_nodes = moretrees.birch_biome.surface,
	grow_function = "moretrees.grow_birch"
})

biome_lib:grow_plants({
	grow_delay = 2,
	grow_chance = 30,
	grow_plant = "moretrees:birch_sapling_ongen",
	grow_nodes = moretrees.birch_biome.surface,
	grow_function = "moretrees.grow_birch"
})

biome_lib:grow_plants({
	grow_delay = moretrees.sapling_interval,
	grow_chance = moretrees.sapling_chance,
	grow_plant = "moretrees:spruce_sapling",
	grow_nodes = moretrees.spruce_biome.surface,
	grow_function = "moretrees.grow_spruce"
})

biome_lib:grow_plants({
	grow_delay = 2,
	grow_chance = 30,
	grow_plant = "moretrees:spruce_sapling_ongen",
	grow_nodes = moretrees.spruce_biome.surface,
	grow_function = "moretrees.grow_spruce"
})

biome_lib:grow_plants({
	grow_delay = moretrees.sapling_interval,
	grow_chance = moretrees.sapling_chance,
	grow_plant = "moretrees:fir_sapling",
	grow_nodes = moretrees.fir_biome.surface,
	grow_function = "moretrees.grow_fir"
})

biome_lib:grow_plants({
	grow_delay = 2,
	grow_chance = 30,
	grow_plant = "moretrees:fir_sapling_ongen",
	grow_nodes = moretrees.fir_biome.surface,
	grow_function = "moretrees.grow_fir"
})

biome_lib:grow_plants({
	grow_delay = moretrees.sapling_interval,
	grow_chance = moretrees.sapling_chance,
	grow_plant = "default:junglesapling",
	grow_nodes = moretrees.jungletree_biome.surface,
	grow_function = "moretrees.grow_jungletree"
})

biome_lib:grow_plants({
	grow_delay = 2,
	grow_chance = 30,
	grow_plant = "moretrees:jungletree_sapling_ongen",
	grow_nodes = moretrees.jungletree_biome.surface,
	grow_function = "moretrees.grow_jungletree"
})

