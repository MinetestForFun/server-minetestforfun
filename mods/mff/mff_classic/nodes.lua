local modname = minetest.get_current_modname()

minetest.register_node(modname .. ':acid_source', {
  description = 'Acid Source',
  inventory_image = minetest.inventorycube('default_acid.png'),
  drawtype = 'liquid',
  tiles = {
    {name = 'default_acid_source_animated.png', animation={type = 'vertical_frames', aspect_w = 16, aspect_h = 16, length = 1.5}}
  },
  special_tiles = {
    -- New-style acid source material (mostly unused)
    {
      name = 'default_acid_source_animated.png',
      animation = {type = 'vertical_frames', aspect_w= 16, aspect_h = 16, length = 1.5},
      backface_culling = false,
    }
  },
  alpha = 160,
  paramtype = 'light',
  walkable = false,
  pointable = false,
  diggable = false,
  buildable_to = true,
  drop = '',
  drowning = 2,
  liquidtype = 'source',
  liquid_alternative_flowing = modname .. ':acid_flowing',
  liquid_alternative_source = modname .. ':acid_source',
  liquid_viscosity = 1,
  liquid_range = 4,
  damage_per_second = 3,
  post_effect_color = {a = 120, r = 50, g = 90, b = 30},
  groups = {water = 3, acid = 3, liquid = 3, puts_out_fire = 1},
})

minetest.register_node(modname .. ':acid_flowing', {
  description = 'Flowing Acid',
  inventory_image = minetest.inventorycube('default_acid.png'),
  drawtype = 'flowingliquid',
  tiles = {'default_acid.png'},
  special_tiles = {
    {
      image = 'default_acid_flowing_animated.png',
      backface_culling=false,
      animation={type = 'vertical_frames', aspect_w= 16, aspect_h = 16, length = 0.6}
    },
    {
      image = 'default_acid_flowing_animated.png',
      backface_culling=true,
      animation={type = 'vertical_frames', aspect_w= 16, aspect_h = 16, length = 0.6}
    },
  },
  alpha = 160,
  paramtype = 'light',
  paramtype2 = 'flowingliquid',
  walkable = false,
  pointable = false,
  diggable = false,
  buildable_to = true,
  drop = '',
  drowning = 2,
  liquidtype = 'flowing',
  liquid_alternative_flowing = modname .. ':acid_flowing',
  liquid_alternative_source = modname .. ':acid_source',
  liquid_viscosity = 1,
  liquid_range = 4,
  damage_per_second = 3,
  post_effect_color = {a = 120, r = 50, g = 90, b = 30},
  groups = {water = 3, acid = 3, liquid = 3, puts_out_fire = 1, not_in_creative_inventory = 1},
})

minetest.register_node(modname .. ':sand_source', {
  description = 'Sand Source',
  inventory_image = minetest.inventorycube('default_sand.png'),
  drawtype = 'liquid',
  tiles = {'default_sand.png'},
  alpha = 255,
  paramtype = 'light',
  walkable = false,
  pointable = false,
  diggable = false,
  buildable_to = true,
  drop = '',
  drowning = 4,
  liquidtype = 'source',
  liquid_alternative_flowing = modname .. ':sand_flowing',
  liquid_alternative_source = modname .. ':sand_source',
  liquid_viscosity = 20,
  liquid_renewable = false,
  post_effect_color = {a = 250, r = 0, g = 0, b = 0},
  groups = {liquid = 3},
})

minetest.register_node(modname .. ':sand_flowing', {
  description = 'Flowing Sand',
  inventory_image = minetest.inventorycube('default_sand.png'),
  drawtype = 'flowingliquid',
  tiles = {'default_sand.png'},
  special_tiles = {
    {
      image = 'default_sand_flowing_animated.png',
      backface_culling=false,
      animation={type = 'vertical_frames', aspect_w= 16, aspect_h = 16, length = 0.6}
    },
    {
      image = 'default_sand_flowing_animated.png',
      backface_culling=true,
      animation={type = 'vertical_frames', aspect_w= 16, aspect_h = 16, length = 0.6}
    },
  },
  alpha = 255,
  paramtype = 'light',
  paramtype2 = 'flowingliquid',
  walkable = false,
  pointable = false,
  diggable = false,
  buildable_to = true,
  drop = '',
  drowning = 4,
  liquidtype = 'flowing',
  liquid_alternative_flowing = modname .. ':sand_flowing',
  liquid_alternative_source = modname .. ':sand_source',
  liquid_viscosity = 20,
  post_effect_color = {a = 250, r = 0, g = 0, b = 0},
  groups = {liquid = 3, not_in_creative_inventory = 1},
})


minetest.register_node(modname .. ':clay_burned', {
  description = 'Burned Clay',
  tiles = {'default_clay_burned.png'},
  is_ground_content = true,
  groups = {crumbly = 3},
  drop = 'default:clay_lump 4',
  sounds = default.node_sound_dirt_defaults(),
})

-- From BFD, cherry tree
minetest.register_node(modname .. ':cherry_tree', {
  description = 'Cherry Log',
  tiles = {'default_cherry_top.png', 'default_cherry_top.png', 'default_cherry_tree.png'},
  is_ground_content = false,
  groups = {tree=1,choppy=2,oddly_breakable_by_hand=1,flammable=2},
  sounds = default.node_sound_wood_defaults(),
  drop = modname .. 'cherry_log'
})

minetest.register_node(modname .. ':cherry_log', {
  description = 'Cherry Log',
  tiles = {'default_cherry_top.png', 'default_cherry_top.png', 'default_cherry_tree.png'},
  paramtype2 = 'facedir',
  is_ground_content = false,
  groups = {choppy=2,oddly_breakable_by_hand=1,flammable=2},
  sounds = default.node_sound_wood_defaults(),
  on_place = minetest.rotate_node,
})

minetest.register_node(modname .. ':cherry_plank', {
  description = 'Cherry Planks',
  tiles = {'default_wood_cherry_planks.png'},
  sounds = default.node_sound_wood_defaults(),
  groups = {oddly_breakable_by_hand=1, flammable=1, choppy=3, wood=1},
})

minetest.register_node(modname .. ':cherry_blossom_leaves', {
  description = 'Cherry Blossom Leaves',
  drawtype = 'allfaces_optional',
  visual_scale = 1.3,
  tiles = {'default_cherry_blossom_leaves.png'},
  paramtype = 'light',
  waving = 1,
  is_ground_content = false,
  groups = {snappy=3, leafdecay=3, leafdecay_drop = 1, flammable=2, leaves=1},
  drop = {
    max_items = 1,
    items = {
      {
        items = {modname .. ':cherry_sapling'},
        rarity = 32,
      },
      {
        items = {modname .. ':cherry_blossom_leaves'},
      }
    }
  },
  sounds = default.node_sound_leaves_defaults(),
  on_place = function(itemstack, placer, pointed_thing)
    -- place a random grass node
    local stack = ItemStack(modname .. ':cherry_leaves_deco')
    local ret = minetest.item_place(stack, placer, pointed_thing)
    return ItemStack(modname .. ':cherry_blossom_leaves'..' '..itemstack:get_count()-(1-ret:get_count()))
  end,
})

minetest.register_node(modname .. ':cherry_leaves_deco', {
  description = 'Cherry Leaves',
  drawtype = 'allfaces_optional',
  visual_scale = 1.3,
  tiles = {'default_cherry_blossom_leaves.png'},
  paramtype = 'light',
  waving=1,
  is_ground_content = false,
  groups = {snappy=3, flammable=2, leaves=1},
  sounds = default.node_sound_leaves_defaults(),
  drop = {modname .. 'cherry_blossom_leaves'},
})

minetest.register_node(modname .. ':cherry_sapling', {
  description = 'Cherry Sapling',
  waving = 1,
  visual_scale = 1.0,
  inventory_image = 'default_cherry_sapling.png',
  wield_image = 'default_cherry_sapling.png',
  drawtype = 'plantlike',
  paramtype = 'light',
  tiles = {'default_cherry_sapling.png'},
  walkable = false,
  selection_box = {
    type = 'fixed',
    fixed = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3}
  },
  groups = {snappy = 2, dig_immediate = 3, flammable = 2,
    attached_node = 1, sapling = 1},
  sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node(modname .. ':desert_stone_with_coal', {
  description = 'Coal Ore',
  tiles = {'default_desert_stone.png^default_mineral_coal.png'},
  is_ground_content = true,
  groups = {crumbly = 1, cracky = 3},
  drop = {
    items = {
      {items = {'default:desert_cobble'}},
      {items = {'default:coal_lump'}},
      {items = {'maptools:copper_coin'}},
    },
  },
  sounds = default.node_sound_stone_defaults(),
})

minetest.register_node(modname .. ':desert_stone_with_copper', {
  description = 'Copper Ore',
  tiles = {'default_desert_stone.png^default_mineral_copper.png'},
  is_ground_content = true,
  groups = {crumbly = 1, cracky = 3},
  drop = {
    items = {
      {items = {'default:desert_cobble'}},
      {items = {'default:copper_lump'}},
      {items = {'maptools:copper_coin 3'}},
    },
  },
  sounds = default.node_sound_stone_defaults(),
})

minetest.register_node(modname .. ':stone_with_tin', {
  description = 'Tin Ore',
  tiles = {'default_stone.png^default_mineral_tin.png'},
  is_ground_content = true,
  groups = {cracky = 3},
  drop = {
    items = {
      {items = {'default:cobble'}},
      {items = {'default:tin_lump'}},
      {items = {'maptools:copper_coin 3'}},
    },
  },
  sounds = default.node_sound_stone_defaults(),
})

minetest.register_node(modname .. ':desert_stone_with_tin', {
  description = 'Tin Ore',
  tiles = {'default_desert_stone.png^default_mineral_tin.png'},
  is_ground_content = true,
  groups = {crumbly = 1, cracky = 3},
  drop = {
    items = {
      {items = {'default:desert_cobble'}},
      {items = {'default:tin_lump'}},
      {items = {'maptools:copper_coin 3'}},
    },
  },
  sounds = default.node_sound_stone_defaults(),
})

minetest.register_node(modname .. ':tinblock', {
  description = 'Tin Block',
  tiles = {'default_tin_block.png'},
  is_ground_content = false,
  groups = {snappy = 1, bendy = 2, cracky = 1, melty = 2, level = 2},
  sounds = default.node_sound_stone_defaults(),
})

minetest.register_node(modname .. ':stone_with_silver', {
  description = 'Silver Ore',
  tiles = {'default_stone.png^default_mineral_silver.png'},
  is_ground_content = true,
  groups = {cracky = 3},
  drop = {
    items = {
      {items = {'default:cobble'}},
      {items = {'default:silver_lump'}},
      {items = {'maptools:copper_coin 3'}},
    },
  },
  sounds = default.node_sound_stone_defaults(),
})

minetest.register_node(modname .. ':desert_stone_with_silver', {
  description = 'Silver Ore',
  tiles = {'default_desert_stone.png^default_mineral_silver.png'},
  is_ground_content = true,
  groups = {crumbly = 1, cracky = 3},
  drop = {
    items = {
      {items = {'default:desert_cobble'}},
      {items = {'default:silver_lump'}},
      {items = {'maptools:copper_coin 3'}},
    },
  },
  sounds = default.node_sound_stone_defaults(),
})

minetest.register_node(modname .. ':silverblock', {
  description = 'Silver Block',
  tiles = {'default_silver_block.png'},
  is_ground_content = false,
  groups = {snappy = 1, bendy = 2, cracky = 1, melty = 2, level = 2},
  sounds = default.node_sound_stone_defaults(),
})

-- Meze

local function die_later(digger)
  digger:set_hp(0)
end

minetest.register_node(modname .. ':meze', {
  description = 'Meze Block',
  tiles = {'default_meze_block.png'},
  is_ground_content = true,
  drop = '',
  groups = {cracky = 1, level = 2, fall_damage_add_percent = -75},
  sounds = default.node_sound_wood_defaults(), -- Intended.

  on_dig = function(pos, node, digger)
    if digger and minetest.setting_getbool('enable_damage') and not minetest.setting_getbool('creative_mode') then
      minetest.after(3, die_later, digger)
      minetest.chat_send_player(digger:get_player_name(), 'You feel like you did a mistake.')
      minetest.node_dig(pos, node, digger)
    elseif digger then
      minetest.node_dig(pos, node, digger)
    end
  end,
})

-- Mithril

minetest.register_node(modname .. ':stone_with_mithril', {
  description = 'Mithril Ore',
  tiles = {'default_stone.png^default_mineral_mithril.png'},
  is_ground_content = true,
  groups = {cracky = 3},
  drop = {
    items = {
      {items = {'default:cobble'}},
      {items = {'default:mithril_lump'}},
      {items = {'maptools:copper_coin 3'}},
    },
  },
  sounds = default.node_sound_stone_defaults(),
})

minetest.register_node(modname .. ':mithrilblock', {
  description = 'Mithril Block',
  tiles = {'default_mithril_block.png'},
  is_ground_content = false,
  groups = {snappy = 1, bendy = 2, cracky = 1, melty = 2, level = 2},
  sounds = default.node_sound_stone_defaults(),
})

--

minetest.register_node(modname .. ':stone_with_coin', {
  description = 'Stone with Coin',
  tiles = {'default_stone.png^maptools_gold_coin.png'},
  is_ground_content = true,
  groups = {cracky = 3},
  drop = {
    items = {
      {items = {'default:cobble'}},
      {items = {'maptools:gold_coin'}},
    },
  },
  sounds = default.node_sound_stone_defaults(),
})

minetest.register_node(modname .. ':ladder_obsidian', {
  description = "Obsidian Ladder",
  drawtype = 'signlike',
  tiles = {'default_ladder_obsidian.png'},
  inventory_image = 'default_ladder_obsidian.png',
  wield_image = 'default_ladder_obsidian.png',
  paramtype = 'light',
  paramtype2 = 'wallmounted',
  sunlight_propagates = true,
  walkable = false,
  climbable = true,
  is_ground_content = false,
  selection_box = {
    type = 'wallmounted',
    --wall_top = = <default>
    --wall_bottom = = <default>
    --wall_side = = <default>
  },
  groups = {cracky = 2},
  sounds = default.node_sound_stone_defaults(),
})

default.register_fence(modname .. ':fence_cobble', {
  description = "Cobble Fence",
  texture = 'default_fence_cobble.png',
  material = 'default:cobble',
  groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
  sounds = default.node_sound_wood_defaults()
})

default.register_fence(modname .. ':fence_desert_cobble', {
  description = "Desert Cobble Fence",
  texture = 'default_fence_desert_cobble.png',
  material = 'default:desert_cobble',
  groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
  sounds = default.node_sound_wood_defaults()
})

default.register_fence(modname .. ':fence_steelblock', {
  description = "Steel Block Fence",
  texture = 'default_fence_steelblock.png',
  material = 'default:steelblock',
  groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
  sounds = default.node_sound_wood_defaults()
})

default.register_fence(modname .. ':fence_brick', {
  description = "Brick Fence",
  texture = 'default_fence_brick.png',
  material = 'default:brick',
  groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
  sounds = default.node_sound_wood_defaults()
})

-- Nyan cat

minetest.register_node(modname .. ':nyancat', {
  description = "Nyan Cat",
  tiles = {'default_nc_side.png', 'default_nc_side.png', 'default_nc_side.png',
    'default_nc_side.png', 'default_nc_back.png', 'default_nc_front.png'},
  paramtype2 = 'facedir',
  groups = {cracky = 2},
  is_ground_content = false,
  post_effect_color = {a = 128, r= 255, g= 128, b= 255},
  legacy_facedir_simple = true,
  sounds = default.node_sound_defaults(),
})

minetest.register_node(modname .. ':nyancat_rainbow', {
  description = "Nyan Cat Rainbow",
  drawtype = 'glasslike',
  tiles = {
    'default_nc_rb.png^[transformR90', 'default_nc_rb.png^[transformR90',
    'default_nc_rb.png', 'default_nc_rb.png'
  },
  paramtype = 'light',
  paramtype2 = 'facedir',
  groups = {cracky = 2},
  sunlight_propagate = true,
  walkable = false,
  use_texture_alpha = true,
  climbable = true,
  is_ground_content = false,
  post_effect_color = {a = 128, r= 255, g= 128, b= 255},
  sounds = default.node_sound_defaults(),
})

--

minetest.register_node(modname .. ':obsidian_cooled', {
  description = "Obsidian (cooled)",
  tiles = {'default_obsidian.png'},
  is_ground_content = true,
  drop = 'default:obsidian',
  sounds = default.node_sound_stone_defaults(),
  groups = {cracky = 1, level = 2},
})

minetest.register_node(modname .. ':cobble_cooled', {
  description = "Cobblestone (cooled)",
  tiles = {'default_cobble.png'},
  is_ground_content = true,
  drop = 'default:cobble',
  groups = {cracky = 3, stone = 2},
  sounds = default.node_sound_stone_defaults(),
})
