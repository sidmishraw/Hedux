--
-- Main.hs
-- @author Sidharth Mishra
-- @description Main driver of the program, used for testing and stuff
-- @created Thu Oct 12 2017 19:44:22 GMT-0700 (PDT)
-- @last-modified Fri Oct 13 2017 00:57:31 GMT-0700 (PDT)
--

import System.Environment (getArgs)
-- import qualified Data.Map as Map
import Hedux

samplereducer :: Maybe Int -> Bool -> Maybe Int
-- this is going to be a sample reducer for a counter example
-- to demonstrate the ability of Hedux in managing state
samplereducer p a = case p of 
    Nothing -> return 1
    (Just x) -> return $ if a then x + 1 else x - 1

-- store the store
-- and it is a store with an empty state
store :: Store Int Bool
store = createStore samplereducer Nothing

increment5TimesAction :: Store Int Bool
-- uses the dispatch operator to increment the store by 5 times
increment5TimesAction = store --> True --> True --> True --> True --> True

main :: IO()
-- printing stuff
main = do 
  putStrLn $ "The store's state is updated by the action, but its a new Store altogether:: " ++ (show.getState) increment5TimesAction
  putStrLn $ "The original store is still, um, Empty:: " ++ (show.getState) store