module Brainfuck
  ( BrainfuckError(..)
  , interpret
  , runText
  ) where

import Data.Char (chr, ord)
import Data.Word (Word8)
import qualified Data.Map.Strict as M

newtype BrainfuckError = BrainfuckError String
  deriving (Eq, Show)

type Tape = M.Map Int Word8

data Runtime = Runtime
  { runtimePointer :: Int
  , runtimeTape    :: Tape
  , runtimeInput   :: [Word8]
  , runtimeOutput  :: [Word8]
  , runtimePc      :: Int
  , runtimeJumps   :: M.Map Int Int
  } deriving (Eq, Show)

cellAt :: Int -> Tape -> Word8
cellAt idx tape = M.findWithDefault 0 idx tape

updateCell :: Int -> (Word8 -> Word8) -> Tape -> Tape
updateCell idx f tape = M.insert idx (f (cellAt idx tape)) tape

buildJumps :: String -> Either String (M.Map Int Int)
buildJumps program = go 0 [] M.empty
  where
    go idx stack jumps
      | idx >= length program =
          if null stack
            then Right jumps
            else Left "Unmatched '[' in Brainfuck source."
      | otherwise =
          case program !! idx of
            '[' -> go (idx + 1) (idx : stack) jumps
            ']' -> case stack of
              [] -> Left "Unmatched ']' in Brainfuck source."
              (open : rest) ->
                let newJumps = M.insert open idx (M.insert idx open jumps)
                 in go (idx + 1) rest newJumps
            _ -> go (idx + 1) stack jumps

interpret :: String -> [Word8] -> Either BrainfuckError [Word8]
interpret program input =
  case buildJumps program of
    Left err -> Left (BrainfuckError err)
    Right jumps ->
      let start = Runtime
            { runtimePointer = 0
            , runtimeTape = M.empty
            , runtimeInput = input
            , runtimeOutput = []
            , runtimePc = 0
            , runtimeJumps = jumps
            }
       in go start
  where
    go runtime
      | runtimePc runtime >= length program =
          Right (runtimeOutput runtime)
      | otherwise =
          case program !! runtimePc runtime of
            '>' ->
              let next = runtime { runtimePointer = runtimePointer runtime + 1, runtimePc = runtimePc runtime + 1 }
               in go next
            '<' ->
              let next = runtime { runtimePointer = runtimePointer runtime - 1, runtimePc = runtimePc runtime + 1 }
               in go next
            '+' ->
              let idx = runtimePointer runtime
                  nextTape = updateCell idx (+ 1) (runtimeTape runtime)
                  next = runtime { runtimeTape = nextTape, runtimePc = runtimePc runtime + 1 }
               in go next
            '-' ->
              let idx = runtimePointer runtime
                  nextTape = updateCell idx (subtract 1) (runtimeTape runtime)
                  next = runtime { runtimeTape = nextTape, runtimePc = runtimePc runtime + 1 }
               in go next
            '.' ->
              let cell = cellAt (runtimePointer runtime) (runtimeTape runtime)
                  next = runtime { runtimeOutput = runtimeOutput runtime ++ [cell], runtimePc = runtimePc runtime + 1 }
               in go next
            ',' ->
              let idx = runtimePointer runtime
                  (restInput, inputValue) = case runtimeInput runtime of
                    [] -> ([], 0)
                    (x : xs) -> (xs, x)
                  nextTape = M.insert idx inputValue (runtimeTape runtime)
                  next = runtime { runtimeTape = nextTape, runtimeInput = restInput, runtimePc = runtimePc runtime + 1 }
               in go next
            '[' ->
              let current = cellAt (runtimePointer runtime) (runtimeTape runtime)
               in if current == 0
                    then case M.lookup (runtimePc runtime) (runtimeJumps runtime) of
                      Just target ->
                        let next = runtime { runtimePc = target + 1 }
                         in go next
                      Nothing -> Left (BrainfuckError "Missing matching ']' for '['.")
                    else go (runtime { runtimePc = runtimePc runtime + 1 })
            ']' ->
              let current = cellAt (runtimePointer runtime) (runtimeTape runtime)
               in if current /= 0
                    then case M.lookup (runtimePc runtime) (runtimeJumps runtime) of
                      Just target ->
                        let next = runtime { runtimePc = target }
                         in go next
                      Nothing -> Left (BrainfuckError "Missing matching '[' for ']'.")
                    else go (runtime { runtimePc = runtimePc runtime + 1 })
            '#' ->
              let next = runtime { runtimePc = runtimePc runtime + 1 }
               in go next
            _ ->
              let next = runtime { runtimePc = runtimePc runtime + 1 }
               in go next

runText :: String -> String -> Either BrainfuckError String
runText program input =
  interpret program (map (fromIntegral . ord) input)
    >>= \output -> Right (map (chr . fromIntegral) output)
