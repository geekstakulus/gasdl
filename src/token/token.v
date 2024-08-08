module token

import source

// TokenKind represents the different kinds of tokens based on the EBNF grammar.
pub enum TokenKind as u8 {
    // Keywords
    @module
    attributes

    // Operators
    asterisk
    question_mark

    // Delimiters
    lbrack
    rbrack
    langle
    rangle
    lparen
    rparen
    lbrace
    rbrace
    comma
    pipe
    eq

    // Identifiers
    type_ident
    constructor_ident

    // End of File
    eof
}

// Constants for token group boundaries
const (
    keyword_beg = TokenKind.@module
    keyword_end = TokenKind.attributes
    operator_beg = TokenKind.asterisk
    operator_end = TokenKind.question_mark
    delimiter_beg = TokenKind.lbrack
    delimiter_end = TokenKind.eq
    tokens = [
        'module', 'attributes',
        '[', ']', '<', '>', '(', ')', '{', '}', ',', '*', '.', '?', '|', '=', 'EOF',
        'Type Identifier', 'Constructor Identifier'
    ]
    keywords = {
        'module': TokenKind.@module,
        'attributes': TokenKind.attributes,
    }
)

// Token represents a token in the source code with its kind, lexeme, and position.
pub struct Token {
    pub:
        kind   TokenKind
        lexeme string
        pos    source.Position
}

// TokenKind methods to check the type of token

// is_keyword checks if the token kind is a keyword
pub fn (tk TokenKind) is_keyword() bool {
    return int(tk) >= int(keyword_beg) && int(tk) <= int(keyword_end)
}

// is_operator checks if the token kind is an operator
pub fn (tk TokenKind) is_operator() bool {
    return int(tk) >= int(operator_beg) && int(tk) <= int(operator_end)
}

// is_delimiter checks if the token kind is a delimiter
pub fn (tk TokenKind) is_delimiter() bool {
    return int(tk) >= int(delimiter_beg) && int(tk) <= int(delimiter_end) && !tk.is_operator()
}

// lookup returns the TokenKind for a given string, differentiating between keywords, type_ident, and constructor_ident
pub fn lookup(key string) TokenKind {
    // Check if the string matches a known keyword
    if tk := keywords[key] {
        return tk
    }

    // Determine the kind based on the first character of the string
    match key[0] {
				`A`...`Z` {
						// If the first character is uppercase, it's a constructor identifier
						return TokenKind.constructor_ident
				}
				else {
						// If the first character is not uppercase, it must be lowercase, hence a type identifier
						return TokenKind.type_ident
				}
		}
}
