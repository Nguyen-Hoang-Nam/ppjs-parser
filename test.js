import { convertPipeToJS } from "./main.js";

const ppjs = convertPipeToJS(`
    "text"
    |> capitalName()
    |> print()
`);

console.log(ppjs == `print(capitalName('text'));`);
