--TASK 2
-- DOCENTES (3)
INSERT INTO docentes (nombre_completo, correo_institucional, departamento_academico, anios_experiencia) VALUES
('Carlos Andrés Pérez', 'cperez@universidad.edu.co', 'Ingeniería de Sistemas', 12),
('María Fernanda Gómez', 'mgomez@universidad.edu.co', 'Matemáticas', 8),
('Jorge Luis Ramírez', 'jramirez@universidad.edu.co', 'Ingeniería de Sistemas', 5);

-- ESTUDIANTES (5)
INSERT INTO estudiantes (nombre_completo, correo_electronico, genero, identificacion, carrera, fecha_nacimiento, fecha_ingreso) VALUES
('Valentina Torres Díaz', 'vtorres@correo.com', 'Femenino', '1045678901', 'Ingeniería de Sistemas', '2003-04-15', '2021-02-01'),
('Andrés Felipe Castro', 'acastro@correo.com', 'Masculino', '1045678902', 'Ingeniería de Sistemas', '2002-09-22', '2020-08-01'),
('Laura Sofía Mendoza', 'lmendoza@correo.com', 'Femenino', '1045678903', 'Ingeniería Industrial', '2003-01-10', '2021-02-01'),
('Diego Alejandro Ruiz', 'druiz@correo.com', 'Masculino', '1045678904', 'Ingeniería de Sistemas', '2001-12-05', '2019-08-01'),
('Camila Andrea Vargas', 'cvargas@correo.com', 'Femenino', '1045678905', 'Ingeniería Industrial', '2002-06-30', '2020-02-01');

-- CURSOS (4)
INSERT INTO cursos (nombre, codigo, creditos, semestre, id_docente) VALUES
('Bases de Datos', 'IS301', 3, '2025-1', 1),
('Cálculo Diferencial', 'MAT101', 4, '2025-1', 2),
('Programación Web', 'IS305', 3, '2025-1', 3),
('Estructuras de Datos', 'IS302', 4, '2025-1', 1);

-- INSCRIPCIONES (8)
INSERT INTO inscripciones (id_estudiante, id_curso, fecha_inscripcion, calificacion_final) VALUES
(1, 1, '2025-02-05', 4.5),
(1, 3, '2025-02-05', 4.2),
(2, 1, '2025-02-06', 3.8),
(2, 4, '2025-02-06', 4.0),
(3, 2, '2025-02-07', 3.5),
(4, 1, '2025-02-07', 4.8),
(4, 3, '2025-02-08', 4.1),
(5, 2, '2025-02-08', 3.9);