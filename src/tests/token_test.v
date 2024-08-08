import token

fn test_is_keyword() {
    assert token.TokenKind.@module.is_keyword()
    assert token.TokenKind.attributes.is_keyword()
    assert !token.TokenKind.type_ident.is_keyword()
    assert !token.TokenKind.constructor_ident.is_keyword()
    assert !token.TokenKind.asterisk.is_keyword()
    assert !token.TokenKind.eof.is_keyword()
}

fn test_is_operator() {
    assert token.TokenKind.asterisk.is_operator()
    assert token.TokenKind.question_mark.is_operator()
    assert !token.TokenKind.type_ident.is_operator()
    assert !token.TokenKind.constructor_ident.is_operator()
    assert !token.TokenKind.eof.is_operator()
}

fn test_is_delimiter() {
    assert token.TokenKind.lbrack.is_delimiter()
    assert token.TokenKind.rbrack.is_delimiter()
    assert token.TokenKind.langle.is_delimiter()
    assert token.TokenKind.rangle.is_delimiter()
    assert token.TokenKind.lparen.is_delimiter()
    assert token.TokenKind.rparen.is_delimiter()
    assert token.TokenKind.lbrace.is_delimiter()
    assert token.TokenKind.rbrace.is_delimiter()
    assert token.TokenKind.comma.is_delimiter()
    assert token.TokenKind.pipe.is_delimiter()
    assert token.TokenKind.eq.is_delimiter()
    assert !token.TokenKind.type_ident.is_delimiter()
    assert !token.TokenKind.constructor_ident.is_delimiter()
    assert !token.TokenKind.asterisk.is_delimiter()
    assert !token.TokenKind.eof.is_delimiter()
}

fn test_lookup() {
    // Test all known keywords
    assert token.lookup('module') == .@module
    assert token.lookup('attributes') == .attributes

    // Test type identifiers
    assert token.lookup('mytype') == .type_ident
    assert token.lookup('another_type') == .type_ident

    // Test constructor identifiers
    assert token.lookup('MyConstructor') == .constructor_ident
    assert token.lookup('AnotherConstructor') == .constructor_ident

    // Test string that is not a keyword but should be an identifier
    assert token.lookup('my_variable') == .type_ident
    assert token.lookup('var1') == .type_ident
    assert token.lookup('MyVariable') == .constructor_ident
}

