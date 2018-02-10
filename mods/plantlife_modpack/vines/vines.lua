-- support for i18n
local S = plantlife_i18n.gettext

vines.register_vine( 'root', {
  description = S("Roots"),
  average_length = 9,
},{
  choose_random_wall = true,
  avoid_nodes = {"vines:root_middle"},
  avoid_radius = 5,
  spawn_delay = 500,
  spawn_chance = 10,
  spawn_surfaces = {
    "default:dirt_with_grass",
    "default:dirt"
  },
  spawn_on_bottom = true,
  plantlife_limit = -0.6,
  humidity_min = 0.4,
})

vines.register_vine( 'vine', {
  description = S("Vines"),
  average_length = 5,
},{
  choose_random_wall = true,
  avoid_nodes = {"group:vines"},
  avoid_radius = 5,
  spawn_delay = 500,
  spawn_chance = 100,
  spawn_surfaces = {
    "default:leaves",
    "default:jungleleaves",
    "moretrees:jungletree_leaves_red",
    "moretrees:jungletree_leaves_yellow",
    "moretrees:jungletree_leaves_green"
  },
  spawn_on_bottom = true,
  plantlife_limit = -0.9,
  humidity_min = 0.7,
})

vines.register_vine( 'side', {
  description = S("Vines"),
  average_length = 6,
},{
  choose_random_wall = true,
  avoid_nodes = {"group:vines", "default:apple"},
  avoid_radius = 3,
  spawn_delay = 500,
  spawn_chance = 100,
  spawn_surfaces = {
    "default:leaves",
    "default:jungleleaves",
    "moretrees:jungletree_leaves_red",
    "moretrees:jungletree_leaves_yellow",
    "moretrees:jungletree_leaves_green"
  },
  spawn_on_side = true,
  plantlife_limit = -0.9,
  humidity_min = 0.4,
})

vines.register_vine( "jungle", {
  description = S("Jungle Vines"),
  average_length = 7,
},{
  choose_random_wall = true,
  neighbors = {
    "default:jungleleaves",
    "moretrees:jungletree_leaves_red",
    "moretrees:jungletree_leaves_yellow",
    "moretrees:jungletree_leaves_green"
  },
  avoid_nodes = {
    "vines:jungle_middle",
    "vines:jungle_end",
  },
  avoid_radius = 5,
  spawn_delay = 500,
  spawn_chance = 100,
  spawn_surfaces = {
    "default:jungletree",
    "moretrees:jungletree_trunk"
  },
  spawn_on_side = true,
  plantlife_limit = -0.9,
  humidity_min = 0.2,
})

vines.register_vine( 'willow', {
  description = S("Willow Vines"),
  average_length = 9,
},{
  choose_random_wall = true,
  avoid_nodes = { "vines:willow_middle" },
  avoid_radius = 5,
  near_nodes = { 'default:water_source' },
  near_nodes_size = 1,
  near_nodes_count = 1,
  near_nodes_vertical = 7,
  plantlife_limit = -0.8,
  spawn_chance = 10,
  spawn_delay = 500,
  spawn_on_side = true,
  spawn_surfaces = {"moretrees:willow_leaves"},
  humidity_min = 0.5
})
