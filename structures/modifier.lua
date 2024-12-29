--- @class CPlusModifier
CPlusModifier = Object:extend()

function CPlusModifier:new(id, meta)
	self.id = id
	self.meta = table_merge({ name = id }, meta or {})
	if not self.meta.text then
		self.meta.text = { id }
	end
	return self
end
function CPlusModifier:apply_to_run(arg)
	G.GAME.modifiers[self.id] = arg.value or true
end
