----------------------------
-- Rollbacks Out of FiLes.
-- ROFL
--

rofl = {}
rofl.func = {}
rofl.datas = {}
rofl.datas.filepath = minetest.get_worldpath() .. "/rollback/"
rofl.queue = {}

local function none(v)
	if not v or v == "None" then
		return nil
	else
		return v
	end
end

minetest.register_chatcommand("rofl", {
	description = "Save MFF",
	privs = {server = true},
	func = function(name)
		-- Alert
		minetest.chat_send_all("*** Server Freezing")

		-- The main loop
		local i = 0
		local vm = minetest.get_voxel_manip()
		while true do
			local file = io.open(rofl.datas.filepath .. "/database-output." .. i .. ".txt", "r")
			if not file then
				break
			end
			-- [
			--	id=155,actor=Mg,type=1;
			--	list=None,index=None,add=None,stacknode=None,stackquantity=None,nodemeta=None;
			--	x=-18,y=29,z=31;
			--	oldnode=default:stonebrick,oldparam1=0,oldparam2=None,oldmeta=None;
			--	newnode=air,newparam1=13,newparam2=None,newmeta=None
			-- ]
			for fields in file:lines() do
				local id = tonumber(string.sub(fields, string.find(fields, "id=")+string.len("id="), string.find(fields, ",actor")-1))
				local actor = string.sub(fields, string.find(fields, "actor=")+string.len("actor="), string.find(fields, ",type")-1)
				local action_type = tonumber(string.sub(fields, string.find(fields, "type=")+string.len("type="), string.find(fields, ";list")-1))

				local list = none(string.sub(fields, string.find(fields, "list=")+string.len("list="), string.find(fields, ",index")-1))
				local index = none(tonumber(string.sub(fields, string.find(fields, "index=")+string.len("index="), string.find(fields, ",add")-1)))
				local add = none(tonumber(string.sub(fields, string.find(fields, "add=")+string.len("add="), string.find(fields, ",stacknode")-1)))
				local stacknode = none(string.sub(fields, string.find(fields, "stacknode=")+string.len("stacknode="), string.find(fields, ",stackquantity")-1))
				local stackquantity = none(tonumber(string.sub(fields, string.find(fields, "stackquantity=")+string.len("stackquantity="), string.find(fields, ",nodemeta")-1)))
				local nodemeta = none(string.sub(fields, string.find(fields, "nodemeta=")+string.len("nodemeta="), string.find(fields, ";x=")-1))

				local x = none(tonumber(string.sub(fields, string.find(fields, ";x=")+string.len(";x="), string.find(fields, ",y=")-1)))
				local y = none(tonumber(string.sub(fields, string.find(fields, ",y=")+string.len(",y="), string.find(fields, ",z=")-1)))
				local z = none(tonumber(string.sub(fields, string.find(fields, ",z=")+string.len(",z="), string.find(fields, ";oldnode=")-1)))

				local oldnode = none(string.sub(fields, string.find(fields, "oldnode=")+string.len("oldnode="), string.find(fields, ",oldparam1")-1))
				local oldparam1 = none(tonumber(string.sub(fields, string.find(fields, "oldparam1=")+string.len("oldparam1="), string.find(fields, ",oldparam2")-1)))
				local oldparam2 = none(tonumber(string.sub(fields, string.find(fields, "oldparam2=")+string.len("oldparam2="), string.find(fields, ",oldmeta=")-1)))
				--local oldmeta

				local newnode = none(string.sub(fields, string.find(fields, "newnode=")+string.len("newnode="), string.find(fields, ",newparam1")-1))
				local newparam1 = none(tonumber(string.sub(fields, string.find(fields, "newparam1=")+string.len("newparam1="), string.find(fields, ",newparam2")-1)))
				local newparam2 = none(tonumber(string.sub(fields, string.find(fields, "newparam2=")+string.len("newparam2="), string.find(fields, ",newmeta=")-1)))
				--local newmeta

				if action_type == 1 then -- TYPE_SETNODE
					local forced = minetest.forceload_block({x = x, y = y, z = z})
					if forced then
						minetest.set_node({x = x, y = y, z = z}, {name = newnode, param1 = newparam1, param2 = newparam2})
						minetest.forceload_free_block({x = x, y = y, z = z})
					else
						minetest.log("error", "[ROFL] Couldn't forceplace block " .. minetest.pos_to_string({x = x, y = y, z = z}))
					end

				elseif action_type == 2 then -- TYPE_MODIFY_INVENTORY_STACK


				else -- TYPE_NOTHING
					print("W.T.F. is type " .. (action_type or "nil"))

				end
			end
			i = i + 1
		end
		minetest.chat_send_all("*** Server Up")
	end,
})
