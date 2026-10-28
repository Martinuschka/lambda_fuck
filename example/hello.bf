module Main (main) where

import Brainfuck (runText)
import Test.HUnit
import System.Exit (exitFailure)

helloWorldProgram :: String
helloWorldProgram =
  "++++++++[>++++[>++>+++>+++>+<<<<-]>+>+>->>+[<]<-]>>.>---.+++++++..+++.>>.<-.<.+++.------.--------.>>+.>++."

main :: IO ()
main = do
  counts <- runTestTT tests
  if failures counts == 0
    then pure ()
    else exitFailure

tests :: Test
tests =
  TestList
    [ TestCase (assertEqual "input echo works" (Right "A") (runText ",." "A"))
    , TestCase (assertEqual "simple increment output" (Right "\SOH") (runText "+." ""))
    , TestCase (assertEqual "empty loop is a no-op" (Right "") (runText "[]" ""))
    , TestCase (assertEqual "hello world works" (Right "Hello World!") (runText helloWorldProgram ""))
    ]
