-- 1. Crear el rol revisor_academico
CREATE ROLE revisor_academico LOGIN PASSWORD 'clave_segura_123';

-- 2. Otorgar permiso de SOLO LECTURA sobre la vista
GRANT SELECT ON vista_historial_academico TO revisor_academico;

-- 3. Revocar permisos de modificación de datos en inscripciones
REVOKE INSERT, UPDATE, DELETE ON inscripciones FROM revisor_academico;

BEGIN;

-- Primera actualización
UPDATE inscripciones SET calificacion_final = 5.0 WHERE id_inscripcion = 1;

-- Punto de guardado intermedio
SAVEPOINT punto_1;

-- Segunda actualización (suponer que fue un error)
UPDATE inscripciones SET calificacion_final = 0.0 WHERE id_inscripcion = 2;

-- Arrepentirse de la segunda: volver al savepoint
ROLLBACK TO SAVEPOINT punto_1;
-- La inscripción 1 sigue actualizada a 5.0, pero la 2 NO cambió.

-- Tercera actualización válida
UPDATE inscripciones SET calificacion_final = 4.7 WHERE id_inscripcion = 3;

-- Confirmar todos los cambios pendientes
COMMIT;
-- Resultado final: inscripción 1 = 5.0, inscripción 2 = sin cambios, inscripción 3 = 4.7

-- Verificar despues del commit: 

SELECT id_inscripcion, calificacion_final
FROM inscripciones
WHERE id_inscripcion IN (1, 2, 3);