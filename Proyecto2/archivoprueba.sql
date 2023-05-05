-- ########################### INGRESAR Restaurante ###########################
CALL AddRestaurant('R-01', 'Zona 10, Guatemala City','Guatemala',-10,12121212,10,1); -- Zona invalida
CALL AddRestaurant('R-01', 'Zona 10, Guatemala City','Guatemala',10,12121212,-10,1); -- personal invalido
CALL AddRestaurant('R-03', 'Zona 20, Villa Nueva','Guatemala',10,12121223,10,1); -- ok
CALL AddRestaurant('R-02', 'Zona 19, San Miguel Petapa','Guatemala',10,12121213,10,1); -- ok
CALL AddRestaurant('R-01', 'Zona 10, Guatemala City','Guatemala',10,12121212,10,1); -- error duplicado



-- ########################### INGRESAR Puesto De Trabajo ###########################
CALL AddPosition('Gerente','Monitoreo del restaurante',-5000.00); -- Salario Invalido
CALL AddPosition('Gerente','Monitoreo del restaurante',5000.00);  -- ok
CALL AddPosition('Gerente','Monitoreo del restaurante',5000.00); -- Error repetido
CALL AddPosition('Repartidor','Repartir comida',3500.00); -- ok
CALL AddPosition('Conserje','Limpieza de restaurante',3000.00); -- ok


-- ########################### INGRESAR Empleados ###########################
CALL AddWorker('Harry','Maguire','1990-01-01','hola.com',12347890,'Zona 15',4567098710234,1,'2022-01-01',"R-01"); -- Correo invalido
CALL AddWorker('Harry','Maguire','1990-01-01','hola@gmail.com',12347890,'Zona 15',4567098710234,4,'2022-01-01',"R-01"); -- Error, puesto de trabajo inexistente
CALL AddWorker('Harry','Maguire','1990-01-01','hola@gmail.com',12347890,'Zona 15',4567098710234,1,'2022-01-01',"R-02"); -- Error, restaurante inexistente
CALL AddWorker('Jennie','Maguire','1990-01-01','hola2@gmail.com',12347890,'Zona 21',3000346440101,7,'2022-01-01',"R-01"); -- Ok
CALL AddWorker('James','Hollywood','1990-01-01','aaa@hotmail.es',12347899,'Zona 15',4567098710234,1,'2022-01-01',"R-01"); -- Error, dpi duplicado
CALL AddWorker('James','Hollywood','1990-01-01','aaa@hotmail.es',12347899,'Zona 15',4567098710235,3,'2022-01-01',"R-01"); -- Ok

-- ########################### INGRESAR Clientes ###########################
CALL AddClient(1234678909123,'Alex','Hunter','1990-01-01','bbbbb@',89709867,NULL); -- Correo Invalido
CALL AddClient(1234678909135,'Alex','Hunter2','1990-01-01','bbbbb@gmail.com',89709867,NULL); -- ok
CALL AddClient(1234678909123,'Calvin','Murder','1990-01-01','ccccc@gmail.com',89709867,NULL); -- Error, Dpi duplicado
CALL AddClient(1234678909097,'Calvin','Murder','1990-01-01','ccccc@gmail.com',89709867,89765678); -- ok


-- ########################### INGRESAR Direcciones ###########################

CALL AddDirection(4444444444444,'Zona 24, Guatemala','Guatemala',10); -- Error, dpi inexistente
CALL AddDirection(1234678909123,'Zona 24, Guatemala','Guatemala',10); -- ok
CALL AddDirection(1234678909123,'Zona 6, Mixco','Mixco',-1); -- Error, zona inválida
CALL AddDirection(1234678909097,'Zona 6, Mixco','Mixco',6); -- ok
CALL AddDirection(1234678909097,'Zona 10, Guatemala','Guatemala',10); -- ok


-- ########################### Crear Ordenes ###########################
CALL AddOrder(4444444444444,1,'L'); -- Error, dpi inexistente
CALL AddOrder(1234678909123,2,'L'); -- Error, dpi si existe, pero esa direccion es de otro cliente
CALL AddOrder(1234678909123,1,'L'); -- ok
CALL AddOrder(1234678909097,2,'C'); -- Error canal equivocado
CALL AddOrder(1234678909097,2,'A'); -- Error, no hay restaurante con cobertura
CALL AddOrder(1234678909097,3,'A'); -- ok


-- ########################### Agregar Items a ordenes ###########################
CALL AddItem(10,'C',1,10,''); -- Error, orden inexistente
CALL AddItem(1,'C',1,-10,''); -- Error, cantidad invalida
CALL AddItem(1,'O',1,10,''); -- Error, tipo de producto invalido
CALL AddItem(1,'C',10,10,''); -- Error, producto inexistente
CALL AddItem(6,'C',1,10,''); -- ok
CALL AddItem(6,'E',1,10,''); -- ok
CALL AddItem(1,'B',1,10,''); -- ok
CALL AddItem(1,'P',1,10,''); -- ok
CALL AddItem(1,'P',19,10,''); -- Error, producto inexistente
CALL AddItem(2,'P',19,10,''); -- Error, no se pueden agregar items a una orden sin cobertura
CALL AddItem(2,'C',2,5,''); -- ok
CALL AddItem(2,'E',2,5,''); -- ok
CALL AddItem(2,'B',2,5,''); -- ok
CALL AddItem(2,'P',2,5,''); -- ok


-- ########################### Confirmar ordenes ###########################
CALL ConfirmOrder(10,'E',3); -- Error,Orden inexistente
CALL ConfirmOrder(1,'E',13); -- Error, El trabajador no existe
CALL ConfirmOrder(1,'S',2); -- Error, Método de pago invalido
CALL ConfirmOrder(6,'E',2); -- ok
CALL ConfirmOrder(3,'T',2); -- ok


-- ########################### Finalizar Órdenes ###########################
CALL FinishOrder(1); -- OK
CALL FinishOrder(6); -- Error, orden inexistente
CALL FinishOrder(2); -- OK


-- ########################### REPORTE # 01 ###########################
CALL GetRestaurants();

-- ########################### REPORTE # 02 ###########################
CALL GetEmployee(5); -- Error Empleado inexistente
CALL GetEmployee(1); -- ok
CALL GetEmployee(2); -- ok
CALL GetEmployee(4); -- Error Empleado inexistente

-- ########################### REPORTE # 03 ###########################
CALL GetItemOfOrder(1); -- ok
CALL GetItemOfOrder(4); -- Error, esta orden se quedo en estado de "SIN COBERTURA"
CALL GetItemOfOrder(3); -- ok
CALL GetItemOfOrder(6); -- Error, esta orden no existe

-- ########################### REPORTE # 04 ###########################
CALL ConsultarHistorialOrdenes(1234678909123); -- ok
CALL ConsultarHistorialOrdenes(44444444444444); -- Error, dpi inexistente              ME FALTA
CALL ConsultarHistorialOrdenes(1234678909097); -- ok

-- ########################### REPORTE # 05 ###########################
CALL GetAddress(1234678909123); -- ok
CALL GetAddress(44444444444444); -- Error, dpi inexistente
CALL GetAddress(1234678909097); -- ok

-- ########################### REPORTE # 06 ###########################
CALL GetOrdersByState(-1); -- Debería mostrar una orden sin cobertura
CALL GetOrdersByState(1); -- No debería mostrar nada
CALL GetOrdersByState(2); -- No debería mostrar nada
CALL GetOrdersByState(3); -- No debería mostrar nada
CALL GetOrdersByState(4); -- Debería mostrar 2 órdenes entregadas.

-- ########################### REPORTE # 07 ###########################
-- Editar las fechas según sea el caso de validación
CALL ConsultarFacturas(19,04,2023);
CALL ConsultarFacturas(29,04,2023);

-- ########################### REPORTE # 08 ###########################
-- Editar los minutos de parametro segun sea el caso de validación
CALL GetTimes(3);
CALL GetTimes(10);
CALL GetTimes(1);