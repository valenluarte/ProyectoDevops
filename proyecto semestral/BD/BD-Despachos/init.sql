CREATE DATABASE IF NOT EXISTS tienda_despachos
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE tienda_despachos;


CREATE TABLE despachos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    venta_id INT NOT NULL,
    direccion VARCHAR(200) NOT NULL,
    comuna VARCHAR(100) NOT NULL,
    ciudad VARCHAR(100) NOT NULL,
    region VARCHAR(100) NOT NULL,
    estado VARCHAR(50) NOT NULL DEFAULT 'PENDIENTE',
    fecha_despacho TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_despachos_ventas
        FOREIGN KEY (venta_id)
        REFERENCES ventas(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT uq_despachos_venta UNIQUE (venta_id),

    CONSTRAINT chk_despachos_estado
        CHECK (estado IN ('PENDIENTE', 'EN_PREPARACION', 'EN_CAMINO', 'ENTREGADO', 'CANCELADO'))
);

INSERT INTO despachos 
(venta_id, direccion, comuna, ciudad, region, estado) 
VALUES
(1, 'Av. Valparaíso 1234', 'Viña del Mar', 'Valparaíso', 'Región de Valparaíso', 'EN_PREPARACION'),
(2, 'Los Carrera 456', 'Santiago Centro', 'Santiago', 'Región Metropolitana', 'PENDIENTE'),
(4, 'Av. Alemania 321', 'Valparaíso', 'Valparaíso', 'Región de Valparaíso', 'EN_CAMINO');

