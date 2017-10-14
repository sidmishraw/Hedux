{-# LANGUAGE MultiParamTypeClasses #-}
-- hedux.hs
-- @author Sidharth Mishra
-- @description Hedux implementation. 
-- @created Thu Oct 12 2017 19:47:53 GMT-0700 (PDT)
-- @last-modified Thu Oct 12 2017 19:47:53 GMT-0700 (PDT)

module Hedux (
  Store(..),
  createStore,
  getState,
  dispatch,
  (-->)
) where
  
-- The model for Redux like Store in Haskell and hence the package is called Hedux
-- Get it? `Hedux` xD
data Store s a = EmptyStore (Maybe s -> a -> Maybe s)
              | StoreWithInitialState (Maybe s -> a -> Maybe s) (Maybe s)

createStore :: (Maybe s -> a -> Maybe s) -> Maybe s -> Store s a
-- creates a brand new store given a reducer and initial state of the store
createStore reducer initialState = case initialState of
    Nothing -> EmptyStore reducer
    state -> StoreWithInitialState reducer state
  
getState :: Store s a -> Maybe s
-- given the Store, returns the current state of the Store
getState store = case store of
  (EmptyStore _) -> Nothing
  (StoreWithInitialState _ state) -> state

dispatch :: Store s a -> a -> Store s a
-- The dispatch consumes an incoming action and updates the Store's state
-- acts as the action dispatcher
dispatch currentStore action = case currentStore of
  (EmptyStore reducer) -> StoreWithInitialState reducer (reducer Nothing action)
  (StoreWithInitialState reducer currentState) -> StoreWithInitialState reducer (reducer currentState action)

(-->) :: Store s a -> a -> Store s a
-- Some syntatic sugar for dispatching actions
store --> a = dispatch store a