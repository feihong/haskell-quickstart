import Data.Char (chr)
import Control.Monad (forM)
import System.Random (randomRIO)
import Data.List (intercalate)

randomHanzi :: Int -> IO [Char]
randomHanzi n =
  forM [1..n] $ \_ -> chr <$> randomRIO (0x4e00, 0x9fff)

main :: IO ()
main = do
  chars <- randomHanzi 8
  let strings = map (\c -> [c]) chars
  putStrLn $ intercalate ", " strings
