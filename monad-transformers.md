# Monad Transformers

Source: [A Gentle Introduction to Monad Transformers](https://two-wrongs.com/a-gentle-introduction-to-monad-transformers)


```haskell
data EitherIO e a = EitherIO {
    runEitherIO :: IO (Either e a)
}

λ> :type EitherIO
EitherIO :: IO (Either e a) -> EitherIO e a

λ> :type runEitherIO
runEitherIO :: EitherIO e a -> IO (Either e a)

instance Functor (EitherIO e) where
    fmap f ex = wrapped
        where
            unwrapped = runEitherIO ex
            fmapped   = fmap (fmap f) unwrapped
            wrapped   = EitherIO fmapped

-- My attempt
instance Applicative (EitherIO e) where
    pure :: a -> f a
    pure x = Right x

    (<*>) :: f (a -> b) -> f a -> f b
    fex <*> ex = EitherIO unwrapped
        where
            unwrapped = do $
                            value <- runEitherIO ex
                            f     <- runEitherIO fex
                            return $ f value

-- My attempt
instance Applicative m => Monad (EitherIO e) where
    return :: a -> m a
    return x = Right x

    (>>=) :: forall a b. m a -> (a -> m b) -> m b
    ex >>= fex = EitherIO unwrapped
        where
            unwrapped = do $
                            value    <- runEitherIO ex
                            newValue <- fex value
                            return newValue

```
