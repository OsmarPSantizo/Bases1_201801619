-- FUNCIONES
-- Con esto valido que el numero sea entero positivo
DELIMITER $$
CREATE FUNCTION ValidarPositivo(num int)
RETURNS BOOLEAN 
DETERMINISTIC

BEGIN
	RETURN num >= 0;
END

-- Con esto valido que el numero sea 0 o 1 para las entradas booleanas
DELIMITER $$
CREATE FUNCTION ValidarBooleano(num int)
RETURNS BOOLEAN 
DETERMINISTIC

BEGIN
	IF num = 0 OR num = 1 THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END

-- Con esto valido que sea un correo correcto
DELIMITER $$
CREATE FUNCTION ValidarCorreo(email VARCHAR(255))
RETURNS BOOLEAN 
DETERMINISTIC

BEGIN
	DECLARE es_valido BOOLEAN;
    IF email REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$' THEN
        RETURN TRUE;
    ELSE
       RETURN FALSE; 
    END IF;
END


-- Con esto valido que el canal solo sea 'L' o 'A'
DELIMITER $$
CREATE FUNCTION ValidarCanal(canal char)
RETURNS BOOLEAN 
DETERMINISTIC

BEGIN
	IF canal = 'L' OR canal = 'A' THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
end

-- Con esto valido que el tipo de producto solo sea 'C','E', 'B','P'
DELIMITER $$
CREATE FUNCTION ValidarTipoProd(producto char)
RETURNS BOOLEAN 
DETERMINISTIC

BEGIN
	IF producto = 'C' OR producto = 'E' OR producto = 'B' OR producto = 'P' THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
end

-- Con esto valido que la forma de pago solo sea 'E','T'
DELIMITER $$
CREATE FUNCTION ValidarFormaPago(pago char)
RETURNS BOOLEAN 
DETERMINISTIC

BEGIN
	IF pago = 'T' OR pago = 'E'  THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END