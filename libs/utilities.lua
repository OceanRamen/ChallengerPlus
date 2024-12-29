--[[
  Helper function to remove an item by its ID from a list.
  @param list The list to search.
  @param item_id The ID of the item to remove.
  @return The list with the item removed.
]]
function table_remove_id(list, id)
	for i, item in ipairs(list) do
		if item.id == id then
			table.remove(list, i)
			break
		end
	end
	return list
end

--[[
  Merges multiple tables into the target table.
  @param target The table to merge into.
  @param ... Additional tables to merge from.
  @return The merged target table.
]]
function table_merge(target, ...)
	assert(type(target) == "table", "Target is not a table")
	local tables_to_merge = { ... }
	if #tables_to_merge == 0 then
		return target
	end

	for k, t in ipairs(tables_to_merge) do
		assert(type(t) == "table", string.format("Expected a table as parameter %d", k))
	end

	for _, from in ipairs(tables_to_merge) do
		for k, v in pairs(from) do
			if type(k) == "number" then
				table.insert(target, v)
			elseif type(k) == "string" then
				if type(v) == "table" and type(target[k]) == "table" then
					target[k] = table_merge(target[k], v)
				else
					target[k] = table_copy(v)
				end
			end
		end
	end

	return target
end

--[[
  Creates a deep copy of a table.
  @param orig The table to copy.
  @return A new table that is a deep copy of the original.
]]
function table_copy(orig)
	if type(orig) ~= "table" then
		return orig
	end

	local copy = {}
	for key, value in pairs(orig) do
		copy[table_copy(key)] = table_copy(value)
	end
	setmetatable(copy, table_copy(getmetatable(orig)))
	return copy
end
