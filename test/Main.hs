module Main (main) where

import Brainfuck (BrainfuckError(..), runText, textToBrainfuck)
import Test.HUnit

simpleTests :: Test
simpleTests =
  TestList
    [ TestCase (assertEqual "single output byte" (Right [toEnum 1]) (runText "+." ""))
    , TestCase (assertEqual "unmatched opening bracket" (Left (BrainfuckError "Unmatched '[' in Brainfuck source.")) (runText "[" ""))
    , TestCase (assertEqual "empty text encodes to empty program" "" (textToBrainfuck ""))
    , TestCase (assertEqual "generated program reproduces text" (Right "Hello, Brainfuck!") (runText (textToBrainfuck "Hello, Brainfuck!") ""))
    , TestCase (assertEqual "generated program handles byte wraparound" (Right [toEnum 255, 0, 1]) (runText (textToBrainfuck (map toEnum [255, 0, 1])) ""))
    ]

main :: IO ()
main = do
  helloWorldSource <- readFile "examples/hello.bf"
  counts <- runTestTT
    (TestList
      [ simpleTests
      , TestCase (assertEqual "hello file works" (Right "Hello World!\n") (runText helloWorldSource ""))
      ])
  if failures counts == 0 && errors counts == 0
    then pure ()
    else fail "Brainfuck tests failed"
