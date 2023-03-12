const {exec} = require ('child_process');
const oracledb = require('oracledb');
const usernameorc = 'prac1'
const passwordorc = 'prac1'
const controlFile = 'C:\Users\osmarp\Desktop\Primer Semestre 2023\Repos\Bases1_201801619\Proyecto1\Temporal\carga.ctl'
const fs = require('fs');
const user = "prac1";
const pass = "prac1";
const conn = "localhost:1521/ORCL18"




exports.cons1 = async function(req,res){
    try{
        var connection = await oracledb.getConnection({
            user: user,
            password: pass,
            connectString: conn
        });

        const result = await connection.execute(`
      SELECT h.NOMBRE, h.DIRECCION, Count(h.nombre) AS muertes
      FROM VICTIMAS_VIRUS vv 
      JOIN VICTIMA_HOSPITAL vh ON vh.ID_VICTIMA = vv.ID_VICTIMA 
      JOIN HOSPITAL h ON vh.ID_HOSPITAL = h.ID_HOSPITAL 
      WHERE VV.FECHA_MUERTE IS NOT NULL
      GROUP BY h.NOMBRE, h.DIRECCION
    `);

        await connection.close()
        res.status(200).send({msg:"Consulta 1", resultado:result,valid:true})
    }catch(error){
        console.log(error)
        res.status(400).send({msg:"error en server"})
    }
}


exports.cons2 = async function(req,res){
    try{
        var connection = await oracledb.getConnection({
            user: user,
            password: pass,
            connectString: conn
        });

        const result = await connection.execute(`
        SELECT VV.NOMBRE_VICTIMA , VV.APELLIDO_VICTIMA  FROM VICTIMAS_VIRUS vv 
        JOIN VICTIMA_TRATAMIENTO vt ON VV.ID_VICTIMA = VT.ID_VICTIMA 
        JOIN TRATAMIENTO t ON T.ID_TRATAMIENTO = VT.ID_TRATAMIENTO
        WHERE VT.EFECTIVIDAD_VIC > 5 AND VT.ID_TRATAMIENTO = 1
    `);

        await connection.close()
        res.status(200).send({msg:"Consulta 2", resultado:result,valid:true})
    }catch(error){
        res.status(400).send({msg:"error en server"})
    }
}

exports.cons3 = async function(req,res){
    try{
        res.status(200).send({msg:"Consulta 3", valid:true})
    }catch(error){
        res.status(400).send({msg:"error en server"})
    }
}

exports.cons4 = async function(req,res){
    try{
        res.status(200).send({msg:"Consulta 4", valid:true})
    }catch(error){
        res.status(400).send({msg:"error en server"})
    }
}

exports.cons5 = async function(req,res){
    try{
        res.status(200).send({msg:"Consulta 5", valid:true})
    }catch(error){
        res.status(400).send({msg:"error en server"})
    }
}

exports.cons6 = async function(req,res){
    try{
        res.status(200).send({msg:"Consulta 6", valid:true})
    }catch(error){
        res.status(400).send({msg:"error en server"})
    }
}

exports.cons7 = async function(req,res){
    try{
        res.status(200).send({msg:"Consulta 7", valid:true})
    }catch(error){
        res.status(400).send({msg:"error en server"})
    }
}
exports.cons8 = async function(req,res){
    try{
        res.status(200).send({msg:"Consulta 8", valid:true})
    }catch(error){
        res.status(400).send({msg:"error en server"})
    }
}
exports.cons9 = async function(req,res){
    try{
        res.status(200).send({msg:"Consulta 9", valid:true})
    }catch(error){
        res.status(400).send({msg:"error en server"})
    }
}
exports.cons10 = async function(req,res){
    try{
        res.status(200).send({msg:"Consulta 10", valid:true})
    }catch(error){
        res.status(400).send({msg:"error en server"})
    }
}

exports.deleteTemp = async function(req,res){
    try{
        res.status(200).send({msg:"eliminarTemporal", valid:true})
    }catch(error){
        res.status(400).send({msg:"error en server"})
    }
}

exports.deleteMod = async function(req,res){
    try{
        res.status(200).send({msg:"eliminarModelo", valid:true})
    }catch(error){
        res.status(400).send({msg:"error en server"})
    }
}

exports.chargeTemp = async function(req,res){
    try{
        const sqlldrCommand = 'sqlldr userid=prac1/prac1@localhost:1521/ORCL18 control=./Temporal/carga.ctl'

        exec (sqlldrCommand,(error,stdout,stderr)=>{
            if(error){
                console.error(`Error al ejectuar el comando sqlldr: ${error.message}`);
                return;
            }
            if(stderr){
                console.error(`Error al ejecutar el comando sqlldr: ${stderr}`);
                return;
            }
            console.log(`El comando sqlldr se ha ejecutado correctamente: ${stdout}`)
        })
        res.status(200).send({msg:"Se cargaron correctamente los datos a la tabla temporal", valid:true})
    }catch(error){
        res.status(400).send({msg:"Ocurrió un error", err:error})
    }
}

exports.chargeModel = async function(req,res){
    try {
        var connection = await oracledb.getConnection({
          user: user,
          password: pass,
          connectString: conn
      });

      const sql = fs.readFileSync('./archivos_sql/archivo_sql_datos.sql' , 'utf-8');
      
      const statements = sql.split(';')
      console.log(statements)
      connection.executeMany(statements,{},(err,result)=>{
        if(err){
            console.error(err.message);
        }else{
            console.log('Ejecución exitosa de todas las sentencias');
        }
      })
      await connection.close();
      console.log('El archivo SQL se ha ejecutado correctamente');

      }catch(error){
        console.error(error);
      }
}