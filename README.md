# lambda-fuck

A small Haskell project using Cabal for a Brainfuck interpreter and text-to-Brainfuck encoder.

## Overview

The project contains a simple but functional Brainfuck interpreter with:

- a pure runtime state consisting of a pointer, tape, and program counter
- precomputed loop positions using `Map`
- a CLI with `bf run <file>`, `bf eval <program>`, and `bf brain <text>`
- a small test suite for basic functionality

## Usage

```bash
cabal build
cabal run bf -- run example/hello.bf
```

Run an embedded Brainfuck program:

```bash
cabal run bf -- eval "+.+."
```

Generate Brainfuck that prints text (quote the text so it is passed as one argument):

```bash
cabal run bf -- brain "Hello, world!"
```

The `brain` command emits a program that prints the given text when run by a Brainfuck interpreter. It encodes each character as an 8-bit cell value; characters above U+00FF are reduced modulo 256.

## Example

```brainfuck
++++++++[>++++[>++>+++>+++>+<<<<-]>+>+>->>+[<]<-]>>.>---.+++++++..+++.>>.<-.<.+++.------.--------.>>+.>++.
```

This produces the output:

```text
Hello World!
```

## Project Structure

- `src/Brainfuck.hs` – Interpreter and text encoder
- `app/Main.hs` – Command-line interface
- `test/Main.hs` – Test suite
- `example/hello.bf` – Hello World example

## Ideas for Extensions

- `#` debug command to print the current tape
- Optimize loops using a jump map or tree
- Support for more input and output formats
- More tests with Mandelbrot, quines, and Brainfuck katas
