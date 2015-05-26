-----------------------------------
-- The various pipe select boxes

pipeworks.pipe_selectboxes = {
	{ -32/64,  -8/64,  -8/64,  8/64,  8/64,  8/64 },
	{ -8/64 ,  -8/64,  -8/64, 32/64,  8/64,  8/64 },
	{ -8/64 , -32/64,  -8/64,  8/64,  8/64,  8/64 },
	{ -8/64 ,  -8/64,  -8/64,  8/64, 32/64,  8/64 },
	{ -8/64 ,  -8/64, -32/64,  8/64,  8/64,  8/64 },
	{ -8/64 ,  -8/64,  -8/64,  8/64,  8/64, 32/64 }
}

-- Tube models

pipeworks.tube_leftstub = {
	{ -32/64, -9/64, -9/64, 9/64, 9/64, 9/64 },	-- tube segment against -X face
}

pipeworks.tube_rightstub = {
	{ -9/64, -9/64, -9/64,  32/64, 9/64, 9/64 },	-- tube segment against +X face
}

pipeworks.tube_bottomstub = {
	{ -9/64, -32/64, -9/64,   9/64, 9/64, 9/64 },	-- tube segment against -Y face
}

pipeworks.tube_topstub = {
	{ -9/64, -9/64, -9/64,   9/64, 32/64, 9/64 },	-- tube segment against +Y face
}

pipeworks.tube_frontstub = {
	{ -9/64, -9/64, -32/64,   9/64, 9/64, 9/64 },	-- tube segment against -Z face
}

pipeworks.tube_backstub = {
	{ -9/64, -9/64, -9/64,   9/64, 9/64, 32/64 },	-- tube segment against -Z face
} 

pipeworks.tube_boxes = {pipeworks.tube_leftstub, pipeworks.tube_rightstub, pipeworks.tube_bottomstub, pipeworks.tube_topstub, pipeworks.tube_frontstub, pipeworks.tube_backstub}

pipeworks.tube_selectboxes = {
	{ -32/64,  -10/64,  -10/64,  10/64,  10/64,  10/64 },
	{ -10/64 ,  -10/64,  -10/64, 32/64,  10/64,  10/64 },
	{ -10/64 , -32/64,  -10/64,  10/64,  10/64,  10/64 },
	{ -10/64 ,  -10/64,  -10/64,  10/64, 32/64,  10/64 },
	{ -10/64 ,  -10/64, -32/64,  10/64,  10/64,  10/64 },
	{ -10/64 ,  -10/64,  -10/64,  10/64,  10/64, 32/64 }
}

