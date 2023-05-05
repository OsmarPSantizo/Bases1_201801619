-- TRIGGERS
-- TABLA PRODUCTOS

CREATE TRIGGER tr_producto_insert
AFTER INSERT ON Productos
FOR EACH ROW
BEGIN
INSERT INTO Historial (Fecha, Descripcion, Tipo)
VALUES (NOW(), CONCAT('Se ha insertado el producto ', NEW.Nombre), 'INSERT');
END;

CREATE TRIGGER tr_producto_update
AFTER UPDATE ON Productos
FOR EACH ROW
BEGIN
INSERT INTO historial (Fecha, Descripcion, Tipo)
VALUES (NOW(), CONCAT('Se ha actualizado el producto ', NEW.Nombre), 'UPDATE');
END;

CREATE TRIGGER tr_producto_delete
AFTER DELETE ON Productos
FOR EACH ROW
BEGIN
INSERT INTO historial (Fecha, Descripcion, Tipo)
VALUES (NOW(), CONCAT('Se ha eliminado el producto ', OLD.Nombre), 'DELETE');
END;


-- TABLA RESTAURANTES

CREATE TRIGGER tr_restaurantes_insert
AFTER INSERT ON Restaurantes
FOR EACH ROW
BEGIN
INSERT INTO historial (Fecha, Descripcion, Tipo)
VALUES (NOW(), CONCAT('Se ha insertado el restaurante con Id ', NEW.Id), 'INSERT');
END;

CREATE TRIGGER tr_restaurantes_update
AFTER UPDATE ON Restaurantes
FOR EACH ROW
BEGIN
INSERT INTO historial (Fecha, Descripcion, Tipo)
VALUES (NOW(), CONCAT('Se ha actualizado el restaurante con Id ', NEW.Id), 'UPDATE');
END;

CREATE TRIGGER tr_restaurantes_delete
AFTER DELETE ON Restaurantes
FOR EACH ROW
BEGIN
INSERT INTO historial (Fecha, Descripcion, Tipo)
VALUES (NOW(), CONCAT('Se ha eliminado el restaurante con Id ', OLD.Id), 'DELETE');
END;

-- TABLA PUESTOS

CREATE TRIGGER tr_puestos_insert
AFTER INSERT ON Puestos
FOR EACH ROW
BEGIN
INSERT INTO historial (Fecha, Descripcion, Tipo)
VALUES (NOW(), CONCAT('Se ha insertado el puesto con Id ', NEW.Id), 'INSERT');
END;

CREATE TRIGGER tr_puestos_update
AFTER UPDATE ON Puestos
FOR EACH ROW
BEGIN
INSERT INTO historial (Fecha, Descripcion, Tipo)
VALUES (NOW(), CONCAT('Se ha actualizado el puesto con Id ', NEW.Id), 'UPDATE');
END;

CREATE TRIGGER tr_puestos_delete
AFTER DELETE ON Puestos
FOR EACH ROW
BEGIN
INSERT INTO historial (Fecha, Descripcion, Tipo)
VALUES (NOW(), CONCAT('Se ha eliminado el puesto con Id ', OLD.Id), 'DELETE');
END;

-- TABLA EMPLEADOS

CREATE TRIGGER tr_insert_Empleados
BEFORE INSERT ON Empleados
FOR EACH ROW
BEGIN
    INSERT INTO historial (fecha, descripcion, tipo)
    VALUES (NOW(), CONCAT('Se ha insertado el empleado con Id ',NEW.Id), 'INSERT');
END;

CREATE TRIGGER tr_update_Empleados
BEFORE UPDATE ON Empleados
FOR EACH ROW
BEGIN
    INSERT INTO historial (fecha, descripcion, tipo)
    VALUES (NOW(), CONCAT('Se ha actualizado el empleado con Id ',NEW.Id), 'UPDATE');
END;

CREATE TRIGGER tr_delete_Empleados
BEFORE DELETE ON Empleados
FOR EACH ROW
BEGIN
    INSERT INTO historial (fecha, descripcion, tipo)
    VALUES (NOW(), CONCAT('Se ha eliminado el empleado con Id ',OLD.Id), 'DELETE');
END;

-- TABLA CLIENTES

CREATE TRIGGER tr_insert_clientes
BEFORE INSERT ON clientes
FOR EACH ROW
BEGIN
    INSERT INTO historial (fecha, descripcion, tipo)
    VALUES (NOW(), 'Cliente insertado', 'INSERT');
END;

CREATE TRIGGER tr_update_clientes
BEFORE UPDATE ON clientes
FOR EACH ROW
BEGIN
    INSERT INTO historial (fecha, descripcion, tipo)
    VALUES (NOW(), 'Cliente actualizado', 'UPDATE');
END;

CREATE TRIGGER tr_delete_clientes
BEFORE DELETE ON clientes
FOR EACH ROW
BEGIN
    INSERT INTO historial (fecha, descripcion, tipo)
    VALUES (NOW(), 'Cliente eliminado', 'DELETE');
END;

-- TABLA DIRECCIONES

CREATE TRIGGER tr_insert_direcciones
BEFORE INSERT ON direcciones
FOR EACH ROW
BEGIN
    INSERT INTO historial (fecha, descripcion, tipo) 
    VALUES (NOW(), 'Direccion Insertada', 'INSERT');
END;

CREATE TRIGGER tr_update_direcciones
BEFORE UPDATE ON direcciones
FOR EACH ROW
BEGIN
    INSERT INTO historial (fecha, descripcion, tipo) 
    VALUES (NOW(), 'Direccion actualizada', 'UPDATE');
END;

CREATE TRIGGER tr_delete_direcciones
BEFORE DELETE ON direcciones
FOR EACH ROW
BEGIN
    INSERT INTO historial (fecha, descripcion, tipo) 
    VALUES (NOW(), 'Direccion eliminada', 'DELETE');
END;

-- TABLA ORDENES

CREATE TRIGGER tr_insert_ordenes
BEFORE INSERT ON ordenes
FOR EACH ROW
BEGIN
    INSERT INTO historial (fecha, descripcion, tipo) 
    VALUES (NOW(), 'Orden insertada', 'INSERT');
END;

CREATE TRIGGER tr_update_ordenes
BEFORE UPDATE ON ordenes
FOR EACH ROW
BEGIN
    INSERT INTO historial (fecha, descripcion, tipo) 
    VALUES (NOW(), 'Orden actualizada', 'UPDATE');
END;

CREATE TRIGGER tr_b4_delete_ordenes
BEFORE DELETE ON ordenes
FOR EACH ROW
BEGIN
    INSERT INTO historial (fecha, descripcion, tipo) 
    VALUES (NOW(), 'Orden Eliminada', 'DELETE');
END;

-- TABLA ITEMS

CREATE TRIGGER tr_insert_items
BEFORE INSERT ON items
FOR EACH ROW
BEGIN
    INSERT INTO historial (fecha, descripcion, tipo) 
    VALUES (NOW(), 'Item agregado', 'INSERT');
END;

CREATE TRIGGER tr_update_items
BEFORE UPDATE ON items
FOR EACH ROW
BEGIN
    INSERT INTO historial (fecha, descripcion, tipo) 
    VALUES (NOW(), 'Item actualizado', 'UPDATE');
END;


CREATE TRIGGER tr_delete_items
BEFORE DELETE ON items
FOR EACH ROW
BEGIN
    INSERT INTO historial (fecha, descripcion, tipo) 
    VALUES (NOW(), 'Item eliminado', 'DELETE');
END;

-- TABLA FACTURAS

CREATE TRIGGER tr_facturas_after_insert
AFTER INSERT ON facturas
FOR EACH ROW
BEGIN
  INSERT INTO historial (Fecha, Descripcion, Tipo)
  VALUES (NOW(), CONCAT('Se insertó la factura con ID ', NEW.IdFactura), 'INSERT');
END;

CREATE TRIGGER tr_facturas_after_update
AFTER UPDATE ON facturas
FOR EACH ROW
BEGIN
  INSERT INTO historial (Fecha, Descripcion, Tipo)
  VALUES (NOW(), CONCAT('Se actualizó la factura con ID ', NEW.IdFactura), 'UPDATE');
END;

CREATE TRIGGER tr_facturas_after_delete
AFTER DELETE ON facturas
FOR EACH ROW
BEGIN
  INSERT INTO historial (Fecha, Descripcion, Tipo)
  VALUES (NOW(), CONCAT('Se eliminó la factura con ID ', OLD.IdFactura), 'DELETE');
END;