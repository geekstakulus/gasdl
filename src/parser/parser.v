module parser

import token
import scanner

pub struct Parser {
    mut:
    scan scanner.Scanner
}

pub fn new(s scanner.Scanner) Parser {
    return Parser{ scan: s }
}

pub fn (mut p Parser) parse_module() bool {
    p.scan.advance() // get the module token
    if !p.expect(token.TokenKind.@module) {
        return false
    }

    // Read the next token to check if it is an identifier
    identifier_token := p.scan.current_token()

    if identifier_token.kind !in [token.TokenKind.type_ident, token.TokenKind.constructor_ident] {
        return false
    }

    // Advance past the identifier
    p.scan.advance()

    if !p.expect(token.TokenKind.lbrace) {
        return false
    }

    if !p.expect(token.TokenKind.rbrace) {
        return false
    }

    return true
}

fn (mut p Parser) expect(expected_kind token.TokenKind) bool {
    current_token := p.scan.current_token()
    if current_token.kind == expected_kind {
        p.scan.advance()
        return true
    }
    return false
}
