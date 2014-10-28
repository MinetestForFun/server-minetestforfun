-- painting - in-game painting for minetest

-- THIS MOD CODE AND TEXTURES LICENSED 
--            <3 TO YOU <3
--    UNDER TERMS OF WTFPL LICENSE

-- 2012, 2013, 2014 obneq aka jin xi

minetest.register_craft({
      output = 'painting:easel 1',
      recipe = {
         { '', 'default:wood', '' },
         { '', 'default:wood', '' },
         { 'default:stick','', 'default:stick' },
      }})

minetest.register_craft({
      output = 'painting:canvas_16 1',
      recipe = {
         { '', '', '' },
         { '', '', '' },
         { 'default:paper', '', '' },
      }})

minetest.register_craft({
      output = 'painting:canvas_32 1',
      recipe = {
         { '', '', '' },
         { 'default:paper', 'default:paper', '' },
         { 'default:paper', 'default:paper', '' },
      }})

minetest.register_craft({
      output = 'painting:canvas_64 1',
      recipe = {
         { 'default:paper', 'default:paper', 'default:paper' },
         { 'default:paper', 'default:paper', 'default:paper' },
         { 'default:paper', 'default:paper', 'default:paper' },
      }})
