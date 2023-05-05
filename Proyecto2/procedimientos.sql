-- PROCEDIMIENTOS
-- Proc para añadir restaurante
DELIMITER $$ 
DROP PROCEDURE IF EXISTS AddRestaurant;
CREATE PROCEDURE AddRestaurant (
  IN p_Id VARCHAR(100),
  IN Direccion VARCHAR(200),
  IN Municipio VARCHAR(200),
  IN Zona INT,
  IN Telefono BIGINT,
  IN Personal INT,
  IN Tiene_parqueo BOOLEAN
)

add_restaurant: BEGIN
	-- Primero valido que la zona sea un entero positivo
	IF (NOT ValidarPositivo(Zona)) THEN 
		SELECT 'ZONA DEBE SER UN NUMERO POSITIVO' AS ERROR;
		LEAVE add_restaurant;
	END IF;
	-- Validar que el numero de empleados sea un entero positivo 
	IF (NOT ValidarPositivo(Personal)) THEN 
		SELECT 'NUMERO DE EMPLEADOS DEBE SER UN NUMERO POSITIVO' AS ERROR;
		LEAVE add_restaurant;
	END IF;
	-- Valido que el numero en parqueo sea 0 o 1 
	IF (NOT ValidarBooleano(Tiene_parqueo)) THEN 
		SELECT 'PARQUEO DEBE SER 0 O 1 UNICAMENTE' AS ERROR;
		LEAVE add_restaurant;
	END IF;
	IF (EXISTS(SELECT Id FROM Restaurantes WHERE Id = p_Id)) THEN
		SELECT 'RESTAURANTE YA EXISTE' AS ERROR;
		LEAVE add_restaurant;
		END IF;
	INSERT INTO Restaurantes (Id,Direccion,Municipio,Zona,Telefono,Personal,Parqueo) 
	VALUES (p_Id,Direccion,Municipio,Zona,Telefono,Personal,Tiene_parqueo);
END;

-- Proc para añadir puesto
DELIMITER $$ 
DROP PROCEDURE IF EXISTS AddPosition;
CREATE PROCEDURE AddPosition (
  IN p_Nombre VARCHAR(200),
  IN Descripcion VARCHAR(200),
  IN Salario INT
)

add_position: BEGIN
	-- Primero valido que el salario sea un entero positivo
	IF (NOT ValidarPositivo(Salario)) THEN 
		SELECT 'SALARIO DEBE SER UN NUMERO POSITIVO' AS ERROR;
		LEAVE add_position;
	END IF;
	/* VALIDAR QUE EL ID DEL RESTAURANTE NO EXISTA YA */
	IF (EXISTS(SELECT Nombre FROM Puestos WHERE Nombre = p_Nombre)) THEN
	SELECT 'PUESTO YA INGRESADO' AS ERROR;
	LEAVE add_position;
	END IF;

	INSERT INTO Puestos (Nombre,Descripcion,Salario) 
	VALUES (p_Nombre,Descripcion,Salario);
END;

-- Proc para añadir empleados
DROP PROCEDURE IF EXISTS AddWorker;
CREATE PROCEDURE AddWorker (
  IN Nombres VARCHAR(200),
  IN Apellidos VARCHAR(200),
  IN FechaNacimiento DATE,
  IN Correo VARCHAR(100),
  IN Telefono INT ,
  IN Direccion VARCHAR(100),
  IN p_NumDPI BIGINT,
  IN p_IdPuesto INT,
  IN FechaInicio DATE,
  IN p_IdRestaurante VARCHAR(100)
)

add_worker: BEGIN
	-- Primero valido que la zona sea un entero positivo
	IF (NOT ValidarCorreo(Correo)) THEN 
		SELECT 'EL CORREO NO ES VALIDO' AS ERROR;
		LEAVE add_worker;
	END IF;
	/* VALIDAR QUE EL ID DEL PUESTO EXISTA  */
	IF (NOT EXISTS(SELECT Nombre FROM Puestos WHERE Id = p_IdPuesto)) THEN
	SELECT 'EL PUESTO INGRESADO NO EXISTE' AS ERROR;
	LEAVE add_worker;
	END IF;
	/* VALIDAR QUE EL ID DEL RESTAURANTE EXISTA  */
	IF (NOT EXISTS(SELECT Id FROM Restaurantes WHERE Id = p_IdRestaurante)) THEN
	SELECT 'EL RESTAURANTE INGRESADO NO EXISTE' AS ERROR;
	LEAVE add_worker;
	END IF;
	/* VALIDAR QUE EL DPI DEL EMPLEADO NO EXISTA YA */
	IF (EXISTS(SELECT Nombres FROM Empleados WHERE NumDPI = p_NumDPI)) THEN
	SELECT 'EL EMPLEADO YA ESTA INGRESADO' AS ERROR;
	LEAVE add_worker;
	END IF;

	INSERT INTO Empleados (Nombres,Apellidos,FechaNacimiento,Correo,Telefono,Direccion,NumDPI,IdPuesto,FechaInicio,IdRestaurante) 
	VALUES (Nombres,Apellidos,FechaNacimiento,Correo,Telefono,Direccion,NumDPI,p_IdPuesto,FechaInicio,p_IdRestaurante);
END;


-- Proc para añadir clientes
DROP PROCEDURE IF EXISTS AddClient;
CREATE PROCEDURE AddClient (
  IN p_DPI BIGINT,
  IN Nombre VARCHAR(255),
  IN Apellidos VARCHAR(255),
  IN Fecha_de_nacimiento DATE,
  IN Correo VARCHAR(255) ,
  IN Telefono INT,
  IN NIT INT
)

add_client: BEGIN
	-- Primero valido que el correo sea valido
	IF (NOT ValidarCorreo(Correo)) THEN 
		SELECT 'EL CORREO NO ES VALIDO' AS ERROR;
		LEAVE add_client;
	END IF;
	/* VALIDAR QUE EL DPI DEL CLIENTE NO EXISTA YA */
	IF (EXISTS(SELECT Nombre FROM Clientes WHERE DPI = p_DPI)) THEN
	SELECT 'EL CLIENTE YA EXISTE' AS ERROR;
	LEAVE add_client;
	END IF;

	INSERT INTO clientes (DPI,Nombre,Apellidos,Fecha_de_nacimiento,Correo,Telefono,NIT) 
	VALUES (p_DPI,Nombre,Apellidos,Fecha_de_nacimiento,Correo,Telefono,NIT);
END;


-- Proc para añadir direcciones
DROP PROCEDURE IF EXISTS AddDirection;
CREATE PROCEDURE AddDirection (
  IN p_DPI BIGINT,
  IN Direccion VARCHAR(255),
  IN Municipio VARCHAR(255),
  IN Zona INT
 
)

add_direction: BEGIN
	-- Primero valido que la zona sea un entero positivo
	IF (NOT ValidarPositivo(Zona)) THEN 
		SELECT 'ZONA DEBE SER UN NUMERO POSITIVO' AS ERROR;
		LEAVE add_direction;
	END IF;
	/* VALIDAR QUE EL DPI DEL CLIENTE NO EXISTA YA */
	IF (NOT EXISTS(SELECT Nombre FROM Clientes WHERE DPI = p_DPI)) THEN
	SELECT 'EL CLIENTE NO EXISTE' AS ERROR;
	LEAVE add_direction;
	END IF;

	INSERT INTO Direcciones (DPI,Direccion,Municipio,Zona) 
	VALUES (p_DPI,Direccion,Municipio,Zona);
END;

-- Proc para añadir ordenes
DROP PROCEDURE IF EXISTS AddOrder;
CREATE PROCEDURE AddOrder (
  IN p_Id BIGINT,
  IN IdCliente BIGINT,
  IN Canal CHAR(1) 
)

add_order: begin
	/* DECLARO VARIABLES PARA GUARDAR LA INFO  */
    DECLARE municipioCliente VARCHAR(255);
    DECLARE zonaCliente INT;
    DECLARE idRestaurante VARCHAR(100);
   
   	
    /* GUARDO LA RESPUESTA EN MIS VARIABLES municipioCliente, zonaCliente  */
   	SELECT Municipio, Zona INTO  municipioCliente, zonaCliente FROM direcciones WHERE Id = IdCliente;
   /* GUARDO LA RESPUESTA EN MI VARIABLE idRestaurante  */
    SELECT Id INTO idRestaurante FROM Restaurantes WHERE Municipio = municipioCliente AND Zona = zonaCliente;
   
	/* VALIDAR QUE EL DPI DEL CLIENTE EXISTA */
	IF (NOT EXISTS(SELECT Nombre FROM Clientes WHERE DPI = p_Id)) THEN
	SELECT 'EL CLIENTE NO EXISTE' AS ERROR;
	LEAVE add_order;
	END IF;
	/* VALIDAR QUE EL CANAL SEA PERMITDIO */
	IF (NOT ValidarCanal(Canal)) THEN 
		SELECT 'CANAL NO VALIDO' AS ERROR;
		LEAVE add_order;
	END IF;

	IF (NOT EXISTS(SELECT Municipio FROM direcciones WHERE DPI = p_Id AND Id = IdCliente)) THEN
		SELECT 'LA DIRECCION ES DE OTRO CLIENTE' AS ERROR;
		LEAVE add_order;
		END IF;

	IF idRestaurante IS NULL THEN
        INSERT INTO ordenes (IdCliente, Canal, Estado) VALUES (p_Id, canal, 'SIN COBERTURA');
    ELSE
        INSERT INTO ordenes (IdCliente, IdDireccion,idRestaurante,Canal, Estado) VALUES (p_Id, idRestaurante,idRestaurante, canal, 'INICIADA');
    END IF;
END;

-- Proc para añadir items
DROP PROCEDURE IF EXISTS AddItem;
CREATE PROCEDURE AddItem (
  IN idOrden INT,
  IN tipo_prod CHAR(1),
  IN producto INT,
  IN cantidad INT,
  IN Observacion VARCHAR(200)
)

add_item: begin
	
	DECLARE estadoOrden VARCHAR(50);
	/* VALIDAR QUE LA ORDEN EXISTA  */
	IF (NOT EXISTS(SELECT Id FROM Ordenes WHERE Id = idOrden )) THEN
	SELECT 'LA ORDEN NO EXISTE' AS ERROR;
	LEAVE add_item;
	END IF;

	/* VALIDAR QUE LA ORDEN EXISTA  */
	IF (NOT EXISTS(SELECT Id FROM Ordenes WHERE Id = idOrden AND (Estado = 'INICIADA' OR Estado = 'AGREGANDO') )) THEN
	SELECT 'EL ESTADO NO PERMITE AGREGAR ITEMS' AS ERROR;
	LEAVE add_item;
	END IF;

	/* OBTENGO EL ESTADO DE LA ORDEN */
    SELECT Estado INTO estadoOrden FROM ordenes WHERE Id = idOrden;
   
    /* VALIDO QUE LA ORDEN NO ESTÉ EN ESTADO FINALIZADA O EN CAMINO */
    IF estadoOrden = 'FINALIZADA' OR estadoOrden = 'EN CAMINO' THEN
        SELECT 'NO SE PUEDE AGREGAR PRODUCTO A UNA ORDEN FINALIZADA O EN CAMINO' AS ERROR;
        LEAVE add_item;
    END IF;
   
    /* ACTUALIZO EL ESTADO DE LA ORDEN A "AGREGANDO" SI SE ENCONTRABA EN "INICIADA" */
    IF estadoOrden = 'INICIADA' THEN
        UPDATE ordenes SET Estado = 'AGREGANDO' WHERE Id = idOrden;
    END IF;
	
	/* VALIDAR QUE EL TIPO DE PRODUCTO SEA PERMITDIO */
	IF (NOT ValidarTipoProd(tipo_prod)) THEN 
		SELECT 'TIPO DE PRODUCTO NO PERMITIDO' AS ERROR;
		LEAVE add_item;
	END IF;

	/* VALIDAR QUE CANTIDAD SE ENTERO POSITIVO */
	IF (NOT ValidarPositivo(cantidad)) THEN 
			SELECT 'CANTIDAD DEBE SER UN NUMERO POSITIVO' AS ERROR;
			LEAVE add_item;
		END IF;

	/* VALIDAR QUE SEA UN PRODUCTO QUE EXISTA */
	IF (NOT EXISTS(SELECT Nombre FROM productos WHERE Id = CONCAT(tipo_prod, producto))) THEN
	SELECT 'EL PRODUCTO NO EXISTE' AS ERROR; 
	LEAVE add_item;
	END IF;
		
	INSERT INTO items (tipo_prod, producto, cantidad, idOrden, observacion) 
    VALUES (tipo_prod, producto, cantidad, idOrden, Observacion);
	
END;


-- Proc para confirmar orden
DROP PROCEDURE IF EXISTS ConfirmOrder;
CREATE PROCEDURE ConfirmOrder (
  IN idOrden INT,
  IN FormaPago CHAR(1),
  IN p_IdRepartidor INT
)

confirm_order: begin
	
	/*DECLARAMOS TODO PARA LA FACTURA*/
	DECLARE p_total DECIMAL(10,2);
	DECLARE p_numserie VARCHAR(50);
	DECLARE p_lugar VARCHAR(200);
	DECLARE p_fecha_hora DATETIME;
	DECLARE p_nit INT;
	DECLARE p_FormaPago CHAR(1);
	DECLARE p_estado_orden VARCHAR(50);
	
	/* VALIDAR QUE LA ORDEN EXISTA  */
	IF (NOT EXISTS(SELECT Id FROM Ordenes WHERE Id = idOrden )) THEN
	SELECT 'LA ORDEN NO EXISTE' AS ERROR;
	LEAVE confirm_order;
	END IF;


	/* VALIDAR QUE LA FORMA DE PAGO ES CORRECTA */
	IF (NOT ValidarFormaPago(FormaPago)) THEN 
		SELECT 'FORMA DE PAGO NO ADMITIDO' AS ERROR;
		LEAVE confirm_order;
	END IF;

	/* VALIDAR QUE EL TRABAJADOR EXISTA  */
	IF (NOT EXISTS(SELECT Id FROM empleados WHERE Id = p_IdRepartidor )) THEN
	SELECT 'NO EXISTE EL TRABAJADOR' AS ERROR;
	LEAVE confirm_order;
	END IF;
	
	
	/* OBTENGO EL ESTADO DE LA ORDEN */
    SELECT Estado INTO p_estado_orden FROM ordenes WHERE Id = idOrden;
   
   /* VALIDO QUE LA ORDEN NO ESTÉ EN ESTADO ENTREGADA O EN CAMINO */
    IF estadoOrden != 'AGREGANDO' THEN
        SELECT 'NO SE PUEDE CONFIRMAR LA ORDEN AHORA' AS ERROR;
        LEAVE confirm_order;
    END IF;

	UPDATE ordenes SET Estado = 'EN CAMINO', IdRepartidor = p_IdRepartidor WHERE Id = idOrden;

	/* OBTENGO LOS DATOS DE LA ORDEN Y DEL CLIENTE */	
 	SELECT IdCliente, IdRestaurante INTO @cliente, @restaurante FROM ordenes WHERE Id = p_IdOrden;
    SELECT Municipio INTO p_lugar FROM direcciones WHERE DPI = @cliente;
    SELECT NIT INTO v_NITCliente FROM Clientes WHERE DPI = @cliente;
END;


-- Proc para finalizar orden
DROP PROCEDURE IF EXISTS FinishOrder;
CREATE PROCEDURE FinishOrder (
  IN idOrden INT
)

finish_order: begin
	DECLARE p_estado_orden VARCHAR(50);
	
	/* VALIDAR QUE LA ORDEN EXISTA  */
	IF (NOT EXISTS(SELECT Id FROM Ordenes WHERE Id = idOrden )) THEN
	SELECT 'LA ORDEN NO EXISTE' AS ERROR;
	LEAVE finish_order;
	END IF;

	/* OBTENGO EL ESTADO DE LA ORDEN */
    SELECT Estado INTO p_estado_orden FROM ordenes WHERE Id = idOrden;
   
   /* VALIDO QUE LA ORDEN NO ESTÉ EN ESTADO ENTREGADA O EN CAMINO */
    IF p_estado_orden != 'EN CAMINO' THEN
        SELECT 'NO SE PUEDE FINALIZAR LA ORDEN PORQUE NO ESTÁ EN CAMINO' AS ERROR;
        LEAVE finish_order;
    END IF;

	UPDATE ordenes SET Estado = 'ENTREGADA',FechaEntrega = CURRENT_TIMESTAMP  WHERE Id = idOrden;

END;

-- Proc para Listar los restaurantes
DROP PROCEDURE IF EXISTS GetRestaurants;
CREATE PROCEDURE GetRestaurants()
BEGIN
    SELECT Id, Direccion, Municipio, Zona, Telefono, Personal,
        CASE Parqueo WHEN 1 THEN 'Sí' ELSE 'No' END AS Tiene_Parqueo
    FROM Restaurantes;
END;

-- Proc para Listar los obtener datos de un empleado
DROP PROCEDURE IF EXISTS GetEmployee;
CREATE PROCEDURE GetEmployee(
	IN idEmpleado INT
)
get_empoyee : BEGIN
	
	/* VALIDAR QUE EL EMPLEADO NO EXISTA  */
	IF (NOT EXISTS(SELECT Id FROM Empleados WHERE Id = idEmpleado )) THEN
	SELECT 'EL CLIENTE NO EXISTE' AS ERROR;
	LEAVE get_empoyee;
	END IF;
	
	SELECT e.Id , CONCAT(e.Nombres,' ',e.Apellidos) AS NombreCompleto, e.FechaNacimiento, e.Correo, e.Telefono, e.Direccion, e.NumDPI, e.FechaInicio, p.Nombre,p.Salario
	FROM Empleados e
	INNER JOIN Puestos p ON e.IdPuesto = p.Id
	WHERE e.Id = idEmpleado;
	
END;

-- Proc para obtener los items de las ordenes
DROP PROCEDURE IF EXISTS GetItemOfOrder;
CREATE PROCEDURE GetItemOfOrder(
	IN idOrder INT
)
get_items : BEGIN
	
	/* VALIDAR QUE EL EMPLEADO NO EXISTA  */
	IF (NOT EXISTS(SELECT Id FROM ordenes WHERE Id = idOrder )) THEN
	SELECT 'LA ORDEN NO EXISTE' AS ERROR;
	LEAVE get_items;
	END IF;
	/* VALIDAR QUE LA ORDEN SEA DIFERENTE A SIN CONBERTURA  */
	IF (NOT EXISTS(SELECT Id FROM Ordenes WHERE Id = idOrder AND (Estado = 'INICIADA' OR Estado = 'AGREGANDO') )) THEN
	SELECT 'ESTA ORDEN NO TIENE COBERTURA' AS ERROR;
	LEAVE get_items;
	END IF;

	/* LE PONGO NOMBRE AL TIPO DE PRODUCTO  */
	SELECT p.Nombre AS Producto,
	       CASE i.tipo_prod
		       WHEN 'C' THEN 'Combo'
		       WHEN 'E' THEN 'Extra'
		       WHEN 'B' THEN 'Bebida'
		       WHEN 'P' THEN 'Postre'
	       END AS TipoProducto,
	       p.Precio AS Precio,
	       i.cantidad AS Cantidad,
	       i.observacion AS Observacion
	FROM items i
	INNER JOIN Productos p ON CONCAT(i.tipo_prod, producto) = p.Id
	WHERE i.idOrden = idOrder;
	
END;

-- Proc para obtener las direcciones de un cliente
DROP PROCEDURE IF EXISTS GetAddress;
CREATE PROCEDURE GetAddress(
	IN dpi_client BIGINT
)
get_address : BEGIN
	
	/* VALIDAR QUE EL EMPLEADO NO EXISTA  */
	IF (NOT EXISTS(SELECT DPI FROM clientes WHERE DPI = dpi_client )) THEN
	SELECT 'EL CLIENTE NO EXISTE' AS ERROR;
	LEAVE get_address;
	END IF;
	/* OBTENGO LOS DATOS DE LA DIRECCION  */
	SELECT Direccion,Municipio,Zona  FROM direcciones 
	WHERE DPI = dpi_client;
	
END;

-- Proc para obtener ordenes según el estado
DROP PROCEDURE IF EXISTS GetOrdersByState;
CREATE PROCEDURE GetOrdersByState(
	IN EstadoOrden INT
)
get_orders_state : BEGIN
	
	SELECT o.Id as IdOrden, o.Estado, o.FechaInicio as Fecha, o.IdCliente as DPICliente,o.IdDireccion, CASE o.canal
		       WHEN 'L' THEN 'Llamada'
		       WHEN 'A' THEN 'Aplicacion'
	       END AS Canal, r.Direccion as Restaurante
	FROM ordenes o 
	LEFT OUTER JOIN restaurantes r ON r.Id = IdDireccion
	WHERE Estado = CASE EstadoOrden
		       WHEN 1 THEN 'INICIADA'
		       WHEN 2 THEN 'AGREGANDO'
		       WHEN 3 THEN 'EN CAMINO'
		       WHEN 4 THEN 'ENTREGADA'
     		   WHEN -1 THEN 'SIN COBERTURA'
	       END;
	
END;


-- Proc para consultar los tiempos de espera
DROP PROCEDURE IF EXISTS GetTimes;
CREATE PROCEDURE GetTimes(
	IN Minutos INT
)
get_times : BEGIN
	
	SELECT o.Id as IdOrden, o.IdDireccion as DireccionEntrega, o.FechaInicio, TIMEDIFF(o.FechaEntrega, o.FechaInicio) AS TiempoEspera, CONCAT(e.Nombres,' ',e.Apellidos) AS Repartidor
	FROM ordenes o
	LEFT JOIN empleados e ON o.IdRepartidor = e.Id
	WHERE o.Estado = 'ENTREGADA' AND TIMESTAMPDIFF(MINUTE, o.FechaInicio, o.FechaEntrega) >= Minutos;
END;