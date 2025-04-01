-- Creacion de la base de datos
CREATE DATABASE CultivaInt;
USE CultivaInt;

-- 1. CREACIÓN DE TABLAS

-- Tabla de Roles
CREATE TABLE Roles (
    RolID INT NOT NULL,
    Nombre VARCHAR(50) NOT NULL UNIQUE,
    PRIMARY KEY (RolID)
);

-- Tabla de Planes
CREATE TABLE Planes (
    PlanID INT NOT NULL,
    Nombre VARCHAR(50) NOT NULL UNIQUE,
    Descripcion TEXT NOT NULL,
    ProductorID INT NOT NULL,  -- Relación con Productores
    PRIMARY KEY (PlanID)
);

-- Tabla de Usuarios
CREATE TABLE Usuarios (
    UsuarioID INT NOT NULL AUTO_INCREMENT,
    Nombre VARCHAR(100) NOT NULL,
    Correo VARCHAR(100) UNIQUE NOT NULL,
    Contraseña VARCHAR(255) NOT NULL,
    RolID INT NOT NULL,
    PlanID INT NOT NULL,
    PRIMARY KEY (UsuarioID),
    FOREIGN KEY (RolID) REFERENCES Roles(RolID),
    FOREIGN KEY (PlanID) REFERENCES Planes(PlanID)
);

-- Tabla de Productores
CREATE TABLE Productores (
    ProductosID INT NOT NULL AUTO_INCREMENT,
    Nombre VARCHAR(100) NOT NULL,
    Contacto VARCHAR(100),
    Ubicacion VARCHAR(255),
    UsuarioID INT,
    PRIMARY KEY (ProductosID),
    FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID)
);

-- Tabla de Cultivos
CREATE TABLE Cultivos (
    CultivosID INT NOT NULL AUTO_INCREMENT,
    Nombre VARCHAR(100) NOT NULL,
    FechaSiembra DATE NOT NULL,
    Estado VARCHAR(50),
    ProductorID INT,
    ParcelaID INT,
    PRIMARY KEY (CultivosID),
    FOREIGN KEY (ProductorID) REFERENCES Productores(ProductosID),
    FOREIGN KEY (ParcelaID) REFERENCES Parcelas(ParcelasID)
);

-- Tabla de Parcelas
CREATE TABLE Parcelas (
    ParcelasID INT NOT NULL AUTO_INCREMENT,
    Ubicacion VARCHAR(255) NOT NULL,
    TipoSuelo VARCHAR(100),
    ProductorID INT,
    PRIMARY KEY (ParcelasID),
    FOREIGN KEY (ProductorID) REFERENCES Productores(ProductosID)
);

-- Tabla de Sensores
CREATE TABLE Sensores (
    SensoresID INT NOT NULL AUTO_INCREMENT,
    Tipo VARCHAR(50) NOT NULL,
    Ubicacion VARCHAR(255),
    ParcelaID INT,
    PRIMARY KEY (SensoresID),
    FOREIGN KEY (ParcelaID) REFERENCES Parcelas(ParcelasID)
);

-- Tabla de Lecturas de Sensores
CREATE TABLE Lecturas (
    LecturaID INT NOT NULL AUTO_INCREMENT,
    SensorID INT NOT NULL,
    FechaHora DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    Humedad DECIMAL(5,2),
    Temperatura DECIMAL(5,2),
    PH DECIMAL(4,2),
    Nutrientes DECIMAL(5,2),
    PRIMARY KEY (LecturaID),
    FOREIGN KEY (SensorID) REFERENCES Sensores(SensoresID)
);

-- Tabla de Riego
CREATE TABLE Riego (
    RiegoID INT NOT NULL AUTO_INCREMENT,
    ParcelaID INT,
    FechaHora DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    CantidadAgua DECIMAL(6,2) NOT NULL,
    Estado VARCHAR(50),
    PRIMARY KEY (RiegoID),
    FOREIGN KEY (ParcelaID) REFERENCES Parcelas(ParcelasID)
);

-- Tabla de Plagas
CREATE TABLE Plagas (
    PlagasID INT NOT NULL AUTO_INCREMENT,
    Nombre VARCHAR(100) NOT NULL,
    CultivoID INT,
    FechaDeteccion DATE NOT NULL,
    Estado VARCHAR(50),
    PRIMARY KEY (PlagasID),
    FOREIGN KEY (CultivoID) REFERENCES Cultivos(CultivosID)
);

-- Tabla de Alertas
CREATE TABLE Alertas (
    AlertasID INT NOT NULL AUTO_INCREMENT,
    Tipo VARCHAR(50) NOT NULL CHECK (Tipo IN ('Riego', 'Plaga', 'Sensor')),
    Descripcion TEXT NOT NULL,
    Estado VARCHAR(20) NOT NULL CHECK (Estado IN ('Pendiente', 'Resuelta')),
    FechaHora DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    ProductorID INT,
    SensorID INT,
    PRIMARY KEY (AlertasID),
    FOREIGN KEY (ProductorID) REFERENCES Productores(ProductosID),
    FOREIGN KEY (SensorID) REFERENCES Sensores(SensoresID)
);

-- Tabla de Configuracion del Sistema
CREATE TABLE Configuracion (
    ConfigID INT NOT NULL AUTO_INCREMENT,
    NombreParametro VARCHAR(100) NOT NULL UNIQUE,
    Valor VARCHAR(255) NOT NULL,
    PRIMARY KEY (ConfigID)
);

-- Tabla de Servicio
CREATE TABLE Servicio (
    ServicioID INT NOT NULL AUTO_INCREMENT,
    Nombre VARCHAR(100) NOT NULL UNIQUE,
    Descripcion TEXT NOT NULL,
    ProductorID INT NOT NULL,  -- Relacionamos el servicio con el Productor
    PRIMARY KEY (ServicioID),
    FOREIGN KEY (ProductorID) REFERENCES Productores(ProductosID)
);

-- Tabla de Historial de Riego
CREATE TABLE HistorialRiego (
    HistorialID INT NOT NULL AUTO_INCREMENT,
    RiegoID INT,
    ParcelaID INT,
    FechaProgramada DATETIME NOT NULL,
    FechaEjecutada DATETIME,
    CantidadAgua DECIMAL(6,2) NOT NULL,
    Estado VARCHAR(20) CHECK (Estado IN ('Programado', 'Ejecutado', 'Cancelado')),
    PRIMARY KEY (HistorialID),
    FOREIGN KEY (RiegoID) REFERENCES Riego(RiegoID),
    FOREIGN KEY (ParcelaID) REFERENCES Parcelas(ParcelasID)
);

-- Tabla de Tratamientos
CREATE TABLE Tratamientos (
    TratamientoID INT NOT NULL AUTO_INCREMENT,
    PlagaID INT,
    CultivoID INT,
    NombreProducto VARCHAR(100) NOT NULL,
    Dosis DECIMAL(5,2),
    FechaAplicacion DATE NOT NULL,
    Estado VARCHAR(20) CHECK (Estado IN ('Pendiente', 'Aplicado')),
    PRIMARY KEY (TratamientoID),
    FOREIGN KEY (PlagaID) REFERENCES Plagas(PlagasID),
    FOREIGN KEY (CultivoID) REFERENCES Cultivos(CultivosID)
);

-- Tabla de Historial de Sensores
CREATE TABLE HistorialSensores (
    HSensoresID INT NOT NULL AUTO_INCREMENT,
    SensorID INT,
    ParcelaID INT,
    Evento VARCHAR(100) NOT NULL CHECK (Evento IN ('Instalado', 'Mantenimiento', 'Falla', 'Reemplazado')),
    FechaEvento DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    Descripcion TEXT,
    PRIMARY KEY (HSensoresID),
    FOREIGN KEY (SensorID) REFERENCES Sensores(SensoresID),
    FOREIGN KEY (ParcelaID) REFERENCES Parcelas(ParcelasID)
);

-- Tabla de Registro de Actividad de Usuarios
CREATE TABLE ActividadUsuarios (
    ActividadID INT NOT NULL AUTO_INCREMENT,
    UsuarioID INT,
    Accion VARCHAR(255) NOT NULL,
    FechaHora DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    Descripcion TEXT,
    PRIMARY KEY (ActividadID),
    FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID)
);

-- Tabla de Pagos (relacionado con Productores)
CREATE TABLE Pagos (
    PagoID INT NOT NULL AUTO_INCREMENT,
    ProductorID INT NOT NULL,  -- Relacionamos el pago con el Productor
    FechaPago DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    Monto DECIMAL(10,2) NOT NULL,
    Estado VARCHAR(20) CHECK (Estado IN ('Pendiente', 'Pagado', 'Vencido')) NOT NULL,
    PRIMARY KEY (PagoID),
    FOREIGN KEY (ProductorID) REFERENCES Productores(ProductosID)
);select * from Sensores; select * from Productores;
-- Tabla de Movimientos
CREATE TABLE Movimientos (
    MovimientoID INT NOT NULL AUTO_INCREMENT,
    UsuarioID INT,
    ParcelaID INT,
    TipoMovimiento VARCHAR(50) NOT NULL CHECK (TipoMovimiento IN ('Entrada', 'Salida', 'Transferencia', 'Aplicación')),
    Cantidad DECIMAL(10,2) NOT NULL CHECK (Cantidad > 0),
    FechaHora DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    Descripcion TEXT NOT NULL,
    PRIMARY KEY (MovimientoID),
    FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID),
    FOREIGN KEY (ParcelaID) REFERENCES Parcelas(ParcelasID)
);

-- Tabla de Relacion entre Plagas y Cultivos
CREATE TABLE Plagas_Cultivos (
    PlagaID INT,
    CultivoID INT,
    PRIMARY KEY (PlagaID, CultivoID),
    FOREIGN KEY (PlagaID) REFERENCES Plagas(PlagasID),
    FOREIGN KEY (CultivoID) REFERENCES Cultivos(CultivosID)
);

-- Insertar datos en la tabla Roles
INSERT INTO Roles (RolID, Nombre) VALUES
(1, 'Administrador'),
(2, 'Productor'),
(3, 'Técnico');

-- Insertar datos en la tabla Planes
INSERT INTO Planes (PlanID, Nombre, Descripcion, ProductorID) VALUES
(1, 'Básico', 'Plan con funcionalidades básicas de monitoreo.', 1),
(2, 'Profesional', 'Plan avanzado con análisis detallado y alertas.', 1),
(3, 'Premium', 'Plan completo con soporte 24/7 y asesoría personalizada.', 2);

-- Insertar datos en la tabla Usuarios
INSERT INTO Usuarios (Nombre, Correo, Contraseña, RolID, PlanID) VALUES
('Admin CultivaInt', 'admin@cultivaint.com', '$2y$10$YOUR_HASHED_PASSWORD_HERE', 1, 3), -- Reemplaza YOUR_HASHED_PASSWORD_HERE con el hash de una contraseña (ej: 'admin123')
('Juan Pérez', 'juan.perez@productor.com', '$2y$10$ANOTHER_HASHED_PASSWORD', 2, 2), -- Reemplaza ANOTHER_HASHED_PASSWORD
('María Rodríguez', 'maria.rodriguez@tecnico.com', '$2y$10$YET_ANOTHER_HASH', 3, 1); -- Reemplaza YET_ANOTHER_HASH

-- Insertar datos en la tabla Productores
INSERT INTO Productores (Nombre, Contacto, Ubicacion, UsuarioID) VALUES
('Finca La Esperanza', '555-1234', 'Carretera Principal Km 5', 2),
('AgroTech Solutions', '555-5678', 'Zona Industrial, Bodega 10', 3);

-- Insertar datos en la tabla Parcelas
INSERT INTO Parcelas (Ubicacion, TipoSuelo, ProductorID) VALUES
('Lote A', 'Franco arenoso', 5),
('Invernadero 1', 'Sustrato especial', 5),
('Campo Experimental', 'Arcilloso', 6);

-- Insertar datos en la tabla Sensores
INSERT INTO Sensores (Tipo, Ubicacion, ParcelaID) VALUES
('Humedad del suelo', 'Lote A, cerca de la bomba', 4),
('Temperatura del suelo', 'Invernadero 1, centro', 5),
('pH del suelo', 'Lote A, esquina noroeste', 6),
('Luminosidad', 'Invernadero 1, techo', 5);

-- Insertar datos en la tabla Cultivos
INSERT INTO Cultivos (Nombre, FechaSiembra, Estado, ProductorID, ParcelaID) VALUES
('Tomate', '2025-04-15', 'En crecimiento', 5, 4),
('Lechuga', '2025-03-20', 'Cosechada', 5, 5),
('Maíz', '2025-05-01', 'Siembra planificada', 6, 6);

-- Insertar datos en la tabla Lecturas de Sensores
INSERT INTO Lecturas (SensorID, Humedad, Temperatura, PH, Nutrientes) VALUES
(1, 65.20, 22.50, 6.30, 120.50),
(2, NULL, 28.15, NULL, NULL),
(3, 58.75, 21.90, 6.85, 115.20),
(4, NULL, NULL, NULL, 950.75);

-- Insertar datos en la tabla Riego
INSERT INTO Riego (ParcelaID, CantidadAgua, Estado) VALUES
(4, 50.00, 'Completado'),
(5, 30.50, 'Programado'),
(6, 75.00, 'Pendiente');

-- Insertar datos en la tabla Plagas
INSERT INTO Plagas (Nombre, CultivoID, FechaDeteccion, Estado) VALUES
('Pulgón', 1, '2025-05-10', 'Activo'),
('Mildiu', 2, '2025-04-05', 'Tratado');

-- Insertar datos en la tabla Alertas
INSERT INTO Alertas (Tipo, Descripcion, Estado, ProductorID, SensorID) VALUES
('Riego', 'Nivel de humedad bajo en Lote A.', 'Pendiente', 5, 1),
('Plaga', 'Detección de pulgón en cultivo de tomate.', 'Pendiente', 5, NULL),
('Sensor', 'Sensor de temperatura en Invernadero 1 reporta valores atípicos.', 'Resuelta', 6, 2);

-- Insertar datos en la tabla Configuracion del Sistema
INSERT INTO Configuracion (NombreParametro, Valor) VALUES
('Umbral_Humedad_Bajo', '40'),
('Umbral_Temperatura_Alto', '35');

-- Insertar datos en la tabla Servicio
INSERT INTO Servicio (Nombre, Descripcion, ProductorID) VALUES
('Análisis de suelo', 'Servicio de análisis de composición del suelo.', 5),
('Consultoría agronómica', 'Asesoramiento experto en manejo de cultivos.', 6);

-- Insertar datos en la tabla Historial de Riego
INSERT INTO HistorialRiego (RiegoID, ParcelaID, FechaProgramada, FechaEjecutada, CantidadAgua, Estado) VALUES
(1, 4, '2025-05-15 08:00:00', '2025-05-15 08:15:00', 50.00, 'Ejecutado'),
(NULL, 6, '2025-05-16 10:00:00', NULL, 30.50, 'Programado');

-- Insertar datos en la tabla Tratamientos
INSERT INTO Tratamientos (PlagaID, CultivoID, NombreProducto, Dosis, FechaAplicacion, Estado) VALUES
(1, 1, 'Insecticida X', 0.5, '2025-05-12', 'Aplicado'),
(2, 2, 'Fungicida Y', 1.0, '2025-04-07', 'Aplicado');

-- Insertar datos en la tabla Historial de Sensores
INSERT INTO HistorialSensores (SensorID, ParcelaID, Evento, FechaEvento, Descripcion) VALUES
(1, 4, 'Instalado', '2025-04-01 10:30:00', 'Sensor de humedad instalado en el lote A.'),
(2, 5, 'Mantenimiento', '2025-05-05 14:00:00', 'Se realizó calibración del sensor de temperatura.');

-- Insertar datos en la tabla ActividadUsuarios
INSERT INTO ActividadUsuarios (UsuarioID, Accion, Descripcion) VALUES
(2, 'Inicio de sesión', 'Usuario administrador inició sesión.'),
(3, 'Creación de cultivo', 'Usuario Juan Pérez creó el cultivo de tomate en Lote A.');

-- Insertar datos en la tabla Pagos
INSERT INTO Pagos (ProductorID, Monto, Estado) VALUES
(5, 49.00, 'Pagado'),
(6, 99.00, 'Pendiente');

-- Insertar datos en la tabla Movimientos
INSERT INTO Movimientos (UsuarioID, ParcelaID, TipoMovimiento, Cantidad, Descripcion) VALUES
(2, 1, 'Entrada', 100.00, 'Se ingresaron 100 plántulas de tomate.'),
(2, 2, 'Salida', 50.00, 'Se cosecharon 50 cabezas de lechuga.');

-- Insertar datos en la tabla Relacion entre Plagas y Cultivos
INSERT INTO Plagas_Cultivos (PlagaID, CultivoID) VALUES
(1, 1), -- Pulgón afecta al Tomate
(2, 2); -- Mildiu afecta a la Lechuga