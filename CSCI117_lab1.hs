-- CSci 117, Lab 1:  Introduction to Haskell
-- Nav Sanya Anand

---------------- Part 1 ----------------

-- Work through Chapters 1 - 3 of Learn You a Haskell for Great Good!
-- Type in the examples and make sure you understand the results.
-- Ask questions about anything you don't understand! This is your
-- chance to get off to a good start understanding Haskell.


---------------- Part 2 ----------------

-- The Haskell Prelude has a lot of useful built-in functions related
-- to numbers and datasets.  In Part 2 of this lab, you will catalog many
-- of these functions.

data Color = Red | Orange | Yellow | Green | Blue | Violet
     deriving (Show, Eq, Ord, Enum)

-- For each of the Prelude functions listed below, give its type,
-- describe in your own words what the function does, answer any
-- questions specified, and give several examples of its use.  If
-- the function applies at all to the "Color" type defined above,
-- make sure at least one of your examples illustrates this.

-- succ, pred

-- succ ~ Enum a => a -> a
-- Members of the Enum typeclass can be ordered in a sequence (enumerated) in datasets. 
-- The succ (successor) function returns whatever comes after the input you entered, and

-- pred ~ Enum a => a -> a
-- the pred function (predecesor) returns whatever comes before the value entered.

--   succ Red
-- Orange
--   succ Yellow
-- Green.
--   succ 47
-- 48
--   pred Violet
-- Blue
--   pred 1009
-- 1008
--   pred 'z'
-- 'y'


-- toEnum, fromEnum, enumFrom, enumFromThen, enumFromTo, enumFromThenTo $$$$$$
-- As one of your examples, try  (toEnum 3) ~ Color

-- toEnum ~ Enum a => Int -> a
-- toEnum returns the value from the index on a dataset
--   (toEnum 3) ~ Color
-- Green
--   (toEnum 0) ~ Color
-- Red
--   (toEnum 5) ~ Color
-- Violet
--   (toEnum 5) ~ Int
-- 5

-- fromEnum ~ Enum a => a -> Int
-- Returns the index of a value in a dataset.
--   fromEnum Red
-- 0
--   fromEnum Yellow
-- 2

-- enumFrom ~ Enum a => a -> [a]
-- Returns an dataset of members of an enumeration starting with the argument.
--   enumFrom Orange
-- [Orange,Yellow,Green,Blue,Violet]
--   take 10 (enumFrom 'K')
-- "KLMNOPQRST"
--   take 10 (enumFrom 0)
-- [0,1,2,3,4,5,6,7,8,9]

-- enumFromThen ~ Enum a => a -> a -> [a]
-- Enumerates a dataset beginning with first argument at the interval between the first and second
-- argument.
--   take 10 (enumFromThen 0 2)
-- [0,2,4,6,8,10,12,14,16,18]
--   enumFromThen Red Yellow
-- [Red,Yellow,Blue]

-- enumFromTo ~ Enum a => a -> a -> [a]
-- Enumerates a dataset beginning with first argument and ending with the last.
--   enumFromTo Red Blue
-- [Red,Orange,Yellow,Green,Blue]
--   enumFromTo 0 10
-- [0,1,2,3,4,5,6,7,8,9,10]
--   enumFromTo 'd' 'z'
-- "defghijklmnopqrstuvwxyz"

-- enumFromThenTo ~ Enum a => a -> a -> a -> [a]
-- returns a dataset of elements of an enumeration starting with the first argument 
-- and finishing with the third one in distances determined by the difference between the
-- first and the second.
--   enumFromThenTo 'A' 'D' 'M'
-- "ADGJM"
--   enumFromThenTo 0 5 50
-- [0,5,10,15,20,25,30,35,40,45,50]

   
-- ==, /=
{-
  (==) ~ Eq a => a -> a -> Bool
  (/=) ~ Eq a => a -> a -> Bool
  == and /= are operators that test for equality or inequality,returning a boolean value
    Green == Red
  False
    -9 /= 9
  True
    -9 == 9
  False
    'A' == 'a'
  False 
-}
 
-- quot, div            $$$$$$$$
{-
  Both quot and div take two integer arguments, dividing the first by the second.
  quot ~ Integral a => a -> a -> a
  quot performs integer division that rounds toward zero. 
  quot returns 0, if the dividend is less than the divisor.
  
  div ~ Integral a => a -> a -> a
  div is like quot, but it rounds below zero—negative infinity. 
  div rounds off the divisor to the negative infinity, if either the dividend or divisor is negative.
  div returns 0, if the dividend is less than the divisor, and both arguments are positive.
  div returns -1 if the dividend is negative, and its absolute value is less than the divisor.
  

--   div 17 5
-- 3
--   div 5 17
-- 0
--   div 17 (-5)
-- -4
--   div (-17) 5
-- -4
--   div (-17) (-5)
-- 3

--   quot 17 5
-- 3
--   quot 5 17
-- 0
--   quot 17 (-5)
-- -3
--   quot (-17) 5
-- -3
--   quot (-17) (-5)
-- 3

-}
 
-- rem, mod             $$$$$$$$$$$
{-
    :t rem
  rem ~ Integral a => a -> a -> a
  *rem returns the remainder of a division.
  *rem follows the sign of the dividend.
  *rem returns the dividend, if the dividend is less than the divisor.
    :t mod
  mod ~ Integral a => a -> a -> a
  The rem function returns the remainder after dividing the first integer by the second.
  Not sure why in one example the remainder is negative and the other is positive.
  *mod, on the other hand, performs modular arithmetic.
  *mod follows the sign of the divisor.
  *mod returns the dividend, if the dividend is less than the divisor, and both arguments are positive.
  *mod returns the difference of the absolute values of the dividend and the divisor, following the sign of the divisor, if either the dividend or the divisor is negative, and if the absolute of the dividend is less than the absolute value of the divisor.
  
    rem 20 5
  0
    rem 21 5
  1
    rem 45 (-8)
  5
    rem (-45) 8
  -5
    mod 20 5
  0
    mod 21 5
  1
    mod 45 (-8)
  -3
    mod (-45) 8
  3
-}



-- quotRem, divMod		$$$$$$$$$$
{-
  quotRem ~ Integral a => a -> a -> (a, a)
  Divides first input by the second and returns a tuple: (result of integer division, reminder)
    quotRem 25 3
  (8,1)
    quotRem (-25) 3
  (-8,-1)
    quotRem 9 3
  (3,0)
    quotRem (-9) 3
  (-3,0)


  divMod ~ Integral a => a -> a -> (a, a)
  Same as quotRem?
    divMod 25 3
  (8,1)
    divMod (-25) 3
  (-9,2)                      
    divMod 9 3
  (3,0)
    divMod (-9) 3
  (-3,0)
-}

-- &&, ||
{-
  (&&) ~ Bool -> Bool -> Bool
  (||) ~ Bool -> Bool -> Bool
  && is the boolean "and" operator, || is the "or" operator. Both take boolean inputs
  and compare them.
    True && False
  False
    True && True
  True
    False && False
  False
    False && True
  False
    False && True && False
  False
    True || False
  True
    True || True
  True
    False || False
  False
    False || True
  True
    False || True || False
  True
-}

-- ++			$$$$$$$$$$$
{-
  (++) ~ [a] -> [a] -> [a]
  Puts two datasets together; appends the dataset on the right to the end of the dataset on the left.
    [1, 2, 3] ++ [4, 5, 6]
  [1,2,3,4,5,6]
    [4, 5, 6] ++ [1, 2, 3]
  [4,5,6,1,2,3]
    "My name is " ++ "Werewolf"
  "My name is Werewolf"
-}

-- compare
{-
  compare ~ Ord a => a -> a -> Ordering 
 -- compares the first argument to the second and returns whether the first is greater than (GT),  
 -- less than (LT), or equal to (EQ)
    compare 5 10
  LT
    compare 10 5
  GT
    compare 'a' 'b'
  LT
    compare 'b' 'a'
  GT
-}

-- <, >
{-
  (<) ~ Ord a => a -> a -> Bool
  Compares two inputs; if the input on the left is less than the input on the right, it
  returns "True," otherwise returns "False."
  
  (>) ~ Ord a => a -> a -> Bool
  Compares two inputs; if the input on the left is greater than the input on the right, it
  returns "True," otherwise returns "False."

    5 < 10
  True
    10<5
  False
    'a' < 'b'
  True
    'b' < 'a'
  False
    5 > 10
  False
    10 > 5
  True
    'a' > 'b'
  False
    'b' > 'a'
  True
-}

-- max, min
{-
  max ~ Ord a => a -> a -> a
  Compares 2 input values and returns the highest value.

  min ~ Ord a => a -> a -> a
  Compares 2 input values and returns the lowest value.
    max 100 4
  100
    min 100 4
  4
    max 'a' 'b'
  'b'
    min 'a' 'b'
  'a'
    max 'A' 'a'
  'a'
    min 'A' 'a'
  'A'
    max "werewolf" "Werewolf"
  "werewolf"
    min "werewolf" "Werewolf"
  "Werewolf"
-}

-- ^
{-
  (^) ~ (Integral b, Num a) => a -> b -> a
  Exponent operator. Raises a number to a non-negative integral power.
    5^2
  25
    -5^2
  -25
    5^(-2)
  
-}

-- all, any
{-
  all ~ Foldable t => (a -> Bool) -> t a -> Bool
  (from Hoogle) Determines whether all elements of the structure satisfy the
  predicate.

  any ~ Foldable t => (a -> Bool) -> t a -> Bool
  Determines whether any element of the structure satisfies the
  predicate.
    all (<5) [6,7,8,9,10]
  False
    all (>5) [6,7,8,9,10]
  True
    any (<6) [6,7,8,9,10]
  False
    any (>9) [6,7,8,9,10]
  True
-}

-- break					$$$$$$$$$$$
{-
  break ~ (a -> Bool) -> [a] -> ([a], [a])
  (from Hoogle) break, applied to a predicate p and a dataset
  xs, returns a tuple where first element is longest prefix
  (possibly empty) of xs of elements that do not satisfy [opposite of span]
  p and second element is the remainder of the dataset.
    break (<5) [1,3,5,7,9]
  ([],[1,3,5,7,9])
    break (>0) [5,0,-5,-10]
  ([],[5,0,-5,-10])
    break (<0) [5,0,-5,-10]
  ([5,0],[-5,-10])
    break (>0) [-5,-1,0,3,7]
  ([-5,-1,0],[3,7])
-}

-- concat
{-
  concat ~ Foldable t => t [a] -> [a]
  The concatenation of all the elements of a container of datasets. Flattens a dataset of datasets into
  just one dataset; only removes one level of nesting.
    concat ["Haskell ", "is ", "hard."]
  "Haskell is hard."
    concat [[1,2,3],[4,5,6]]
  [1,2,3,4,5,6]
    concat [[[1,2,3],[4,5,6]],[[1,2,3],[4,5,6]]]
  [[1,2,3],[4,5,6],[1,2,3],[4,5,6]]
-}

-- const			$$$$$$$$$$$$$
{-
  const ~ a -> b -> a
  Takes the first input and returns that, or uses the first input to do whatever the second 
  input requires.
  (taken from Hoogle) const x is a unary function which evaluates to x for all inputs.
    const 3 5
  3
    const "this is " "bologna"
  "this is "
    map (const "unicorn") [1..5]
  ["unicorn","unicorn","unicorn","unicorn","unicorn"]
-}

-- cycle
{-
  cycle ~ [a] -> [a]
  Repeats elements in a dataset. Used in conjunction with the take function to avoid infinite loops.
    take 10 (cycle [1,2,3])
  [1,2,3,1,2,3,1,2,3,1]
    take 15 (cycle "oo")
  "oooooooooo"
-}

-- drop, take				$$$$$$$$$$$$$
{-
  drop ~ Int -> [a] -> [a]
  Takes number and a dataset. Drops the number of elements from the beginning of a dataset.
    :t take
  take ~ Int -> [a] -> [a]
  Takes a number and a dataset. It extracts that many elements from the beginning of the dataset. 
  
    drop 2 "Werewolf"
  "rewolf"
    drop 1 [2,4,5,13]
  [4,5,13]
  
    take 3 "Werewolf"
  "Wer"
    take 4 [1,2,3,4]
  [1,2,3,4]
    take 2 [1,2,3,4]
  [1,2]
-}

-- dropWhile, takeWhile			$$$$$$$$$$
{-
  takeWhile ~ (a -> Bool) -> [a] -> [a]
  Returns elements from the beginning of a dataset up until the parameter is no longer fulfilled.

  dropWhile ~ (a -> Bool) -> [a] -> [a]
  Drops the elements from the beginning of the dataset until the parameter is no longer fulfilled.

    takeWhile (<10) [0, 5,10,15,20]
  [0,5]
    dropWhile (<10) [0, 5,10,15,20]
  [10,15,20]
    takeWhile (<'s') ['m','e','l','i','s','s','a']
  "meli"
    dropWhile (<'s') ['m','e','l','i','s','s','a']
  "ssa"
    takeWhile (<5) [1,2,3,4,5,6,1,2,3]
  [1,2,3,4]
    dropWhile (<5) [1,2,3,4,5,6,1,2,3]
  [5,6,1,2,3]
    takeWhile (>5) [1,2,3,4,5,6,1,2,3]
  []
    dropWhile (>5) [1,2,3,4,5,6,1,2,3]
  [1,2,3,4,5,6,1,2,3]
    takeWhile (>5) [6,1,2,3,4,5,6,1,2,3]
  [6]
    dropWhile (>5) [6,1,2,3,4,5,6,1,2,3]
  [1,2,3,4,5,6,1,2,3]
-}

-- elem     $$$$$$$$$
{-
  elem ~ (Foldable t, Eq a) => a -> t a -> Bool
  Determines whether an input is an element of a dataset and returns a Bool(checks for equality.
  
     4 `elem` [3,4,5,6]
  True
    'a' `elem` ['M', 'e', 'l', 'i', 's', 's', 'a']
  True
    'a' `elem` ['n', 'o']
  False
-}

-- even
{-
  even ~ Integral a => a -> Bool
  Evaluates whether a whole number is even, then returns True or False.
  
    even 5
  False
    even 2
  True
    even (-2)
-}

-- filter    $$$$$$$$$$$$$$
{-
  filter ~ (a -> Bool) -> [a] -> [a]
  Takes a function that returns a boolean value and a dataset, and returns a dataset of the elements
  that are true.
  
    filter (>5) [-3, 12, 0, 1.1, 25, 100]
  [12.0,25.0,100.0]
    filter (`elem` ['A'..'Z']) "Werewolf Thomas Handsome"
  "WTH"
-}

-- fst
{-
  fst ~ (a, b) -> a
  Takes 2 input values and returns the first one in the tuple.
  
    fst ("yin", "yang")
  "yin"
    fst (43,2)
  43
-}

-- gcd=HCF               $$$$$$$$$$$$
{-
  gcd ~ Integral a => a -> a -> a
  Takes two whole numbers and returns the greatest common divisor; the highest number that 
  both arguments can be divided by evenly.
  
     gcd (-24) 8
  8
    gcd 100 47
  1
-}

-- head
{-
  head ~ [a] -> a
  Returns the first element (head) of a dataset.
  
    head [1,2,3,4,5]
  1
    head "Werewolf"
  'W'
-}

-- id			$$$$$$$$$$$$$$
{-
  id ~ a -> a
  It returns the argument unchanged.
    id 6
  6
    id (-6)
  -6
    id 'a'
  'a'
    id "boo"
  "boo"
    id False
  False
    id True
  True
    id (-2.7)
  -2.7
-}

-- init   $$$$$$$$$$$
{-
  init ~ [a] -> [a]
  Returns all but the last element in a dataset.
  
    init [1,2,3,4,5]
  [1,2,3,4]
    init "Werewolf"
  "Werewol"
-}

-- iterate			$$$$$$$$$$$$
{-
  iterate ~ (a -> a) -> a -> [a]
  Takes a function and a starting value. Applies the function to the first value, then applies
  the function to that result, and so on, generating an infinite dataset.
  
    take 5 (iterate (^2) 2)
  [2,4,16,256,65536]
    take 5 (iterate (+1) 0)
  [0,1,2,3,4]
    take 5 (iterate (*3) 1.25)
  [1.25,3.75,11.25,33.75,101.25]
-}

-- last
{-
  last ~ [a] -> a
  Returns the last element in a dataset.
  
    last [1,2,3,4,5]
  5
    last "Werewolf"
  'f'
-}

-- lcm
{-
  lcm ~ Integral a => a -> a -> a
  Takes 2 whole numbers and calculates the smallest possible whole number that can be divided 
  by both x and y.
  
    lcm 2 15
  30
    lcm 100 105
  2100
    lcm -5 -31
    lcm (-5) (-12)
  60
-}

-- length
{-
  length ~ Foldable t => t a -> Int
  Returns the number of elements in a dataset.
    length [1,2,3,4,5]
  5
    length "Werewolf"
  8
-}

-- map			$$$$$$$$$$$$$$
{-
  map ~ (a -> b) -> [a] -> [b]
  Takes a function and a dataset, applies the function to each element in the dataset and returns
  a dataset of those results.
    map (/2) [1,2,3,4]
  [0.5,1.0,1.5,2.0]
    map ('a':) [" cow", " dog", " pig"]
  ["a cow","a dog","a pig"]
-}

-- null
{-
  null ~ Foldable t => t a -> Bool
  Determines whether a dataset is empty and returns True if it is or False if it is not.
    null [1,2,3,4,5]
  False
    null "Werewolf"
  False
    null []
  True
-}

-- odd
{-
  odd ~ Integral a => a -> Bool
  Evaluates whether a whole number is odd and returns true or false.
    odd 2
  False
    odd 5
  True
    odd (-3)
  True
-}

-- repeat			$$$$$$$$$$$$$
{-
  repeat ~ a -> [a]
  Takes an element and produces a dataset of just that element.
    take 6 (repeat 1)
  [1,1,1,1,1,1]
    take 10 (repeat 'x')
  "xxxxxxxxxx"
-}

-- replicate
{-
  replicate ~ Int -> a -> [a]
  Takes an integer and an element. Produces a dataset of the element repeated the specified
  number of times.
    replicate 4 17
  [17,17,17,17]
    replicate 10 'a'
  "aaaaaaaaaa"
-}

-- reverse
{-
  reverse ~ [a] -> [a]
  Reverses the contents of a dataset.
    reverse [1,2,3]
  [3,2,1]
    reverse "Werewolf"
  "flowereW"
-}

-- snd
{-
  snd ~ (a, b) -> b
  Takes two arguments and returns the second one in the tuple.
    snd ("yin", "yang")
  "yang"
    snd (43,2)
  2
-}

-- span				$$$$$$$$$$$$
{-
  span ~ (a -> Bool) -> [a] -> ([a], [a])
  Takes a function that returns datasets. Evaluates whether each element in the dataset
  is true or false, returns two datasets: the first containing all elements up until the first 
  "false" element, and the second containing everything after that.
    span (<5) [1,3,5,7,9]
  ([1,3],[5,7,9])
    span (>0) [5,0,-5,-10]
  ([5],[0,-5,-10])
    span (>0) [-5,-1,0,3,7]
  ([],[-5,-1,0,3,7])
-}

-- splitAt			$$$$$$$$$$
{-
  splitAt ~ Int -> [a] -> ([a], [a])
  Takes an integer and a dataset, and splits the dataset into two. The first dataset contains the 
  specified number of elements, the second dataset contains everything after that.
    splitAt 8 "Werewolf Mate"
  ("Werewolf ","Mate")
    splitAt 2 [-1,0,1,2,3]
  ([-1,0],[1,2,3])
-}

-- zip			$$$$$$$$$$$$
{-
  zip ~ [a] -> [b] -> [(a, b)]
  Takes two datasets and then zips them together into one dataset by joining 
  the matching elements into tuples.
 
    zip [1,2,3,4,5] ['a','b','c','d','e']
  [(1,'a'),(2,'b'),(3,'c'),(4,'d'),(5,'e')]
    zip ["wine", "vodka", "beer"] ["glass","bottle","keg"]
  [("wine","glass"),("vodka","bottle"),("beer","keg")]
    zip [1..] ['a','b','c']
  [(1,'a'),(2,'b'),(3,'c')]
-}