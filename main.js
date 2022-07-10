import { parse } from "./pipe.js";
import escodegen from "escodegen";

export function convertPipeToJS(pipeCode) {
    return escodegen.generate(parse(pipeCode));
}
