local shapes = {
   {  { x = {0, 1, 0, 1}, y = {0, 0, 1, 1} } },
     
   {  { x = {1, 1, 1, 1}, y = {0, 1, 2, 3} },
      { x = {0, 1, 2, 3}, y = {1, 1, 1, 1} } },

   {  { x = {0, 0, 1, 1}, y = {0, 1, 1, 2} },
      { x = {1, 2, 0, 1}, y = {0, 0, 1, 1} } },

   {  { x = {1, 0, 1, 0}, y = {0, 1, 1, 2} },
      { x = {0, 1, 1, 2}, y = {0, 0, 1, 1} } },

   {  { x = {1, 2, 1, 1}, y = {0, 0, 1, 2} },
      { x = {0, 1, 2, 2}, y = {1, 1, 1, 2} },
      { x = {1, 1, 0, 1}, y = {0, 1, 2, 2} },
      { x = {0, 0, 1, 2}, y = {0, 1, 1, 1} } },

   {  { x = {1, 1, 1, 2}, y = {0, 1, 2, 2} },
      { x = {0, 1, 2, 0}, y = {1, 1, 1, 2} },
      { x = {0, 1, 1, 1}, y = {0, 0, 1, 2} },
      { x = {0, 1, 2, 2}, y = {1, 1, 1, 0} } },

   {  { x = {1, 0, 1, 2}, y = {0, 1, 1, 1} },
      { x = {1, 1, 1, 2}, y = {0, 1, 2, 1} },
      { x = {0, 1, 2, 1}, y = {1, 1, 1, 2} },
      { x = {0, 1, 1, 1}, y = {1, 0, 1, 2} } } }

local colors = { "computer_cyan.png", "computer_magenta.png", "computer_red.png",
	"computer_blue.png", "computer_green.png", "computer_orange.png", "computer_yellow.png" }

local background = "image[0,0;3.55,6.66;computer_black.png]"
local buttons = "button[3,4.5;0.6,0.6;left;<]"
	.."button[3.6,4.5;0.6,0.6;rotateleft;L]"
	.."button[4.2,4.5;0.6,0.6;down;v]"
	.."button[4.2,5.3;0.6,0.6;drop;V]"
	.."button[4.8,4.5;0.6,0.6;rotateright;R]"
	.."button[5.4,4.5;0.6,0.6;right;>]"
	.."button[3.5,3;2,2;new;New Game]"

local formsize = "size[5.9,5.7]"
local boardx, boardy = 0, 0
local sizex, sizey, size = 0.29, 0.29, 0.31

local comma = ","
local semi = ";"
local close = "]"

local concat = table.concat
local insert = table.insert

local draw_shape = function(id, x, y, rot, posx, posy)
	local d = shapes[id][rot]
	local scr = {}
	local ins = #scr

	for i=1,4 do
		local tmp = { "image[",
			(d.x[i]+x)*sizex+posx, comma,
			(d.y[i]+y)*sizey+posy, semi,
			size, comma, size, semi,
			colors[id], close }

		ins = ins + 1
		scr[ins] = concat(tmp)
	end

	return concat(scr)
end

local function step(pos, fields)
	local meta = minetest.get_meta(pos)
	local t = minetest.deserialize(meta:get_string("tetris"))
	
	local function new_game(pos)
		local nex = math.random(7)

		t = {
			board = {},
			boardstring = "",
			previewstring = draw_shape(nex, 0, 0, 1, 4, 1),
			score = 0,
			cur = math.random(7),
			nex = nex,
			x=4, y=0, rot=1 
		}

		local timer = minetest.get_node_timer(pos)
		timer:set(0.3, 0)
	end

	local function update_boardstring()
		local scr = {}
		local ins = #scr

		for i, line in pairs(t.board) do
			for _, tile in pairs(line) do
				local tmp = { "image[",
					tile[1]*sizex+boardx, comma,
					i*sizey+boardy, semi,
					size, comma, size, semi,
					colors[tile[2]], close }
				
				ins = ins + 1
				scr[ins] = concat(tmp)
			end
		end

		t.boardstring = concat(scr)
	end

	local function add()
		local d = shapes[t.cur][t.rot]

		for i=1,4 do
			local l = d.y[i] + t.y
			if not t.board[l] then t.board[l] = {} end
			insert(t.board[l], {d.x[i] + t.x, t.cur})
		end
	end

	local function scroll(l)
		for i=l, 1, -1 do
			t.board[i] = t.board[i-1] or {}
		end
	end

	local function check_lines()
		for i, line in pairs(t.board) do
			if #line >= 10 then
				scroll(i)
				t.score = t.score + 20
			end
		end
	end

	local function check_position(x, y, rot)
		local d = shapes[t.cur][rot]

		for i=1,4 do
			local cx, cy = d.x[i]+x, d.y[i]+y
			
			if cx < 0 or cx > 9 or cy < 0 or cy > 19 then
				return false 
			end

			for _, tile in pairs(t.board[ cy ] or {}) do
				if tile[1] == cx then return false end
			end
		end

		return true
	end

	local function stuck()
		if check_position(t.x, t.y+1, t.rot) then return false end
		return true
	end

	local function tick()
		if stuck() then	
			if t.y <= 0 then
				return false end
			add()
			check_lines()
			update_boardstring()
			t.cur, t.nex = t.nex, math.random(7)
			t.x, t.y, t.rot = 4, 0, 1
			t.previewstring = draw_shape(t.nex, 0, 0, 1, 4.1, 0.6)
		else
			t.y = t.y + 1
		end
		return true
	end  

	local function move(dx, dy)
		local newx, newy = t.x+dx, t.y+dy
		if not check_position(newx, newy, t.rot) then return end
		t.x, t.y = newx, newy
	end

	local function rotate(dr)
		local no = #(shapes[t.cur])
		local newrot = (t.rot+dr) % no

		if newrot<1 then newrot = newrot+no end
		if not check_position(t.x, t.y, newrot) then return end
		t.rot = newrot
	end

	local function key()
		if fields.left then
			move(-1, 0)
		end
		if fields.rotateleft then
			rotate(-1)
		end
		if fields.down then
			t.score = t.score + 1
			move(0, 1)
		end
		if fields.drop then
		   while not stuck() do
			  t.score = t.score + 2
		      move(0, 1)
		   end
		end
		if fields.rotateright then
			rotate(1)
		end
		if fields.right then
			move(1, 0)
		end
	end

	local run = true

	if fields then
		if fields.new then
			new_game(pos)
		else
			key(fields)
		end
	else
		run = tick()
	end

	if t then
	local scr = { formsize, background, 
		t.boardstring, t.previewstring,
		draw_shape(t.cur, t.x, t.y, t.rot, boardx, boardy),
		"label[3.8,0.1;Next...]label[3.8,2.7;Score: ", 
		t.score, close, buttons }


		meta:set_string("formspec", concat(scr)
			..default.gui_bg..default.gui_bg_img..default.gui_slots)
		meta:set_string("tetris", minetest.serialize(t))
	end

	return run
end

minetest.register_node("computer:tetris_arcade", {
	description="Tetris Arcade",
	drawtype = "mesh",
	mesh = "tetris_arcade.obj",
	tiles = {"tetris_arcade.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {snappy=3},
	on_rotate = screwdriver.rotate_simple,
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 1.5, 0.5}
	},
	collision_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 1.5, 0.5}
	},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", formsize.."button[2,2.5;2,2;new;New Game]"
			..default.gui_bg..default.gui_bg_img..default.gui_slots)
	end,
	on_timer = function(pos)
		return step(pos, nil)
	end,
	on_receive_fields = function(pos, formanme, fields, sender)
		step(pos, fields)
	end,
	on_place = function(itemstack, placer, pointed_thing)
		local pos = pointed_thing.above
		if minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name ~= "air" then
			minetest.chat_send_player(placer:get_player_name(), "No room for place the Arcade!")
		return end
		local dir = placer:get_look_dir()
		local node = {name="computer:tetris_arcade", param1=0, param2 = minetest.dir_to_facedir(dir)}
		minetest.set_node(pos, node)
		itemstack:take_item()
		return itemstack
	end
})
