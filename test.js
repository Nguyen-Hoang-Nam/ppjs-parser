import { convertPipeToJS } from "./main.js";
import test from "ava";

test("1 pipe operator", (t) => {
    const ppjs = convertPipeToJS(`
        "text"
        |> print()
    `);

    t.is(ppjs, `print('text');`);
});

test("1 pipe operator with member expression", (t) => {
    const ppjs = convertPipeToJS(`
        "text"
        |> console.log()
    `);

    t.is(ppjs, `console.log('text');`);
});

test("1 pipe operator with argument", (t) => {
    const ppjs = convertPipeToJS(`
        "text"
        |> print("argument 1", "argument 2")
        `);

    t.is(ppjs, `print('text', 'argument 1', 'argument 2');`);
});

test("1 pipe operator with arithmetic", (t) => {
    const ppjs = convertPipeToJS(`
        (1 + 1)
        |> print()
        `);

    t.is(ppjs, `print(1 + 1);`);
});

test("1 pipe operator with arra", (t) => {
    const ppjs = convertPipeToJS(`
        [1, 2, 3]
        |> print()
        `);

    t.is(ppjs, `print([1, 2, 3]);`);
});

test("2 pipe operator", (t) => {
    const ppjs = convertPipeToJS(`
        "text"
        |> print()
        |> print()
    `);

    t.is(ppjs, `print(print('text'));`);
});

test("2 pipe operator with member expression", (t) => {
    const ppjs = convertPipeToJS(`
        "text"
        |> console.log()
        |> print()
    `);

    t.is(ppjs, `print(console.log('text'));`);
});
