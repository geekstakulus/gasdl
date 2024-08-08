module scanner

import token
import source
import strings

pub struct Scanner {
    mut:
    src      source.Source
    symbol   token.TokenKind
    position source.Position
    text     strings.Builder
}

pub fn new(src source.Source) Scanner {
    return Scanner{
        src: src,
        symbol: token.TokenKind.eof, // Default to EOF initially
        position: source.Position{line: 1, column: 1},
        text: strings.new_builder(100)
    }
}

pub fn (mut s Scanner) advance() {
    s.skip_whitespace()
    match s.src.current_char {
        `*`, `?` { // Valid operators
            s.scan_operator()
        }
        `(`, `)`, `{`, `}`, `,`, `|`, `=` { // Valid delimiters
            s.scan_delimiter()
        }
        `a`...`z`, `A`...`Z` { // Identifiers or keywords
            s.scan_identifier_or_keyword()
        }
        `\0` { // End of file
            s.symbol = .eof
            s.position = s.src.character_position()
            s.text.clear()
            s.text.write_byte(`\0`)
        }
        `-` { // Start of comment
            if s.src.peek() == `-` {
		s.src.advance() // consume `-`
                s.scan_comment() // comment is ignored
		s.advance() // get the next token
            } else {
		s.scan_illegal_token()
	    }
        }
        else {
            s.scan_illegal_token()
        }
    }
}

pub fn (mut s Scanner) skip_whitespace() {
    for s.src.current_char in [` `, `\t`, `\n`, `\r`] {
        s.src.advance()
    }
}

pub fn (mut s Scanner) current_token() token.Token {
    return token.Token{
        kind: s.symbol,
        pos: s.position,
        lexeme: s.text.str()
    }
}

fn (mut s Scanner) scan_operator() {
    match s.src.current_char {
        `*` { s.symbol = .asterisk }
        `?` { s.symbol = .question_mark }
        else { s.symbol = .invalid }
    }
    s.position = s.src.character_position()
    s.text.write_byte(s.src.current_char)
    s.src.advance()
}

fn (mut s Scanner) scan_delimiter() {
    match s.src.current_char {
        `(` { s.symbol = .lparen }
        `)` { s.symbol = .rparen }
        `{` { s.symbol = .lbrace }
        `}` { s.symbol = .rbrace }
        `,` { s.symbol = .comma }
        `|` { s.symbol = .pipe }
        `=` { s.symbol = .eq }
        else { s.symbol = .invalid }
    }
    s.position = s.src.character_position()
    s.text.write_byte(s.src.current_char)
    s.src.advance()
}

fn (mut s Scanner) scan_identifier_or_keyword() {
    s.position = s.src.character_position()
    s.text.clear()

    for {
	match s.src.current_char {
	    `a`...`z`, `_`, `A`...`Z`, `0`...`9` {
		s.text.write_byte(s.src.current_char)
		s.src.advance()
	    }
	    else {
		break
	    }
	}
    }

    keyword := s.text.str()
    s.symbol = token.lookup(keyword)
    s.text.write_string(keyword)
}

fn (mut s Scanner) scan_illegal_token() {
    s.text.write_byte(s.src.current_char)
    s.position = s.src.character_position()
    s.symbol = .invalid
    s.src.advance()
}

fn (mut s Scanner) scan_comment() {
    s.src.advance() // advance to the next character

    // Skip characters until end of line
    for s.src.current_char != `\n` && s.src.current_char != `\r` && s.src.current_char != `\0` {
        s.src.advance()
    }

    match s.src.current_char {
	`\n`, `\r` {
	    s.src.advance()
	}
	else {}
    }
}

