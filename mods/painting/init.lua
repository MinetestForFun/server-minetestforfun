-- painting - in-game painting for minetest

-- THIS MOD CODE AND TEXTURES LICENSED
--            <3 TO YOU <3
--    UNDER TERMS OF WTFPL LICENSE

-- 2012, 2013, 2014 obneq aka jin xi

-- picture is drawn using a nodebox to draw the canvas
-- and an entity which has the painting as its texture.
-- this texture is created by minetests internal image
-- compositing engine (see tile.cpp).

dofile(minetest.get_modpath("painting").."/crafts.lua")

textures = {
  white = "white.png", yellow = "yellow.png",
  orange = "orange.png", red = "red.png",
  violet = "violet.png", blue = "blue.png",
  green = "green.png", magenta = "magenta.png",
  cyan = "cyan.png", grey = "grey.png",
  darkgrey = "darkgrey.png", black = "black.png",
  darkgreen = "darkgreen.png", brown="brown.png",
  pink = "pink.png"
}

local colors = {}
local revcolors = {}

thickness = 0.1

-- picture node
picbox = {
  type = "fixed",
  fixed = { -0.499, -0.499, 0.499, 0.499, 0.499, 0.499 - thickness }
}

picnode =  {
  description = "Picture",
  tiles = { "white.png" },
  inventory_image = "painted.png",
  drawtype = "nodebox",
  sunlight_propagates = true,
  paramtype = "light",
  paramtype2 = "facedir",
  node_box = picbox,
  selection_box = picbox,
  groups = { snappy = 2, choppy = 2, oddly_breakable_by_hand = 2, not_in_creative_inventory=1},

  --handle that right below, don't drop anything
  drop = "",

  after_dig_node=function(pos, oldnode, oldmetadata, digger)
    --find and remove the entity
    local objects = minetest.env:get_objects_inside_radius(pos, 0.5)
    for _, e in ipairs(objects) do
      if e:get_luaentity().name == "painting:picent" then
        e:remove()
      end
    end

    --put picture data back into inventory item
    local data = oldmetadata.fields["painting:picturedata"]
    local item = { name = "painting:paintedcanvas", count = 1, metadata = data }
    digger:get_inventory():add_item("main", item)
  end
}

-- picture texture entity
picent = {
  collisionbox = { 0, 0, 0, 0, 0, 0 },
  visual = "upright_sprite",
  textures = { "white.png" },

  on_activate = function(self, staticdata)
      local pos = self.object:getpos()
      local meta = minetest.env:get_meta(pos)
      local data = meta:get_string("painting:picturedata")
      data = minetest.deserialize(data)
      if not data.grid then return end
      self.object:set_properties({textures = { to_imagestring(data.grid, data.res) }})
  end
}

paintbox = { [0] = { -0.5,-0.5,0,0.5,0.5,0 },
             [1] = { 0,-0.5,-0.5,0,0.5,0.5 } }

paintent = {
  collisionbox = { 0, 0, 0, 0, 0, 0 },
  visual = "upright_sprite",
  textures = { "white.png" },

  on_punch = function(self, puncher, time_from_last_punch, tool_capabilities, dir)
    --check for brush
    local name = puncher:get_wielded_item():get_name()
    name = string.split(name, "_")[2]
    if not textures[name] then return end

    --get player eye level
    --see player.h line 129
    local ppos = puncher:getpos()
    ppos = { x = ppos.x, y = ppos.y + 1.625, z = ppos.z }

    local pos = self.object:getpos()
    local l = puncher:get_look_dir()

    local d = dirs[self.fd]
    local od = dirs[(self.fd + 1) % 4]
    local normal = { x = d.x, y = 0, z = d.z }
    local p = intersect(ppos, l, pos, normal)

    local off = -0.5
    pos = { x = pos.x + off * od.x, y = pos.y + off, z = pos.z + off * od.z }
    p = sub(p, pos)
    local x = math.abs(p.x + p.z)
    local y = 1 - p.y

    --print("x: "..x.." y: "..y)

    x = math.floor(x / (1/self.res) )
    y = math.floor(y / (1/self.res) )

    --print("grid x: "..x.." grid y: "..y)
    
    x = clamp(x, self.res)
    y = clamp(y, self.res)

    self.grid[x][y] = colors[name]
    self.object:set_properties({textures = { to_imagestring(self.grid, self.res) }})

    local wielded = puncher:get_wielded_item()
    wielded:add_wear(65535/256)
    puncher:set_wielded_item(wielded)
  end,

  on_activate = function(self, staticdata)
    local data = minetest.deserialize(staticdata)
    if not data then return end
    self.fd = data.fd
    self.res = data.res
    self.grid = data.grid
    self.object:set_properties({ textures = { to_imagestring(self.grid, self.res) }})
    self.object:set_properties({ collisionbox = paintbox[self.fd%2] })
    self.object:set_armor_groups({immortal=1})
  end,

  get_staticdata = function(self)
    local data = { fd = self.fd, res = self.res, grid = self.grid }
    return minetest.serialize(data)
  end
}

-- just pure magic
local walltoface = {-1, -1, 1, 3, 0, 2}

--paintedcanvas picture inventory item
paintedcanvas = {
  description = "Painted Canvas",
  inventory_image = "painted.png",
  stack_max = 1, 
  groups = { snappy = 2, choppy = 2, oddly_breakable_by_hand = 2, not_in_creative_inventory=1 },
    
  on_place = function(itemstack, placer, pointed_thing)
    --place node
    local pos = pointed_thing.above

    local under = pointed_thing.under
    local above = pointed_thing.above
    local dir = sub(under, above)

    local wm = minetest.dir_to_wallmounted(dir)

    local fd = walltoface[wm + 1]
    if fd == -1 then
      return itemstack
    end

    minetest.env:add_node(pos, { name = "painting:pic",
                                 param2 = fd,
                                 paramtype2 = "none" })

    --save metadata
    local data = itemstack:get_metadata()
    local meta = minetest.env:get_meta(pos)
    meta:set_string("painting:picturedata", data)

    --add entity
    dir = dirs[fd]
    local off = 0.5 - thickness - 0.01

    pos = { x = pos.x + dir.x * off,
            y = pos.y,
            z = pos.z + dir.z * off }

    data = minetest.deserialize(data)

    local p = minetest.env:add_entity(pos, "painting:picent"):get_luaentity()
    p.object:set_properties({ textures = { to_imagestring(data.grid, data.res) }})
    p.object:setyaw(math.pi * fd / -2)

    return ItemStack("")
  end
}

--canvas inventory item
canvas = {
  description = "Canvas",
  inventory_image = "default_paper.png",
  stack_max = 99,
}

--canvas for drawing
canvasbox = {
  type = "fixed",
  fixed = { -0.5, -0.5, 0.0, 0.5, 0.5, thickness }
}

canvasnode = {
  description = "Canvas",
  tiles = { "white.png" },
  inventory_image = "painted.png",
  drawtype = "nodebox",
  sunlight_propagates = true,
  paramtype = "light",
  paramtype2 = "facedir",
  node_box = canvasbox,
  selection_box = canvasbox,
  groups = { snappy = 2, choppy = 2, oddly_breakable_by_hand = 2, not_in_creative_inventory=1 },

  drop = "",

  after_dig_node=function(pos, oldnode, oldmetadata, digger)
    --get data and remove pixels
    local data = {}
    local objects = minetest.env:get_objects_inside_radius(pos, 0.5)
    for _, e in ipairs(objects) do
      e = e:get_luaentity()
      if e.grid then
        data.grid = e.grid
        data.res = e.res
      end
      e.object:remove()
    end

    pos.y = pos.y-1
    minetest.env:get_meta(pos):set_string("has_canvas", 0)

    if data.grid then
      local item = { name = "painting:paintedcanvas", count = 1, metadata = minetest.serialize(data) }
      digger:get_inventory():add_item("main", item)
    end
  end
}

-- easel
easelbox = {
  type="fixed",
  fixed = {
    --feet
    {-0.4, -0.5, -0.5, -0.3, -0.4, 0.5 },
    { 0.3, -0.5, -0.5,  0.4, -0.4, 0.5 },
    --legs
    {-0.4, -0.4, 0.1, -0.3, 1.5, 0.2 },
    { 0.3, -0.4, 0.1,  0.4, 1.5, 0.2 },
    --shelf
    {-0.5, 0.35, -0.3, 0.5, 0.45, 0.1 }
  }
}

easel = {
  description = "Easel",
  tiles = { "default_wood.png" },
  drawtype = "nodebox",
  sunlight_propagates = true,
  paramtype = "light",
  paramtype2 = "facedir",
  node_box = easelbox,
  selection_box = easelbox,

  groups = { snappy = 2, choppy = 2, oddly_breakable_by_hand = 2 },

  on_punch = function(pos, node, player)
    local wielded_raw = player:get_wielded_item():get_name()
    wielded = string.split(wielded_raw, "_")

    local name = wielded[1]
    local res = tonumber(wielded[2])

    if name ~= "painting:canvas" then
      return
    end
    local meta = minetest.env:get_meta(pos)
    local fd = node.param2
    pos = { x = pos.x, y = pos.y + 1, z = pos.z }

    if minetest.env:get_node(pos).name ~= "air" then return end
    minetest.env:add_node(pos, { name = "painting:canvasnode",
                                 param2 = fd,
                                 paramtype2 = "none" })

    local dir = dirs[fd]
    pos = { x = pos.x - 0.01 * dir.x, y = pos.y, z = pos.z - 0.01 * dir.z }

    local p = minetest.env:add_entity(pos, "painting:paintent"):get_luaentity()
    p.object:set_properties({ collisionbox = paintbox[fd%2] })
    p.object:set_armor_groups({immortal=1})
    p.object:setyaw(math.pi * fd / -2)
    p.grid = initgrid(res)
    p.res = res
    p.fd = fd

    meta:set_int("has_canvas", 1)
    local itemstack = ItemStack(wielded_raw)
    player:get_inventory():remove_item("main", itemstack)
  end,

  can_dig = function(pos,player)
    local meta = minetest.env:get_meta(pos)
    local inv = meta:get_inventory()

    if meta:get_int("has_canvas") == 0 then
      return true
    end
    return false
  end
}

--brushes
local function table_copy(t)
  local t2 = {}
  for k,v in pairs(t) do
    t2[k] = v
  end
  return t2
end

brush = {
  description = "brush",
  inventory_image = "default_tool_steelaxe.png",
  wield_image = "",
  wield_scale = { x = 1, y = 1, z = 1 },
  stack_max = 99,
  liquids_pointable = false,
  tool_capabilities = {
    full_punch_interval = 1.0,
    max_drop_level=0,
    groupcaps = {}
  }
}

minetest.register_entity("painting:picent", picent)
minetest.register_node("painting:pic", picnode)

minetest.register_craftitem("painting:canvas_16", canvas)

minetest.register_craftitem("painting:canvas_32", canvas)
minetest.register_craftitem("painting:canvas_64", canvas)

minetest.register_craftitem("painting:paintedcanvas", paintedcanvas)
minetest.register_entity("painting:paintent", paintent)
minetest.register_node("painting:canvasnode", canvasnode)

minetest.register_node("painting:easel", easel)

for color, _ in pairs(textures) do
  table.insert(revcolors, color)
  local brush_new = table_copy(brush)
  brush_new.description = color:gsub("^%l", string.upper).." brush"
  brush_new.inventory_image = "painting_brush_"..color..".png"
  minetest.register_tool("painting:brush_"..color, brush_new)
  minetest.register_craft({
    output = "painting:brush_"..color,
    recipe = {
      {"dye:"..color},
      {"default:stick"},
      {"default:stick"}
    }
  })
end

for i, color in ipairs(revcolors) do
  colors[color] = i
end

minetest.register_alias("easel", "painting:easel")
minetest.register_alias("canvas", "painting:canvas_16")

function initgrid(res)
  local grid, x, y = {}
  for x = 0, res - 1 do
    grid[x] = {}
    for y = 0, res - 1 do
      grid[x][y] = colors["white"]
    end
  end
  return grid
end

function to_imagestring(data, res)
  if not data then return end
  local t = { "[combine:", res, "x", res, ":" }
  for y = 0, res - 1 do
    for x = 0, res - 1 do
       table.insert(t, x..","..y.."="..revcolors[ data[x][y] ]..".png:")
    end
  end
  return table.concat(t)
end

dirs = {
  [0] = { x = 0, z = 1 },
  [1] = { x = 1, z = 0 },
  [2] = { x = 0, z =-1 },
  [3] = { x =-1, z = 0 } }

function sub(v, w)
  return { x = v.x - w.x,
           y = v.y - w.y,
           z = v.z - w.z }
end

function dot(v, w)
  return  v.x * w.x + v.y * w.y + v.z * w.z
end

function intersect(pos, dir, origin, normal)
  local t = -(dot(sub(pos, origin), normal)) / dot(dir, normal)
  return { x = pos.x + dir.x * t,
           y = pos.y + dir.y * t,
           z = pos.z + dir.z * t }
end

function clamp(num, res)
  if num < 0 then
    return 0
  elseif num > res - 1 then
    return res - 1
  else
    return num
  end
end
