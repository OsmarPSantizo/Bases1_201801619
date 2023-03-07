const oracledb = require('oracledb');

const user = "PRAC1";
const pass = "1234";
const conn = "localhost:1521/ORCL18"


async function checkConnection() {
    try {
      var connection = await oracledb.getConnection({
          user: user,
          password: pass,
          connectString: conn
      });
      console.log('connected to database');
    } catch (err) {
      console.error(err.message);
    } finally {
      if (connection) {
        try {
          // Always close connections
          await connection.close(); 
          console.log('close connection success');
        } catch (err) {
          console.error(err.message);
        }
      }
    }
  }

checkConnection();