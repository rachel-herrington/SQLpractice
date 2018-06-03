drop table books;
drop table stud_classes;
drop table students;
drop table teachers;
drop table classes;

create table Students
(
    stud_id        number            primary key,
    fname          varchar2(150)     not null,
    mname          varchar2(150),
    lname          varchar2(150)     not null,
    major          varchar2(150)     not null
);
/

create table Classes
(
    crn            number            primary key,
    class_name     varchar2(80)      not null,
    room_num       number,
    start_date     date,
    end_date       date,
    start_time     varchar2(8),
    end_time       varchar2(8),
    teacher_id     number            not null
);

alter table Classes
add constraint classes_teach_id_fk foreign key (teacher_id)
references teachers(teacher_id);

/

create table stud_classes --Pivot table
(
    stud_id        number            not null,
    crn            number            not null,
    
    constraint stud_class_id_fk foreign key 
    (stud_id) references students(stud_id),
    
    constraint stud_class_crn_fk foreign key    -- constraint NAME TYPE COLUMN_NAME 
    (crn) references classes(crn)               -- references TABLE_NAME(TABLE_ID)
);
/

create table Books
(
    isbn           number            primary key,
    title          varchar2(500)     not null,
    author         varchar2(500)     not null,
    publisher      varchar2(500),
    crn            number            not null,
    constraint books_crn_fk foreign key
    (crn) references classes(crn)
);
/

create table Teachers
(
    teacher_id     number            primary key,
    fname          varchar2(150)     not null,
    lname          varchar2(150)     not null,
    salary         number(10, 2),
    department     varchar2(150),
    email          varchar2(150)     not null
);
/


-- STEPS TO CREATE --
/* 
    * Declare define relationships
    * Identify primary and foreign keys  
    * Declare a datatype [NUMBER, VARCHAR, VARCHAR2, DATE, etc]
    * Declare NOT NULL, UNIQUE, PRIMARY KEY, or FOREIGN KEY
    * Add contraints if needed
*/



-- TABLE CREATION, DELETE, DROP, ALTER, TRUNCATE, FLASHBACK, PURGE --
/*
    * DROP drops a table
    * DELETE columns/records
    * CREATE table
    * ALTER table
    * TRUNCATE gets rid of all the records in a table.  Be very careful doing this in a live/production database!
*/

-- Truncate --
truncate table books;                   -- Be very careful doing this in a live/production database!

-- Set Unused --
                                        -- Unused Columns, if you notice something is not used in production you can mark it as unused
alter table books                       -- Syntax, alter table table
set unused(publisher);                  -- Syntax, set unused(column)

-- Drop Unused --                        
alter table books                       -- To drop a column later, you can do this
drop unused columns;
                        
alter table books                       -- Dropping a column without marking it as unused first can be dangerous (in case you realize you needed it)
drop column publisher;                  -- Dropping columns that are keys for other tables wont work this way

-- Flashback --
                                        -- Flashback, rarely used and is expensive, similar to rollback but specifically recovers dropped tables
                                        -- Essentially it creates lots of frequent backups, creates astronomical data storage requirements
flashback table books to before drop;

-- Purge --
                                        -- Purge, deletes table to recycle bin; good choice if you're unsure you should drop a table
drop table books purge;                 -- Purges table to recycle bin, assigns it new name
purge table "BIN$IDMdosJceWxgg041==$0"; -- Deletes tables in recycle, tables in recycle bin are assigned weird names




-- CONSTRAINTS, LOCK, INTERACTIVE OPERATORS --
/*  
    * LOCK share mode others can change things, if exclusive mode only you can make changes.  
    * The only time to really LOCK a table is for data backups (so they can't be changed or corrupted).
    * SELECT...FOR UPDATE locks specific records that you selected from. 
*/

-- Interactive Operators --
select  title 
from    books
where   title = '&books';                 -- &receive, any field with & means you will be entering/receiving data from whoever is inputting
/* where title = :books; */             -- More or less the same as &, easier to enter multiple values at once when using select*

-- Lock table --
lock table books in share mode;         -- share mode or exclusive mode

-- Select...for update --
select  title
from    books
where   title = 'Oracle 12c: SQL'         -- Says this single record can be updated by other users
for update;

-- Constraint --
constraint stud_class_crn_fk foreign key
(crn) references classes(crn)
--constraint NAME TYPE COLUMN_NAME 
--references TABLE_NAME(TABLE_ID)




-- COMPARISON OPERATORS, WILDCARD, LIKE, BETWEEN, AND, OR --
/*    
    * Comparison Operators are < > <= >= != =
    * NUMBER, DATE can use all operators to compare
    * VARCHAR can only use != =
    * When we CREATE tables they are automatically committed but when you INSERT a table you must COMMIT it to the database using COMMIT;
    * Opposite of COMMIT is ROLLBACK but only works with INSERT and UPDATE since CREATE autmatically commits.
    * DELETE also requires an explicit COMMIT. DROP does not.
*/

insert into Teachers
    (teacher_id, fname, lname, salary, department, email)
values
    ('900154891', 'James', 'Powell', '200000', 'Business Education', 'andy.powell@wiregrass.edu');

insert into Classes
    (crn, class_name, room_num, start_date, end_date, start_time, end_time, teacher_id)
values
    ('10034', 'C++ Programming I', '7217', '09-JAN-2018', '03-MAY-2018', '1:00 PM', '4:00 PM', '900154891');

insert into Classes
    (crn, class_name, room_num, start_date, end_date, start_time, end_time, teacher_id)
values
    ('10033', 'Program Design & Development', '7217', '09-JAN-2018', '03-MAY-2018', '8:00 AM', '9:15 AM', '900154891');

insert into Books
    (isbn, title, author, publisher, crn)
values
    ('9781305251038', 'Oracle 12c: SQL', 'Joan Casteel', 'Cnegage', '10036';)

-- Commit --
commit;

insert into Classes
    (crn, class_name, room_num, start_date, end_date, start_time, end_time, teacher_id)
values
    ('10097', 'Visual Basic I', '7217', '09-JAN-2018', '03-MAY-2018', '8:00 AM', '9:15 AM', '900154891');

-- Rollback --
rollback;                                       -- Reverts to last commit

select *
from    Classes                                    -- Even though Visual Basic I has not been committed into your database it will still show in your select * however if you exit without commiting it will be lost
where   sysdate between start_date and end_date;  -- For between to work you must compare data smallest to largest (start -> end), sysdate is the date that it is run; so today

select *
from    Classes
where   class_name != "C++ Programming I";

-- Wildcards --
select *
from    Classes
where   class_name like '%Programming';           -- % means Wildcard, this statement would take Programming as the last word in a class_name, IT IS CASE SENSITIVE
                                                -- '%Programming%' will return anything with the word 'Programming' in the class_name
                                                -- 'Programming%' will return anything with the word 'Programming' as the beginning word in a class_name
                                                -- You can use any letter etc it does not have to be a word
select *
from    Classes
where   start_time like '%P%';                    -- To select afternoon classes
                                                -- '1:00%' Can be used with Date, Number, etc
-- Comparison Operators --
select *
from    Classes
where   start_date < end_date;

-- Conditional Operators AND, OR --
select *
from    Classes
where   room_num < 7218
and     room_num > 7200;                            -- Both must be true to return anything

select *
from    Classes
where   room_num < 7200
or      room_num = 7217;                             -- One must be true to return anything


-- SEQUENCING, INCREMENTING, INDEXING, COUNTING, MIN, MAX, SUM, AVG, TRIGGERS --
/*
    * Sequencing allows you to increment values sequentially
    * Indexing allows the database to look at a column and save it to be specifically searched for
    *    Ex: 
    *        You would index student 20-21, 23 (essentially indexing just saves the position for what you want to index to make searches faster)
    *        20 Student: R H L
    *        21 Student: K H L
    *        22 Teacher: P W L
    *        23 Student: M N S

*/

-- Sequence --
create sequence students_seq
increment by    1
start with      900000001
nocache
nocycle;                                -- Means it will never recycle numbers or loop back to the beginning, ensures value will be unique

select  students_seq.nextval             -- Selects next value in sequence, starts from initial value and will incrememnt each time you run this.  Useful when using INSERT to ensure a unique primary key
from    DUAL; 

select  students_seq.currval             -- Shows current value but does not increment it
from    DUAL;

insert into students
    (stud_id, fname, mname, lname, major)
values
    (students_seq.nextval, 'Travis', 'L', 'Phinney', 'Computer Science');

-- Index --
create index students_mname_idx         -- Balanced Tree Index (B-Tree)
on students (mname);

create index students_name_idk          -- Composite Index also called "Concatenated Index", combines 2 columns that are usually searched together, such as fname and lname
on students (fname, lname);

create bitmap index students_mjr_idx    -- Bitmap Index, used for a column that has low variability.  Means this column has a low number of varaibles to choose from, such as regions, states, etc.
on students (major);


-- Count --
select  count(*)                         -- Returns the number of selected column(s) that fit the criteria
from    students
where   major like "D%";

select  sum(stud_id)                     -- Returns the total of the columns VALUES, meaning it adds the column values together
from    students;

select  min(stud_id)                     -- Returns the lowest column value
from    students;

select  max(stud_id)                     -- Returns the maximum column value
from    students;

select  avg(stud_id)                     -- Returns the average of the column values
from    students;

-- Trigger --
create sequence classes_seq
increment   1
start with  10038
nocycle
nocache;

create or replace trigger classes_trig
before                                  -- Before, After, Instead of
insert                                  -- Insert, update, or delete
on classes
for each row 
when (NEW.crn is null)
select classes_seq.nextval
into :NEW.crn                           -- Input what is selected into :NEW.crn
from DUAL;
end;

insert into classes
    (class_name, room_num, start_date, end_date, start_time, end_time, teacher_id)
values
    ('C++ II', 7217, '09-JAN-2018', '03-MAY-2018', '1:00 PM', '2:00 PM', '900154891');

select *
from classes;
order by start_time asc, end_time desc; -- Orders results by 2 columns using Asc(smallest to largest) or Desc(largest to smallest)
                                        -- Prioritizes first column stated, is ASC or DESC not specified it uses ASC by default

select *
from        students
where       (fname like 'R%' or
            fname like 'T%')
and         stud_id > 90000055
order by    fname desc;                    -- descending


-- PRACTICE --
insert into teachers
    (teacher_id, fname, lname, salary, department, email)
values
    (900167454, 'Tim', 'Drexler', 100, 'Business Education', 'timothy.drexler@wiregrass.edu');

truncate table  books;
delete from     classes;
where           1=1;
commit;

insert into classes
    (crn, class_name, room_num, start_date, end_date, start_time, end_time, teacher_id)
values
    (10033, 'Structured Query Language (SQL)', 7217, '9-JAN-2018', '3-MAY-2018', '8:00 AM', '11:00 AM', 900154891);

insert into classes
    (crn, class_name, room_num, start_date, end_date, start_time, end_time, teacher_id)
values
    (10034, 'C++ Programming I', 7217, '9-JAN-2018', '3-MAY-2018', '1:00 PM', '4:00 PM', 900154891);

insert into classes
    (crn, class_name, room_num, start_date, end_date, start_time, end_time, teacher_id)
values
    (10035, 'Program Design and Development', 7217, '9-JAN-2018', '3-MAY-2018', '8:00 AM', '9:15 AM', 900154891);

insert into classes
    (crn, class_name, room_num, start_date, end_date, start_time, end_time, teacher_id)
values
    (10036, 'Java Programming II', 7217, '9-JAN-2018', '3-MAY-2018', '1:00 PM', '4:00 PM', 900154891);

insert into classes
    (crn, class_name, room_num, start_date, end_date, start_time, end_time, teacher_id)
values
    (10037, 'C# Programming', 7217, '9-JAN-2018', '3-MAY-2018', '8:00 AM', '9:15 AM', 900154891);

insert into classes
    (crn, class_name, room_num, start_date, end_date, start_time, end_time, teacher_id)
values
    (10038, 'C++ II', 7217, '9-JAN-2018', '3-MAY-2018', '1:00 PM', '2:00 PM', 900154891);

insert into classes
    (crn, class_name, room_num, start_date, end_date, start_time, end_time, teacher_id)
values
    (10039, 'Advanced Photoshop', 7218, '9-JAN-2018', '3-MAY-2018', '9:30 AM', '12:00 PM', 900167454);

insert into classes
    (crn, class_name, room_num, start_date, end_date, start_time, end_time, teacher_id)
values
    (10040, '3D Animation', 7217, '9-JAN-2018', '3-MAY-2018', '1:00 PM', '4:00 PM', 900167454);


insert into stud_classes 
(stud_id, crn)

select      stud_id,                        -- Subquery, remember when using these you can't return more than one row
(           select      crn
            from        classes 
            where       start_time = '8:00 AM'
            AND where   rownum = 1
)
from        students
where       mname 
like        'J%';


select  sc.stud_id,
(       select s.fname || ' ' || s.lname    -- Concatenating fname and lname
        from students s                     -- Alias so we can tell the difference between the tables
        where s.stud_id = sc.stud_id
)       "Stud Name",                        -- Alias

(       select class_name
        from classes c                      -- Alias so we can tell the difference between the tables
        where c.crn = sc.crn
)       "Class"                             -- Alias
from    stud_classes sc;
order by "Stud Name", "Class";              -- In order by you can order with an alias
order by 2;                                 -- Orders by 2nd column

--- PRACTICE END ---



--- SYNONYM --

create synonym students_in_class            -- A synonym for an existing table, used as a security measure because tables cannot be dropped by synonym
for stud_classes;

select *
from students_in_class;

drop table students_in_class;               -- This won't work because it is a synonym, this way hackers can't reverse engineer your code and drop tables

drop synonym students_in_class;             -- To drop a synonym (not the original table)


--- MANIPULATING VARCHARS:  UPPER, LOWER, TRIM, TRIM, PAD, CONCAT, INITCAP, REPLACE, LENGTH, INSTR, SUBSTR, TRANSLATE --

select upper(fname),                        -- Capitalizes
       lower(fname)                         -- Lowercase 
       fname,
       initcap(fname                        -- Capitalizes first letter of every word
       concat(fname, lname),                -- Appends text to first argument
       trim('Andy Powell '),                -- Tris off white spaces
       rtrim('Andy Powell '),               -- Right trim, trims farthest character to the right
       ltrim(' Andy Powell'),               -- Left trim, trims farthest character to the left
       rtrim('Andy Powell', 'a'),           -- Example of right trim
       rpad('Andy Powell', 2, ' '),         -- Right pad 2 characters to the right using character provided
       lpad ('Andy Powell', 12, ' '),       -- Pads the left BUT you must specify the length of your string + the spaces you want to add
       replace('landy powell', 'l', ''),    -- Replaces characters
       length(fname),                       -- Counts the characters
       instr(fname, 't'),                   -- Checks if char is in string, returns 0 if it's not
       substr(fname, 3),                    -- Split a string
       translate(fname, 'a', 'p') 

from   students
where  lower(fname) = 'caleb';

-- MANIPULATING NUMBERS: ROUND, TRUNC, MOD, ABS, POWER --

select round(12.1015, 2),                   -- Rounds to nearest decimal specified by the 2
       trunc(12.1015, 2),                   -- Very similar to round but it doesnt round, simply drops extra decimal places.  Useful for currency.
       mod(5, 3),                           -- Modulus, returns remainder of division, this will return 2.  Useful for determining if a value is even or odd
       abs(-25),                            -- Absolute value, useful when you always want positive numbers
       power(5,2)                           -- Raises 5 to the power of 2
from   DUAL;

-- MANIPULATING DATES: SYSDATE, --

select add_months(sysdate, 5),                          -- Adds months to date
       round(sysdate, 'MONTH'),
       round(sysdate, 'YEAR'),
       round(TO_DATE ('12-DEC-2018'), 'YEAR'),          -- Same as previous line just different syntax
       next_day(sysdate, 'TUE'),                        -- Gives you the next specified day
       sysdate + 1,                                     -- Adds 1 day to the current date, ie tomorrow.  Useful for automating emails.
       last_day(sysdate),                               -- Returns last day of the month
       TO_DATE('1-JUN-2018'),                           -- Converts CHAR to DATE, can be used to specify format, see next line
       TO_DATE('3/13/2018', 'mm/dd/yyyy'),              -- Example of format conversion for TO_DATE
       ROUND(MONTHS_BETWEEN('1-JUN-2018', sysdate)),    -- Returns how many months are between specified dates.  Always do highest date first. Note you can round or trunc this.
       (sysdate + 3) - sysdate                          -- Returns number of days between specified dates.

from DUAL;

-- GROUPING --
select      room_num
from        classes
group by    room_num;

select      count(*),                       -- Will count nulls, if you pass room_num instead, it will exclude nulls
            room_num
from        classes
group by    room_num nulls first;           -- Optional; nulls first, nulls last

select      sum(crn),                       -- Adds values together
            room_num
from        classes
group by    room_num;

select      avg(room_num)                   -- Note: There's no point in grouping by primary keys
        -- min(room_num)
        -- max(room_num)
        -- stddev(room_num)
        -- variance(room_num)
from        classes
group by    room_num;

select      count(*),
            teacher_id,
            room_num
from        classes
group by    teacher_id, room_num
having      count(*) > 2;                   -- Kind of like a 'where' clause for group by, it's not required but is useful for data validation or making your query more specific

select      teacher_id
from        classes
group by    grouping sets 
(teacher_id, room_num, (teacher_id, end_date));

select      teacher_id,
            room_num
from        classes
group by    cube (teacher_id, room_num);    -- Groups every possible combination of value for these, so just teacher_id's, just room_num, then both.  Same as above but without end_date.

select      avg(teacher_id),
            room_num
from        classes
group by    rollup (teacher_id, room_num); 

select                                      -- We're going to rewrite this subquery using joins
    (   select  fname || ' ' || lname
        from    students s2
        where   s.stud_id = s2.stud_id
    )
    (   select  class_name
        from    classes c
        where   s.crn = c.crn
    )
from        stud_classes s;

select      s.fname,                        -- Still have to use aliases
            s.lname,
            s.major
from        stud_classes sc
join        students s
on          sc.stud_id = sc.stud_id         -- Created 2 different join statements here but you don't have to use multiple, for the 'on' statement make sure to use foreign keys
join        classes c
on          sc.crn = c.crn;                 -- So we used stud_id and crn because they are foreign keys

select      class_name,
            t.fname,
            t.lname
from        classes
join        teachers t 
on          c.teacher_id = t.teacher_id
where       t.salary > 500;


select      column_name
from        table_name 
join        table_name
on          column_name = column_name;

select      class_name,
            t.name,
            t.lname
from        classes c
natural join teachers t;                    -- Column name must be identical

select      sc.stud_id,                     -- Gets stud_id from stud_classes but stud_id from students.  
            s.fname,
            s.lname
from        students s
left join   stud_classes sc                 -- Left join takes everything from students table first then will combine with stud_classes data and return only values 
on sc.stud_id = s.stud_id;                  -- where the 'on' clause is true. 
                                            -- sc.stud_id returns all rows from students table
                                            -- s.stud_id only returns rows that are true

                                            -- Inner join, returns like data from both tables instead of Left join's left -> right
                                            
-- ALL JOINS --

-- Inner join, combines two tables with a unique identifier
-- Left join, Shows all on left of join and combines two tables using a unique identifier
-- Right join, shows all on right of join and combines two tables using a unique identifier
-- Outer join, see left join, right join, and full join
-- Cartesion join, returns duplicate rows 
-- Full join, shows all on right and left of join and combines two tables with a unique identifier
-- Self join, joins the same tables together
-- Equality join, joins data in tables having equivalent data in a common column
-- Non-equality join, joins tables when there are no equivalent rows in the table to be joined
-- Natural join, joins table containing a column with the same name and definition
-- Using join, Joins table basedd off a user defined common column with the same name and definition
-- Join, combines two tables with a unique identifier

select  fname,
        lname
from    teachers
where   teacher_id = '900154891'
union                                       -- You can only use unions on fields with the same datatypes and selected in the same order
select  fname,
        lname
from    teachers
where   teacher_id = '900167454';

select  teacher_id,
        fname,
        lname
from    teachers
union                                       -- You can use static values as placeholders for data you do not want to return if you need to
select  0,
        fname,
        lname
from    teachers

select  teacher_id,
        fname,
        lname
from    teachers
union all                                   -- Will show you each occurance of the union data (like union but doesnt group them together)
select  0,
        fname,
        lname
from    teachers


-- SET OPERATORS --

-- Union, combines 2 queries, groups duplicates
-- Union All, combines 2 queries, shows all returned data from both queries
-- Minus, removes the second query's results from the output if they are also found in the first query's results
-- Intersect, lists only records returned by both queries


select  teacher_id,
        fname,
        lname
from    teachers
minus                                       -- Basically subtracts duplicates 
select  teacher_id,
        fname,
        lname
from    teachers

select  teacher_id,
        fname,
        lname
from    teachers
intersect                                   -- Opposite of minus, only returns duplicates
select  teacher_id,
        fname,
        lname
from    teachers


-- VIEWS --

-- Simple View, A view on a single table
create or replace view simple_view
    as
    select *
    from classes
    where student_pk = 5;

-- Complex View, A view with multiple tables
create or replace view complex_view
    as
    select *
    from classes
    join teachers
    on teacher_fk = teacher_pk;

-- Inline View, A sub-query in the from statement
select *
from (select student_fk,
             teacher_fk,
             class_id,
      from   classes);


-- Another example of a more complicated inline view
select avg(student_fk)
from (select sum (student_fk) student_fk,
             teacher_fk,
             class_id,
      from   classes)
      group by  teacher_fk, class_id)
      join      student 
      on        student_fk = student_pk
      where     teacher_fk = (select teacher_fk -- another sub-query
      from      teachers
      where     fname = 'Andy');












