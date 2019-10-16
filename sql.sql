-- get all customers whose first names contain 'dan' (eg Dan, Daniel, Jordan)

SELECT customer_id, first_name, last_name 
FROM customer
WHERE first_name ILIKE '%dan%';


*** ANSWER ***

 customer_id | first_name | last_name
-------------+------------+-----------
         150 | Danielle   | Daniels
         179 | Dana       | Hart
         310 | Daniel     | Cabral
         399 | Danny      | Isom
         477 | Dan        | Paine
         560 | Jordan     | Archuleta
(6 rows)


*** ALTERNATIVE ***
SELECT customer_id, first_name, last_name 
FROM customer
WHERE LOWER(first_name) LIKE '%dan%';

-- get all customers whose last names contain 'dan' (eg Dan, Daniel, Jordan) 

SELECT customer_id, first_name, last_name 
FROM customer
WHERE last_name ILIKE '%dan%';


*** ANSWER ***

 customer_id | first_name | last_name
-------------+------------+-----------
         110 | Tiffany    | Jordan
         150 | Danielle   | Daniels
(2 rows)


*** ALTERNATIVE ***

SELECT customer_id, first_name, last_name 
FROM customer
WHERE LOWER(last_name) LIKE '%dan%';

-- now add the results of the first query to the results of the second (UNION)


WITH dan_in_first_name AS (

    SELECT customer_id, first_name, last_name 
    FROM customer
    WHERE first_name ILIKE '%dan%'
),

dan_in_last_name AS (
    SELECT customer_id, first_name, last_name 
    FROM customer
    WHERE last_name ILIKE '%dan%'
)

SELECT first_name as dan_in_name FROM dan_in_first_name
UNION
SELECT last_name FROM dan_in_last_name;


**** ANSWER ***

 dan_in_name
-------------
 Danny
 Daniels
 Daniel
 Jordan
 Dan
 Dana
 Danielle
(7 rows)

*** ALTERNATIVE ***


    SELECT customer_id, first_name, last_name 
    FROM customer
    WHERE first_name ILIKE '%dan%'

    UNION
    
    SELECT customer_id, first_name, last_name 
    FROM customer
    WHERE last_name ILIKE '%dan%';


 customer_id | first_name | last_name
-------------+------------+-----------
         110 | Tiffany    | Jordan
         399 | Danny      | Isom
         560 | Jordan     | Archuleta
         179 | Dana       | Hart
         310 | Daniel     | Cabral
         477 | Dan        | Paine
         150 | Danielle   | Daniels
(7 rows)


-- find customers exist in both queries
-- hint: there's one


WITH dan_in_first_name AS (

    SELECT customer_id, first_name, last_name 
    FROM customer
    WHERE first_name ILIKE '%dan%'
),

dan_in_last_name AS (
    SELECT customer_id, first_name, last_name 
    FROM customer
    WHERE last_name ILIKE '%dan%'
)

SELECT f.customer_id, f.first_name, f.last_name
FROM dan_in_first_name as f INNER JOIN dan_in_last_name USING (customer_id);


*** ANSWER ***

 customer_id | first_name | last_name
-------------+------------+-----------
         150 | Danielle   | Daniels
(1 row)

*** ALTERNATIVE ***

    SELECT customer_id, first_name, last_name 
    FROM customer
    WHERE first_name ILIKE '%dan%'

    INTERSECT

    SELECT customer_id, first_name, last_name 
    FROM customer
    WHERE last_name ILIKE '%dan%';

 customer_id | first_name | last_name
-------------+------------+-----------
         150 | Danielle   | Daniels
(1 row)


-- find all film with 'Fred' in the title

SELECT film_id, title
FROM film
WHERE title ILIKE '%fred%';

*** ANSWER ***

 film_id |     title
---------+----------------
     154 | Clash Freddy
     276 | Element Freddy
     334 | Freddy Storm
     801 | Sister Freddy
(4 rows)

--find all films that mention squirrels in the description

SELECT film_id, title
FROM film
WHERE description ILIKE '%squirrel%';

*** ANSWER ***
 film_id |         title
---------+-----------------------
      20 | Amelie Hellfighters
      32 | Apocalypse Flamingos
      60 | Beast Hunchback
      72 | Bill Others
     104 | Bugsy Song
     105 | Bull Shawshank
     118 | Canyon Stock
     132 | Chainsaw Uptown
     154 | Clash Freddy
     183 | Conversation Downhill
     189 | Creatures Shakespeare
     190 | Creepers Kane
     211 | Darling Breaking
     214 | Daughter Madigan
     218 | Deceiver Betrayed
     219 | Deep Crusade
     235 | Divide Monster
     243 | Doors President
     253 | Drifter Commandments
     259 | Duck Racer
     276 | Element Freddy
     283 | Ending Crowds
     295 | Expendable Stallion
     312 | Fiddler Lost
     315 | Finding Anaconda
     330 | Forrester Comancheros
     333 | Freaky Pocus
     335 | Freedom Cleopatra
     346 | Galaxy Sweethearts
     359 | Gladiator Westward
     364 | Godfather Diary
     382 | Grit Clockwork
     390 | Guys Falcon
     395 | Handicap Boondock
     406 | Haunting Pianist
     427 | Homeward Cider
     437 | House Dynamite
     467 | Intrigue Worst
     470 | Ishtar Rocketeer
     474 | Jade Bunch
     504 | Kwai Homeward
     753 | Rush Goodfellas
     526 | Lock Rear
     539 | Luck Opus
     545 | Madness Attacks
     554 | Malkovich Pet
     568 | Memento Zoolander
     578 | Million Ace
     591 | Monsoon Cause
     599 | Mother Oleander
     605 | Mulholland Beast
     620 | Nemo Campus
     629 | Notorious Reunion
     643 | Orient Closer
     656 | Papi Necklace
     658 | Paris Weekend
     663 | Patient Sister
     684 | Pizza Jumanji
     704 | Pure Runner
     721 | Reds Pocus
     733 | River Outlaw
     736 | Robbery Bright
     739 | Rocky War
     755 | Sabrina Midnight
     819 | Song Hedwig
     821 | Sorority Queen
     829 | Spinal Rocky
     834 | Spoilers Hellfighters
     903 | Traffic Hobbit
     904 | Train Bunch
     935 | Vanished Garden
     946 | Virtual Spoilers
     951 | Voyage Legally
     978 | Wisdom Worker
     981 | Wolves Desire
(75 rows)


--find the intersection of the two previous subqueries
-- hint: there's two

WITH fred_in_title AS (
    SELECT film_id, title
    FROM film
    WHERE title ILIKE '%fred%'
) , 

squirrel_in_description AS (
    SELECT film_id, title
    FROM film
    WHERE description ILIKE '%squirrel%'
)   

SELECT f.film_id, f.title
FROM fred_in_title AS f INNER JOIN squirrel_in_description USING(film_id);


*** ANSWER *** 

 film_id |     title
---------+----------------
     154 | Clash Freddy
     276 | Element Freddy
(2 rows)

*** ALTERNATIVE ***


    SELECT film_id, title
    FROM film
    WHERE title ILIKE '%fred%'
    
    INTERSECT

    SELECT film_id, title
    FROM film
    WHERE description ILIKE '%squirrel%';


