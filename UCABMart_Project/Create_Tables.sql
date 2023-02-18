--CREAR TABLAS


SELECT SYSDATETIMEOFFSET() AT TIME ZONE'Venezuela Standard Time';
SET DATEFORMAT dmy;




--Tabla Sede
CREATE TABLE sede(
	id_sede			numeric(3)	NOT NULL,
	nombre_sede		varchar(50)	NOT NULL,
	fechai_sede		date		NOT NULL,
	fechaf_sede		date,
	CONSTRAINT		pk_sede				PRIMARY KEY (id_sede)
);

CREATE SEQUENCE sq_sede
increment by 1
start with 1;




--Tabla Lugar
CREATE TABLE lugar(
	id_lugar		numeric(4)	NOT NULL,
	tipo_lugar		varchar(10)	NOT NULL,
	nombre_lugar		varchar(50)	NOT NULL,
	cod_padre_lugar		numeric(4),
	cod_sede_lugar		numeric(3),
	CONSTRAINT		fk_padre_lugar			FOREIGN KEY	(cod_padre_lugar)		REFERENCES	lugar (id_lugar),
	CONSTRAINT		fk_sede_lugar			FOREIGN KEY	(cod_sede_lugar)		REFERENCES	sede (id_sede),
	CONSTRAINT		pk_lugar			PRIMARY KEY	(id_lugar)
);

CREATE SEQUENCE sq_lugar
increment by 1
start with 1;




--Tabla Personal
CREATE TABLE personal(
	id_personal		numeric(3)	NOT NULL,
	ci			varchar(12)	NOT NULL,
	nombre1_personal	varchar(15)	NOT NULL,
	nombre2_personal	varchar(15),
	apellido1_personal	varchar(15)	NOT NULL,
	apellido2_personal	varchar(15),
	cod_sede_personal	numeric(3)	NOT NULL,
	CONSTRAINT		fk_sede_personal		FOREIGN KEY	(cod_sede_personal)		REFERENCES	sede (id_sede),
	CONSTRAINT 		pk_personal			PRIMARY KEY (id_personal)
);

CREATE SEQUENCE sq_personal
increment by 1
start with 1;




--Tabla Vacacion 
CREATE TABLE vacacion(
	id_vacacion		numeric(3)	NOT NULL,
	fechai_vacacion		date		NOT NULL,
	fechaf_vacacion		date		NOT NULL,
	cod_personal_vacacion	numeric(3)	NOT NULL,
	CONSTRAINT		fk_personal_vacacion		FOREIGN KEY	(cod_personal_vacacion)		REFERENCES	personal (id_personal),
	CONSTRAINT		pk_vacacion			PRIMARY KEY	(id_vacacion, cod_personal_vacacion)
);

CREATE SEQUENCE sq_vacacion
increment by 1
start with 1;




--Tabla Horario
CREATE TABLE horario(
	id_horario		numeric(3)	NOT NULL,
	fecha 			date		NOT NULL,
	horai			datetime2	NOT NULL,
	horaf			datetime2	NOT NULL,
	CONSTRAINT		pk_horario			PRIMARY KEY	(id_horario)
);

CREATE SEQUENCE sq_horario
increment by 1
start with 1;




--Tabla Personal_Horario 
CREATE TABLE personal_horario(
	cod_personal_ph		numeric(3)	NOT NULL,
	cod_horario_ph		numeric(3)	NOT NULL,
	asistencia		bit,
	horai_asistencia	datetime2,
	horaf_asistencia	datetime2,
	CONSTRAINT		fk_personal_ph			FOREIGN KEY	(cod_personal_ph)		REFERENCES	personal (id_personal),
	CONSTRAINT		fk_horario_ph			FOREIGN KEY	(cod_horario_ph)		REFERENCES	horario (id_horario),
	CONSTRAINT		pk_personal_horario		PRIMARY KEY 	(cod_personal_ph, cod_horario_ph)
);




--Tabla Beneficio
CREATE TABLE beneficio(
	id_beneficio		numeric(3)	NOT NULL,
	nombre_beneficio	varchar(20)	NOT NULL,
	descripcion_beneficio	varchar(150)	NOT NULL,
	CONSTRAINT		pk_beneficio			PRIMARY KEY	(id_beneficio)
);

CREATE SEQUENCE sq_beneficio
increment by 1
start with 1;




--Tabla Personal_Beneficio 
CREATE TABLE personal_beneficio(
	cod_personal_pb		numeric(3)	NOT NULL,
	cod_beneficio_pb	numeric(3)	NOT NULL,
	CONSTRAINT		fk_personal_pb			FOREIGN KEY	(cod_personal_pb)		REFERENCES	personal (id_personal),
	CONSTRAINT		fk_beneficio_pb			FOREIGN KEY	(cod_beneficio_pb)		REFERENCES	beneficio (id_beneficio),
	CONSTRAINT		pk_personal_beneficio		PRIMARY KEY 	(cod_personal_pb, cod_beneficio_pb)
);




--Tabla Proveedor
CREATE TABLE proveedor(
	id_proveedor		numeric(3)	NOT NULL,
	razons_proveedor	varchar(50)	NOT NULL,
	denominacionc_proveedor	varchar(50)	NOT NULL,
	rif_proveedor		varchar(12)	NOT NULL,
	pagweb_proveedor	varchar(50)	NOT NULL,
	CONSTRAINT		pk_proveedor			PRIMARY KEY	(id_proveedor)
);

CREATE SEQUENCE sq_proveedor
increment by 1
start with 1;




--Tabla Rubro
CREATE TABLE rubro(
	id_rubro		numeric(3)	NOT NULL,
	tipo_rubro		varchar(25)	NOT NULL,
	descripcion_rubro	varchar(100)	NOT NULL,
	CONSTRAINT		pk_rubro			PRIMARY KEY	(id_rubro)
);

CREATE SEQUENCE sq_rubro
increment by 1
start with 1;




--Tabla Proveedor_Rubro
CREATE TABLE proveedor_rubro(
	cod_proveedor_pr	numeric(3)	NOT NULL,
	cod_rubro_pr		numeric(3)	NOT NULL,
	CONSTRAINT		fk_proveedor_pr			FOREIGN KEY	(cod_proveedor_pr)		REFERENCES	proveedor (id_proveedor),
	CONSTRAINT		fk_rubro_pr			FOREIGN KEY	(cod_rubro_pr)			REFERENCES	rubro (id_rubro),
	CONSTRAINT		pk_proveedor_rubro		PRIMARY KEY 	(cod_proveedor_pr, cod_rubro_pr)
);




--Tabla Producto
CREATE TABLE producto(
	id_producto		numeric(3)	NOT NULL,
	nombre_producto		varchar(50)	NOT NULL,
	descripcion_producto	varchar(100)	NOT NULL,
	unidad_medida		varchar(10)	NOT NULL,
	cant_presentacion	numeric(3)	NOT NULL,
	imagen_producto		binary,
	CONSTRAINT		pk_producto			PRIMARY KEY 	(id_producto)
);

CREATE SEQUENCE sq_producto
increment by 1
start with 1;




--Tabla Clasificacion
CREATE TABLE clasificacion(
	id_clasificacion	numeric(3)	NOT NULL,
	clasificacion		varchar(20)	NOT NULL,
	descripcion_clasif	varchar(100)	NOT NULL,
	CONSTRAINT		pk_clsificacion			PRIMARY KEY	(id_clasificacion)
);

CREATE SEQUENCE sq_clasificacion
increment by 1
start with 1;




--Tabla Clasificacion_Producto 
CREATE TABLE clasificacion_producto(
	cod_clasificacion_cp	numeric(3)	NOT NULL,
	cod_producto_cp		numeric(3)	NOT NULL,
	CONSTRAINT		fk_clasificacion_cp		FOREIGN KEY	(cod_clasificacion_cp)		REFERENCES	clasificacion (id_clasificacion),
	CONSTRAINT		fk_producto_cp			FOREIGN KEY	(cod_producto_cp)		REFERENCES	producto (id_producto),
	CONSTRAINT		pk_clasificacion_producto	PRIMARY KEY 	(cod_clasificacion_cp, cod_producto_cp)
);




--Tabla Hist_Precio 
CREATE TABLE hist_precio(
	id_hist_precio		numeric(4)	NOT NULL,
	precio			numeric(12,2)	NOT NULL,
	fechai_precio		date		NOT NULL	DEFAULT	GETDATE(),
	fechaf_precio		date,
	cod_prodcuto_hprecio	numeric(3)	NOT NULL,
	CONSTRAINT		fk_producto_hp			FOREIGN KEY	(cod_prodcuto_hprecio)		REFERENCES	producto (id_producto),
	CONSTRAINT		pk_hist_precio			PRIMARY KEY 	(id_hist_precio, cod_prodcuto_hprecio)
);

CREATE SEQUENCE sq_hist_precio
increment by 1
start with 1;




--Tabla Promocion
CREATE TABLE promocion(
	id_promocion		numeric(3)	NOT NULL,
	descuento		numeric(4,3)	NOT NULL,
	CONSTRAINT		pk_promocion			PRIMARY KEY	(id_promocion)
);

CREATE SEQUENCE sq_promocion
increment by 1
start with 1;




--Tabla Promocion_Producto 
CREATE TABLE promocion_producto(
	cod_promocion_pp	numeric(3)	NOT NULL,
	cod_producto_pp		numeric(3)	NOT NULL,
	fechai_p		date		NOT NULL,
	fechaf_p		date,
	CONSTRAINT		fk_promocion_pp			FOREIGN KEY	(cod_promocion_pp)		REFERENCES	promocion (id_promocion),
	CONSTRAINT		fk_producto_pp			FOREIGN KEY	(cod_producto_pp)		REFERENCES	producto (id_producto),
	CONSTRAINT		pk_promocion_producto	PRIMARY KEY 	(cod_promocion_pp, cod_producto_pp)
);




--Tabla Proveedor_Producto 
CREATE TABLE proveedor_producto(
	cod_proveedor_provp	numeric(3)	NOT NULL,
	cod_producto_provp	numeric(3)	NOT NULL,
	cant_productop		numeric(9)	NOT NULL,
	CONSTRAINT		fk_proveedor_provp		FOREIGN KEY	(cod_proveedor_provp)		REFERENCES	proveedor (id_proveedor),
	CONSTRAINT		fk_producto_provp		FOREIGN KEY	(cod_producto_provp)		REFERENCES	producto (id_producto),
	CONSTRAINT		pk_proveedor_producto		PRIMARY KEY 	(cod_proveedor_provp, cod_producto_provp)
);




--Tabla Pasillo 
CREATE TABLE pasillo(
	id_pasillo		numeric(4)	NOT NULL,
	nro_pasillo		numeric(1)	NOT NULL,
	cant_producto_pasillo	numeric(3)	NOT NULL,
	cod_sede_pasillo	numeric(3)	NOT NULL,
	cod_producto_pasillo	numeric(3)	NOT NULL,
	CONSTRAINT		fk_sede_pasillo			FOREIGN KEY	(cod_sede_pasillo)		REFERENCES	sede (id_sede),
	CONSTRAINT		fk_producto_pasillo		FOREIGN KEY	(cod_producto_pasillo)		REFERENCES	producto (id_producto),
	CONSTRAINT		pk_pasillo			PRIMARY KEY 	(id_pasillo)
);

CREATE SEQUENCE sq_pasillo
increment by 1
start with 1;




--Tabla Sede_producto 
CREATE TABLE sede_producto(
	id_sede_producto	numeric(4)	NOT NULL,
	cod_sede_sp		numeric(3)	NOT NULL,
	cod_producto_sp		numeric(3)	NOT NULL,
	cant_producto_sede	numeric(6)	NOT NULL,
	CONSTRAINT		fk_sede_sp			FOREIGN KEY	(cod_sede_sp)			REFERENCES	sede (id_sede),
	CONSTRAINT		fk_producto_sp			FOREIGN KEY	(cod_producto_sp)		REFERENCES	producto (id_producto),
	CONSTRAINT		pk_sede_producto		PRIMARY KEY 	(id_sede_producto)
);

CREATE SEQUENCE sq_sede_producto
increment by 1
start with 1;




--Tabla Hist_movimiento 
CREATE TABLE hist_movimiento(
	hist_mov		numeric(4)	NOT NULL,
	fecha_mov		date		NOT NULL	DEFAULT	GETDATE(),
	ingreso_egreso		char		NOT NULL,
	cant_p			numeric(8)	NOT NULL,
	cod_sede_producto_hm	numeric(4),
	cod_pasillo_hm		numeric(4),
	CONSTRAINT		fk_sede_producto		FOREIGN KEY	(cod_sede_producto_hm)		REFERENCES	sede_producto (id_sede_producto),
	CONSTRAINT		fk_pasillo			FOREIGN KEY	(cod_pasillo_hm)		REFERENCES	pasillo (id_pasillo),
	CONSTRAINT		pk_hist_movimiento		PRIMARY KEY	(hist_mov)
);

CREATE SEQUENCE sq_hist_movimiento
increment by 1
start with 1;




--Tabla Cliente
CREATE TABLE cliente(
	id_cliente		numeric(8)	NOT NULL,
	rif_cliente		varchar(12)	NOT NULL,
	cant_puntos		numeric(4)	NOT NULL,
	CONSTRAINT		pk_cliente			PRIMARY KEY 	(id_cliente)
);

CREATE SEQUENCE sq_cliente
increment by 1
start with 1;




--Tabla Juridico 
CREATE TABLE c_juridico(
	cod_clientej		numeric(8)	NOT NULL,
	denominacionc_juridico	varchar(50)	NOT NULL,
	razons_juridico		varchar(50)	NOT NULL,
	pagweb_juridico		varchar(50)	NOT NULL,
	capital			numeric(12,2)	NOT NULL,
	cod_fiscal_lugar	numeric(4)	NOT NULL,
	cod_fisico_lugar	numeric(4)	NOT NULL,
	CONSTRAINT		fk_cliente_juridico		FOREIGN KEY	(cod_clientej)			REFERENCES	cliente (id_cliente),
	CONSTRAINT		fk_fiscal_lugar			FOREIGN KEY	(cod_fiscal_lugar)		REFERENCES	lugar (id_lugar),
	CONSTRAINT		fk_fisico_lugar			FOREIGN KEY	(cod_fisico_lugar)		REFERENCES	lugar (id_lugar),
	CONSTRAINT		pk_juridico			PRIMARY KEY	(cod_clientej)
);




--Tabla Natural 
CREATE TABLE c_natural(
	cod_clienten		numeric(8)	NOT NULL,
	cedula_natural		varchar(12)	NOT NULL,
	nombre1_natural		varchar(15)	NOT NULL,
	nombre2_natural		varchar(15),
	apellido1_natural	varchar(15)	NOT NULL,
	apellido2_natural	varchar(15),
	cod_habitacion_lugar	numeric(4)	NOT NULL,
	CONSTRAINT		fk_cliente_natural		FOREIGN KEY	(cod_clienten)			REFERENCES	cliente (id_cliente),
	CONSTRAINT		fk_habitacion_lugar		FOREIGN KEY	(cod_habitacion_lugar)		REFERENCES	lugar (id_lugar),
	CONSTRAINT		pk_natural			PRIMARY KEY	(cod_clienten)
);




--Tabla Hist_puntos 
CREATE TABLE hist_puntos(
	id_hist_puntos		numeric(4)	NOT NULL,
	fecha_canjeo		date		NOT NULL	DEFAULT	GETDATE(),
	cod_clientehp 		numeric(8)	NOT NULL,
	CONSTRAINT		fk_cliente_hpuntos		FOREIGN KEY	(cod_clientehp)			REFERENCES	cliente (id_cliente),
	CONSTRAINT		pk_hist_puntos			PRIMARY KEY	(id_hist_puntos)
);

CREATE SEQUENCE sq_hist_puntos
increment by 1
start with 1;




--Tabla Registro 
CREATE TABLE registro(
	cod_cliente_registro	numeric(8)	NOT NULL,
	cod_sede_registro	numeric(3)	NOT NULL,
	cod_qr			binary,
	fecha_registro		date		NOT NULL	DEFAULT	GETDATE(),
	fecha_salida		date,
	CONSTRAINT 		fk_cliente_registro		FOREIGN KEY	(cod_cliente_registro)		REFERENCES	cliente (id_cliente),
	CONSTRAINT 		fk_sede_registro		FOREIGN KEY	(cod_sede_registro)		REFERENCES	sede (id_sede),
	CONSTRAINT		pk_registro			PRIMARY KEY	(cod_cliente_registro, cod_sede_registro)
);




--Tabla Persona_Contacto
CREATE TABLE persona_contacto(
	id_contacto		numeric(3)	NOT NULL,
	cedula_contacto		varchar(12)	NOT NULL,
	nombre1_contacto	varchar(15)	NOT NULL,
	nombre2_contacto	varchar(15),
	apellido1_contacto	varchar(15)	NOT NULL,
	apellido2_contacto	varchar(15),
	cod_proveedor_contacto	numeric(3),
	cod_juridico_contacto	numeric(8),
	CONSTRAINT		fk_proveedor_contacto		FOREIGN KEY	(cod_proveedor_contacto)	REFERENCES	proveedor (id_proveedor),
	CONSTRAINT		fk_juridico_contacto		FOREIGN KEY	(cod_juridico_contacto)		REFERENCES	c_juridico (cod_clientej),
	CONSTRAINT		pk_persona_cliente		PRIMARY KEY	(id_contacto)
);

CREATE SEQUENCE sq_contacto
increment by 1
start with 1;




--Tabla Telefono
CREATE TABLE telefono(
	id_tlf			numeric(4)	NOT NULL,	
	codigo_int		numeric(3)	NOT NULL,
	codigo_local		numeric(4)	NOT NULL,
	nro_tlf			numeric(7)	NOT NULL,
	cod_proveedor_tlf	numeric(3),
	cod_sede_tlf		numeric(3),
	cod_cliente_tlf		numeric(8),
	cod_contacto_tlf	numeric(3),
	CONSTRAINT		fk_proveedor_tlf		FOREIGN KEY	(cod_proveedor_tlf)		REFERENCES	proveedor (id_proveedor),
	CONSTRAINT		fk_sede_tlf			FOREIGN KEY	(cod_sede_tlf)			REFERENCES	sede (id_sede),
	CONSTRAINT		fk_cliente_tlf			FOREIGN KEY	(cod_cliente_tlf)		REFERENCES	cliente (id_cliente),
	CONSTRAINT		fk_contacto_tlf			FOREIGN KEY	(cod_contacto_tlf)		REFERENCES	persona_contacto (id_contacto),
	CONSTRAINT		pk_telefono			PRIMARY KEY	(id_tlf)
);

CREATE SEQUENCE sq_tlf
increment by 1
start with 1;




--Tabla Correo
CREATE TABLE correo(
	id_correo		numeric(4) 	NOT NULL,
	dir_correo		varchar(50)	NOT NULL,
	cod_proveedor_correo	numeric(3),
	cod_sede_correo		numeric(3),
	cod_cliente_correo	numeric(8),
	cod_contacto_correo	numeric(3),
	CONSTRAINT		fk_proveedor_correo		FOREIGN KEY	(cod_proveedor_correo)		REFERENCES	proveedor (id_proveedor),
	CONSTRAINT		fk_sede_correo			FOREIGN KEY	(cod_sede_correo)		REFERENCES	sede (id_sede),
	CONSTRAINT		fk_cliente_correo		FOREIGN KEY	(cod_cliente_correo)		REFERENCES	cliente (id_cliente),
	CONSTRAINT		fk_contacto_correo		FOREIGN KEY	(cod_contacto_correo)		REFERENCES	persona_contacto (id_contacto),
	CONSTRAINT		pk_correo			PRIMARY KEY	(id_correo)
);

CREATE SEQUENCE sq_correo
increment by 1
start with 1;




--Tabla Compra
CREATE TABLE compra(
	id_compra		numeric(4)	NOT NULL,
	fecha_compra		date		NOT NULL	DEFAULT	GETDATE(),
	nro_factura		numeric(4)	NOT NULL,
	total_compra		numeric(12,2)	NOT NULL,
	tipo_compra		varchar(6)	NOT NULL,
	cod_sede_compra		numeric(3)	NOT NULL,
	cod_proveedor_compra	numeric(3),
	cod_cliente_compra	numeric(8),
	CONSTRAINT		fk_sede_compra			FOREIGN KEY 	(cod_sede_compra)		REFERENCES	sede (id_sede),
	CONSTRAINT		fk_proveedor_compra		FOREIGN KEY 	(cod_proveedor_compra)		REFERENCES	proveedor (id_proveedor),
	CONSTRAINT		fk_cliente_compra		FOREIGN KEY 	(cod_cliente_compra)		REFERENCES	cliente (id_cliente),
	CONSTRAINT		pk_compra			PRIMARY KEY	(id_compra)
);

CREATE SEQUENCE sq_compra
increment by 1
start with 1;




--Tabla Detalle_Compra 
CREATE TABLE detalle_compra(
	reglon			numeric(4)	NOT NULL,
	cant_producto		numeric(4)	NOT NULL,
	costo_producto		numeric(12,2)	NOT NULL,
	cod_compra_detalle	numeric(4)	NOT NULL,
	cod_producto_detalle	numeric(3)	NOT NULL,
	CONSTRAINT 		fk_compra_detalle		FOREIGN KEY	(cod_compra_detalle)		REFERENCES	compra (id_compra),
	CONSTRAINT 		fk_producto_detalle		FOREIGN KEY	(cod_producto_detalle)		REFERENCES	producto (id_producto),
	CONSTRAINT		pk_detalle_compra		PRIMARY KEY	(reglon, cod_compra_detalle)
);




--Tabla Estatus
CREATE TABLE estatus(
	id_estatus		numeric(1)	NOT NULL,
	estatus			varchar(10)	NOT NULL,
	CONSTRAINT		pk_estatus			PRIMARY KEY	(id_estatus)
);

CREATE SEQUENCE sq_estatus
increment by 1
start with 1;




--Tabla Estatus_Compra
CREATE TABLE estatus_compra(
	fecha_hora		datetime2	NOT NULL,
	cod_compra_ec		numeric(4)	NOT NULL,
	cod_estatus_ec		numeric(1)	NOT NULL,
	CONSTRAINT		fk_compra_ec			FOREIGN KEY	(cod_compra_ec)			REFERENCES	compra (id_compra),
	CONSTRAINT		fk_estatus_ec			FOREIGN KEY	(cod_estatus_ec)		REFERENCES	estatus (id_estatus),
	CONSTRAINT		pk_estatus_compra		PRIMARY KEY	(cod_compra_ec, cod_estatus_ec)
);




--Tabla Rol
CREATE TABLE rol(
	id_rol			numeric(3)	NOT NULL,
	nombre_rol		varchar(20)	NOT NULL,
	descripcion_rol		varchar(100)	NOT NULL,
	CONSTRAINT		pk_rol				PRIMARY KEY	(id_rol)
);

CREATE SEQUENCE sq_rol
increment by 1
start with 1;




--Tabla Usuario
CREATE TABLE usuario(
	id_usuario		numeric(4)	NOT NULL,
	usuario			varchar(20)	NOT NULL,
	contrasena		varchar(15)	NOT NULL,
	cod_cliente_usuario	numeric(8),
	cod_personal_usuario	numeric(3),
	cod_rol_usuario		numeric(3)	NOT NULL,
	CONSTRAINT		fk_cliente_usuario		FOREIGN KEY	(cod_cliente_usuario)		REFERENCES	cliente (id_cliente),
	CONSTRAINT		fk_personal_usuario		FOREIGN KEY	(cod_personal_usuario)		REFERENCES	personal (id_personal),
	CONSTRAINT		fk_rol_usuario			FOREIGN KEY	(cod_rol_usuario)		REFERENCES	rol (id_rol),
	CONSTRAINT		pk_usuario			PRIMARY KEY	(id_usuario)
);

CREATE SEQUENCE sq_usuario
increment by 1
start with 1;




--Tabla Privilegio
CREATE TABLE privilegio(
	id_privilegio		numeric(3)	NOT NULL,
	nombre_privilegio	varchar(15)	NOT NULL,
	descripcion_privilegio	varchar(100)	NOT NULL,
	CONSTRAINT		pk_privilegio			PRIMARY KEY	(id_privilegio)
);

CREATE SEQUENCE sq_privilegio
increment by 1
start with 1;




--Tabla Privilegio_Rol 
CREATE TABLE privilegio_rol(
	cod_privilegio_prol	numeric(3)	NOT NULL,
	cod_rol_prol		numeric(3)	NOT NULL,
	CONSTRAINT		fk_privilegio_prol			FOREIGN KEY	(cod_privilegio_prol)		REFERENCES	privilegio (id_privilegio),
	CONSTRAINT		fk_rol_prol				FOREIGN KEY	(cod_rol_prol)			REFERENCES	rol (id_rol),
	CONSTRAINT		pk_privilegio_rol			PRIMARY KEY 	(cod_privilegio_prol, cod_rol_prol)
);




--Tabla Modo_Pago
CREATE TABLE modo_pago(
	id_modo_pago		numeric(4)	NOT NULL,
	cod_cliente_modo	numeric(8)	NOT NULL,
	tipo_mp			varchar(15)	NOT NULL,
	CONSTRAINT		fk_cliente_modo				FOREIGN KEY	(cod_cliente_modo)		REFERENCES 	cliente (id_cliente),
	CONSTRAINT		pk_modo_pago				PRIMARY KEY	(id_modo_pago)
);

CREATE SEQUENCE sq_modo_pago
increment by 1
start with 1;




--Tabla TarjetaC 
CREATE TABLE tarjetac(
	cod_modo_tc		numeric(4)	NOT NULL,
	nro_tarjetac		numeric(16),
	bancotc			varchar(50),
	nro_seguridad		numeric(3),
	CONSTRAINT		fk_modo_tc				FOREIGN KEY	(cod_modo_tc)			REFERENCES	modo_pago (id_modo_pago),
	CONSTRAINT		pk_tarjetac				PRIMARY KEY 	(cod_modo_tc)
);

--Tabla TarjetaD 		
CREATE TABLE tarjetad(
	cod_modo_td		numeric(4)	NOT NULL,
	nro_tarjetad		numeric(16),
	bancotd			varchar(50),
	CONSTRAINT		fk_modo_td				FOREIGN KEY	(cod_modo_td)			REFERENCES	modo_pago (id_modo_pago),
	CONSTRAINT		pk_tarjetad				PRIMARY KEY 	(cod_modo_td)	
);

--Tabla Cheque 
CREATE TABLE cheque(
	cod_modo_c		numeric(4)	NOT NULL,
	bancotd			varchar(50),
	CONSTRAINT		fk_modo_c				FOREIGN KEY	(cod_modo_c)			REFERENCES	modo_pago (id_modo_pago),
	CONSTRAINT		pk_cheque				PRIMARY KEY 	(cod_modo_c)	
);

--Tabla Punto 
CREATE TABLE punto(
	cod_modo_p		numeric(4)	NOT NULL,
	CONSTRAINT		fk_modo_p				FOREIGN KEY	(cod_modo_p)			REFERENCES	modo_pago (id_modo_pago),
	CONSTRAINT		pk_punto				PRIMARY KEY 	(cod_modo_p)	
);

--Tabla Efectivo (DEBIL)
CREATE TABLE efectivo(
	cod_modo_e		numeric(4)	NOT NULL,
	nombre_moneda		varchar(15)	NOT NULL,
	CONSTRAINT		fk_modo_e				FOREIGN KEY	(cod_modo_e)			REFERENCES	modo_pago (id_modo_pago),
	CONSTRAINT		pk_efectivo				PRIMARY KEY 	(cod_modo_e)	

);




--Tabla Compra_ModoPago (DEBIL)
CREATE TABLE compra_modopago(
	fecha_pago		date		NOT NULL	DEFAULT	GETDATE(),
	cant_pago		numeric(12,2)	NOT NULL,
	cod_compra_cp		numeric(4)	NOT NULL,
	cod_modo_cp		numeric(4)	NOT NULL,
	CONSTRAINT		fk_compra_cp				FOREIGN KEY	(cod_compra_cp)			REFERENCES	compra (id_compra),
	CONSTRAINT		fk_modo_cp				FOREIGN KEY	(cod_modo_cp)			REFERENCES	modo_pago (id_modo_pago),
	CONSTRAINT		pk_compra_modo				PRIMARY KEY	(cod_compra_cp, cod_modo_cp)
);
