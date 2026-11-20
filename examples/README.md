# Brainfuck examples

These programs use the interpreter's 8-bit wrapping cells. Run one with:

```bash
cabal run bf -- run examples/<name>.bf
```

For programs that read input, pass it as the optional third argument:

```bash
cabal run bf -- run examples/echo.bf "A"
```

| File | Function | Input/output |
| --- | --- | --- |
| `hello.bf` | Prints `Hello World!` | No input; prints a greeting. |
| `echo.bf` | Echoes one byte | Reads one byte and prints it. |
| `cat.bf` | Copies a stream | Reads and prints bytes until a zero byte/EOF. |
| `reverse.bf` | Reverses a line | Reads bytes terminated by EOF/zero and prints them in reverse order. |
| `add.bf` | Adds two bytes | Input: two bytes; output: their 8-bit sum. |
| `multiply.bf` | Multiplies two bytes | Input: two bytes; output: their 8-bit product. |
| `fibonacci.bf` | Emits Fibonacci byte values | Prints `0, 1, 1, 2, 3, 5, 8, 13, 21, 34` as raw byte values. |
| `truth-machine.bf` | Repeats a truthy byte | Input `0` produces no output; a nonzero byte is printed repeatedly. Stop an infinite run externally. |
| `rot13.bf` | Demonstrates a ROT13 step | Reads one byte and adds 13; use with a byte in the first half of the 8-bit range (for example, `a` becomes `n`). |
| `quine.bf` | Loop/arithmetic demonstration | A small finite control-flow example; it is intentionally a compact quine-oriented placeholder, not a general self-printing quine. |
| `mandelbrot.bf` | Nested-loop stress example | A small bounded arithmetic/control-flow smoke test; it is intentionally not a full ASCII Mandelbrot renderer. |

The last two files are conservative, runnable placeholders rather than large canonical quine and Mandelbrot implementations. This keeps the examples quick and safe for the interpreter while leaving room for full versions later.
