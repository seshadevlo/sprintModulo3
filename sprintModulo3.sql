/*luego de modelar la base de datos, por medio de un diagrama entidad-relacion (EER),
realizamos un proceso de Forward Engineering, para conseguir el scrip de dicha base*/

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `sprint_final_sql` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `sprint_final_sql` ;

-- -----------------------------------------------------
-- se crea Tabla `categorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sprint_final_sql`.`categorias` (
  `id_categoria` INT NOT NULL AUTO_INCREMENT,
  `nombre_categoria` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_categoria`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- se crea Tabla `clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sprint_final_sql`.`clientes` (
  `id_cliente` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NULL DEFAULT NULL,
  `apellido` VARCHAR(50) NULL DEFAULT NULL,
  `direccion` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`id_cliente`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- se crea Tabla `productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sprint_final_sql`.`productos` (
  `id_producto` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  `stock` INT NOT NULL,
  `precio` INT NOT NULL,
  `id_categoria` INT NOT NULL,
  `color` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id_producto`),
  INDEX `id_categoria_idx` (`id_categoria` ASC) VISIBLE,
  CONSTRAINT `id_categoria`
    FOREIGN KEY (`id_categoria`)
    REFERENCES `sprint_final_sql`.`categorias` (`id_categoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- se crea Tabla `proveedores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sprint_final_sql`.`proveedores` (
  `id_proveedor` INT NOT NULL AUTO_INCREMENT,
  `nombre_representante_legal` VARCHAR(50) NOT NULL,
  `nombre_corporativo` VARCHAR(50) NOT NULL,
  `telefono1` VARCHAR(15) NOT NULL,
  `telefono2` VARCHAR(15) NOT NULL,
  `recepcionista` VARCHAR(50) NOT NULL,
  `correo` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_proveedor`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- se crea Tabla `proveedor_productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sprint_final_sql`.`proveedor_productos` (
  `id_proveedor` INT NOT NULL,
  `id_producto` INT NOT NULL,
  CONSTRAINT `id_producto`
    FOREIGN KEY (`id_producto`)
    REFERENCES `sprint_final_sql`.`productos` (`id_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_proveedores`
    FOREIGN KEY (`id_proveedor`)
    REFERENCES `sprint_final_sql`.`proveedores` (`id_proveedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

--  --
INSERT INTO `sprint_final_sql`.`categorias` (`nombre_categoria`) VALUES
('Computadoras'),
('Smartphones'),
('Televisores'),
('Camaras'),
('Scooter Electricos');

INSERT INTO `sprint_final_sql`.`clientes` (`nombre`, `apellido`, `direccion`) VALUES
('Fernanda', 'González', 'Avenida Providencia 123'),
('Diego', 'Rodríguez', 'Calle Moneda 456'),
('Camila', 'Vega', 'Calle Merced 789'),
('Joaquín', 'Soto', 'Avenida Libertador Bernardo O\'Higgins 1010'),
('Valentina', 'López', 'Avenida Los Leones 1212');

INSERT INTO `sprint_final_sql`.`productos` (`nombre`, `stock`, `precio`, `id_categoria`, `color`) VALUES
('Laptop Lenovo', 20, 550000, 1, 'Gris'),
('Smartphone Samsung Galaxy S21', 30, 800000, 2, 'Negro'),
('Smart TV LG 55"', 15, 900000, 3, 'Negro'),
('Cámara Nikon D5600', 8, 600000, 4, 'Negro'),
('Scooter Eléctrico Xiaomi Mi Electric Scooter Pro 2', 5, 450000, 5, 'Negro'),
('PC Gamer HP Pavilion', 10, 1200000, 1, 'Negro'),
('Smartphone Xiaomi Redmi Note 10 Pro', 25, 400000, 2, 'Azul'),
('TV Samsung 75" 4K', 5, 2500000, 3, 'Negro'),
('Cámara Canon EOS Rebel T7', 12, 650000, 4, 'Negro'),
('Scooter Eléctrico Ninebot Segway MAX G30', 3, 600000, 5, 'Blanco');

INSERT INTO proveedor_productos (id_proveedor, id_producto) VALUES 
(6,1),
(7,4),
(8,2),
(9,3),
(10,5);

INSERT INTO `sprint_final_sql`.`proveedores` (`nombre_representante_legal`, `nombre_corporativo`, `telefono1`, `telefono2`, `recepcionista`, `correo`) VALUES
('John Smith', 'Smith Inc.', '+15 1023 4567', '+18 859 6543', 'Jane Doe', 'john@smithinc.com'),
('Pablo Rodriguez', 'Rodriguez S.A.', '+54 1234 5678', '+54 8765 4321', 'Maria Gomez', 'pablo@rodriguezsa.com'),
('David Lee', 'Lee Co. Ltd.', '+82 1234 5678', '+82 8765 4321', 'Kim Soo-Jin', 'david@leeco.kr'),
('Anna Kowalski', 'Kowalski Sp. z o.o.', '+48 9123 4567', '+48 9870 6543', 'Jan Nowak', 'anna@kowalski.pl'),
('Emilie Martin', 'Martin SAS', '+33 2345 6789', '+33 1798 9832', 'Jean Dupont', 'emilie@martin.fr');


-- se realiza consulta para determinar la categoria con mayor fecuencia en la tabla --
SELECT id_categoria, COUNT(id_categoria) AS frecuencia
FROM productos
GROUP BY id_categoria
ORDER BY frecuencia DESC
LIMIT 1;

-- se realiza consulta para ver el producto con mayor stock --

SELECT * FROM productos ORDER BY stock DESC LIMIT 1;

-- se realiza consulta para saber el color mas frecuente entre los productos --

SELECT color, COUNT(color) AS color_popular
FROM productos
GROUP BY color
ORDER BY color_popular DESC
LIMIT 1;

-- se realiza consulta para saber el provedor con menor stock de productos --
 
SELECT nombre, stock, id_categoria, nombre_corporativo
FROM productos
INNER JOIN proveedores pv ON id_proveedor = pv.id_proveedor
WHERE stock = (SELECT MIN(stock) FROM productos)
LIMIT 1; 

-- cambiamos la categoria de prodcutos mas popular por "Electrónica y Computación" --

update categorias set nombre_categoria='Electrónica_y_Computación' WHERE nombre_categoria='smartphones';

-- se sube base de datos a repositorio de github--
