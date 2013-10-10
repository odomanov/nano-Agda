module Common where

import Terms
import Names
import Control.Monad.Error

 -- General error

type Err = ErrorT String IO

 -- Typing error

data TypeInfo
    = Unification Ident Ident String
    | CheckT Term Type
    | CheckI Ident Type
    | IncompBindings Ident Term Term
    | UnknownError String

instance Error TypeInfo where
    strMsg s = UnknownError s

type TypeError = Either TypeInfo

throw :: TypeInfo -> TypeError a
throw = throwError

catch :: TypeError a -> (TypeInfo -> TypeError a) -> TypeError a
catch = catchError

convert :: TypeError a -> Err a
convert = undefined