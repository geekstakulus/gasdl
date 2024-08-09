import token
import source
import scanner

fn test_operators() {
    src := source.new(" * ? ")
    mut s := scanner.new(src)

    s.advance()
    assert s.current_token() == token.Token{
        kind: .asterisk
        pos: source.Position{line: 1, column: 2}
        lexeme: "*"
    }

    s.advance()
    assert s.current_token() == token.Token{
        kind: .question_mark
        pos: source.Position{line: 1, column: 4}
        lexeme: "?"
    }
}

fn test_delimiters() {
    src := source.new("( ) { } , | =")
    mut s := scanner.new(src)

    s.advance()
    assert s.current_token() == token.Token{
        kind: .lparen
        pos: source.Position{line: 1, column: 1}
        lexeme: "("
    }

    s.advance()
    assert s.current_token() == token.Token{
        kind: .rparen
        pos: source.Position{line: 1, column: 3}
        lexeme: ")"
    }

    s.advance()
    assert s.current_token() == token.Token{
        kind: .lbrace
        pos: source.Position{line: 1, column: 5}
        lexeme: "{"
    }

    s.advance()
    assert s.current_token() == token.Token{
        kind: .rbrace
        pos: source.Position{line: 1, column: 7}
        lexeme: "}"
    }

    s.advance()
    assert s.current_token() == token.Token{
        kind: .comma
        pos: source.Position{line: 1, column: 9}
        lexeme: ","
    }

    s.advance()
    assert s.current_token() == token.Token{
        kind: .pipe
        pos: source.Position{line: 1, column: 11}
        lexeme: "|"
    }

    s.advance()
    assert s.current_token() == token.Token{
        kind: .eq
        pos: source.Position{line: 1, column: 13}
        lexeme: "="
    }
}


fn test_identifiers() {
    src := source.new("myVar my_type MY_CONSTANT")
    mut s := scanner.new(src)

    // Test for constructor identifier
    s.advance()
    assert s.current_token() == token.Token{
        kind: .type_ident
        pos: source.Position{line: 1, column: 1}
        lexeme: "myVar"
    }

    // Test for type identifier
    s.advance()
    assert s.current_token() == token.Token{
        kind: .type_ident
        pos: source.Position{line: 1, column: 7}
        lexeme: "my_type"
    }

    // Test for constructor identifier
    s.advance()
    assert s.current_token() == token.Token{
        kind: .constructor_ident
        pos: source.Position{line: 1, column: 15}
        lexeme: "MY_CONSTANT"
    }
}


fn test_comments() {
    src := source.new("-- This is a comment\n*")
    mut s := scanner.new(src)

    s.advance()
    assert s.current_token() == token.Token{
        kind: .asterisk
        pos: source.Position{line: 2, column: 1}
        lexeme: "*"
    }
}

fn test_whitespace() {
    src := source.new("   \t\n\r*")
    mut s := scanner.new(src)

    s.advance()
    assert s.current_token() == token.Token{
        kind: .asterisk
        pos: source.Position{line: 2, column: 1}
        lexeme: "*"
    }
}

fn test_illegal_tokens() {
    src := source.new("@")
    mut s := scanner.new(src)

    s.advance()
    assert s.current_token() == token.Token{
        kind: .invalid
        pos: source.Position{line: 1, column: 1}
        lexeme: "@"
    }
}

