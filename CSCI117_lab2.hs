-- CSci 117, Lab 2:  Functional techniques, iterators/accumulators,
-- and higher-order functions
--NAV SANYA ANAND--

---- Part 1: Basic structural recursion ----------------

-- 1. Merge sort

-- Deal a list into two (almost) equal-sizes lists by alternating elements
-- For example, deal [1,2,3,4,5,6,7] = ([1,3,5,7], [2,4,6])
deal :: [a] -> ([a],[a])
deal [] = ([],[])
deal [x] = ([x],[])
deal (x:y:xys) = (x:xs, y:ys)
          where (xs,ys)=deal xys
{-deal :: [a]->([a],[a]) $$not used because it takes too much time you have to go through the list 2x once for checking the length and the other for dividing it
  deal xs = (take n xs, drop n xs)
		where n=(length xs) `div` 2
-}

-- Now implement merge and mergesort (ms), and test with some
-- scrambled lists to gain confidence that your code is correct

merge :: Ord a => [a] -> [a] -> [a]
merge xs []= xs
merge [] ys =ys
merge (x:xs) (y:ys) = if x<y
			       then x : (merge xs (y:ys))
			       else y : (merge ys(x:xs))

ms :: Ord a => [a] -> [a]
ms [] = []
ms [x] = [x]
ms xs= merge (ms n) (ms m) 
	where (n,m)=deal xs

-- *Main> ms [12,1,34,234,9,20,27,22,1,76,56,66,45]
-- [1,1,9,12,20,22,27,34,45,56,66,76,234]
-- *Main> ms ['a','A', 'b', 'B', 'x','g','t','q','V','Y','O']
-- "ABOVYabgqtx"
-- *Main> ms ["Sanya","Nav", "Anand","Werewolf","Mate"]
-- ["Anand","Mate","Nav","Sanya","Werewolf"]
-- *Main> ms "Chocolate Chip Cookies"
-- "  CCCaceehhiikloooopst"




-- 2. A backward list data structure 

-- Back Lists: Lists where elements are added to the back ("snoc" == rev "cons")
-- For example, the list [1,2,3] is represented as Snoc (Snoc (Snoc Nil 1) 2) 3
data BList a = Nil | Snoc (BList a) a deriving Show

-- Add an element to the beginning of a BList, like (:) does
cons :: a -> BList a -> BList a
cons x Nil = Snoc Nil x
cons v1 (Snoc box v2) = Snoc (cons v1 box) v2 

-- Convert a usual list into a BList (hint: use cons)
toBList :: [a] -> BList a
toBList [] = Nil
toBList (b:box) = cons b (toBList box)  -- b=head box=rest of the list

-- Add an element to the end of a usual list
snoc :: [a] -> a -> [a]
snoc [] n = [n]
snoc (b:box) c = b: snoc box c

-- Convert a BList into a usual list (hint: use snoc)
fromBList :: BList a -> [a]
fromBList Nil = []
fromBList (Snoc box b) = snoc (fromBList box) b


-- 3. A binary tree data structure
data Tree a = Empty | Node a (Tree a) (Tree a) deriving Show --root left child right child

-- Count number of Empty's in the tree
num_empties :: Tree a -> Int
num_empties Empty = 1
num_empties (Node bt l r) = (num_empties l) + (num_empties r)

-- Count number of Node's in the tree
num_nodes :: Tree a -> Int
num_nodes Empty = 0
num_nodes (Node bt l r) = (num_nodes l) + (num_nodes r) + 1 
--num_nodes (Node _ st1 st2)=1+num_nodes(st1)+num_nodes(st2)  --root + nodes in left sub tree + nodes in right sub tree

-- Insert a new node in the leftmost spot in the tree
insert_left :: a -> Tree a -> Tree a
insert_left nn Empty = (Node nn Empty Empty)
insert_left nn (Node bt l r) = Node bt (insert_left nn l) r

-- Insert a new node in the rightmost spot in the tree
insert_right :: a -> Tree a -> Tree a
insert_right nn Empty = Node nn Empty Empty
insert_right nn (Node bt l r) = Node bt l (insert_left nn r)

-- Add up all the node values in a tree of numbers
sum_nodes :: Num a => Tree a -> a
sum_nodes Empty = 0
sum_nodes (Node bt l r) = (sum_nodes l) + (sum_nodes r) + bt

-- Produce a list of the node values in the tree via an inorder traversal
-- Feel free to use concatenation (++)
inorder :: Tree a -> [a]
inorder Empty = []
inorder (Node bt l r) = inorder l ++ [bt] ++ inorder r

-- 4. A different tree data structure
data Tree2 a = Leaf a | Node2 a (Tree2 a) (Tree2 a) deriving Show

-- Count the number of elements in the tree (leaf or node)
num_elts :: Tree2 a -> Int
num_elts (Leaf x) = 1
num_elts (Node2 bt l r) = (num_elts l) + (num_elts r) + 1 

-- Add up all the elements in a tree of numbers
sum_nodes2 :: Num a => Tree2 a -> a
sum_nodes2 (Leaf x) = x
sum_nodes2 (Node2 bt l r) = (sum_nodes2 l) + (sum_nodes2 r) + bt

-- Produce a list of the elements in the tree via an inorder traversal
-- Again, feel free to use concatenation (++)
inorder2 :: Tree2 a -> [a]
inorder2 (Leaf x) = [x]
inorder2 (Node2 bt l r) = inorder2 l ++ [bt] ++ inorder2 r

-- Convert a Tree2 into an equivalent Tree1 (with the same elements)
conv21 :: Tree2 a -> Tree a
conv21 (Leaf x) = (Node x Empty Empty) 
conv21 (Node2 bt l r) = Node bt (conv21 l)  (conv21 r) 



---- Part 2: Iteration and Accumulators ----------------


-- Both toBList and fromBList from Part 1 Problem 2 are O(n^2) operations.
-- Reimplement them using iterative helper functions (locally defined using
-- a 'where' clause) with accumulators to make them O(n)
-- toBList' box = toBList_it box Nil where
                  -- toBList_it :: [a] -> BList a -> BList a --inputs list and iterator output is Blist
		-- toBList_it [] a = a
                  -- toBList_it (b:boxs) i = toBList_it boxs (Snoc i b) -- b=head box=rest of the list
toBList' :: [a] -> BList a
toBList' b = toBList_it b Nil where
    toBList_it :: [a] -> BList a -> BList a
    toBList_it [] a = a
    toBList_it (x:xs) a = toBList_it xs (Snoc a x)

				  
fromBList' :: Num a => BList a -> [a]
fromBList' bl = fromBList_it bl 0 where
                  fromBList_it :: BList a -> a -> [a] --Inputs are a Blist and iterator output is a list
                  fromBList_it Nil i = [i]
                  fromBList_it (Snoc bls b) i = snoc (fromBList_it bls i) b

-- Even tree functions that do multiple recursive calls can be rewritten
-- iteratively using lists of trees and an accumulator. For example,
sum_nodes' :: Num a => Tree a -> a
sum_nodes' t = sum_nodes_it [t] 0 where
  sum_nodes_it :: Num a => [Tree a] -> a -> a
  sum_nodes_it [] a = a
  sum_nodes_it (Empty:ts) a = sum_nodes_it ts a
  sum_nodes_it (Node n t1 t2:ts) a = sum_nodes_it (t1:t2:ts) (n+a)

-- Use the same technique to convert num_empties, num_nodes, and sum_nodes2
-- into iterative functions with accumulators

num_empties' :: Tree a -> Int
num_empties' t = num_empties_it [t] 0 where
	num_empties_it :: [Tree a] -> Int -> Int
	num_empties_it [] x = x
	num_empties_it (Empty:rs) x = num_empties_it rs (x+1)
	num_empties_it (Node bt l r:rs) x = num_empties_it (l:r:rs) x 
		 
num_nodes' :: Tree a -> Int
num_nodes' box = num_nodes_it [box] 0 where
    num_nodes_it :: [Tree a] -> Int -> Int
    num_nodes_it [] a = a
    num_nodes_it (Empty:ts) a = num_nodes_it ts (a)
    num_nodes_it (Node bt l r:rs) a = num_nodes_it (l:r:rs) (a+1)

sum_nodes2' :: Num a => Tree2 a -> a
sum_nodes2' t = sum_nodes2_it [t] 0 where
                sum_nodes2_it :: Num a => [Tree2 a] -> a -> a
                sum_nodes2_it [] x = x
                sum_nodes2_it ((Leaf a):ts) x = sum_nodes2_it ts (a+x)
                sum_nodes2_it (Node2 n t1 t2:ts) x = sum_nodes2_it (t1:t2:ts) (n+x)

-- Use the technique once more to rewrite inorder2 so it avoids doing any
-- concatenations, using only (:).
-- Hint 1: (:) produces lists from back to front, so you should do the same.
-- Hint 2: You may need to get creative with your lists of trees to get the
-- right output.

inorder2' :: Tree2 a -> [a]
inorder2' = undefined



---- Part 3: Higher-order functions ----------------

-- The functions map, all, any, filter, dropWhile, takeWhile, and break
-- from the Prelude are all higher-order functions. Reimplement them here
-- as list recursions. break should process each element of the list at
-- most once. All functions should produce the same output as the originals.

my_map :: (a -> b) -> [a] -> [b]  --map function = apply the function on the whole list
my_map _ [] = []
my_map f (b:box) = f b : my_map f box

my_all :: (a -> Bool) -> [a] -> Bool --for all x
my_all _ [] = True
my_all f (b:box) = if f b
			  then my_all f box
			  else False
				
my_any :: (a -> Bool) -> [a] -> Bool  ---there exists an x
my_any _ [] = False
my_any f (b:box) = if f b
			    then True
			    else my_any f box

my_filter :: (a -> Bool) -> [a] -> [a] --all the values that make the condition true
my_filter _ [] = [] 
my_filter f (b:box)  	| f b = b : my_filter f box
				| otherwise = filter f box

my_dropWhile :: (a -> Bool) -> [a] -> [a] --drops the values of the list till the condition is true and once it turns false (print the list that is left)
my_dropWhile _ [] = []
my_dropWhile f (b:box) 	| f b = my_dropWhile f box
					| otherwise = (b:box)

my_takeWhile :: (a -> Bool) -> [a] -> [a] --takes the values while the condition is true
my_takeWhile _ [] = []
my_takeWhile f (b:box) 	| f b = b : my_takeWhile f box --true then in the list
					|otherwise = [] --if false return empty list

my_break :: (a -> Bool) -> [a] -> ([a], [a])
my_break _ [] = ([], [])
my_break f boxs@(b:box)  | f b = ([],boxs) 
                        | otherwise =   let (ys, zs) = my_break f box
                                        in (b:ys, zs)

						
-- Implement the Prelude functions and, or, concat using foldr

my_and :: [Bool] -> Bool
my_and [] = True
my_and box = foldr (&&)  True box

my_or :: [Bool] -> Bool
my_or [] = False
my_or box = foldr (||) False box

my_concat :: [[a]] -> [a] 
my_concat [[]] = [] 
my_concat (b:box) = foldr (++) b box
 

-- Implement the Prelude functions sum, product, reverse using foldl

my_sum :: Num a => [a] -> a
my_sum box = foldl (+) 0 box

my_product :: Num a => [a] -> a
my_product box = foldl (*) 1 box

my_reverse :: [a] -> [a]
my_reverse xs = foldl (\acc x-> x : acc) [] xs 



---- Part 4: Extra Credit ----------------

-- Convert a Tree into an equivalent Tree2, IF POSSIBLE. That is, given t1,
-- return t2 such that conv21 t2 = t1, if it exists. (In math, this is called
-- the "inverse image" of the function conv21.)  Thus, if conv21 t2 = t1, then
-- it should be that conv 12 t1 = Just t2. If there does not exist such a t2,
-- then conv12 t1 = Nothing. Do some examples on paper first so you can get a
-- sense of when this conversion is possible.
conv12 :: Tree a -> Maybe (Tree2 a)
conv12 = undefined


-- Binary Search Trees. Determine, by making only ONE PASS through a tree,
-- whether or not it's a Binary Search Tree, which means that for every
-- Node a t1 t2 in the tree, every element in t1 is strictly less than a and
-- every element in t2 is strictly greater than a. Complete this for both
-- Tree a and Tree2 a.

-- Hint: use a helper function that keeps track of the range of allowable
-- element values as you descend through the tree. For this, use the following
-- extended integers, which add negative and positvie infintiies to Int:

data ExtInt = NegInf | Fin Int | PosInf deriving Eq

instance Show ExtInt where
  show NegInf     = "-oo"
  show (Fin n) = show n
  show PosInf     = "+oo"

instance Ord ExtInt where
  compare NegInf  NegInf  = EQ
  compare NegInf  n       = LT
  compare (Fin n) (Fin m) = compare n m
  compare (Fin n) PosInf  = LT
  compare PosInf  PosInf  = EQ
  compare _       _       = GT
  -- Note: defining compare automatically defines <, <=, >, >=, ==, /=
  
bst :: Tree Int -> Bool
bst = undefined
    
bst2 :: Tree2 Int -> Bool
bst2 = undefined

