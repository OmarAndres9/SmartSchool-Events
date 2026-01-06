-- Init Script for PostgreSQL

-- Crear Tablas

CREATE TABLE "eventos" (
  "Codigo_Event" varchar(10) NOT NULL PRIMARY KEY,
  "Tipo_Event" varchar(25) NOT NULL,
  "Fecha_ingre" date NOT NULL,
  "Hora" time NOT NULL,
  "Fecha_Final" timestamp NOT NULL,
  "Lugar_Event" varchar(35) NOT NULL,
  "Modalidad" varchar(20) NOT NULL,
  "Descrp_Event" varchar(50) NOT NULL,
  "Objetiv_Event" varchar(50) NOT NULL,
  "Control_Person" varchar(13) NOT NULL,
  "Nomb_Event" varchar(35) NOT NULL,
  "Grupo_Destinad" varchar(20) NOT NULL
);

CREATE TABLE "agenda_escolar" (
  "Codigo_Agend" varchar(10) NOT NULL PRIMARY KEY,
  "Codigo_Event" varchar(10) NOT NULL,
  "Titulo" varchar(25) NOT NULL,
  "Fecha" timestamp NOT NULL,
  CONSTRAINT "agenda_escolar_ibfk_1" FOREIGN KEY ("Codigo_Event") REFERENCES "eventos" ("Codigo_Event") ON DELETE CASCADE
);

CREATE TABLE "recurso_logistica" (
  "Codigo_Recurs" varchar(10) NOT NULL PRIMARY KEY,
  "Nomb_Recurs" varchar(25) NOT NULL,
  "Tipo_Recurs" varchar(15) NOT NULL,
  "Ubicacion" varchar(40) NOT NULL,
  "Estado" varchar(20) NOT NULL,
  "Fecha_Entreg" timestamp NOT NULL,
  "Fecha_Devoluc" timestamp NOT NULL
);

CREATE TABLE "evento_recursos" (
  "Codigo_Event" varchar(10) NOT NULL,
  "Codigo_Recurs" varchar(10) NOT NULL,
  PRIMARY KEY ("Codigo_Event", "Codigo_Recurs"),
  CONSTRAINT "evento_recursos_ibfk_1" FOREIGN KEY ("Codigo_Event") REFERENCES "eventos" ("Codigo_Event") ON DELETE CASCADE,
  CONSTRAINT "evento_recursos_ibfk_2" FOREIGN KEY ("Codigo_Recurs") REFERENCES "recurso_logistica" ("Codigo_Recurs") ON DELETE CASCADE
);

CREATE TABLE "notificaciones" (
  "Codigo_Notifi" varchar(10) NOT NULL PRIMARY KEY,
  "Codigo_Event" varchar(10) NOT NULL,
  "Tipo_Notifi" varchar(15) NOT NULL,
  "Canal_Envio" varchar(25) NOT NULL,
  "Mensaje" text NOT NULL,
  "Fecha_Crea" timestamp NOT NULL,
  "Titulo" varchar(30) NOT NULL,
  CONSTRAINT "notificaciones_ibfk_1" FOREIGN KEY ("Codigo_Event") REFERENCES "eventos" ("Codigo_Event") ON DELETE CASCADE
);

CREATE TABLE "usuario" (
  "Codigo_Usuar" varchar(10) NOT NULL PRIMARY KEY,
  "Nombre" varchar(25) NOT NULL,
  "Documento" bigint NOT NULL,
  "Tip_Doc" varchar(6) NOT NULL,
  "Usuario" varchar(27) NOT NULL,
  "Contrasena" varchar(25) NOT NULL,
  "Correo" varchar(36) NOT NULL
);

CREATE TABLE "reportes" (
  "Codigo_Report" varchar(10) NOT NULL PRIMARY KEY,
  "Codigo_Usuar" varchar(10) NOT NULL,
  "Codigo_Event" varchar(10) NOT NULL,
  CONSTRAINT "reportes_ibfk_1" FOREIGN KEY ("Codigo_Usuar") REFERENCES "usuario" ("Codigo_Usuar") ON DELETE CASCADE,
  CONSTRAINT "reportes_ibfk_2" FOREIGN KEY ("Codigo_Event") REFERENCES "eventos" ("Codigo_Event") ON DELETE CASCADE
);

CREATE TABLE "roles" (
  "Codigo_Rol" varchar(10) NOT NULL PRIMARY KEY,
  "Nomb_Rol" varchar(18) NOT NULL,
  "Descrip_Rol" varchar(30) NOT NULL
);

CREATE TABLE "usuario_roles" (
  "Codigo_Usuar" varchar(10) NOT NULL,
  "Codigo_Rol" varchar(10) NOT NULL,
  PRIMARY KEY ("Codigo_Usuar", "Codigo_Rol"),
  CONSTRAINT "usuario_roles_ibfk_1" FOREIGN KEY ("Codigo_Usuar") REFERENCES "usuario" ("Codigo_Usuar") ON DELETE CASCADE,
  CONSTRAINT "usuario_roles_ibfk_2" FOREIGN KEY ("Codigo_Rol") REFERENCES "roles" ("Codigo_Rol") ON DELETE CASCADE
);

-- Insertar Datos

INSERT INTO "eventos" ("Codigo_Event", "Tipo_Event", "Fecha_ingre", "Hora", "Fecha_Final", "Lugar_Event", "Modalidad", "Descrp_Event", "Objetiv_Event", "Control_Person", "Nomb_Event", "Grupo_Destinad") VALUES
('E01', 'Taller', '2025-03-01', '08:30:00', '2025-03-01 12:30:00', 'Salón A', 'Presencial', 'Taller de ciencias', 'Fomentar investigación', 'U001', 'Feria de Ciencias', 'Estudiantes'),
('E02', 'Conferencia', '2025-03-05', '10:00:00', '2025-03-05 12:00:00', 'Sala Audiovisual', 'Virtual', 'Conferencia de matemáticas', 'Pensamiento lógico', 'U002', 'Matemáticas en la vida', 'Docentes'),
('E03', 'Reunión', '2025-03-10', '14:00:00', '2025-03-10 16:00:00', 'Bloque Administrativo', 'Mixta', 'Reunión de padres', 'Comunicación', 'U003', 'Reunión Padres', 'Padres'),
('E04', 'Feria', '2025-03-12', '09:00:00', '2025-03-12 15:00:00', 'Patio Central', 'Presencial', 'Feria de arte', 'Creatividad', 'U004', 'Feria de Arte', 'Estudiantes'),
('E05', 'Charla', '2025-03-15', '11:00:00', '2025-03-15 12:30:00', 'Auditorio', 'Virtual', 'Charla motivacional', 'Superación', 'U005', 'Charla Motivación', 'Estudiantes'),
('E06', 'Concurso', '2025-03-18', '09:00:00', '2025-03-18 13:00:00', 'Auditorio', 'Presencial', 'Concurso de lectura', 'Expresión oral', 'U006', 'Concurso Lectura', 'Docentes'),
('E07', 'Reunión', '2025-03-20', '15:00:00', '2025-03-20 17:00:00', 'Bloque Administrativo', 'Mixta', 'Reunión comité académico', 'Coordinación', 'U007', 'Comité Académico', 'Docentes'),
('E08', 'Exposición', '2025-03-22', '10:00:00', '2025-03-22 14:00:00', 'Salón B', 'Presencial', 'Exposición de robótica', 'Innovación', 'U008', 'Expo Robótica', 'Estudiantes'),
('E09', 'Feria', '2025-03-25', '09:00:00', '2025-03-25 15:00:00', 'Cancha Principal', 'Presencial', 'Juegos deportivos', 'Actividad física', 'U009', 'Olimpiadas Escolares', 'Estudiantes'),
('E10', 'Taller', '2025-03-28', '08:00:00', '2025-03-28 11:00:00', 'Laboratorio Química', 'Presencial', 'Experimentos químicos', 'Investigación', 'U010', 'Taller Química', 'Estudiantes');

INSERT INTO "agenda_escolar" ("Codigo_Agend", "Codigo_Event", "Titulo", "Fecha") VALUES
('A01', 'E01', 'Preparación feria ciencia', '2025-02-25 09:00:00'),
('A02', 'E02', 'Ensayo conferencia mate', '2025-03-03 10:00:00'),
('A03', 'E03', 'Revisión acta padres', '2025-03-08 15:00:00'),
('A04', 'E04', 'Montaje feria arte', '2025-03-11 08:00:00'),
('A05', 'E05', 'Previa charla motivación', '2025-03-14 09:00:00'),
('A06', 'E06', 'Clasificatoria lectura', '2025-03-16 10:00:00'),
('A07', 'E07', 'Agenda comité académico', '2025-03-19 14:00:00'),
('A08', 'E08', 'Preparación expo robótica', '2025-03-21 11:00:00'),
('A09', 'E09', 'Entrenamiento juegos', '2025-03-24 08:00:00'),
('A10', 'E10', 'Prácticas de laboratorio', '2025-03-27 09:00:00');

INSERT INTO "recurso_logistica" ("Codigo_Recurs", "Nomb_Recurs", "Tipo_Recurs", "Ubicacion", "Estado", "Fecha_Entreg", "Fecha_Devoluc") VALUES
('RL01', 'Salón A', 'Espacio', 'Bloque 1', 'Disponible', '2025-03-01 08:00:00', '2025-03-01 18:00:00'),
('RL02', 'Proyector Epson', 'Tecnología', 'Sala Audiovisual', 'En uso', '2025-03-02 09:00:00', '2025-03-02 12:00:00'),
('RL03', 'Bus Escolar', 'Transporte', 'Parqueadero 2', 'Mantenimiento', '2025-03-03 07:00:00', '2025-03-03 17:00:00'),
('RL04', 'Cancha Principal', 'Espacio', 'Zona Deportiva', 'Disponible', '2025-03-04 08:00:00', '2025-03-04 18:00:00'),
('RL05', 'Computador Dell', 'Tecnología', 'Sala Informática', 'Disponible', '2025-03-05 08:00:00', '2025-03-05 18:00:00'),
('RL06', 'Sonido JBL', 'Tecnología', 'Auditorio', 'En uso', '2025-03-06 09:00:00', '2025-03-06 12:00:00'),
('RL07', 'Sillas Plegables', 'Mobiliario', 'Depósito', 'Disponible', '2025-03-07 10:00:00', '2025-03-07 16:00:00'),
('RL08', 'Carpa Grande', 'Mobiliario', 'Patio Central', 'Disponible', '2025-03-08 06:00:00', '2025-03-08 20:00:00'),
('RL09', 'Micrófono Inalámbrico', 'Tecnología', 'Auditorio', 'Disponible', '2025-03-09 10:00:00', '2025-03-09 14:00:00'),
('RL10', 'Laboratorio Química', 'Espacio', 'Bloque Ciencias', 'En uso', '2025-03-10 08:00:00', '2025-03-10 12:00:00');

INSERT INTO "evento_recursos" ("Codigo_Event", "Codigo_Recurs") VALUES
('E01', 'RL01'),
('E02', 'RL02'),
('E03', 'RL03'),
('E04', 'RL04'),
('E05', 'RL05'),
('E06', 'RL06'),
('E07', 'RL07'),
('E08', 'RL08'),
('E09', 'RL09'),
('E10', 'RL10');

INSERT INTO "notificaciones" ("Codigo_Notifi", "Codigo_Event", "Tipo_Notifi", "Canal_Envio", "Mensaje", "Fecha_Crea", "Titulo") VALUES
('N01', 'E01', 'Aviso', 'Correo', 'Recuerda asistir a la feria de ciencias.', '2025-02-20 10:00:00', 'Feria Ciencias'),
('N02', 'E02', 'Aviso', 'App', 'No faltes a la conferencia de matemáticas.', '2025-03-01 08:00:00', 'Conferencia Matemáticas'),
('N03', 'E03', 'Recordatorio', 'Correo', 'Reunión de padres este viernes.', '2025-03-05 09:00:00', 'Reunión Padres'),
('N04', 'E04', 'Aviso', 'App', 'Feria de arte escolar.', '2025-03-10 12:00:00', 'Feria Arte'),
('N05', 'E05', 'Cambio', 'Correo', 'Cambio de hora en charla motivación.', '2025-03-13 11:00:00', 'Charla Motivación'),
('N06', 'E06', 'Aviso', 'App', 'Participa en el concurso de lectura.', '2025-03-15 14:00:00', 'Concurso Lectura'),
('N07', 'E07', 'Recordatorio', 'Correo', 'Reunión comité académico próxima semana.', '2025-03-17 08:00:00', 'Comité Académico'),
('N08', 'E08', 'Aviso', 'App', 'Visita la exposición de robótica.', '2025-03-19 13:00:00', 'Expo Robótica'),
('N09', 'E09', 'Aviso', 'Correo', 'Juegos deportivos inician mañana.', '2025-03-23 10:00:00', 'Olimpiadas Escolares'),
('N10', 'E10', 'Recordatorio', 'App', 'Taller de química este viernes.', '2025-03-26 09:00:00', 'Taller Química');

INSERT INTO "usuario" ("Codigo_Usuar", "Nombre", "Documento", "Tip_Doc", "Usuario", "Contrasena", "Correo") VALUES
('U002', 'Carlos Gómez', 1023456789, 'CC', 'cgomez', 'clave456', 'carlos@email.com'),
('U003', 'Laura Torres', 1034567890, 'TI', 'ltorres', 'laura789', 'laura@email.com'),
('U004', 'Pedro Sánchez', 1045678901, 'CC', 'psanchez', 'pedro321', 'pedro@email.com'),
('U005', 'María López', 1056789012, 'CC', 'mlopez', 'maria654', 'maria@email.com'),
('U006', 'Javier Ruiz', 1067890123, 'CC', 'jruiz', 'javi987', 'javier@email.com'),
('U007', 'Camila Ortega', 1078901234, 'TI', 'cortega', 'cami852', 'camila@email.com'),
('U008', 'Luis Ramírez', 1089012345, 'CC', 'lramirez', 'luis741', 'luis@email.com'),
('U009', 'Elena Vargas', 1090123456, 'CC', 'evargas', 'elena369', 'elena@email.com'),
('U010', 'Andrés Silva', 1101234567, 'CC', 'asilva', 'andres159', 'andres@email.com');

INSERT INTO "roles" ("Codigo_Rol", "Nomb_Rol", "Descrip_Rol") VALUES
('R01', 'Administrador', 'Gestión total'),
('R02', 'Docente', 'Gestión de clases'),
('R03', 'Estudiante', 'Acceso básico'),
('R04', 'Padre', 'Consulta reportes'),
('R05', 'Logística', 'Manejo de recursos'),
('R06', 'Coordinador', 'Organización eventos'),
('R07', 'Rector', 'Dirección general'),
('R08', 'Bibliotecario', 'Gestión biblioteca'),
('R09', 'Invitado', 'Acceso limitado'),
('R10', 'Auxiliar', 'Apoyo académico');

INSERT INTO "usuario_roles" ("Codigo_Usuar", "Codigo_Rol") VALUES
('U002', 'R02'),
('U003', 'R03'),
('U004', 'R04'),
('U005', 'R05'),
('U006', 'R06'),
('U007', 'R07'),
('U008', 'R08'),
('U009', 'R09'),
('U010', 'R10');

INSERT INTO "reportes" ("Codigo_Report", "Codigo_Usuar", "Codigo_Event") VALUES
('REP02', 'U002', 'E02'),
('REP03', 'U003', 'E03'),
('REP04', 'U004', 'E04'),
('REP05', 'U005', 'E05'),
('REP06', 'U006', 'E06'),
('REP07', 'U007', 'E07'),
('REP08', 'U008', 'E08'),
('REP09', 'U009', 'E09'),
('REP10', 'U010', 'E10');
