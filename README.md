# lambda-fuck

Ein kleines Haskell-Projekt mit Cabal für einen Brainfuck-Interpreter.

## Überblick

Das Projekt enthält einen einfachen, aber funktionalen Brainfuck-Interpreter mit:

- einem reinen Laufzeitzustand aus Zeiger, Band und Programmzähler
- einer Vorberechnung der Schleifen-Positionen mit `Map`
- einer CLI mit `bf run <datei>` und `bf eval <programm>`
- einer kleinen Test-Suite für Grundfunktionalität

## Verwendung

```bash
cabal build
cabal run bf -- run example/hello.bf
```

Oder direkt mit einem eingebetteten Programm:

```bash
cabal run bf -- eval "+.+."
```

## Beispiel

```brainfuck
++++++++[>++++[>++>+++>+++>+<<<<-]>+>+>->>+[<]<-]>>.>---.+++++++..+++.>>.<-.<.+++.------.--------.>>+.>++.
```

Das erzeugt die Ausgabe:

```text
Hello World!
```

## Projektstruktur

- `src/Brainfuck.hs` – Interpreter-Logik
- `app/Main.hs` – Kommandozeilen-Interface
- `test/Main.hs` – Kleiner Test-Satz
- `example/hello.bf` – Hello-World-Beispiel

## Ideen für Erweiterungen

- `#`-Debug-Befehl für die Ausgabe des aktuellen Bands
- Optimierung der Schleifen mit einer Jump-Map oder einem Baum
- Unterstützung für mehr Eingabe- und Ausgabe-Formate
- Mehr Tests mit Mandelbrot/Quine/Brainfuck-Katas
