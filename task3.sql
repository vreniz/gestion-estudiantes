-- A. Estudiantes con sus inscripciones y cursos
SELECT e.nombre_completo, c.nombre AS curso, i.fecha_inscripcion, i.calificacion_final
FROM estudiantes e
JOIN inscripciones i ON e.id_estudiante = i.id_estudiante
JOIN cursos c ON i.id_curso = c.id_curso
ORDER BY e.nombre_completo;

-- B. Cursos dictados por docentes con más de 5 años de experiencia
SELECT c.nombre AS curso, c.codigo, d.nombre_completo AS docente, d.anios_experiencia
FROM cursos c
JOIN docentes d ON c.id_docente = d.id_docente
WHERE d.anios_experiencia > 5;

-- C. Promedio de calificaciones por curso
SELECT c.nombre AS curso, ROUND(AVG(i.calificacion_final), 2) AS promedio
FROM cursos c
JOIN inscripciones i ON c.id_curso = i.id_curso
GROUP BY c.id_curso, c.nombre
ORDER BY promedio DESC;

-- D. Estudiantes inscritos en más de un curso
SELECT e.nombre_completo, COUNT(*) AS total_cursos
FROM estudiantes e
JOIN inscripciones i ON e.id_estudiante = i.id_estudiante
GROUP BY e.id_estudiante, e.nombre_completo
HAVING COUNT(*) > 1;

-- E. Agregar columna estado_academico
ALTER TABLE estudiantes
ADD COLUMN estado_academico VARCHAR(20) DEFAULT 'Normal'
CHECK (estado_academico IN ('Normal', 'Prueba', 'Distinguido', 'Suspendido'));


-- F. Eliminar un docente y observar el efecto
DELETE FROM docentes WHERE id_docente = 3;
-- Ahora el docente 2 y su curso "Cálculo Diferencial" (id_curso 2) se eliminan juntos,
-- y por el CASCADE de inscripciones, también caen las inscripciones de ese curso.

-- G. Cursos con más de 2 estudiantes inscritos
SELECT c.nombre AS curso, COUNT(i.id_estudiante) AS total_inscritos
FROM cursos c
JOIN inscripciones i ON c.id_curso = i.id_curso
GROUP BY c.id_curso, c.nombre
HAVING COUNT(i.id_estudiante) > 2;