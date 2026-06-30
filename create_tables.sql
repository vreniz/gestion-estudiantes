--TASK 1
CREATE TABLE estudiantes (
    id_estudiante SERIAL PRIMARY KEY,
    nombre_completo VARCHAR(120) NOT NULL,
    correo_electronico VARCHAR(120) UNIQUE NOT NULL,
    genero VARCHAR(20) CHECK (genero IN ('Masculino', 'Femenino', 'Otro')),
    identificacion VARCHAR(30) UNIQUE NOT NULL,
    carrera VARCHAR(100) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    fecha_ingreso DATE DEFAULT CURRENT_DATE
);

CREATE TABLE docentes (
    id_docente SERIAL PRIMARY KEY,
    nombre_completo VARCHAR(120) NOT NULL,
    correo_institucional VARCHAR(120) UNIQUE NOT NULL,
    departamento_academico VARCHAR(100) NOT NULL,
    anios_experiencia INT NOT NULL CHECK (anios_experiencia >= 0)
);
CREATE TABLE cursos (
    id_curso SERIAL PRIMARY KEY,
    nombre VARCHAR(120) NOT NULL,
    codigo VARCHAR(20) UNIQUE NOT NULL,
    creditos INT NOT NULL CHECK (creditos > 0),
    semestre VARCHAR(20) NOT NULL,
    id_docente INT NOT NULL,
    CONSTRAINT fk_curso_docente
        FOREIGN KEY (id_docente)
        REFERENCES docentes(id_docente)
        ON DELETE RESTRICT
);
CREATE TABLE inscripciones (
    id_inscripcion SERIAL PRIMARY KEY,
    id_estudiante INT NOT NULL,
    id_curso INT NOT NULL,
    fecha_inscripcion DATE DEFAULT CURRENT_DATE,
    calificacion_final NUMERIC(4,2) CHECK (calificacion_final >= 0 AND calificacion_final <= 5),
    CONSTRAINT fk_inscripcion_estudiante
        FOREIGN KEY (id_estudiante)
        REFERENCES estudiantes(id_estudiante)
        ON DELETE CASCADE,
    CONSTRAINT fk_inscripcion_curso
        FOREIGN KEY (id_curso)
        REFERENCES cursos(id_curso)
        ON DELETE CASCADE,
    CONSTRAINT uq_inscripcion UNIQUE (id_estudiante, id_curso)
);