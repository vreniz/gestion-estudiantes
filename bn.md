Aquí tienes la lista detallada de las cardinalidades corregidas una a una para cada relación entre tus entidades, siguiendo las reglas estándar de modelado de bases de datos para EcoMarket Riwi S.A.S.:
------------------------------
## 1. city (Ciudad) a distribution_center (Centro de Distribución)

* Cardinalidad: 1:N (Uno a Muchos)
* Explicación: Un Centro de Distribución puede atender u operar en muchas (N) ciudades. Cada ciudad en tu sistema se asigna a un (1) Centro de Distribución principal.
* En el mapa: Coloca un 1 en la línea junto a distribution_center y una N en la línea junto a city.

## 2. city (Ciudad) a client (Cliente)

* Cardinalidad: 1:N (Uno a Muchos)
* Explicación: En una ciudad pueden residir muchos (N) clientes de tu tienda. Cada cliente individual pertenece únicamente a una (1) ciudad.
* En el mapa: Coloca un 1 en la línea junto a city y una N en la línea junto a client. (Recuerda borrar el "1:N" del rombo born_in).

## 3. client (Cliente) a order (Pedido)

* Cardinalidad: 1:N (Uno a Muchos)
* Explicación: Un solo cliente puede realizar muchos (N) pedidos a lo largo del tiempo. Cada pedido individual pertenece obligatoriamente a un (1) único cliente.
* En el mapa: Coloca un 1 en la línea junto a client y una N en la línea junto a order. (Borra el "1:N" del rombo places).

## 4. distribution_center (Centro de Distribución) a inventory (Inventario)

* Cardinalidad: 1:N (Uno a Muchos)
* Explicación: Un Centro de Distribución almacena el stock de muchos (N) productos diferentes (múltiples registros de inventario). Cada registro específico de stock físico pertenece a un (1) centro de distribución.
* En el mapa: Cambia la "1" actual del lado de inventory por una N. Deja el 1 en el lado de distribution_center.

## 5. product (Producto) a inventory (Inventario)

* Cardinalidad: 1:N (Uno a Muchos)
* Explicación: Un producto en catálogo puede registrar existencias en muchos (N) inventarios de distintas sedes o pasillos. Cada celda o registro de inventario detalla el stock de un (1) solo producto.
* En el mapa: Deja el 1 junto a product y la N junto a inventory (Esta es la única que estaba 100% correcta de origen).

## 6. category (Categoría) a product (Producto)

* Cardinalidad: 1:N (Uno a Muchos)
* Explicación: Una categoría de la tienda (ej. "Orgánicos") agrupa a muchos (N) productos. Cada producto se clasifica bajo una (1) única categoría principal.
* En el mapa: Coloca un 1 en la línea junto a category y una N en la línea junto a product.

## 7. order (Pedido) a order_detail (Detalle del Pedido)

* Cardinalidad: 1:N (Uno a Muchos)
* Explicación: Una orden de compra completa se compone de muchas (N) líneas de detalle (los distintos productos del carrito). Cada línea de detalle pertenece estrictamente a un (1) pedido general.
* En el mapa: Coloca un 1 en la línea junto a order y una N en la línea junto a order_detail.

## 8. product (Producto) a order_detail (Detalle del Pedido)

* Cardinalidad: 1:N (Uno a Muchos)
* Explicación: Un producto del catálogo puede aparecer referenciado en muchos (N) detalles de compras hechas por diferentes clientes. Cada línea de detalle específica registra la cantidad vendida de un (1) único producto.
* En el mapa: Coloca un 1 en la línea junto a product y una N en la línea junto a order_detail.

------------------------------
¿Deseas que verifiquemos los atributos (óvalos) de tus entidades para asegurar que los nombres de las llaves primarias (id) y las llaves foráneas coincidan perfectamente con estas cardinalidades?

