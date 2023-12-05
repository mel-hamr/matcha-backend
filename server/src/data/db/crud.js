const { Client } = require("pg");
const client = require("./createDB");
const matchaClient = client.matchaClient;
const matchaPool = client.matchaPool;


const createRecord = async (user, table) => {
  const data = user;
  const columns = Object.keys(data).join(", ");
  const values = Object.values(data);
  const placeholders = values.map((_, i) => `$${i + 1}`).join(", ");

  const query = `INSERT INTO ${table} (${columns}) VALUES (${placeholders}) RETURNING *`;
  let result;
  result = await matchaPool.query(query, values);
  return result.rows[0];
};


async function getAllRecords(table) {
  const query = `SELECT * FROM ${table}`;
  let result;
  result = await matchaPool.query(query);
  return result.rows[0];
}



async function getRecordById(table, id) {
  const query = `SELECT * FROM ${table} WHERE id = $1`;

  let result = await matchaPool.query(query, [id]);
  return result.rows[0];
}

async function getRecordBy(table, columnName, columnValue) {
  const query = `SELECT * FROM ${table} WHERE ${columnName} = $1`;

  let result = await matchaPool.query(query, [columnValue]);
  return result.rows[0];
}

async function getRecordBy(table, columnName, columnValue) {
  const query = `SELECT * FROM ${table} WHERE ${columnName} = $1`;

  let result = await matchaPool.query(query, [columnValue]);
  return result.rows[0];
}

// Update
const updateRecord = async (table, id, updateObject) => {
  const columns = Object.keys(updateObject);
  const values = Object.values(updateObject);
  const setClause = columns.map((col, i) => `${col} = $${i + 2}`).join(", ");

  const query = `UPDATE ${table} SET ${setClause} WHERE id = $1 RETURNING *`;
  let result = await matchaPool.query(query, [id, ...values]);
  return result.rows[0];
};

async function deleteRecord(table, id) {
  const query = `DELETE FROM ${table} WHERE id = $1 RETURNING *`;
  let result = await matchaPool.query(query, [id]);
  return result.rows[0];
}

module.exports = {
  createRecord,
  getAllRecords,
  updateRecord,
  deleteRecord,
  getRecordById,
  getRecordBy,
};
