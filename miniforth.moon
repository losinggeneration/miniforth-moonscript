import extend from require "moon"

class MiniForth
	new: (subj = "") =>
		@subject = subj
		@position = 1
		@dictionary = {}
		@mode = "interpret"
		@modes = {interpret: ->
			@word = @get_word_or_newline! or ""
			@p_s_i!
			@interpret_primitive! or @interpret_nonprimitive! or @interpret_number! or error string.format[[Can't interpret: "%s"]], @word
		}

	add_words: (words) => extend(@dictionary, words)

	parse_by_pattern: (pat) =>
		cap, newpos = string.match @subject, pat, @position
		if newpos
			@position = newpos
			cap

	parse_spaces: => @parse_by_pattern "^([ \t]*)()"
	parse_word: => @parse_by_pattern "^(%S+)()"
	parse_newline: => @parse_by_pattern "^(\n)()"
	parse_rest_of_line: => @parse_by_pattern "^([^\n]*)()"
	parse_word_or_newline: => @parse_word! or @parse_newline!

	get_word: =>
		@parse_spaces!
		@parse_word!

	get_word_or_newline: =>
		@parse_spaces!
		@parse_word_or_newline!

	interpret_primitive: => if type(@dictionary[@word]) == "function" then
		@dictionary[@word]!
		true

	interpret_nonprimitive: => false
	interpret_number: => false
	p_s_i: =>
	run: => while @mode != "stop" do @modes[@mode]!

{ :MiniForth }
