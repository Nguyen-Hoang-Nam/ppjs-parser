# PPJS Parser (Pipe JS)

Experimental implement pipe operator to Javascript. This will be a parser for
ppjs (read as pipe js).

## Installation

```bash
npm install ppjs-parser
```

## Usage

```javascript
import { convertPipeToJS } from "ppjs-parser";

convertPipeToJS(`
"text"
|> capitalName()
|> print()
`); // print(capitalName("text"))
```

## Concept

Parser will convert code to [Esprima AST](https://astexplorer.net/) then use Escodegen to convert to Javascript
code.

## TO DO

- [x] Support array type

## Contributing

Pull requests are welcome. For major changes,
please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License

[MIT](https://choosealicense.com/licenses/mit/)
