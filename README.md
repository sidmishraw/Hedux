# Hedux

Hedux is my attempt to understand state management in Haskell.

`Store` :: Is a data structure that houses a `reducer` and an initial `state`

`reducer` is a function that houses the logic for calculating a new `state` given an `action`

`dispatch` or the `->` operator can be used on the `Store` to consume an `action` and update it's `state`.

`getState` is used to extract the `state` of the `Store`.

```haskell
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
```

Output of the sample code::
```haskell
The store's state is updated by the action, but its a new Store altogether:: Just 5
The original store is still, um, Empty:: Nothing
```


`- Sid`