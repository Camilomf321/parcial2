CREATE TABLE Sede(
ID varchar(4),
Sede varchar(15),
CONSTRAINT pk_sede PRIMARY KEY(ID)
);
CREATE TABLE Cargo(
ID varchar(4),
Cargo varchar(15),
CONSTRAINT pk_cargo PRIMARY KEY(ID)
);
CREATE TABLE Estrato(
ID varchar(4),
estrato varchar(15),
CONSTRAINT pk_estrato PRIMARY KEY(ID)
);

CREATE TABLE Empleado(
cc varchar(11),
nombres varchar(40),
primer_apellido varchar(15),
segundo_apellido varchar(15),
edad varchar(3),
ID_estrato varchar(4),

CONSTRAINT pk_Empleado PRIMARY KEY(cc),
CONSTRAINT fk_Empleado_Estrato FOREIGN KEY(ID_estrato) REFERENCES Estrato(ID)
);

CREATE TABLE Empleado_Estado(
Cc_Empleado varchar(11),
ID_Cargo varchar(4),
Sueldo FLOAT,
ID_Sede varchar(4),
Fecha_de_contratacion DATE,

CONSTRAINT fk_Empleado FOREIGN KEY(Cc_Empleado) REFERENCES Empleado(cc),
CONSTRAINT fk_Cargo FOREIGN KEY(ID_Cargo) REFERENCES Cargo(ID),
CONSTRAINT fk_Sede FOREIGN KEY(ID_Sede) REFERENCES Sede(ID)
)

----- PREGUNTAS ----

--1---
SELECT count(*)
from Empleado;
---

--2---
SELECT sede,count(*)
FROM empleado_estado ED
INNER JOIN Sede s ON s.id = ed.id_sede
GROUP BY id_sede,sede;

---

--3---
SELECT e.estrato,count(*)
FROM empleado m
INNER JOIN Estrato e ON e.id = m.id_estrato
GROUP BY estrato
ORDER BY estrato;

---
--4---
select *
from (
SELECT  m.nombres,ed.fecha_de_contratacion
FROM Empleado_Estado ED
INNER JOIN Empleado m ON ed.cc_empleado = m.cc
ORDER BY ed.fecha_de_contratacion DESC
) WHERE ROWNUM<=1;


---5----
select *
from (
SELECT  m.nombres,ed.fecha_de_contratacion
FROM Empleado_Estado ED
INNER JOIN Empleado m ON ed.cc_empleado = m.cc
ORDER BY ed.fecha_de_contratacion 
) WHERE ROWNUM<=1;

--
---6---
SELECT  m.nombres,s.sede,c.cargo
FROM Empleado_Estado ED
INNER JOIN Empleado m ON ed.cc_empleado = m.cc
INNER JOIN Sede s ON s.id = ed.id_sede
INNER JOIN Cargo c ON c.id = ed.id_cargo
WHERE m.cc='10662101';

---7---
DELETE FROM empleado m
WHERE m.cc = '10188530';

DELETE FROM Empleado_Estado ED
WHERE ed.cc_empleado = '10188530';

---8---
SELECT  m.nombres,m.primer_apellido,m.segundo_apellido,ed.fecha_de_contratacion
FROM Empleado_Estado ED
INNER JOIN Empleado m ON ed.cc_empleado = m.cc
WHERE ed.fecha_de_contratacion BETWEEN '01/01/2000' AND '31/12/2005'
GROUP BY m.nombres,m.primer_apellido,m.segundo_apellido,ed.fecha_de_contratacion
ORDER BY ed.fecha_de_contratacion
;

---
---9 ---

(SELECT m.nombres,m.edad
FROM Empleado_Estado ED
INNER JOIN Empleado m ON ed.cc_empleado = m.cc
WHERE m.edad IN (SELECT MIN(m.edad) FROM Empleado m)) 

UNION 
(SELECT m.nombres,m.edad
FROM Empleado_Estado ED
INNER JOIN Empleado m ON ed.cc_empleado = m.cc
WHERE ed.fecha_de_contratacion IN (SELECT MIN(ed.fecha_de_contratacion) FROM Empleado_Estado ED) );
---

---10 ---
SELECT m.nombres,m.edad
FROM Empleado m
WHERE m.edad BETWEEN 17 AND 25
ORDER BY m.edad ;

---

---11 ---
SELECT ROUND(AVG(m.edad))
FROM Empleado m
;
---


---12 ---
SELECT SUM(m.sueldo)
FROM Empleado_Estado m
;
---


---13---
SELECT  m.nombres,s.sede,e.estrato,ed.fecha_de_contratacion
FROM Empleado_Estado ED
INNER JOIN Empleado m ON ed.cc_empleado = m.cc
INNER JOIN Sede s ON s.id = ed.id_sede
INNER JOIN Estrato e ON e.id = m.id_estrato
WHERE ed.sueldo IN (SELECT MAX(ed.sueldo) FROM  Empleado_Estado ED)
;
---

---14---
SELECT  m.nombres,m.edad
FROM Empleado_Estado ED
INNER JOIN Empleado m ON ed.cc_empleado = m.cc
INNER JOIN Sede s ON s.id = ed.id_sede
INNER JOIN Estrato e ON e.id = m.id_estrato
WHERE s.sede='SUR'  AND m.edad IN (SELECT  MIN(m.edad)
FROM Empleado_Estado ED
INNER JOIN Empleado m ON ed.cc_empleado = m.cc
INNER JOIN Sede s ON s.id = ed.id_sede
INNER JOIN Estrato e ON e.id = m.id_estrato
WHERE s.sede='SUR' )
;
---

--15---
SELECT sede,count(*)
FROM empleado_estado ED
INNER JOIN Sede s ON s.id = ed.id_sede
GROUP BY id_sede,sede;

---

--16---
SELECT e.estrato,count(*)
FROM empleado m
INNER JOIN Estrato e ON e.id = m.id_estrato
GROUP BY estrato
ORDER BY estrato;
