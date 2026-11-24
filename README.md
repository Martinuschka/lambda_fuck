# lambda-fuck

A small Haskell project using Cabal for a Brainfuck interpreter and text-to-Brainfuck encoder.

## Overview

The project contains a simple Brainfuck interpreter with a pure runtime state, precomputed loop positions, a CLI, and a small test suite.

## Usage

Run a Brainfuck program file (*.bf):

```bash
cabal build
cabal run bf -- run examples/hello.bf
```

Run an embedded Brainfuck program:

```bash
cabal run bf -- eval "+.+."
```

Generate Brainfuck that prints text:

```bash
cabal run bf -- brain "Hello, world!"
```

## Examples

```brainfuck
++++++++[>++++[>++>+++>+++>+<<<<-]>+>+>->>+[<]<-]>>.>---.+++++++..+++.>>.<-.<.+++.------.--------.>>+.>++.
```

This produces the output:

```text
Hello World!
```

See [`examples/README.md`](examples/README.md) for the runnable example programs and their expected input/output behavior.

## Project Structure

- `src/Brainfuck.hs` – Interpreter and text encoder
- `app/Main.hs` – Command-line interface
- `test/Main.hs` – Test suite
- `examples/` – Brainfuck example programs
