user = LOAD '/user/rajni/users/users.txt' USING PigStorage(',') AS (UserID, Gender, Age:int, Occupation:chararray, Zip_code:int);
users_clean = FOREACH user GENERATE UserID, Zip_code;
users_clean_filter = FILTER users_clean BY Zip_code is not null;
users_group = GROUP users_clean_filter by Zip_code;
users_count = FOREACH users_group GENERATE group as Zip_code, COUNT(users_clean_filter.UserID);
users_sorted = ORDER users_count by $1 desc; -- if there is no alias, $1 is the default name given by pig
top_zipcodes = LIMIT users_sorted 10;
STORE top_zipcodes into '/user/rajni/topZip2/' USING PigStorage(',','-schema');
