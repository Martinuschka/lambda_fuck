# lambda-fuck

A small Haskell project using Cabal for a Brainfuck interpreter.

## Overview

The project contains a simple but functional Brainfuck interpreter with:

- a pure runtime state consisting of a pointer, tape, and program counter
- precomputed loop positions using `Map`
- a CLI with `bf run <file>` and `bf eval <program>`
- a small test suite for basic functionality

## Usage

```bash
cabal build
cabal run bf -- run example/hello.bf
```

Or directly with an embedded program:

```bash
cabal run bf -- eval "+.+."
```

## Example

```brainfuck
++++++++[>++++[>++>+++>+++>+<<<<-]>+>+>->>+[<]<-]>>.>---.+++++++..+++.>>.<-.<.+++.------.--------.>>+.>++.
```

This produces the output:

```text
Hello World!
```

## Project Structure

- `src/Brainfuck.hs` – Interpreter logic
- `app/Main.hs` – Command-line interface
- `test/Main.hs` – Small test suite
- `example/hello.bf` – Hello World example

## Ideas for Extensions

- `#` debug command to print the current tape
- Optimize loops using a jump map or tree
- Support for more input and output formats
- More tests with Mandelbrot, quines, and Brainfuck katas
