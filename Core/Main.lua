local lovely = require("lovely")
local nfs = require("nativefs")

--[[
- Custom Challenge UI
- Ability to select vanilla challenges stake and deck
- API for challenge creation
- In-game challenge creator
  - Ability to share challenge code for others to play challenge
- Custom challenges added by mod
  - Deck is randomised every Ante [req from doc]
- Custom Challenges can have variants i.e. options API
- Challenge Browser [ Long term goal ]
]]
--TODO: REMOVE FOR RELEASE
function inspectDepth(tbl, indent, depth)
  if depth and depth > 5 then
    return "Depth limit reached"
  end

  if type(tbl) ~= "table" then
    return "Not a table"
  end

  local str = ""
  indent = indent or 0

  for k, v in pairs(tbl) do
    local formatting = string.rep("  ", indent) .. tostring(k) .. ": "
    if type(v) == "table" then
      str = str .. formatting .. "\n"
      str = str .. inspectDepth(v, indent + 1, (depth or 0) + 1)
    elseif type(v) == "function" then
      str = str .. formatting .. "function\n"
    elseif type(v) == "boolean" then
      str = str .. formatting .. tostring(v) .. "\n"
    else
      str = str .. formatting .. tostring(v) .. "\n"
    end
  end

  return str
end

Challenger = {}

-- assert(
--   load(nfs.read(lovely.mod_dir .. "/Challenger+/UI/challenge_selection.lua"))
-- )()
-- assert(load(nfs.read(lovely.mod_dir .. "/Challenger+/Debug/testing.lua")))()

Challenger.RELEASE = false
Challenger.VER = "1.0.0"
Challenger.VER = Challenger.VER
  .. "-"
  .. (Challenger.RELEASE and "FULL" or "DEV")

Challenger.challenges = {}

local EMPTY_CONFIG = {
  rules = {
    custom = {},
    modifiers = {},
  },
  jokers = {},
  consumables = {},
  vouchers = {},
  deck = {
    type = "Challenge Deck",
    cards = {},
  },
  restrictions = {
    banned_cards = {},
    banned_tags = {},
    banned_other = {},
  },
}

Challenge = Object:extend()

--[[
  Initializes a new Challenge instance with the given configuration.
  @param config The configuration table to initialize the challenge.
]]
function Challenge:new(config)
  tableMerge(self, deepCopy(EMPTY_CONFIG), deepCopy(config))
  table.insert(Challenger.challenges, 1, self)
end

--[[
  Sets the deck type for the challenge.
  @param type The type of the deck.
]]
function Challenge:setDeckType(type)
  self.deck.type = type
end

--[[
  Sets the deck cards for the challenge.
  @param cards The cards in the deck
]]
function Challenge:setDeckCards(cards)
  self.deck.cards = cards
end

--[[
  Adds a custom rule to the challenge.
  @param rule The rule to add.
]]
function Challenge:addCustomRule(rule)
  table.insert(self.rules.custom, rule)
end

--[[
  Removes a custom rule from the challenge.
  @param rule_id The ID of the rule to remove.
]]
function Challenge:removeCustomRule(rule_id)
  self.rules.custom = removeItemById(self.rules.custom, rule_id)
end

--[[
  Adds a modifier to the challenge.
  @param modifier The modifier to add.
]]
function Challenge:addModifier(modifier)
  table.insert(self.rules.modifiers, modifier)
end

--[[
  Removes a modifier from the challenge.
  @param modifier_id The ID of the modifier to remove.
]]
function Challenge:removeModifier(modifier_id)
  self.rules.modifiers = removeItemById(self.rules.modifiers, modifier_id)
end

--[[
  Adds a joker to the challenge.
  @param joker The joker to add.
]]
function Challenge:addJoker(joker)
  table.insert(self.jokers, joker)
end

--[[
  Removes a joker from the challenge.
  @param joker_id The ID of the joker to remove.
]]
function Challenge:removeJoker(joker_id)
  self.jokers = removeItemById(self.jokers, joker_id)
end

--[[
  Adds a consumable to the challenge.
  @param consumable The consumable to add.
]]
function Challenge:addConsumable(consumable)
  table.insert(self.consumables, consumable)
end

--[[
  Removes a consumable from the challenge.
  @param consumable_id The ID of the consumable to remove.
]]
function Challenge:removeConsumable(consumable_id)
  self.consumables = removeItemById(self.consumables, consumable_id)
end

--[[
  Adds a voucher to the challenge.
  @param voucher The voucher to add.
]]
function Challenge:addVoucher(voucher)
  table.insert(self.vouchers, voucher)
end

--[[
  Removes a voucher from the challenge.
  @param voucher_id The ID of the voucher to remove.
]]
function Challenge:removeVoucher(voucher_id)
  self.vouchers = removeItemById(self.vouchers, voucher_id)
end

--[[
  Adds a banned card to the challenge.
  @param banned_card The banned card to add.
]]
function Challenge:addBannedCard(banned_card)
  table.insert(self.restrictions.banned_cards, banned_card)
end

--[[
  Removes a banned card from the challenge.
  @param banned_card_id The ID of the banned card to remove.
]]
function Challenge:removeBannedCard(banned_card_id)
  self.restrictions.banned_cards =
    removeItemById(self.restrictions.banned_cards, banned_card_id)
end

--[[
  Adds a banned tag to the challenge.
  @param banned_tag The banned tag to add.
]]
function Challenge:addBannedTag(banned_tag)
  table.insert(self.restrictions.banned_tags, banned_tag)
end

--[[
  Removes a banned tag from the challenge.
  @param banned_tag_id The ID of the banned tag to remove.
]]
function Challenge:removeBannedTag(banned_tag_id)
  self.restrictions.banned_tags =
    removeItemById(self.restrictions.banned_tags, banned_tag_id)
end

--[[
  Adds a banned other item to the challenge.
  @param banned_other The banned other item to add.
]]
function Challenge:addBannedOther(banned_other)
  table.insert(self.restrictions.banned_other, banned_other)
end

--[[
  Removes a banned other item from the challenge.
  @param banned_other_id The ID of the banned other item to remove.
]]
function Challenge:removeBannedOther(banned_other_id)
  self.restrictions.banned_other =
    removeItemById(self.restrictions.banned_other, banned_other_id)
end

--[[
  Helper function to remove an item by its ID from a list.
  @param list The list to search.
  @param item_id The ID of the item to remove.
  @return The list with the item removed.
]]
function removeItemById(list, item_id)
  for i, item in ipairs(list) do
    if item.id == item_id then
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
function tableMerge(target, ...)
  assert(type(target) == "table", "Target is not a table")
  local tables_to_merge = { ... }
  if #tables_to_merge == 0 then
    return target
  end

  for k, t in ipairs(tables_to_merge) do
    assert(
      type(t) == "table",
      string.format("Expected a table as parameter %d", k)
    )
  end

  for _, from in ipairs(tables_to_merge) do
    for k, v in pairs(from) do
      if type(k) == "number" then
        table.insert(target, v)
      elseif type(k) == "string" then
        if type(v) == "table" and type(target[k]) == "table" then
          target[k] = tableMerge(target[k], v)
        else
          target[k] = deepCopy(v)
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
function deepCopy(orig)
  if type(orig) ~= "table" then
    return orig
  end

  local copy = {}
  for key, value in pairs(orig) do
    copy[deepCopy(key)] = deepCopy(value)
  end
  setmetatable(copy, deepCopy(getmetatable(orig)))
  return copy
end
