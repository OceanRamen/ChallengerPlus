local EMPTY_CHALLENGE = {
	rules = {
		custom = {},
		modifiers = {},
	},
	jokers = {},
	consumeables = {},
	vouchers = {},
	deck = {
		type = "CPlusChallenge Deck",
		cards = {},
	},
	restrictions = {
		banned_cards = {},
		banned_tags = {},
		banned_other = {},
	},
}

--- @class CPlusChallenge
CPlusChallenge = Object:extend()

function CPlusChallenge:get_empty()
	return EMPTY_CHALLENGE
end

function CPlusChallenge:new(id, meta, config)
	self.id = id
	self.meta = table_merge({ name = id }, meta)
	table_merge(self, table_copy(EMPTY_CHALLENGE), table_copy(config or {}))
	return self
end
function CPlusChallenge:set_deck_back(type)
	self.deck.type = type
end
function CPlusChallenge:set_deck_cards(cards)
	self.deck.cards = cards
end
function CPlusChallenge:add_custom_rule(rule)
	table.insert(self.rules.custom, rule)
end
function CPlusChallenge:remove_custom_rule(rule_id)
	self.rules.custom = table_remove_id(self.rules.custom, rule_id)
end
function CPlusChallenge:add_modifier(modifier)
	table.insert(self.rules.modifiers, modifier)
end
function CPlusChallenge:remove_modifier(modifier_id)
	self.rules.modifiers = table_remove_id(self.rules.modifiers, modifier_id)
end
function CPlusChallenge:add_joker(joker, position)
	if position then
		table.insert(self.jokers, position, joker)
	else
		table.insert(self.jokers, joker)
	end
end
function CPlusChallenge:remove_joker(joker_id)
	self.jokers = table_remove_id(self.jokers, joker_id)
end
function CPlusChallenge:add_consumeable(consumeable)
	table.insert(self.consumeables, consumeable)
end
function CPlusChallenge:remove_consumeable(consumeable_id)
	self.consumeables = table_remove_id(self.consumeables, consumeable_id)
end
function CPlusChallenge:add_voucher(voucher)
	table.insert(self.vouchers, voucher)
end
function CPlusChallenge:remove_voucher(voucher_id)
	self.vouchers = table_remove_id(self.vouchers, voucher_id)
end
function CPlusChallenge:add_banned_card(banned_card)
	table.insert(self.restrictions.banned_cards, banned_card)
end
function CPlusChallenge:remove_banned_card(banned_card_id)
	self.restrictions.banned_cards = table_remove_id(self.restrictions.banned_cards, banned_card_id)
end
function CPlusChallenge:add_banned_tag(banned_tag)
	table.insert(self.restrictions.banned_tags, banned_tag)
end
function CPlusChallenge:remove_banned_tag(banned_tag_id)
	self.restrictions.banned_tags = table_remove_id(self.restrictions.banned_tags, banned_tag_id)
end
function CPlusChallenge:add_banned_blind(banned_blind)
	table.insert(self.restrictions.banned_other, banned_blind)
end
function CPlusChallenge:remove_banned_blind(banned_blind_id)
	self.restrictions.banned_other = table_remove_id(self.restrictions.banned_other, banned_blind_id)
end
function CPlusChallenge:to_config()
	return {
		id = self.id,
		name = self.name,
		meta = self.meta,
		rules = self.rules,
		jokers = self.jokers,
		consumeables = self.consumeables,
		vouchers = self.vouchers,
		deck = self.deck,
		restrictions = self.restrictions,
	}
end
