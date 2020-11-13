Possible issues related to MySQL:

* Make sure it's actually running. Try `brew services stop mysql` followed by
  `brew services start mysql`.
* Check if it's working via the terminal first: `mysql -uroot`
* If it is, and Sequel Pro is giving an error like
  `Authentication plugin 'caching_sha2_password' cannot be loaded`,
  then open up mysql in the terminal and type:
  `ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '';`
