CREATE DATABASE normalizacion_clinica;
USE normalizacion_clinica;

CREATE TABLE Paciente(
    paciente_id VARCHAR(10) PRIMARY KEY,
    nombre_paciente VARCHAR(100),
    telefono_paciente VARCHAR(20)
);

CREATE TABLE Especialidad(
    especialidad_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_especialidad VARCHAR(100)
);

CREATE TABLE Facultad(
    facultad_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_facultad VARCHAR(100),
    becano_facultad VARCHAR(100)
);

CREATE TABLE Medico(
    medico_id VARCHAR(10) PRIMARY KEY,
    nombre_medico VARCHAR(100),
    especialidad_id INT,
    facultad_id INT,
    FOREIGN KEY (especialidad_id) REFERENCES Especialidad(especialidad_id),
    FOREIGN KEY (facultad_id) REFERENCES Facultad(facultad_id)
);

CREATE TABLE Sede(
    sede_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_sede VARCHAR(100),
    direccion_sede VARCHAR(150)
);

CREATE TABLE Cita(
    cod_cita VARCHAR(10) PRIMARY KEY,
    paciente_id VARCHAR(10),
    medico_id VARCHAR(10),
    sede_id INT,
    fecha_cita DATE,
    diagnostico VARCHAR(150),
    FOREIGN KEY (paciente_id) REFERENCES Paciente(paciente_id),
    FOREIGN KEY (medico_id) REFERENCES Medico(medico_id),
    FOREIGN KEY (sede_id) REFERENCES Sede(sede_id)
);

CREATE TABLE Medicamento(
    medicamento_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_medicamento VARCHAR(100)
);

CREATE TABLE Receta(
    receta_id INT AUTO_INCREMENT PRIMARY KEY,
    cod_cita VARCHAR(10),
    medicamento_id INT,
    dosis VARCHAR(50),
    FOREIGN KEY (cod_cita) REFERENCES Cita(cod_cita),
    FOREIGN KEY (medicamento_id) REFERENCES Medicamento(medicamento_id)
);