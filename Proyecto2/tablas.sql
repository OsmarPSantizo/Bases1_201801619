-- Creo mi tabla para guardar el menu

CREATE TABLE Producto (
    Id INT NOT NULL,
    Nombre VARCHAR(50) NOT NULL,
    Precio DECIMAL(8,2) NOT NULL,
    PRIMARY KEY (Id)
);

-- Creo mi tabla para guardar mis restaurantes
CREATE TABLE Restaurantes (
	Id VARCHAR(100) NOT NULL,
    Direccion VARCHAR(200) NOT NULL,
    Municipio VARCHAR(200) NOT NULL,
    Zona INT NOT NULL,
    Telefono INT NOT NULL,
    Personal INT NOT NULL,
    Parqueo BOOLEAN NOT NULL,
 	PRIMARY KEY (Id)  
);

-- Creo mi tabla de puesto
CREATE TABLE Puestos (
	Id INT NOT NULL AUTO_INCREMENT,
    Nombre VARCHAR(200) NOT NULL,
    Descripcion VARCHAR(200) NOT NULL,
    Salario INT NOT NULL,
 	PRIMARY KEY (Id)  
);

-- Creo mi tabla para guardar los empleados
CREATE TABLE Empleados (
    Id INT(8) ZEROFILL NOT NULL AUTO_INCREMENT,
    Nombres VARCHAR(100) NOT NULL,
    Apellidos VARCHAR(100) NOT NULL,
    FechaNacimiento DATE NOT NULL,
    Correo VARCHAR(100) NOT NULL,
    Telefono INT NOT NULL,
    Direccion VARCHAR(100) NOT NULL,
    NumDPI BIGINT NOT NULL,
    IdPuesto INT NOT NULL,
    FechaInicio DATE NOT NULL,
    IdRestaurante VARCHAR(100) NOT NULL,
    PRIMARY KEY (Id),
    FOREIGN KEY (IdRestaurante) REFERENCES Restaurantes (Id),
    FOREIGN KEY (IdPuesto) REFERENCES Puestos (Id)
);

-- Creo mi tabla para guardar mis clientes
CREATE TABLE clientes (
  DPI BIGINT NOT NULL,
  Nombre VARCHAR(255) NOT NULL,
  Apellidos VARCHAR(255) NOT null ,
  Fecha_de_nacimiento DATE NOT NULL,
  Correo VARCHAR(255) NOT NULL,
  Telefono INT NOT NULL,
  NIT INT,
  PRIMARY KEY (DPI)
);
-- Creo mi tabla para guardar mis direcciones
drop table direcciones
CREATE TABLE direcciones (
  Id INT NOT NULL AUTO_INCREMENT,
  DPI BIGINT,
  Direccion VARCHAR(255),
  Municipio VARCHAR(255),
  Zona INT,
  PRIMARY KEY (Id)
);

-- Creo mi tabla para guardar mis ordenes
CREATE TABLE ordenes (
  Id INT NOT NULL AUTO_INCREMENT,
  IdCliente BIGINT NOT NULL,
  Canal CHAR(1) NOT NULL,
  IdDireccion VARCHAR(50),
  FechaInicio DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FechaEntrega DATETIME,
  Estado VARCHAR(50) NOT NULL,
  idRestaurante VARCHAR(100),
  PRIMARY KEY (Id)
);

-- Creo mi tabla para guardar mis items para las ordenes

CREATE TABLE items (
  Id INT NOT NULL AUTO_INCREMENT,
  tipo_prod CHAR(1) NOT NULL,
  producto INT NOT NULL,
  cantidad INT NOT NULL,
  idOrden INT NOT NULL,
  observacion VARCHAR(200),
  PRIMARY KEY (Id),
  FOREIGN KEY (idOrden) REFERENCES ordenes (Id)
);

-- Creo mi tabla para guardar mis facturas
CREATE TABLE facturas (
  IdFactura INT AUTO_INCREMENT,
  NumeroSerie VARCHAR(50) NOT NULL,
  MontoTotal DECIMAL(10, 2) NOT NULL,
  Lugar VARCHAR(255) NOT NULL,
  FechaHora DATETIME NOT NULL,
  IdOrden INT NOT NULL,
  NitCliente VARCHAR(20) NOT NULL,
  FormaPago CHAR(1) NOT NULL,
  PRIMARY KEY (IdFactura)
);