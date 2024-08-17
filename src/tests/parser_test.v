import source
import scanner
import parser

fn test_parse_valid_module() {
    src := source.new("module MyModule {}")
    mut s := scanner.new(src)
    mut p := parser.new(s)

    result := p.parse_module()

    assert result == true
}

fn test_parse_invalid_module() {
    src := source.new("module 123Module {}")
    mut s := scanner.new(src)
    mut p := parser.new(s)

    result := p.parse_module()

    assert result == false
}

