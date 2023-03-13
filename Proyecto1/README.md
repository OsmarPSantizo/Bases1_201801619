**<h1 align="center"> PROYECTO 1. </h1>**
### Datos Estudiante
| Nombre | Carné |
| ------ | ------ |
| Osmar Abdel Peña Santizo  | 201801619 |
----
El proyecto consiste en aprender a realizar cargas masivas desde un archivo de excel, convertir la información para insertarla en la base de datos y posteriormente utilizar la misma API para realizar consultas óptimas y obtener reportería sobre los datos almacenados
----

**<h4 align="center">LOGICA (API)</h4>**
Se creo una tabla llamada **TEMPORAL** en la base de datos la cual almacena los datos que provee el archivo de excel.
Para hacer esa carga masiva de datos se utilizó un archivo de control **.ctl** y la herramienta que provee oracle llamada **sqlldr**:

- Explicación del archivo **.ctl**
    ```
    OPTIONS (SKIP=1)                           # Saltamos la primera linea (los encabezados)
        LOAD DATA
        CHARACTERSET UTF8                      # Indicamos la codificacion del archivo
        INFILE './Temporal/DB_Excel.csv'       # Indicamos la ruta del archivo a leer
        INTO TABLE TEMPORAL TRUNCATE           # Borramos los datos si es que tuviera la tabla
        FIELDS TERMINATED BY ';'               # Indicamos como terminarán los datos
        TRAILING NULLCOLS(                     # Seguidamente indicamos los nombres de todos los encabezados
            NOMBRE_VICTIMA,
            APELLIDO_VICTIMA,
            DIRECCION_VICTIMA,
            FECHA_PRIMERA_SOSPECHA DATE 'DD-MM-YYYY HH24:MI',
            FECHA_CONFIRMACION DATE 'DD-MM-YYYY HH24:MI',
            FECHA_MUERTE DATE 'DD-MM-YYYY HH24:MI',
            ESTADO_VICTIMA,
            NOMBRE_ASOCIADO,
            APELLIDO_ASOCIADO,
            FECHA_CONOCIO DATE 'DD-MM-YYYY HH24:MI',
            CONTACTO_FISICO,
            FECHA_INICIO_CONTACTO DATE 'DD-MM-YYYY HH24:MI',
            FECHA_FIN_CONTACTO DATE 'DD-MM-YYYY HH24:MI',
            NOMBRE_HOSPITAL,
            DIRECCION_HOSPITAL,
            UBICACION_VICTIMA,
            FECHA_LLEGADA DATE 'DD-MM-YYYY HH24:MI',
            FECHA_RETIRO DATE 'DD-MM-YYYY HH24:MI',
            TRATAMIENTO,
            EFECTIVIDAD INTEGER EXTERNAL,
            FECHA_INICIO_TRATAMIENTO DATE 'DD-MM-YYYY HH24:MI',
            FECHA_FIN_TRATAMIENTO DATE 'DD-MM-YYYY HH24:MI',
            EFECTIVIDAD_EN_VICTIMA INTEGER EXTERNAL
        )
    ```
- El comando sqlldr se utiliza de la siguiente forma
    ```
    sqlldr userid=prac1/prac1@localhost:1521/ORCL18 control=./Temporal/carga.ctl

    ```
    1. Como primer parámetro **userid** se coloca nuestra conexión a la base de datos
    2. Como segundo parámetro **carga** se coloca la ruta de nuestro archivo **.ctl** creado anteriormente
    
**<h4 align="center">BACKEND (API)</h4>**

Para el backend se utilizó **nodejs** con la librería **express**. Se crearon dos carpetas una llamada **controllers** en la cual están los controladores de todos los endpoints y otra llamada **routes** en la cual se encuentran listadas las urls con sus respectivos controladores.

Para la conexión a la base de datos se utilizo la librería **oracledb**
```
const oracledb = require('oracledb');
const user = "prac1";
const pass = "prac1";
const conn = "localhost:1521/ORCL18"
var connection = await oracledb.getConnection({
    user: user,
    password: pass,
    connectString: conn
});

```

**<h4 align="center">BASE DE DATOS ORACLE</h4>**
La base de datos se hizo en un contenedor de docker utilizando la imagen de **oracle 18c**
Los comandos que se utilizaron para crear la imagen y el usuario son los siguientes:
Descargo la imagen de Oracle:
```
    docker pull dockerhelp/docker/docker-oracle-ee-18c
```
Inicio la imagen de Oracle, le asigno el puerto en el cual va a iniciar para poder comunicarme
```
    docker run -it -d -p 1521:1521 --name=oracle dockerhelp/docker-oracle-ee-18c /bin/bash
```

Para acceder a la consola del contenedor de oracle utilizamos el siguiente comando:
```
sh post_install.sh
```
### CREAR OTRO USUARIO EN ORACLE
```
sqlplus
user-name: sys as sysdba #USUARIO POR DEFECTO
password: oracle #PASSWORD POR DEFECTO

alter session set "_ORACLE_SCRIPT"=true;
create user (tu_user) identified by (tu_user);
grant all privileges to (tu_user); 
```

### CONECTARSE A TRAVES DE CMD 
```
sqlplus (tu_user)/(tu_user)@(tu_ip):1521/ORCL18
```