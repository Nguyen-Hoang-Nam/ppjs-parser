start = _ code:(statements / _) _ {
    return { 
        "type": "Program",
        "body": [code]
    };
 }

statements = _ pipe_statement:pipe_statement {
    return pipe_statement
}

pipe_statement = _ expression:expression _ pipe:(middle_pipe / end_pipe) {
    return {
        "type": "ExpressionStatement",
        "expression": pipe(expression)
    }
}

middle_pipe = _ "|>" _ callee:(member_expression / identifier) "(" _ args:(middle_arguments / last_arguments)* _ ")" _ tail:(middle_pipe / end_pipe) {
    if (!args[0]) {
        args[0] = []
    }

    return (expression) => {
        args[0].unshift(expression)

        return tail({
            "type": "CallExpression",
            "callee": callee,
            "arguments": args[0],
            "optional": false
        })
    }
}

end_pipe = _ "|>" _ callee:(member_expression / identifier) "(" _ args:(middle_arguments / last_arguments)* _ ")" _ {
    if (!args[0]) {
        args[0] = []
    }

    return (expression) => {
        args[0].unshift(expression)

        return {

            "type": "CallExpression",
            "callee": callee,
            "arguments": args[0],
            "optional": false
        }
    }
}

middle_arguments = expression:expression _ "," _ args:(middle_arguments / last_arguments) {
    args.unshift(expression)
    return args
}

last_arguments = expression:expression { return [expression] }

expression = expression:(variable / arithmetic / literal ) { return expression; }

literal = value:(string / Integer) {
   return {"type": "Literal", "value": value };
}

variable = !keywords variable:name {
  return {
    "type": "Identifier",
    "name": variable
  }
}

identifier = identifier:name {
    return {
        "type": "Identifier",
        "name": identifier
    }
}

member_expression = object:identifier "." property:identifier {
    return {
        "type": "MemberExpression",
        "object": object,
        "property": property,
        "computed": false,
        "optional": false
    }
}

keywords = "if" / "else" / "var" / "let" / "const" / "for" / "while" / "import" / "from" / "require"

name = [A-Z_$a-z][A-Z_a-z0-9]* { return text(); }

string = "\"" ([^"] / "\\\\\"")*  "\"" {
  return JSON.parse(text());
}

arithmetic
  = head:term tail:(_ ("+" / "-") _ term)* {
      return tail.reduce(function(result, element) {
          return {
            "type": "BinaryExpression",
            "operator": element[1],
            "left": result,
            "right": element[3]
          };
      }, head);
    }

term
  = head:factor tail:(_ ("*" / "/") _ factor)* {
      return tail.reduce(function(result, element) {
          return {
            "type": "BinaryExpression",
            "operator": element[1],
            "left": result,
            "right": element[3]
          };
      }, head);
    }

factor
  = "(" _ expr:arithmetic _ ")" { return expr; }
  / literal

Integer "integer"
  = _ [0-9]+ { return parseInt(text(), 10); }

comments = "#" [^\n]*

_ "whitespace"
  = [ \t\n\r]* {
   return [];
}
