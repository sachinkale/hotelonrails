class JapaneseTranslator
    # My knowledge of counting Japanese is limited, so this may not
    # be entirely correct; in particular, I don't know what rules
    # to follow after 'hyaku man' (1,000,000).
    # I also combine a digit with its group, such as 'gohyaku' rather
    # than 'go hyaku'; I just like reading it better that way.

    DIGITS = %w(zero ichi ni san shi go roku shichi hachi kyu)
    GROUPS = %w(nothingtoseeheremovealong ju hyaku sen)
    MAN = 10000

    def to_spoken(val)
        case val <=> 0
        when -1
            '- ' + to_spoken(-val)
        when 0
            DIGITS[0]
        else
            group(val, 0)
        end
    end

    private

    def group(val, level)
        if val >= MAN
            group(val / MAN, 0) + 'man ' + group(val % MAN, 0)
        else
            case val
            when 0
                ''
            when 1
                level == 0 ? DIGITS[val] : GROUPS[level]
            when 2...10
                DIGITS[val] + (GROUPS[level] if level > 0).to_s
            else
                group(val / 10, level+1) + ' ' + group(val % 10, level)
            end
        end
    end
end


class USEnglishTranslator
    # Formal, US English. Optional 'and'. Will not produce things
    # such as 'twelve hundred' but rather 'one thousand two hundred'.
    # The use of 'and' is incomplete; it is sometimes missed.

    DIGITS = %w(zero one two three four five six seven eight nine)
    TEENS  = %w(ten eleven twelve thirteen fourteen fifteen sixteen
                seventeen eighteen nineteen)
    TENS   = %w(hello world twenty thirty forty fifty sixty seventy
                eighty ninety)
    GROUPS = %w(thousand million billion trillion quadrillion
                quintillion sextillion septillion octillion nonillion
                decillion)
    K = 1000

    def initialize(conjunction = true)
        @conjunction = conjunction
    end

    def to_spoken(val)
        case val <=> 0
        when -1
            'negative ' + to_spoken(-val)
        when 0
            DIGITS[0]
        else
            group(val, 0).flatten.join(' ')
        end
    end

    private

    def group(val, level)
        x = group(val / K, level + 1) << GROUPS[level] if val >= K
        x.to_a << under_1000(val % K, level)
    end

    def under_1000(val, level)
        x = [DIGITS[val / 100]] << 'hundred' if val >= 100
        x.to_a << under_100(val % 100, (level == 0 and not x.nil?))
    end

    def under_100(val, junction)
        x = [('and' if @conjunction and junction)]    # wyf?
        case val
        when 0
            []
        when 1...10
            x << DIGITS[val]
        when 10...20
            x << TEENS[val - 10]
        else
            d = val % 10
            x << (TENS[val / 10] + ('-' + DIGITS[d] if d != 0).to_s)
        end
    end
end


class Integer
	
	def to_english(number = self)
		translator = USEnglishTranslator.new
		translator.to_spoken(number).squeeze(' ').strip
  end

	def to_japanese(number = self)
    translator = JapaneseTranslator.new
    translator.to_spoken(number).squeeze(' ').strip
  end    

  ## change the whole number into dollars
  def to_dollars(number = self)
  	translator = USEnglishTranslator.new
		currency = translator.to_spoken(number).squeeze(' ').strip
		currency << ' dollars' if currency != 'one'
		currency << ' dollar' if currency == 'one'
		currency
	end
end

class Float
  ## change the floating point number into dollars and cents
  def to_dollars(number = self)
		use_and = false
		translator = USEnglishTranslator.new(use_and)
	  currency = translator.to_spoken(number.floor).squeeze(' ').strip
    currency << ' dollars' if currency != 'one'
		currency << ' dollar' if currency == 'one'
		change = ((number - number.to_i) * 100).round
		cent = change == 1 ? 'cent' : 'cents'
		currency << ' and ' << translator.to_spoken(change).squeeze(' ').strip << " #{cent}"
	end

	def to_english(number = self)
		number.to_i.to_english
	end

	def to_japanese(number = self)
		number.to_i.to_japanese
	end
end
    


#number = 42354325434234325
#change = 123.05
#puts number.to_english
#puts number.to_dollars
#puts change.to_dollars
#puts number.to_japanese

