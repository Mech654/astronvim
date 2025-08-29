// Test file for SQL highlighting
const query = sql`
  SELECT id, name, email
  FROM users
  WHERE active = true
  ORDER BY created_at DESC
`;

const insertQuery = query`
  INSERT INTO products (name, price)
  VALUES ($1, $2)
  RETURNING id
`;

const updateQuery = SQL`
  UPDATE users
  SET last_login = NOW()
  WHERE id = $1
`;