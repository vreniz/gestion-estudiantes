-- a. Estudiantes cuyo promedio de calificación supera el promedio general
SELECT e.nombre_completo, ROUND(AVG(i.calificacion_final), 2) AS promedio_estudiante
FROM estudiantes e
JOIN inscripciones i ON e.id_estudiante = i.id_estudiante
GROUP BY e.id_estudiante, e.nombre_completo
HAVING AVG(i.calificacion_final) > (
    SELECT AVG(calificacion_final) FROM inscripciones
)
ORDER BY promedio_estudiante DESC;

-- b. Carreras con estudiantes inscritos en cursos del semestre >= 2
-- (interpretando "semestre" por número de créditos >= 2; ajusta si tu campo semestre usa otro criterio)
SELECT DISTINCT e.carrera
FROM estudiantes e
WHERE EXISTS (
    SELECT 1
    FROM inscripciones i
    JOIN cursos c ON i.id_curso = c.id_curso
    WHERE i.id_estudiante = e.id_estudiante
      AND c.creditos >= 2
);

-- c. Indicadores globales con funciones de agregación
SELECT
    COUNT(*) AS total_inscripciones,
    ROUND(AVG(calificacion_final), 2) AS promedio_general,
    MAX(calificacion_final) AS nota_maxima,
    MIN(calificacion_final) AS nota_minima,
    ROUND(SUM(calificacion_final), 2) AS suma_calificaciones
FROM inscripciones;

-- c (extra). Indicadores por curso, más útil para mostrar
SELECT
    c.nombre AS curso,
    COUNT(i.id_estudiante) AS total_inscritos,
    ROUND(AVG(i.calificacion_final), 2) AS promedio,
    MAX(i.calificacion_final) AS nota_maxima,
    MIN(i.calificacion_final) AS nota_minima
FROM cursos c
JOIN inscripciones i ON c.id_curso = i.id_curso
GROUP BY c.id_curso, c.nombre
ORDER BY promedio DESC;