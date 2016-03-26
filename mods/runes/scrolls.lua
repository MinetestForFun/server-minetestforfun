-- Scrolls for Runes Redo
-- 

runes.scrolls = {}

function register_scroll(name, type, data)
	if not data then return end

	local def = {
		inventory_image = (data.texture or "runes_scroll_unknown.png"),
		groups = {scroll = 1},
		description = (data.description or "Mysterious Scroll"),
	}

	minetest.register_craftitem("runes:scroll_" .. name, def)
	runes.scrolls[name] = {}

	if type == "knowledge" and data.glyph then
		runes.scrolls[name].glyph = data.glyph
	end
end



register_scroll("watchdog", "knowledge", {
	glyph = "runes:glyph_watchdog",
	texture = "runes_scroll_watchdog.png",
	description = "Watch Dog Knowledge Scroll"
})

register_scroll("manasucker", "knowledge", {
	glyph = "runes:glyph_manasucker",
	texture = "runes_scroll_manasucker.png",
	description = "Mana Sucker Knowledge Scroll",
})
