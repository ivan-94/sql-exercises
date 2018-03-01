-- 生产者
create table manufacturers (
  code serial PRIMARY KEY, -- 等价于 DEFAULT nextval('manufacturers_code_seq'),
  name text
);