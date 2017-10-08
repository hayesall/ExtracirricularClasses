users = LOAD '/user/shri/users/*' USING PigStorage(',') AS (userID, gender, age:int, occupation:chararray, zipcode:int);

users_clean = FOREACH users GENERATE userID, zipcode;

users_clean_filter = FILTER users_clean BY zipcode is not null;

--users_clean_filter = FILTER users_clean BY zipcode '75025';

users_group = GROUP users_clean_filter BY zipcode;

users_count = FOREACH users_group GENERATE group as zipcode, COUNT(users_clean_filter.userID) as total_users;

users_sorted = ORDER users_count BY total_users DESC;

top_zipcodes = LIMIT users_sorted 10;

STORE top_zipcodes INTO  '/user/shri/topZip/' USING PigStorage('|','-schema');
