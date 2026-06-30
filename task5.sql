-- Create view
CREATE VIEW vista_historial_academico AS
SELECT
    e.nombre_completo AS estudiante,
    c.nombre AS curso,
    d.nombre_completo AS docente,
    c.semestre,
    i.calificacion_final
FROM inscripciones i
JOIN estudiantes e ON i.id_estudiante = e.id_estudiante
JOIN cursos c ON i.id_curso = c.id_curso
JOIN docentes d ON c.id_docente = d.id_docente;
-- consulta de view
SELECT * FROM vista_historial_academico
ORDER BY estudiante, curso;