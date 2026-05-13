CREATE DATABASE IF NOT EXISTS tienda_ventas
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE tienda_ventas;

CREATE TABLE clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    correo VARCHAR(150) NOT NULL,
    telefono VARCHAR(30),
    direccion VARCHAR(200),
    comuna VARCHAR(100),
    ciudad VARCHAR(100),
    region VARCHAR(100),
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uq_clientes_correo UNIQUE (correo)
);

CREATE TABLE ventas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    fecha_venta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total INT NOT NULL,
    estado VARCHAR(30) NOT NULL DEFAULT 'REGISTRADA',

    CONSTRAINT fk_ventas_clientes
        FOREIGN KEY (cliente_id)
        REFERENCES clientes(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT chk_ventas_total CHECK (total >= 0),
    CONSTRAINT chk_ventas_estado CHECK (estado IN ('REGISTRADA', 'PAGADA', 'ANULADA'))
);

CREATE TABLE detalle_ventas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    venta_id INT NOT NULL,
    producto_id INT NOT NULL,
    nombre_producto VARCHAR(150) NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario INT NOT NULL,
    subtotal INT NOT NULL,

    CONSTRAINT fk_detalle_ventas_ventas
        FOREIGN KEY (venta_id)
        REFERENCES ventas(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT chk_detalle_cantidad CHECK (cantidad > 0),
    CONSTRAINT chk_detalle_precio CHECK (precio_unitario >= 0),
    CONSTRAINT chk_detalle_subtotal CHECK (subtotal >= 0)
);



INSERT INTO clientes 
(nombre, correo, telefono, direccion, comuna, ciudad, region) 
VALUES
('Camila Rojas', 'camila.rojas@email.com', '+56911112222', 'Av. Valparaíso 1234', 'Viña del Mar', 'Valparaíso', 'Región de Valparaíso'),
('Martín González', 'martin.gonzalez@email.com', '+56922223333', 'Los Carrera 456', 'Santiago Centro', 'Santiago', 'Región Metropolitana'),
('Valentina Soto', 'valentina.soto@email.com', '+56933334444', 'Uno Norte 789', 'Viña del Mar', 'Valparaíso', 'Región de Valparaíso'),
('Diego Morales', 'diego.morales@email.com', '+56944445555', 'Av. Alemania 321', 'Valparaíso', 'Valparaíso', 'Región de Valparaíso');

INSERT INTO ventas 
(cliente_id, total, estado) 
VALUES
(1, 119980, 'PAGADA'),
(2, 64990, 'PAGADA'),
(3, 149970, 'REGISTRADA'),
(4, 45990, 'PAGADA');

INSERT INTO detalle_ventas 
(venta_id, producto_id, nombre_producto, cantidad, precio_unitario, subtotal) 
VALUES
(1, 1, 'Producto 1', 2, 59990, 119980),
(2, 3, 'Producto 2', 1, 64990, 64990),
(3, 2, 'Producto 3', 3, 49990, 149970),
(4, 6, 'Producto 4', 1, 45990, 45990);

