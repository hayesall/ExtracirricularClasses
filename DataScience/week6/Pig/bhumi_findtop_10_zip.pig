--PigScript to find top 10 zipcodes with max people
users = LOAD '/user/bhumi/users/*' USING PigStorage(',') AS (userID, gender,age:int ,occupation:chararray, zipcode:int);

users_clean = FOREACH users GENERATE  userID, zipcode;
users_clean_filter = FILTER users_clean BY userID is not null;
users_group = GROUP users_clean_filter BY zipcode;

users_count = FOREACH  users_group GENERATE group as zipcode, COUNT(users_clean_filter.userID);
users_sorted = order users_count BY $1 DESC;

top_zipcodes= LIMIT users_sorted 10;

STORE top_zipcodes INTO '/user/bhumi/topZip2/' USING PigStorage('|','-schema');
