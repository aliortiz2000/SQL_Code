--MODIFICAR TABLAS


ALTER TABLE producto ADD CONSTRAINT valores_unidad CHECK (unidad_medida IN ('KG', 'LT', 'GR', 'UNIDAD', 'MT'));

ALTER TABLE estatus ADD CONSTRAINT valores_estatus CHECK (estatus IN ('EN PROCESO', 'LISTO', 'ENTREGADO'));

ALTER TABLE efectivo ADD CONSTRAINT valores_efectivo CHECK (nombre_moneda IN ('BS', 'EUR', 'USD', 'CAD', 'AUS', 'YEN', 'LIB', 'PZ', 'PESOS CHILENOS', 'PESOS COLOMBIANOS', 'PESOS DOMINICANOS', 'PESOS MEXICANO', 'SOLES'));

ALTER TABLE pasillo ADD CONSTRAINT valores_pasillo CHECK (nro_pasillo IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12));

ALTER TABLE lugar ADD CONSTRAINT valores_tipo CHECK (tipo_lugar IN ('ESTADO', 'MUNICIPIO', 'PARROQUIA'));
