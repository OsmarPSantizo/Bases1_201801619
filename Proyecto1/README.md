**<h1 align="center"> PROYECTO 1. </h1>**
### Datos Estudiante
| Nombre | Carné |
| ------ | ------ |
| Osmar Abdel Peña Santizo  | 201801619 |
----
El proyecto consiste en aprender a realizar cargas masivas desde un archivo de excel, convertir la información para insertarla en la base de datos y posteriormente utilizar la misma API para realizar consultas óptimas y obtener reportería sobre los datos almacenados
----
**<h4 align="center">BACKEND (API)</h4>**

Para el backend se utilizó **nodejs** con la librería **express**. Se crearon dos carpetas una llamada **controllers** en la cual están los controladores de todos los endpoints y otra llamada **routes** en la cual se encuentran listadas las urls con sus respectivos controladores.

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