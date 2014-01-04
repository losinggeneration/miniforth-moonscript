moonscript = require "moonscript"

export ^

class MiniForth
	new: (subj = "", pos = 1) =>
		@subj, @pos = subj, pos
		@F = {"%M": -> @@eval @parse_rest_of_line!}
		@mode = "interpret"
		@modes = {interpret: ->
			@word = @get_word_or_newline! or ""
			@p_s_i!
			@interpret_primitive! or @interpret_nonprimitive! or @interpret_number! or error string.format[[Can't interpret: "%s"]], @word
		}

	@eval: (code) => assert(moonscript.loadstring code)!

	subject: (s) => @subj = s

	parse_by_pattern: (pat) =>
		cap, newpos = string.match @subj, pat, @pos
		if newpos
			@pos = newpos
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

	run: => while @mode != "stop" do @modes[@mode]!

	interpret_primitive: => if type(@F[@word]) == "function" then
		@F[@word]!
		true

	interpret_nonprimitive: => false
	interpret_number: => false
	p_s_i: =>
