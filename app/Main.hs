module Main where

import Brainfuck (BrainfuckError(..), runText)
import System.Environment (getArgs)
import System.Exit (exitFailure)
import System.IO (hPutStrLn, stderr)

usage :: String
usage = unlines
  [ "Usage:"
  , "  bf run <file> [input]"
  , "  bf eval <program> [input]"
  , "  bf --help"
  ]

runFile :: FilePath -> String -> IO ()
runFile path input = do
  source <- readFile path
  case runText source input of
    Left (BrainfuckError err) -> do
      hPutStrLn stderr err
      exitFailure
    Right output -> putStr output

runProgram :: String -> String -> IO ()
runProgram source input =
  case runText source input of
    Left (BrainfuckError err) -> do
      hPutStrLn stderr err
      exitFailure
    Right output -> putStr output

main :: IO ()
main = do
  args <- getArgs
  case args of
    ["--help"] -> putStrLn usage
    ["run", file] -> runFile file ""
    ["run", file, input] -> runFile file input
    ["eval", source] -> runProgram source ""
    ["eval", source, input] -> runProgram source input
    [] -> do
      putStrLn usage
      exitFailure
    _ -> do
      putStrLn usage
      exitFailure
