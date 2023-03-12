const oracledb = require('oracledb');
const fs = require('fs');

const user = "prac1";
const pass = "prac1";
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



async function runQuery(){
  try {
    var connection = await oracledb.getConnection({
      user: user,
      password: pass,
      connectString: conn
  });

    const result = await connection.execute(
      `SELECT COUNT(*) FROM TRATAMIENTO`
    );
    console.log(result)
  }catch(error){
    console.error(error);
  }finally {
    if(connection){
      try{
        await connection.close();
      }catch (error){
      }
    }
  }
}

