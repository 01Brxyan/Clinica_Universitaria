CREATE DATABASE clinica_universitaria;
USE clinica_universitaria;

CREATE TABLE Paciente(
    paciente_id VARCHAR(10) PRIMARY KEY,
    nombre VARCHAR(100),
    telefono VARCHAR(20)
);

CREATE TABLE Especialidad(
    especialidad_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100)
);

CREATE TABLE Medico(
    medico_id VARCHAR(10) PRIMARY KEY,
    nombre VARCHAR(100),
    especialidad_id INT,
    FOREIGN KEY (especialidad_id) REFERENCES Especialidad(especialidad_id)
);

CREATE TABLE Sede(
    sede_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    direccion VARCHAR(150)
);

CREATE TABLE Cita(
    cod_cita VARCHAR(10) PRIMARY KEY,
    paciente_id VARCHAR(10),
    medico_id VARCHAR(10),
    sede_id INT,
    fecha DATE,
    diagnostico VARCHAR(150),
    FOREIGN KEY (paciente_id) REFERENCES Paciente(paciente_id),
    FOREIGN KEY (medico_id) REFERENCES Medico(medico_id),
    FOREIGN KEY (sede_id) REFERENCES Sede(sede_id)
);

CREATE TABLE Error_Log(
    id INT AUTO_INCREMENT PRIMARY KEY,
    procedimiento VARCHAR(100),
    nombre_tabla VARCHAR(100),
    codigo_error VARCHAR(50),
    mensaje TEXT,
    fecha_hora DATETIME
);

DELIMITER $$

CREATE PROCEDURE insertar_paciente(
    IN p_id VARCHAR(10),
    IN p_nombre VARCHAR(100),
    IN p_telefono VARCHAR(20)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO Error_Log(procedimiento,nombre_tabla,codigo_error,mensaje,fecha_hora)
        VALUES('insertar_paciente','Paciente','SQL_ERROR','Error al insertar el paciente',NOW());
    END;

    INSERT INTO Paciente VALUES(p_id,p_nombre,p_telefono);
END$$

CREATE PROCEDURE actualizar_paciente(
    IN p_id VARCHAR(10),
    IN p_nombre VARCHAR(100),
    IN p_telefono VARCHAR(20)
)
BEGIN
    UPDATE Paciente
    SET nombre=p_nombre,
        telefono=p_telefono
    WHERE paciente_id=p_id;
END$$

CREATE PROCEDURE eliminar_paciente(IN p_id VARCHAR(10))
BEGIN
    DELETE FROM Paciente WHERE paciente_id=p_id;
END$$

CREATE FUNCTION numero_doctores_especialidad(id_especialidad INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total
    FROM Medico
    WHERE especialidad_id=id_especialidad;
    RETURN total;
END$$

CREATE FUNCTION total_pacientes_medico(id_medico VARCHAR(10))
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total
    FROM Cita
    WHERE medico_id=id_medico;
    RETURN total;
END$$

CREATE FUNCTION pacientes_por_sede(id_sede INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total
    FROM Cita
    WHERE sede_id=id_sede;
    RETURN total;
END$$

DELIMITER ;