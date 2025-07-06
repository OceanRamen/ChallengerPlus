CPlus.utils = {}

function CPlus.utils.remove_by_id(list, item_id)
	for i, item in ipairs(list) do
		if item.id == item_id then
			table.remove(list, i)
			break
		end
	end
	return list
end

--- @generic T
--- @generic S
--- @param target T
--- @param source S
--- @param ... any
--- @return T | S
function CPlus.utils.table_merge(target, source, ...)
	assert(type(target) == "table", "Target is not a table")
	local tables_to_merge = { source, ... }
	if #tables_to_merge == 0 then
		return target
	end

	for k, t in ipairs(tables_to_merge) do
		assert(type(t) == "table", string.format("Expected a table as parameter %d", k))
	end

	for i = 1, #tables_to_merge do
		local from = tables_to_merge[i]
		for k, v in pairs(from) do
			if type(v) == "table" then
				target[k] = target[k] or {}
				target[k] = CPlus.utils.table_merge(target[k], v)
			else
				target[k] = v
			end
		end
	end

	return target
end
