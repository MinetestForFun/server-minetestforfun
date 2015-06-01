if riesenpilz.info then
	function riesenpilz.inform(msg, spam, t)
		if spam <= riesenpilz.max_spam then
			local info
			if t then
				info = string.format("[riesenpilz] "..msg.." after ca. %.2fs", os.clock() - t)
			else
				info = "[riesenpilz] "..msg
			end
			minetest.log("action", info)
			if riesenpilz.inform_all then
				minetest.chat_send_all(info)
			end
		end
	end
else
	function riesenpilz.inform()
	end
end
