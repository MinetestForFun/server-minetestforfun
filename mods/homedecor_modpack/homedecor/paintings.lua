--Various kinds of paintings

for i = 1,20 do
	homedecor.register("painting_"..i, {
		description = "Decorative painting #"..i,
		tiles = {
			"homedecor_painting_edges.png",
			"homedecor_painting_edges.png",
			"homedecor_painting_edges.png",
			"homedecor_painting_edges.png",
			"homedecor_painting_back.png",
			"homedecor_painting"..i..".png"
		},
		node_box = {
			type = "fixed",
			fixed = {
				{ -32/64, -32/64, 28/64, -30/64,  32/64, 32/64 }, -- left edge
				{  30/64, -32/64, 28/64,  32/64,  32/64, 32/64 }, -- right edge
				{ -32/64,  30/64, 28/64,  32/64,  32/64, 32/64 }, -- top edge
				{ -32/64, -30/64, 28/64,  32/64, -32/64, 32/64 }, -- bottom edge
				{ -32/64, -32/64, 29/64,  32/64,  32/64, 29/64 }  -- the canvas
			}
		},
		groups = {snappy=3},
	})
end
