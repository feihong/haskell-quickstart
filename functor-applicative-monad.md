# Functor, Applicative, and Monad

## Functor

```haskell
class Functor f where
    fmap :: (a -> b) -> f a -> f b
```

Examples:

```
Prelude> (+ 1) <$> Just 3
Just 4

Prelude> (+ 1) <$> Nothing
Nothing

Prelude> (* 2) <$> [1,2,3]
[2,4,6]

Prelude> fmap (* 2) [1,2,3]
[2,4,6]
```

Typeclass instance for `Maybe`:

```haskell
instance Functor Maybe where
    fmap f Nothing = Nothing
    fmap f (Just x) = Just (f x)
```

Typeclass instance for `List`:

```haskell
instance Functor [] where
    fmap f [] = []
    fmap f x:xs = f x : fmap f xs
```

## Applicative

```haskell
class Functor f => Applicative f where
    pure :: a -> f a

    (<*>) :: f (a -> b) -> f a -> f b

    liftA2 :: (a -> b -> c) -> f a -> f b -> f c
```

Examples:

```
Prelude> Just (+ 3) <*> Just 6
Just 9

Prelude> (+) <$> Just 3 <*> Just 6
Just 9

Prelude> (+) <$> Nothing <*> Just 6
Nothing

Prelude> (+) <$> Just 5 <*> Nothing
Nothing

Prelude> (*) <$> [1,2] <*> [3,4,5]
[3,4,5,6,8,10]

Prelude> [(* 1),(* 2)] <*> [3,4,5]
[3,4,5,6,8,10]

Prelude> (*) <$> [] <*> [3,4,5]
[]

Prelude> (*) <$> [1,2] <*> []
[]

Prelude> import Control.Applicative (liftA2)
Prelude Control.Applicative> liftA2 (*) [1,2] [3,4,5]
[3,4,5,6,8,10]
```

Typeclass instance for `Maybe`:

```haskell
instance Applicative Maybe where
    pure x = Just x

    Nothing <*> _ = Nothing
    _ <*> Nothing = Nothing
    Just f <*> Just x = Just (f x)
```

Typeclass instance for `List`:

```haskell
instance Applicative [] where
    pure x = [x]

    [] <*> _ = []
    _ <*> [] = []
    f:fs <*> xs = (f <$> xs) ++ (fs <*> xs)
```

## Monad

tbd

Examples:

```
Prelude> :{
Prelude| do
Prelude|   a <- Just 4
Prelude|   b <- Just 3
Prelude|   return $ a * b
Prelude| :}
Just 12
```
