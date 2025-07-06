local EMPTY_CONFIG = {
	rules = {
		custom = {},
		modifiers = {},
	},
	jokers = {},
	consumeables = {},
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

-- Challenge = Object:extend()

-- --[[
--   Initializes a new Challenge instance with the given configuration.
--   @param config The configuration table to initialize the challenge.
-- ]]
-- function Challenge:new(args)
--   self.id = args.id
--   self.name = args.name
--   self.author = args.author or nil
--   self.version = args.version or nil
--   tableMerge(self, deepCopy(EMPTY_CONFIG), deepCopy(args.config))
--   table.insert(Challenger.challenges, 1, self)
-- end

-- --[[
--   Sets the deck type for the challenge.
--   @param type The type of the deck.
-- ]]
-- function Challenge:setDeckType(type)
--   self.deck.type = type
-- end

-- --[[
--   Sets the deck cards for the challenge.
--   @param cards The cards in the deck
-- ]]
-- function Challenge:setDeckCards(cards)
--   self.deck.cards = cards
-- end

-- --[[
--   Adds a custom rule to the challenge.
--   @param rule The rule to add.
-- ]]
-- function Challenge:addCustomRule(rule)
--   table.insert(self.rules.custom, rule)
-- end

-- --[[
--   Removes a custom rule from the challenge.
--   @param rule_id The ID of the rule to remove.
-- ]]
-- function Challenge:removeCustomRule(rule_id)
--   self.rules.custom = removeItemById(self.rules.custom, rule_id)
-- end

-- --[[
--   Adds a modifier to the challenge.
--   @param modifier The modifier to add.
-- ]]
-- function Challenge:addModifier(modifier)
--   table.insert(self.rules.modifiers, modifier)
-- end

-- --[[
--   Removes a modifier from the challenge.
--   @param modifier_id The ID of the modifier to remove.
-- ]]
-- function Challenge:removeModifier(modifier_id)
--   self.rules.modifiers = removeItemById(self.rules.modifiers, modifier_id)
-- end

-- --[[
--   Adds a joker to the challenge.
--   @param joker The joker to add.
-- ]]
-- function Challenge:addJoker(joker)
--   table.insert(self.jokers, joker)
-- end

-- --[[
--   Removes a joker from the challenge.
--   @param joker_id The ID of the joker to remove.
-- ]]
-- function Challenge:removeJoker(joker_id)
--   self.jokers = removeItemById(self.jokers, joker_id)
-- end

-- --[[
--   Adds a consumable to the challenge.
--   @param consumable The consumable to add.
-- ]]
-- function Challenge:addConsumable(consumable)
--   table.insert(self.consumeables, consumable)
-- end

-- --[[
--   Removes a consumable from the challenge.
--   @param consumable_id The ID of the consumable to remove.
-- ]]
-- function Challenge:removeConsumable(consumable_id)
--   self.consumeables = removeItemById(self.consumeables, consumable_id)
-- end

-- --[[
--   Adds a voucher to the challenge.
--   @param voucher The voucher to add.
-- ]]
-- function Challenge:addVoucher(voucher)
--   table.insert(self.vouchers, voucher)
-- end

-- --[[
--   Removes a voucher from the challenge.
--   @param voucher_id The ID of the voucher to remove.
-- ]]
-- function Challenge:removeVoucher(voucher_id)
--   self.vouchers = removeItemById(self.vouchers, voucher_id)
-- end

-- --[[
--   Adds a banned card to the challenge.
--   @param banned_card The banned card to add.
-- ]]
-- function Challenge:addBannedCard(banned_card)
--   table.insert(self.restrictions.banned_cards, banned_card)
-- end

-- --[[
--   Removes a banned card from the challenge.
--   @param banned_card_id The ID of the banned card to remove.
-- ]]
-- function Challenge:removeBannedCard(banned_card_id)
--   self.restrictions.banned_cards =
--     removeItemById(self.restrictions.banned_cards, banned_card_id)
-- end

-- --[[
--   Adds a banned tag to the challenge.
--   @param banned_tag The banned tag to add.
-- ]]
-- function Challenge:addBannedTag(banned_tag)
--   table.insert(self.restrictions.banned_tags, banned_tag)
-- end

-- --[[
--   Removes a banned tag from the challenge.
--   @param banned_tag_id The ID of the banned tag to remove.
-- ]]
-- function Challenge:removeBannedTag(banned_tag_id)
--   self.restrictions.banned_tags =
--     removeItemById(self.restrictions.banned_tags, banned_tag_id)
-- end

-- --[[
--   Adds a banned other item to the challenge.
--   @param banned_other The banned other item to add.
-- ]]
-- function Challenge:addBannedOther(banned_other)
--   table.insert(self.restrictions.banned_other, banned_other)
-- end

-- --[[
--   Removes a banned other item from the challenge.
--   @param banned_other_id The ID of the banned other item to remove.
-- ]]
-- function Challenge:removeBannedOther(banned_other_id)
--   self.restrictions.banned_other =
--     removeItemById(self.restrictions.banned_other, banned_other_id)
-- end

-- function Challenge:toConfig()
--   return {
--     id = self.id,
--     name = self.name,
--     rules = self.rules,
--     jokers = self.jokers,
--     consumeables = self.consumeables,
--     vouchers = self.vouchers,
--     deck = self.deck,
--     restrictions = self.restrictions,
--   }
-- end

-- Challenge:new({
--   id = "example_challenge",
--   name = "example_name",
--   author = "example_author",
--   version = "1.0.0",
--   config = {
--     rules = {
--       custom = {
--         --{id = 'no_reward'},
--         { id = "no_reward_specific", value = "Big" },
--         { id = "no_extra_hand_money" },
--         { id = "no_interest" },
--       },
--       modifiers = {
--         { id = "dollars", value = 100 },
--         { id = "discards", value = 1 },
--         { id = "hands", value = 6 },
--         { id = "reroll_cost", value = 10 },
--         { id = "joker_slots", value = 8 },
--         { id = "consumable_slots", value = 3 },
--         { id = "hand_size", value = 5 },
--       },
--     },
--     jokers = {
--       { id = "j_egg" },
--       { id = "j_egg" },
--       { id = "j_egg" },
--       { id = "j_egg" },
--       { id = "j_egg", edition = "foil", eternal = true },
--     },
--     consumeables = {
--       { id = "c_sigil" },
--     },
--     vouchers = {
--       { id = "v_hieroglyph" },
--     },
--     deck = {
--       --enhancement = 'm_glass',
--       --edition = 'foil',
--       --gold_seal = true,
--       --yes_ranks = {['3'] = true,T = true},
--       --no_ranks = {['4'] = true},
--       --yes_suits = {S=true},
--       --no_suits = {D=true},
--       cards = {
--         { s = "D", r = "2", e = "m_glass" },
--         { s = "D", r = "3", e = "m_glass" },
--         { s = "D", r = "4", e = "m_glass" },
--         { s = "D", r = "5", e = "m_glass" },
--         { s = "D", r = "6", e = "m_glass" },
--         { s = "D", r = "7", e = "m_glass" },
--         { s = "D", r = "8", e = "m_glass" },
--         { s = "D", r = "9", e = "m_glass" },
--         { s = "D", r = "T", e = "m_glass" },
--         { s = "D", r = "J", e = "m_glass" },
--         { s = "D", r = "Q", e = "m_glass" },
--         { s = "D", r = "K", e = "m_glass" },
--         { s = "D", r = "A", e = "m_glass" },
--         { s = "C", r = "2", e = "m_glass" },
--         { s = "C", r = "3", e = "m_glass" },
--         { s = "C", r = "4", e = "m_glass" },
--         { s = "C", r = "5", e = "m_glass" },
--         { s = "C", r = "6", e = "m_glass" },
--         { s = "C", r = "7", e = "m_glass" },
--         { s = "C", r = "8", e = "m_glass" },
--         { s = "C", r = "9", e = "m_glass" },
--         { s = "C", r = "T", e = "m_glass" },
--         { s = "C", r = "J", e = "m_glass" },
--         { s = "C", r = "Q", e = "m_glass" },
--         { s = "C", r = "K", e = "m_glass" },
--         { s = "C", r = "A", e = "m_glass" },
--         { s = "H", r = "2", e = "m_glass" },
--         { s = "H", r = "3", e = "m_glass" },
--         { s = "H", r = "4", e = "m_glass" },
--         { s = "H", r = "5", e = "m_glass" },
--         { s = "H", r = "6", e = "m_glass" },
--         { s = "H", r = "7", e = "m_glass" },
--         { s = "H", r = "8", e = "m_glass" },
--         { s = "H", r = "9", e = "m_glass" },
--         { s = "H", r = "T", e = "m_glass" },
--         { s = "H", r = "J", e = "m_glass" },
--         { s = "H", r = "Q", e = "m_glass" },
--         { s = "H", r = "K", e = "m_glass" },
--         { s = "H", r = "A", e = "m_glass" },
--         { s = "S", r = "2", e = "m_glass" },
--         { s = "S", r = "3", e = "m_glass" },
--         { s = "S", r = "4", e = "m_glass" },
--         { s = "S", r = "5", e = "m_glass" },
--         { s = "S", r = "6", e = "m_glass" },
--         { s = "S", r = "7", e = "m_glass" },
--         { s = "S", r = "8", e = "m_glass" },
--         { s = "S", r = "9", e = "m_glass" },
--         { s = "S", r = "T", e = "m_glass" },
--         { s = "S", r = "J", e = "m_glass" },
--         { s = "S", r = "Q", e = "m_glass" },
--         { s = "S", r = "K", e = "m_glass" },
--         { s = "S", r = "A", e = "m_glass" },
--       },
--       type = "Challenge Deck",
--     },
--     restrictions = {
--       banned_cards = {
--         { id = "j_joker" },
--         { id = "j_egg" },
--       },
--       banned_tags = {
--         { id = "tag_garbage" },
--         { id = "tag_handy" },
--       },
--       banned_other = {
--         { id = "bl_wall", type = "blind" },
--       },
--     },
--   },
-- })
