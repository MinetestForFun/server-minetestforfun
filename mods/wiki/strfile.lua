
strfile = { }

function strfile.open(s)
	return {
		_buf = s,
		_pos = 1,
		_readline = function(self)
			if self._pos == nil then
				return nil
			end
			local nl = self._buf:find("\n", self._pos, true)
			local line
			if nl then
				line = self._buf:sub(self._pos, nl - 1)
				nl = nl + 1
			else
				line = self._buf:sub(self._pos)
			end
			self._pos = nl
			return line
		end,
		lines = function(self)
			return self._readline, self, true
		end,
		close = function(self) end,
	}
end
