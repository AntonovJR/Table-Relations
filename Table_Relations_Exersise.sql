-- 1
CREATE TABLE `passports` (
`passport_id` INT UNIQUE PRIMARY KEY ,
`passport_number` VARCHAR(45) UNIQUE
);
INSERT INTO `passports`
VALUES 
(101,'N34FG21B'),
(102,'K65LO4R7'),
(103,'ZE657QP2');
CREATE TABLE `people` (
`person_id` INT AUTO_INCREMENT PRIMARY KEY,
`first_name` VARCHAR(45),
`salary` DECIMAL(7,2),
`passport_id` INT UNIQUE,
CONSTRAINT `fk_passport_id`
FOREIGN KEY (`passport_id`)
REFERENCES `passports`(`passport_id`)
);
INSERT INTO `people`
VALUES 
(1,'Roberto', 43300.00,102),
(2,'Tom', 56100.00,103),
(3,'Yana', 60200.00,101);

-- 2
CREATE TABLE `manufacturers`(
`manufacturer_id` INT NOT NULL AUTO_INCREMENT UNIQUE,
`name` VARCHAR(30),
`established_on` DATE
);
INSERT INTO `manufacturers`
VALUES
(1,'BMW', '1916-03-01'),
(2,'Tesla', '2003-01-01'),
(3,'Lada', '1966-05-01');

CREATE TABLE `models`(
`model_id` INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
`name` VARCHAR(20) NOT NULL,
`manufacturer_id` INT,
CONSTRAINT fk_models_manufacturers
FOREIGN KEY(`manufacturer_id`)
REFERENCES `manufacturers`(`manufacturer_id`)
)AUTO_INCREMENT = 100;

INSERT INTO `models`
VALUES
(101,'X1',1),
(102,'i6',1),
(103,'Model S',2),
(104,'Model X',2),
(105,'Model 3',2),
(106,'Nova',3);

-- 3
CREATE TABLE `students` (
    `student_id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(50),
    PRIMARY KEY (`student_id`)
);

INSERT INTO `students`
VALUES
(1, 'Mila'),
(2, 'Toni'),
(3, 'Ron');

CREATE TABLE `exams` (
    `exam_id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL,
    PRIMARY KEY (`exam_id`)
);
INSERT INTO `exams`
VALUES
(101,'Spring MVC'),
(102,'Neo4j'),
(103,'Oracle 11g');

CREATE TABLE `students_exams` (
    `student_id` INT NOT NULL,
    `exam_id` INT NOT NULL,
    PRIMARY KEY (`student_id`, `exam_id`),
    CONSTRAINT `student_fk`
        FOREIGN KEY `student_fk` (`student_id`) REFERENCES `students` (`student_id`)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `exam_fk`
        FOREIGN KEY `exam_fk` (`exam_id`) REFERENCES `exams` (`exam_id`)
        ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO `students_exams`
VALUES
(1,101),
(1,102),
(2,101),
(3,103),
(2,102),
(2,103);

-- 4
CREATE TABLE `teachers`(
	`teacher_id` INT PRIMARY KEY AUTO_INCREMENT,
	`name` VARCHAR(30),
	`manager_id` INT
	);
	
INSERT INTO `teachers`(`teacher_id`,`name`,`manager_id`)
VALUES
(101,'John',NULL),
(102,'Maya',106),
(103,'Silvia',106),
(104,'Ted',105),
(105,'Mark',101),
(106,'Greta',101);

ALTER TABLE `teachers`
ADD CONSTRAINT `fk_manager_id` FOREIGN KEY(`manager_id`)
REFERENCES `teachers`(`teacher_id`)
ON DELETE NO ACTION;

-- 5
CREATE SCHEMA `online_store`;
CREATE TABLE `cities`(
`city_id`INT NOT NULL AUTO_INCREMENT PRIMARY KEY UNIQUE,
`name` VARCHAR(50)
);
CREATE TABLE `item_types`(
`item_type_id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY UNIQUE,
`name` VARCHAR(50)
);
CREATE TABLE `customers`(
`customer_id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY UNIQUE,
`name` VARCHAR(50),
`birthday` DATE,
`city_id` INT,
CONSTRAINT `fk_customer_city`
FOREIGN KEY(`city_id`)
REFERENCES `cities`(`city_id`)
);
CREATE TABLE `orders`(
`order_id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY UNIQUE,
`customer_id` INT NOT NULL,
CONSTRAINT `fk_customer_order`
FOREIGN KEY(`customer_id`)
REFERENCES `customers`(`customer_id`)
);
CREATE TABLE `items`(
`item_id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY UNIQUE,
`name` VARCHAR(50),
`item_type_id` INT,
CONSTRAINT `fk_item_type`
FOREIGN KEY(`item_type_id`)
REFERENCES `item_types`(`item_type_id`)
);


CREATE TABLE `order_items`(
`order_id` INT NOT NULL AUTO_INCREMENT UNIQUE,
`item_id` INT,
    PRIMARY KEY (`order_id`, `item_id`),
    CONSTRAINT `order_fk`
        FOREIGN KEY `order_fk` (`order_id`) REFERENCES `orders` (`order_id`)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `items_fk`
        FOREIGN KEY `items_fk` (`item_id`) REFERENCES `items` (`item_id`)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- 6
CREATE SCHEMA `soft_uni`;
CREATE TABLE `majors`(
`major_id` INT UNIQUE AUTO_INCREMENT PRIMARY KEY NOT NULL,
`name` VARCHAR(50)
 );
CREATE TABLE `students`(
`student_id` INT UNIQUE AUTO_INCREMENT PRIMARY KEY NOT NULL,
`student_number` VARCHAR(12) UNIQUE NOT NULL,
`student_name` VARCHAR(50),
`major_id` INT,
CONSTRAINT `fk_major_students`
FOREIGN KEY(`major_id`)
REFERENCES `majors`(`major_id`)
);
CREATE TABLE `payments`(
`payment_id` INT UNIQUE AUTO_INCREMENT PRIMARY KEY NOT NULL,
`payment_date` DATE,
`payment_amount` DECIMAL(8,2),
`student_id` INT,
CONSTRAINT `fk_payment_students`
FOREIGN KEY(`student_id`)
REFERENCES `students`(`student_id`)
);
CREATE TABLE `subjects`(
`subject_id` INT UNIQUE AUTO_INCREMENT PRIMARY KEY NOT NULL,
`subject_name` VARCHAR(50)
);

CREATE TABLE `agenda`(
`student_id` INT, 
`subject_id` INT, 
    PRIMARY KEY (`student_id`, `subject_id`),
    CONSTRAINT `student_fk`
        FOREIGN KEY `student_fk` (`student_id`) REFERENCES `students` (`student_id`)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `subject_fk`
        FOREIGN KEY `subject_fk` (`subject_id`) REFERENCES `subjects` (`subject_id`)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- 9
SELECT 
    m.`mountain_range`,
    p.`peak_name`,
    p.`elevation` AS 'peak_elevation'
FROM
    `mountains` AS m
        JOIN
    `peaks` AS p ON m.`id` = p.`mountain_id`
WHERE
    m.`mountain_range` = 'Rila'
ORDER BY p.`elevation` DESC;

