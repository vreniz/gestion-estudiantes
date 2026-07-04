
# Gestión Académica Universidad — Base de Datos PostgreSQL (M4S2)

Proyecto de diseño y manipulación de una base de datos relacional para gestionar **estudiantes, docentes, cursos e inscripciones** de una universidad. Incluye diseño de tablas con restricciones de integridad, inserción de datos, consultas (JOINs, agregaciones, subconsultas), una vista, y control de acceso con transacciones.

La base de datos corre en un contenedor **Docker** con **PostgreSQL 17**, y se administra con **DBeaver**.

---

## Estructura del proyecto

```
GESTION-ESTUDIANTES/
├── docker-compose.yml      # Configuración del contenedor PostgreSQL
├── create_tables.sql       # DDL (Data Definition Language): Creación de tablas y restricciones (PK, FK, UNIQUE, CHECK)
├── insert-info.sql         # DML (Data Manipulation Language): Inserción de datos (estudiantes, docentes, cursos, inscripciones)
├── task3.sql               # DQL (Data Query Language), DDL y DML: Consultas básicas: JOINs, GROUP BY, HAVING, ALTER, DELETE
├── task4.sql               # DQL (Data Query Language): Subconsultas y funciones de agregación
├── task5.sql               # Creación de la vista vista_historial_academico
└── task6.sql               # Control de acceso (roles, GRANT/REVOKE) y transacciones
```

---

## Modelo de datos

La base de datos tiene cuatro tablas relacionadas:

| Tabla           | Descripción                                        | Llaves                                    |
|-----------------|----------------------------------------------------|-------------------------------------------|
| `estudiantes`   | Datos personales y académicos de los estudiantes   | PK: `id_estudiante`; UNIQUE: correo, identificación |
| `docentes`      | Información de los docentes                         | PK: `id_docente`; UNIQUE: correo          |
| `cursos`        | Cursos ofertados, cada uno dictado por un docente  | PK: `id_curso`; UNIQUE: código; FK: `id_docente` |
| `inscripciones` | Relación estudiante–curso con calificación         | PK: `id_inscripcion`; FK: estudiante y curso |

**Relaciones:**
- Un docente puede dictar varios cursos (`cursos.id_docente` → `docentes.id_docente`).
- Un estudiante puede inscribirse en varios cursos y un curso puede tener varios estudiantes, a través de `inscripciones`.

**Reglas de integridad aplicadas:**
- `NOT NULL` en campos obligatorios.
- `UNIQUE` en correos, identificación y código de curso.
- `CHECK` en género, años de experiencia (≥ 0), créditos (> 0) y calificación final (rango 0–5).
- `FOREIGN KEY` con `ON DELETE CASCADE` (al borrar un docente se borran sus cursos e inscripciones asociadas; al borrar un estudiante o curso se borran sus inscripciones).

---

## Requisitos previos

- [Docker](https://www.docker.com/) y Docker Compose instalados.
- [DBeaver](https://dbeaver.io/) instalado (cliente para administrar la base).

---

## Cómo correr el proyecto

### 1. Levantar el contenedor de PostgreSQL

Desde la carpeta del proyecto (`GESTION-ESTUDIANTES`), en la terminal:

```bash
docker compose up -d
```

Verifica que el contenedor esté corriendo:

```bash
docker ps
```

Deberías ver el contenedor `gestion_academica_universidad-postgres` en estado *Up*.

### 2. Datos de conexión

El contenedor expone PostgreSQL en el **puerto 5433** de tu máquina (mapeado al 5432 interno). Las credenciales son:

| Parámetro   | Valor                                |
|-------------|--------------------------------------|
| Host        | `localhost`                          |
| Puerto      | `5433`                               |
| Base de datos | `gestion_academica_universidad`    |
| Usuario     | `postgres`                           |
| Contraseña  | `postgres123`                        |

### 3. Conectar desde DBeaver

1. Abre DBeaver y haz clic en **Nueva conexión** (el icono del enchufe arriba a la izquierda).
2. Selecciona **PostgreSQL** y pulsa *Siguiente*.
3. Rellena los campos con los datos de la tabla de arriba (recuerda usar el puerto **5433**).
4. Pulsa **Test Connection** para verificar. Si pide descargar el driver, acéptalo.
5. Pulsa **Finish**.

---

## Cómo probar los scripts

Tienes dos formas de ejecutar los archivos `.sql`.

### Desde DBeaver (recomendada)

1. Conéctate a la base (ver arriba).
2. Abre cada archivo `.sql` con **File → Open File**, copia y pega el  script en el editor de DBeaver.
3. Asegúrate de que el script apunte a la base correcta (arriba del editor aparece la conexión y la base activa).
4. Ejecuta **todo el script** con `Alt + X`, o ejecuta una sola sentencia con `Ctrl + Enter` (la del cursor).

**Orden recomendado de ejecución:**

```
1. create_tables.sql     → crea las tablas
2. insert-info.sql       → carga los datos
3. task3.sql             → consultas básicas y modificaciones
4. task4.sql             → subconsultas y funciones
5. task5.sql             → crea la vista
6. task6.sql             → roles, permisos y transacciones
```

> Importante: respeta este orden. No puedes insertar datos sin las tablas, ni consultar la vista sin haberla creado.


---

## Qué hace cada tarea

- **create_tables.sql** — Define las cuatro tablas con sus llaves primarias, foráneas y restricciones de integridad (`NOT NULL`, `UNIQUE`, `CHECK`).
- **insert-info.sql** — Inserta 5 estudiantes, 3 docentes, 4 cursos y 8 inscripciones de prueba con datos académicos colombianos.
- **task3.sql** — Consultas con `JOIN`, promedios por curso (`GROUP BY` + `AVG`), estudiantes en más de un curso (`HAVING`), `ALTER TABLE` para agregar `estado_academico`, y demostración del efecto `ON DELETE CASCADE` al borrar un docente.
- **task4.sql** — Subconsultas (estudiantes con promedio superior al general), `EXISTS`, y funciones de agregación (`ROUND`, `SUM`, `MAX`, `MIN`, `COUNT`).
- **task5.sql** — Crea la vista `vista_historial_academico`, que une estudiante, curso, docente, semestre y calificación final.
- **task6.sql** — Crea el rol `revisor_academico` con permiso de solo lectura sobre la vista (`GRANT SELECT`), revoca permisos de modificación sobre `inscripciones` (`REVOKE`), y simula actualizaciones de calificaciones con `BEGIN`, `SAVEPOINT`, `ROLLBACK` y `COMMIT`.

---

## Detener y limpiar

Para detener el contenedor sin borrar los datos:

```bash
docker compose down
```

Para detenerlo **y borrar todos los datos** (vuelve a empezar de cero):

```bash
docker compose down -v
```

> El flag `-v` elimina el volumen `gestion-academica-db-data`, donde se guardan los datos de forma persistente. Úsalo solo si quieres reiniciar la base desde cero.

---

## Notas

- El puerto local es **5433** (no el 5432 habitual), para evitar conflictos si ya tienes otro PostgreSQL corriendo. Recuérdalo al conectar desde DBeaver.
- Los datos se guardan en un volumen de Docker, así que persisten aunque apagues el contenedor (mientras no uses `down -v`).
