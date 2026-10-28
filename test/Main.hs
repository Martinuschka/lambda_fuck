module Main (main) where

import Brainfuck (BrainfuckError(..), runText)
import Test.HUnit

simpleTests :: Test
simpleTests =
  TestList
    [ TestCase (assertEqual "single output byte" (Right [toEnum 1]) (runText "+." ""))
    , TestCase (assertEqual "unmatched opening bracket" (Left (BrainfuckError "Unmatched '[' in Brainfuck source.")) (runText "[" ""))
    ]

main :: IO ()
main = do
  counts <- runTestTT simpleTests
  if failures counts == 0 && errors counts == 0
    then pure ()
    else fail "Brainfuck tests failed"
