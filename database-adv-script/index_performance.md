EXPLAIN SELECT * FROM User WHERE email = 'test@example.com';
```

**BEFORE Index:**
```
+----+-------------+-------+------+---------------+------+---------+------+------+-------------+
| id | select_type | table | type | possible_keys | key  | key_len | ref  | rows | Extra       |
+----+-------------+-------+------+---------------+------+---------+------+------+-------------+
|  1 | SIMPLE      | User  | ALL  | NULL          | NULL | NULL    | NULL |   15 | Using where |
+----+-------------+-------+------+---------------+------+---------+------+------+-------------+
```
- **type: ALL** = Full table scan (SLOW 🐌)
- **rows: 15** = Examines all 15 rows
- **key: NULL** = No index used

**AFTER Index:**
```
+----+-------------+-------+-------+------------------+------------------+---------+-------+------+-------+
| id | select_type | table | type  | possible_keys    | key              | key_len | ref   | rows | Extra |
+----+-------------+-------+-------+------------------+------------------+---------+-------+------+-------+
|  1 | SIMPLE      | User  | const | idx_user_email   | idx_user_email   | 1022    | const |    1 | NULL  |
+----+-------------+-------+-------+------------------+------------------+---------+-------+------+-------+