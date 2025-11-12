#DML Para el Package Almacen.
DELETE FROM MovimientoAlmacen_X_Lote;
DELETE FROM Lote;
DELETE FROM MovimientoAlmacen;
DELETE FROM Almacen;
ALTER TABLE MovimientoAlmacen_X_Lote AUTO_INCREMENT=1;
ALTER TABLE Lote AUTO_INCREMENT=1;
ALTER TABLE MovimientoAlmacen AUTO_INCREMENT=1;
ALTER TABLE Almacen AUTO_INCREMENT=1;
INSERT INTO Almacen (nombre, ubicacion, stock, Tienda_idTienda, activo)
VALUES 
    -- 1. Depósito principal en piso alto (menor costo)
    ('Depósito Master 402', 'Galería Generales, 4to Piso, Puesto 402', 5120, 1, 1),
    
    -- 2. Almacén de Jean en el sótano de una galería clave
    ('Almacén Jean Sotano', 'Galería Plaza Horizonte (Jean), Sótano 1, Local C12', 3800, 1, 1),
    
    -- 3. Puesto de reserva en el mismo piso de la tienda principal
    ('Puesto Reserva 103A', 'Galería Guizado, 1er Piso, Pasillo Trasero 103A', 1550, 1, 1),
    
    -- 4. Almacén externo para grandes volúmenes (fuera de Gamarra)
    ('Local Auxiliar Bazo', 'Jr. Antonio Bazo 980, Cochera #5 (Volumen de tela)', 6750, 1, 1),
    
    -- 5. Depósito para artículos con baja rotación
    ('Stock Antiguo 505', 'Galería Santa Lucía, 5to Piso, Oficina 505', 2990, 1, 1);
    
    -- *******************************************************************
-- 8 MOVIMIENTOS PARA EL ALMACÉN ID 1 (Depósito Master 402)
-- *******************************************************************
INSERT INTO MovimientoAlmacen (Almacen_idAlmacen, fecha, lugarDestino, lugarOrigen, tipo, activo) VALUES 
(1, '2025-11-05 10:00:00', 'Depósito Master 402', 'Proveedor de Telas A', 'Entrada', 1),
(1, '2025-11-05 14:30:00', 'Depósito Master 402', 'Taller de Confección Z', 'Entrada', 1),
(1, '2025-11-06 09:15:00', 'Depósito Master 402', 'Tienda Principal 1', 'Entrada', 1),
(1, '2025-11-06 16:45:00', 'Depósito Master 402', 'Proveedor Accesorios B', 'Entrada', 1),
(1, '2025-11-07 11:30:00', 'Tienda Principal 1', 'Depósito Master 402', 'Salida', 1),
(1, '2025-11-07 17:00:00', 'Tienda Principal 1', 'Depósito Master 402', 'Salida', 1),
(1, '2025-11-08 10:45:00', 'Stock Antiguo 505', 'Depósito Master 402', 'Mov_Interno', 1),
(1, '2025-11-08 15:20:00', 'Local Auxiliar Bazo', 'Depósito Master 402', 'Mov_Interno', 1);

-- *******************************************************************
-- 8 MOVIMIENTOS PARA EL ALMACÉN ID 2 (Almacén Jean Sotano)
-- *******************************************************************
INSERT INTO MovimientoAlmacen (Almacen_idAlmacen, fecha, lugarDestino, lugarOrigen, tipo, activo) VALUES 
(2, '2025-11-05 11:00:00', 'Almacén Jean Sotano', 'Fábrica de Jeans', 'Entrada', 1),
(2, '2025-11-05 15:30:00', 'Almacén Jean Sotano', 'Proveedor Botones C', 'Entrada', 1),
(2, '2025-11-06 10:00:00', 'Almacén Jean Sotano', 'Tienda Principal 1', 'Entrada', 1),
(2, '2025-11-06 17:00:00', 'Almacén Jean Sotano', 'Proveedor Cierres D', 'Entrada', 1),
(2, '2025-11-07 12:45:00', 'Tienda Principal 1', 'Almacén Jean Sotano', 'Salida', 1),
(2, '2025-11-07 18:00:00', 'Tienda Principal 1', 'Almacén Jean Sotano', 'Salida', 1),
(2, '2025-11-08 11:10:00', 'Depósito Master 402', 'Almacén Jean Sotano', 'Mov_Interno', 1),
(2, '2025-11-08 16:00:00', 'Puesto Reserva 103A', 'Almacén Jean Sotano', 'Mov_Interno', 1);

-- *******************************************************************
-- 8 MOVIMIENTOS PARA EL ALMACÉN ID 3 (Puesto Reserva 103A)
-- *******************************************************************
INSERT INTO MovimientoAlmacen (Almacen_idAlmacen, fecha, lugarDestino, lugarOrigen, tipo, activo) VALUES 
(3, '2025-11-05 12:15:00', 'Puesto Reserva 103A', 'Proveedor de Polos E', 'Entrada', 1),
(3, '2025-11-05 16:30:00', 'Puesto Reserva 103A', 'Taller de Estampados', 'Entrada', 1),
(3, '2025-11-06 11:30:00', 'Puesto Reserva 103A', 'Tienda Principal 1', 'Entrada', 1),
(3, '2025-11-06 18:15:00', 'Puesto Reserva 103A', 'Proveedor Algodón F', 'Entrada', 1),
(3, '2025-11-07 13:00:00', 'Tienda Principal 1', 'Puesto Reserva 103A', 'Salida', 1),
(3, '2025-11-07 19:00:00', 'Tienda Principal 1', 'Puesto Reserva 103A', 'Salida', 1),
(3, '2025-11-08 12:00:00', 'Local Auxiliar Bazo', 'Puesto Reserva 103A', 'Mov_Interno', 1),
(3, '2025-11-08 17:15:00', 'Almacén Jean Sotano', 'Puesto Reserva 103A', 'Mov_Interno', 1);

-- *******************************************************************
-- 8 MOVIMIENTOS PARA EL ALMACÉN ID 4 (Local Auxiliar Bazo)
-- *******************************************************************
INSERT INTO MovimientoAlmacen (Almacen_idAlmacen, fecha, lugarDestino, lugarOrigen, tipo, activo) VALUES 
(4, '2025-11-05 13:30:00', 'Local Auxiliar Bazo', 'Importador Ropa G', 'Entrada', 1),
(4, '2025-11-05 17:45:00', 'Local Auxiliar Bazo', 'Taller de Costura Gamarra', 'Entrada', 1),
(4, '2025-11-06 12:30:00', 'Local Auxiliar Bazo', 'Tienda Principal 1', 'Entrada', 1),
(4, '2025-11-06 19:00:00', 'Local Auxiliar Bazo', 'Proveedor Hilos H', 'Entrada', 1),
(4, '2025-11-07 14:15:00', 'Tienda Principal 1', 'Local Auxiliar Bazo', 'Salida', 1),
(4, '2025-11-07 20:00:00', 'Tienda Principal 1', 'Local Auxiliar Bazo', 'Salida', 1),
(4, '2025-11-08 13:00:00', 'Puesto Reserva 103A', 'Local Auxiliar Bazo', 'Mov_Interno', 1),
(4, '2025-11-08 18:00:00', 'Depósito Master 402', 'Local Auxiliar Bazo', 'Mov_Interno', 1);

-- *******************************************************************
-- 8 MOVIMIENTOS PARA EL ALMACÉN ID 5 (Stock Antiguo 505)
-- *******************************************************************
INSERT INTO MovimientoAlmacen (Almacen_idAlmacen, fecha, lugarDestino, lugarOrigen, tipo, activo) VALUES 
(5, '2025-11-05 14:00:00', 'Stock Antiguo 505', 'Proveedor Lanas I', 'Entrada', 1),
(5, '2025-11-05 18:30:00', 'Stock Antiguo 505', 'Taller de Tejidos', 'Entrada', 1),
(5, '2025-11-06 13:45:00', 'Stock Antiguo 505', 'Tienda Principal 1', 'Entrada', 1),
(5, '2025-11-06 20:15:00', 'Stock Antiguo 505', 'Proveedor Etiquetas J', 'Entrada', 1),
(5, '2025-11-07 15:30:00', 'Tienda Principal 1', 'Stock Antiguo 505', 'Salida', 1),
(5, '2025-11-07 21:00:00', 'Tienda Principal 1', 'Stock Antiguo 505', 'Salida', 1),
(5, '2025-11-08 14:00:00', 'Almacén Jean Sotano', 'Stock Antiguo 505', 'Mov_Interno', 1),
(5, '2025-11-08 19:00:00', 'Depósito Master 402', 'Stock Antiguo 505', 'Mov_Interno', 1);

-- DATOS PARA LOS LOTES
INSERT INTO Lote (Almacen_idAlmacen, activo, descripcion) VALUES 
    -- *****************************************************
    -- Lotes para Almacen ID 1 (Depósito Master 402)
    -- *****************************************************
    (1, 1, 'Polos Algodón Jersey Cuello Redondo - Colores Básicos'),
    (1, 1, 'Pantalones Drill Slim Fit (Producción Nacional)'),
    (1, 1, 'Blusas Gasa Estampada - Tallas S y M (Liquidación)'),
    (1, 1, 'Casacas Denim Temporada Otoño-Invierno'),
    (1, 1, 'Ropa Interior y Medias x Mayor (Caja 1000 und.)'),
    (1, 1, 'Hilos de Coser y Material de Avío (Botones, Cierres)'),
    (1, 1, 'Vestidos de Noche (Inventario de Exhibición)'),
    (1, 1, 'Muestras y Patrones Textiles (Desarrollo Producto)');

INSERT INTO Lote (Almacen_idAlmacen, activo, descripcion) VALUES 
    -- *****************************************************
    -- Lotes para Almacen ID 2 (Almacén Jean Sotano)
    -- *****************************************************
    (2, 1, 'Jeans Skinny Mujer (Lycra T-32, T-34)'),
    (2, 1, 'Faldas y Shorts de Mezclilla Desgastados (Stock Nuevo)'),
    (2, 1, 'Telas de Gabardina y Twill (Rollos Completos)'),
    (2, 1, 'Ropa Deportiva: Leggings y Tops (Stock Importado)'),
    (2, 1, 'Polerones con Capucha (Franela Gruesa)'),
    (2, 1, 'Accesorios de Invierno (Gorros, Bufandas, Guantes)'),
    (2, 1, 'Overoles y Enterizos de Jean para Producción'),
    (2, 1, 'Saldos de Polos Publicitarios (Defectos Menores)');

INSERT INTO Lote (Almacen_idAlmacen, activo, descripcion) VALUES 
    -- *****************************************************
    -- Lotes para Almacen ID 3 (Puesto Reserva 103A)
    -- *****************************************************
    (3, 1, 'Reposición Rápida de Polos de Última Moda (Tallas S-L)'),
    (3, 1, 'Lote de Seguridad (Mercadería de Alto Valor)'),
    (3, 1, 'Etiquetas y Empaques de Marca (Bolsas, Cajas)'),
    (3, 1, 'Ternos y Ropa Formal (Solo Tallas Grandes)'),
    (3, 1, 'Pijamas y Ropa de Casa (Stock Infantil)'),
    (3, 1, 'Vestidos de Fiesta y Cóctel (Modelos Exclusivos)'),
    (3, 1, 'Zapatillas Urbanas y Sandalias (Inventario Verano)'),
    (3, 1, 'Blusas de Seda y Chiffon (Colores Pasteles)');

INSERT INTO Lote (Almacen_idAlmacen, activo, descripcion) VALUES 
    -- *****************************************************
    -- Lotes para Almacen ID 4 (Local Auxiliar Bazo)
    -- *****************************************************
    (4, 1, 'Stock Masivo de Polos Blancos para Estampar'),
    (4, 1, 'Rollos de Tela Cruda (Algodón Pima)'),
    (4, 1, 'Materiales de Limpieza y Mantenimiento del Local'),
    (4, 1, 'Importación de Zapatos y Botines (Stock Enero)'),
    (4, 1, 'Buzos y Conjuntos Deportivos de Falla'),
    (4, 1, 'Mochilas y Carteras (Accesorios de Moda)'),
    (4, 1, 'Muestras Aprobadas de Proveedores Extranjeros'),
    (4, 1, 'Uniformes de Personal y Merchandising');

INSERT INTO Lote (Almacen_idAlmacen, activo, descripcion) VALUES 
    -- *****************************************************
    -- Lotes para Almacen ID 5 (Stock Antiguo 505)
    -- *****************************************************
    (5, 1, 'Stock Rezago de la Colección 2023 (Próxima Venta Garage)'),
    (5, 1, 'Prendas con Pequeños Daños de Almacén (Para Retrabajo)'),
    (5, 1, 'Lanas y Hilos para Tejido (Stock de Temporada Fría)'),
    (5, 1, 'Exhibidores y Maniquíes Desmontados'),
    (5, 1, 'Lote de Artículos para Devolución a Taller'),
    (5, 1, 'Prendas Promocionales (Bajo Costo)'),
    (5, 1, 'Jeans y Pantalones con Corte Obsoleto (Liquidación Final)'),
    (5, 1, 'Artículos de Papelería y Oficina (Logística)');
    
-- *******************************************************************
-- 5. INSERCIÓN DE DATOS DE RELACIÓN (MovimientoAlmacen_X_Lote)
-- *******************************************************************
INSERT INTO MovimientoAlmacen_X_Lote 
    (Lote_idLote, MovimientoAlmacen_idMovAlmacen, MovimientoAlmacen_Almacen_idAlmacen, activo) 
VALUES
    -- ALMACÉN 1 (Movs 1-8)
    (1, 1, 1, 1), (2, 2, 1, 1), (3, 3, 1, 1), (4, 4, 1, 1), 
    (5, 5, 1, 1), (6, 6, 1, 1), (7, 7, 1, 1), (8, 8, 1, 1),
    
    -- ALMACÉN 2 (Movs 9-16)
    (9, 9, 2, 1), (10, 10, 2, 1), (11, 11, 2, 1), (12, 12, 2, 1), 
    (13, 13, 2, 1), (14, 14, 2, 1), (15, 15, 2, 1), (16, 16, 2, 1),
    
    -- ALMACÉN 3 (Movs 17-24)
    (17, 17, 3, 1), (18, 18, 3, 1), (19, 19, 3, 1), (20, 20, 3, 1), 
    (21, 21, 3, 1), (22, 22, 3, 1), (23, 23, 3, 1), (24, 24, 3, 1),
    
    -- ALMACÉN 4 (Movs 25-32)
    (25, 25, 4, 1), (26, 26, 4, 1), (27, 27, 4, 1), (28, 28, 4, 1), 
    (29, 29, 4, 1), (30, 30, 4, 1), (31, 31, 4, 1), (32, 32, 4, 1),
    
    -- ALMACÉN 5 (Movs 33-40)
    (33, 33, 5, 1), (34, 34, 5, 1), (35, 35, 5, 1), (36, 36, 5, 1), 
    (37, 37, 5, 1), (38, 38, 5, 1), (39, 39, 5, 1), (40, 40, 5, 1);