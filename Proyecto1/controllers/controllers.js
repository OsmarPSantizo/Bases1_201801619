const {exec} = require ('child_process');
const oracledb = require('oracledb');
const usernameorc = 'prac1'
const passwordorc = 'prac1'
const controlFile = 'C:\Users\osmarp\Desktop\Primer Semestre 2023\Repos\Bases1_201801619\Proyecto1\Temporal\carga.ctl'
const fs = require('fs');
const { autoCommit } = require('oracledb');
const user = "prac1";
const pass = "prac1";
const conn = "localhost:1521/ORCL18"
oracledb.autoCommit=true;




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
        var connection = await oracledb.getConnection({
            user: user,
            password: pass,
            connectString: conn
        });

        const result = await connection.execute(`
        SELECT DISTINCT  VV.NOMBRE_VICTIMA , VV.APELLIDO_VICTIMA,vv.DIRECCION_VICTIMA , COUNT(VT.ID_VICTIMA) AS asociados  FROM VICTIMAS_VIRUS vv 
        JOIN VICTIMA_ASOCIADO vt ON VV.ID_VICTIMA = VT.ID_VICTIMA  
        WHERE vv.FECHA_MUERTE IS NOT NULL 
        GROUP BY VT.ID_VICTIMA, VV.NOMBRE_VICTIMA, VV.APELLIDO_VICTIMA,vv.DIRECCION_VICTIMA
        having count(VT.ID_VICTIMA) > 3
    `);
        res.status(200).send({msg:"Consulta 3", resultado:result,valid:true})
    }catch(error){
        res.status(400).send({msg:"error en server"})
    }
}

exports.cons4 = async function(req,res){
    try{
        var connection = await oracledb.getConnection({
            user: user,
            password: pass,
            connectString: conn
        });

        const result = await connection.execute(`
        SELECT vv.NOMBRE_VICTIMA , vv.APELLIDO_VICTIMA  FROM VICTIMAS_VIRUS vv 
        JOIN VICTIMA_ASOCIADO va ON va.ID_VICTIMA = vv.ID_VICTIMA 
        WHERE va.ID_CONTACTO = 4 AND vv.ESTADO_VICTIMA = 'Suspendida'
    `);
        res.status(200).send({msg:"Consulta 4", resultado: result, valid:true})
    }catch(error){
        res.status(400).send({msg:"error en server"})
    }
}

exports.cons5 = async function(req,res){
    try{
        var connection = await oracledb.getConnection({
            user: user,
            password: pass,
            connectString: conn
        });

        const result = await connection.execute(`
        SELECT DISTINCT  vv.NOMBRE_VICTIMA , vv.APELLIDO_VICTIMA , COUNT(vt.ID_VICTIMA) AS tratamientos FROM VICTIMAS_VIRUS vv
        JOIN VICTIMA_TRATAMIENTO vt ON vt.ID_VICTIMA = vv.ID_VICTIMA 
        WHERE vt.ID_TRATAMIENTO = 2
        GROUP BY vt.ID_VICTIMA, vv.NOMBRE_VICTIMA , vv.APELLIDO_VICTIMA 
        ORDER BY tratamientos DESC 
        FETCH FIRST 5 ROWS ONLY
    `);
        res.status(200).send({msg:"Consulta 5", resultado:result, valid:true})
    }catch(error){
        res.status(400).send({msg:"error en server"})
    }
}

exports.cons6 = async function(req,res){
    try{
        var connection = await oracledb.getConnection({
            user: user,
            password: pass,
            connectString: conn
        });

        const result = await connection.execute(`
        SELECT vv.NOMBRE_VICTIMA, vv.APELLIDO_VICTIMA FROM VICTIMA_UBICACION vu 
        JOIN VICTIMAS_VIRUS vv ON vv.ID_VICTIMA = vu.ID_VICTIMA 
        JOIN VICTIMA_TRATAMIENTO vt ON vt.ID_VICTIMA = vv.ID_VICTIMA 
        WHERE vu.ID_UBICACION = 9 AND vt.ID_TRATAMIENTO = 4
    `);
        res.status(200).send({msg:"Consulta 6",resultado:result, valid:true})
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
        var connection = await oracledb.getConnection({
            user: user,
            password: pass,
            connectString: conn
        });

        const result = await connection.execute(`
        SELECT  h.NOMBRE, (Count(h.nombre)/(SELECT COUNT(*) FROM VICTIMA_HOSPITAL))*100 AS porcentaje FROM VICTIMAS_VIRUS vv 
        JOIN VICTIMA_HOSPITAL vh ON vv.ID_VICTIMA = vh.ID_VICTIMA 
        JOIN HOSPITAL h ON vh.ID_HOSPITAL = h.ID_HOSPITAL 
        GROUP BY h.nombre
    `);
        res.status(200).send({msg:"Consulta 9",resultado:result, valid:true})
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
        console.log("a")
        var connection = await oracledb.getConnection({
            user: user,
            password: pass,
            connectString: conn
        });
        

        await connection.execute(`
            DROP TABLE temporal`);
        await connection.close()
        var connection = await oracledb.getConnection({
            user: user,
            password: pass,
            connectString: conn
        });
        await connection.execute(`
        CREATE TABLE temporal(
            NOMBRE_VICTIMA VARCHAR2(150),
            APELLIDO_VICTIMA VARCHAR2(150),
            DIRECCION_VICTIMA VARCHAR2(150),
            FECHA_PRIMERA_SOSPECHA DATE,
            FECHA_CONFIRMACION DATE,
            FECHA_MUERTE DATE,
            ESTADO_VICTIMA VARCHAR2(100),
            NOMBRE_ASOCIADO VARCHAR2(150),
            APELLIDO_ASOCIADO VARCHAR2(150),
            FECHA_CONOCIO DATE,
            CONTACTO_FISICO  VARCHAR2(100),
            FECHA_INICIO_CONTACTO DATE,
            FECHA_FIN_CONTACTO DATE,
            NOMBRE_HOSPITAL VARCHAR2(150),
            DIRECCION_HOSPITAL VARCHAR2(150),
            UBICACION_VICTIMA VARCHAR2(150),
            FECHA_LLEGADA DATE,
            FECHA_RETIRO DATE,
            TRATAMIENTO VARCHAR(100),
            EFECTIVIDAD NUMBER,
            FECHA_INICIO_TRATAMIENTO DATE,
            FECHA_FIN_TRATAMIENTO DATE,
            EFECTIVIDAD_EN_VICTIMA NUMBER
        )`);
        
        await connection.close()
        res.status(200).send({msg:"Se eliminó correctamente los datos de la temporal", valid:true})
    }catch(error){
        res.status(400).send({msg:"error en server", err:error})
    }
}

exports.deleteMod = async function(req,res){
    try{
        var connection = await oracledb.getConnection({
            user: user,
            password: pass,
            connectString: conn
        });

        await connection.execute('DROP TABLE victima_ubicacion');
        await connection.execute('DROP TABLE victima_tratamiento');
        await connection.execute('DROP TABLE victima_hospital');
        await connection.execute('DROP TABLE victima_asociado');
        await connection.execute('DROP TABLE tratamiento');
        await connection.execute('DROP TABLE hospital');
        await connection.execute('DROP TABLE contacto');
        await connection.execute('DROP TABLE asociado');
        await connection.execute('DROP TABLE ubicacion');
        await connection.execute('DROP TABLE victimas_virus');
        await connection.close()

        res.status(200).send({msg:"Tablas eliminadas correctamente", valid:true})
    }catch(error){
        console.log("%%%%")
        console.log(error)
        console.log("%%%%")
        res.status(400).send({msg:"error en server", err:error})
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
    try{
        var connection = await oracledb.getConnection({
            user: user,
            password: pass,
            connectString: conn
        });
        
        // CREO MI TABLA VICTIMA_VIRUS
        await connection.execute(`
        CREATE TABLE victimas_virus (
            id_victima        		NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
            nombre_victima    		VARCHAR2(50) NULL,
            apellido_victima  		VARCHAR2(50) NULL,
            direccion_victima 		VARCHAR2(200) NULL,
            fecha_primera_sospecha  DATE NULL,
            fecha_confirmacion		DATE NULL,
            fecha_muerte			DATE NULL,
            estado_victima			VARCHAR2(50) NULL
        )`);
        // CREO MI TABLA TRATAMIENTO
        await connection.execute(`
        CREATE TABLE tratamiento (
            id_tratamiento            NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
            tratamiento               VARCHAR2(150) NULL,
            efectividad               INTEGER NULL
        )`);
        // CREO MI TABLA HOSPITAL
        await connection.execute(`
        CREATE TABLE hospital (
            id_hospital             NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
            NOMBRE               	VARCHAR2(150) NULL,
            direccion               VARCHAR2(150) NULL
        )`)
        // CREO MI TABLA CONTACTO
        await connection.execute(`
        CREATE TABLE contacto (
            id_contacto             NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
            TIPO 		          	VARCHAR2(150) NULL   
        )`)
        // CREO MI TABLA UBICACION
        await connection.execute(`
        CREATE TABLE ubicacion (
            id_ubicacion             NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
            DIRECCION	          	 VARCHAR2(150) NULL
        )`)
        // CREO MI TABLA ASOCIADO
        await connection.execute(`
        CREATE TABLE asociado(
            id_asociado 			NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
            nombre_asociado    		VARCHAR2(50) NULL,
            apellido_asociado  		VARCHAR2(50) NULL
        )`)
        // CREO MI TABLA VICTIMA_TRATAMIENTO
        await connection.execute(`
        CREATE TABLE victima_tratamiento(
            id_victima_tratamiento NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
            efectividad_vic		   INTEGER NULL,
            fecha_ini_trat		   DATE NULL,
            fecha_fin_trat		   DATE NULL,
            id_victima 			   NUMBER(10),
            id_tratamiento 		   NUMBER(10),
            FOREIGN KEY (id_victima) REFERENCES victimas_virus(id_victima),
            FOREIGN KEY (id_tratamiento) REFERENCES tratamiento(id_tratamiento)
        )`)
        //CREO MI TABLA VICTIMA_HOSPITAL
        await connection.execute(`
        CREATE TABLE victima_hospital(
            id_victima_hospital NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
            fecha_llegada		   DATE,
            fecha_retiro		   DATE,
            id_victima 			   NUMBER(10),
            id_hospital 		   NUMBER(10),
            FOREIGN KEY (id_victima) REFERENCES victimas_virus(id_victima),
            FOREIGN KEY (id_hospital) REFERENCES hospital(id_hospital)
        )`)
        //CREO MI TABLA VICTIMA_ASOCIADO
        await connection.execute(`
        CREATE TABLE victima_asociado(
            id_victima_asociado 	NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
            fecha_conocio		DATE,
            fecha_ini_cont 		DATE,
            fecha_fin_cont		DATE,
            id_victima    		NUMBER(10) NULL,
            id_asociado  		NUMBER(10) NULL,
            id_contacto			NUMBER(10) NULL,
            FOREIGN KEY (id_victima) REFERENCES victimas_virus(id_victima),
            FOREIGN KEY (id_asociado) REFERENCES asociado(id_asociado),
            FOREIGN KEY (id_contacto) REFERENCES contacto(id_contacto)
        )`)
        //CREO MI TABLA VICTIMA_UBICACION
        await connection.execute(`
        CREATE TABLE victima_ubicacion(
            id_victima_ubicacion 	NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
            id_victima    			NUMBER(10) NULL,
            id_ubicacion  			NUMBER(10) NULL,
            FOREIGN KEY (id_victima) REFERENCES victimas_virus(id_victima),
            FOREIGN KEY (id_ubicacion ) REFERENCES ubicacion(id_ubicacion )
        )`)
        //LLENO MI TABLA DE VICTIMAS_VIRUS
        await connection.execute(`
        INSERT INTO victimas_virus (NOMBRE_VICTIMA, APELLIDO_VICTIMA, DIRECCION_VICTIMA, FECHA_PRIMERA_SOSPECHA, FECHA_CONFIRMACION, FECHA_MUERTE, ESTADO_VICTIMA)
        SELECT DISTINCT t.NOMBRE_VICTIMA , t.APELLIDO_VICTIMA ,t.DIRECCION_VICTIMA ,t.FECHA_PRIMERA_SOSPECHA , t.FECHA_CONFIRMACION , t.FECHA_MUERTE , t.ESTADO_VICTIMA 
        FROM TEMPORAL t WHERE t.NOMBRE_VICTIMA IS NOT NULL AND t.APELLIDO_VICTIMA  IS NOT NULL`)
        //LLENO MI TABLA DE TRATAMIENTOS
        await connection.execute(`
        INSERT INTO TRATAMIENTO (TRATAMIENTO, EFECTIVIDAD)
        SELECT DISTINCT t.TRATAMIENTO , t.EFECTIVIDAD 
        FROM TEMPORAL t WHERE T.TRATAMIENTO IS NOT NULL`)
        //LLENO MI TABLA DE CONTACTOS
        await connection.execute(`
        INSERT INTO CONTACTO (CONTACTO.TIPO)
        SELECT DISTINCT T.CONTACTO_FISICO FROM TEMPORAL t 
        WHERE T.CONTACTO_FISICO IS NOT NULL`)
        //LLENO MI TABLA DE HOSPITAL
        await connection.execute(`
        INSERT INTO HOSPITAL (NOMBRE,DIRECCION)
        SELECT DISTINCT t.NOMBRE_HOSPITAL, t.DIRECCION_HOSPITAL  
        FROM TEMPORAL t WHERE t.NOMBRE_HOSPITAL IS NOT NULL`)
        //LLENO MI TABLA DE ASOCIADOS
        await connection.execute(`
        INSERT INTO ASOCIADO a (a.NOMBRE_ASOCIADO,a.APELLIDO_ASOCIADO)
        SELECT DISTINCT t.NOMBRE_ASOCIADO, t.APELLIDO_ASOCIADO FROM TEMPORAL t
        WHERE t.NOMBRE_ASOCIADO IS NOT NULL AND t.APELLIDO_ASOCIADO IS NOT NULL`)
        //LLENO MI TABLA DE UBICACION
        await connection.execute(`
        INSERT INTO UBICACION (UBICACION.DIRECCION)
        SELECT DISTINCT T.UBICACION_VICTIMA FROM TEMPORAL t  WHERE T.UBICACION_VICTIMA IS NOT NULL`)
        //LLENO MI TABLA VICTIMA_TRATAMIENTO
        await connection.execute(`
        INSERT INTO VICTIMA_TRATAMIENTO (efectividad_vic,fecha_ini_trat	,fecha_fin_trat,id_victima,id_tratamiento)
        SELECT DISTINCT T.EFECTIVIDAD_EN_VICTIMA , T.FECHA_INICIO_TRATAMIENTO, T.FECHA_FIN_TRATAMIENTO, VV.ID_VICTIMA , T2.ID_TRATAMIENTO   FROM TEMPORAL t 
        JOIN VICTIMAS_VIRUS vv ON T.NOMBRE_VICTIMA = VV.NOMBRE_VICTIMA  AND T.APELLIDO_VICTIMA = VV.APELLIDO_VICTIMA
        JOIN TRATAMIENTO t2 ON T2.TRATAMIENTO  = T.TRATAMIENTO`)
        //LLENO MI TABLA VICTIMA_HOSPITAL
        await connection.execute(`
        INSERT INTO VICTIMA_HOSPITAL (FECHA_LLEGADA, FECHA_RETIRO,ID_VICTIMA,ID_HOSPITAL)
        SELECT DISTINCT T.FECHA_LLEGADA ,T.FECHA_RETIRO, VV.ID_VICTIMA , H.ID_HOSPITAL   FROM TEMPORAL t 
        JOIN VICTIMAS_VIRUS vv ON T.NOMBRE_VICTIMA = VV.NOMBRE_VICTIMA  AND T.APELLIDO_VICTIMA = VV.APELLIDO_VICTIMA
        JOIN HOSPITAL h ON T.NOMBRE_HOSPITAL = H.NOMBRE 
        WHERE T.FECHA_LLEGADA IS NOT NULL AND T.FECHA_RETIRO IS NOT NULL`)
        //LLENO MI TABLA VICTIMA_ASOCIADO
        await connection.execute(`
        INSERT INTO VICTIMA_ASOCIADO va (va.ID_VICTIMA,va.ID_ASOCIADO, va.FECHA_CONOCIO, va.FECHA_INI_CONT, va.FECHA_FIN_CONT,va.ID_CONTACTO)
        SELECT DISTINCT VV.ID_VICTIMA , A.ID_ASOCIADO , T.FECHA_CONOCIO, T.FECHA_INICIO_CONTACTO , T.FECHA_FIN_CONTACTO, c.ID_CONTACTO   FROM TEMPORAL t 
        JOIN ASOCIADO a ON T.NOMBRE_ASOCIADO = A.NOMBRE_ASOCIADO AND T.APELLIDO_ASOCIADO = A.APELLIDO_ASOCIADO 
        JOIN VICTIMAS_VIRUS vv ON T.NOMBRE_VICTIMA = VV.NOMBRE_VICTIMA  AND T.APELLIDO_VICTIMA = VV.APELLIDO_VICTIMA
        JOIN CONTACTO c ON C.TIPO = T.CONTACTO_FISICO 
        WHERE t.FECHA_CONOCIO IS NOT NULL  AND t.FECHA_INICIO_CONTACTO  IS NOT NULL AND t.FECHA_FIN_CONTACTO IS NOT NULL`)
        //LLENO MI TABLA VICTIMA_UBICACION
        await connection.execute(`
        INSERT INTO VICTIMA_UBICACION vu (vu.ID_VICTIMA,vu.ID_UBICACION)
        SELECT DISTINCT vv.ID_VICTIMA, u.ID_UBICACION  FROM TEMPORAL t 
        JOIN VICTIMAS_VIRUS vv ON T.NOMBRE_VICTIMA = VV.NOMBRE_VICTIMA  AND T.APELLIDO_VICTIMA = VV.APELLIDO_VICTIMA
        JOIN UBICACION u ON u.DIRECCION = t.UBICACION_VICTIMA`)

        await connection.close()

        res.status(200).send({msg:"Tablas creadas y modelo correctamente", valid:true})
    }catch(error){
        console.log("%%%%")
        console.log(error)
        console.log("%%%%")
        res.status(400).send({msg:"error en server", err:error})
    }
}