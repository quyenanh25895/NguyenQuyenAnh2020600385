CREATE DATABASE IF NOT EXISTS ban_dien_thoai;

USE ban_dien_thoai;

CREATE TABLE users
(
    userID         INT PRIMARY KEY AUTO_INCREMENT,
    userFullname   VARCHAR(100) NOT NULL,
    email          VARCHAR(100) NOT NULL,
    userPhonenumer VARCHAR(100) NOT NULL,
    userAddress    VARCHAR(255) NULL,
    userGender     TINYINT      NOT NULL DEFAULT '0',
    username       VARCHAR(255) NOT NULL UNIQUE,
    password       VARCHAR(255) NOT NULL,
    roleID         INT          NOT NULL DEFAULT '2',
    createdDate    DATE                  DEFAULT CURRENT_TIMESTAMP,
    createBy       VARCHAR(100),
    modifiedDate   DATE                  DEFAULT CURRENT_TIMESTAMP,
    modifiedBy     VARCHAR(100)
);

CREATE TABLE roles
(
    roleID   INT AUTO_INCREMENT PRIMARY KEY,
    roleCODE VARCHAR(255) NOT NULL
);

CREATE TABLE comment
(
    commentID    INT  NOT NULL PRIMARY KEY auto_increment,
    content      TEXT NOT NULL,
    userID       INT  NOT NULL,
    productID    INT  NOT NULL,
    createdDate  DATE DEFAULT CURRENT_TIMESTAMP,
    createBy     VARCHAR(100),
    modifiedDate DATE DEFAULT CURRENT_TIMESTAMP,
    modifiedBy   VARCHAR(100)
);

CREATE TABLE brands
(
    brandID      INT PRIMARY KEY AUTO_INCREMENT,
    bandName     VARCHAR(100) NOT NULL UNIQUE,
    brandStatus  INT  DEFAULT '0',
    createdDate  DATE DEFAULT CURRENT_TIMESTAMP,
    createBy     VARCHAR(100),
    modifiedDate DATE DEFAULT CURRENT_TIMESTAMP,
    modifiedBy   VARCHAR(100)

);

CREATE TABLE categories
(
    cateID       INT PRIMARY KEY AUTO_INCREMENT,
    cateName     VARCHAR(100) NOT NULL UNIQUE,
    cateStatus   TINYINT(1) DEFAULT '0',
    createdDate  DATE       DEFAULT CURRENT_TIMESTAMP,
    createBy     VARCHAR(100),
    modifiedDate DATE       DEFAULT CURRENT_TIMESTAMP,
    modifiedBy   VARCHAR(100)
);

CREATE TABLE brand_category
(
    brandcateID INT PRIMARY KEY AUTO_INCREMENT,
    brandID     INT NOT NULL,
    cateID      INT NOT NULL

);

CREATE TABLE products
(
    productID          INT PRIMARY KEY AUTO_INCREMENT,
    productName        VARCHAR(100)   NOT NULL UNIQUE,
    productPrice       DECIMAL(10, 2) NOT NULL,
    productQuantity    BIGINT         NOT NULL DEFAULT '0',
    brandID            INT            NOT NULL,
    cateID             INT            NOT NULL,
    productDescription TEXT           NOT NULL,
    productStatus      TINYINT(1)              DEFAULT '0',
    createdDate        DATE                    DEFAULT CURRENT_TIMESTAMP,
    createBy           VARCHAR(100),
    modifiedDate       DATE                    DEFAULT CURRENT_TIMESTAMP,
    modifiedBy         VARCHAR(100)
);

CREATE TABLE colors
(
    colorID      INT PRIMARY KEY AUTO_INCREMENT,
    colerCode    VARCHAR(255) NOT NULL,
    createdDate  DATE DEFAULT CURRENT_TIMESTAMP,
    createBy     VARCHAR(100),
    modifiedDate DATE DEFAULT CURRENT_TIMESTAMP,
    modifiedBy   VARCHAR(100)
);

CREATE TABLE capacities
(
    capacityID    INT PRIMARY KEY AUTO_INCREMENT,
    capacityValue BIGINT NOT NULL UNIQUE,
    createdDate   DATE DEFAULT CURRENT_TIMESTAMP,
    createBy      VARCHAR(100),
    modifiedDate  DATE DEFAULT CURRENT_TIMESTAMP,
    modifiedBy    VARCHAR(100)
);

CREATE TABLE images
(
    imageID      INT PRIMARY KEY AUTO_INCREMENT,
    imageLink    VARCHAR(255) NOT NULL,
    createdDate  DATE DEFAULT CURRENT_TIMESTAMP,
    createBy     VARCHAR(100),
    modifiedDate DATE DEFAULT CURRENT_TIMESTAMP,
    modifiedBy   VARCHAR(100)
);

CREATE TABLE product_colors
(
    procolorID INT PRIMARY KEY AUTO_INCREMENT,
    productID  INT NOT NULL,
    colorID    INT NOT NULL
);

CREATE TABLE product_capacities
(
    procapID   INT PRIMARY KEY AUTO_INCREMENT,
    productID  INT NOT NULL,
    capacityID INT NOT NULL
);

CREATE TABLE product_images
(
    proimgID  INT PRIMARY KEY AUTO_INCREMENT,
    productID INT NOT NULL,
    imageID   INT NOT NULL
);

CREATE TABLE carts
(
    cartID       INT PRIMARY KEY AUTO_INCREMENT,
    userID       INT NOT NULL UNIQUE,
    createdDate  DATE DEFAULT CURRENT_TIMESTAMP,
    createBy     VARCHAR(100),
    modifiedDate DATE DEFAULT CURRENT_TIMESTAMP,
    modifiedBy   VARCHAR(100)
);

CREATE TABLE cart_products
(
    cartproductID INT PRIMARY KEY AUTO_INCREMENT,
    cartID        INT            NOT NULL,
    productID     INT            NOT NULL,
    quantity      INT            NOT NULL,
    price         DECIMAL(10, 2) NOT NULL, -- Giá của sản phẩm tại thời điểm được thêm vào giỏ hàng
    createdDate   DATE DEFAULT CURRENT_TIMESTAMP,
    createBy      VARCHAR(100),
    modifiedDate  DATE DEFAULT CURRENT_TIMESTAMP,
    modifiedBy    VARCHAR(100)
);

CREATE TABLE orders
(
    orderID      INT PRIMARY KEY AUTO_INCREMENT,
    userID       INT NOT NULL,
    productID    INT NOT NULL,
    quantity     INT NOT NULL,
    price        INT NOT NULL,
    status       TINYINT(1) DEFAULT '0',
    createdDate  DATE       DEFAULT CURRENT_TIMESTAMP,
    createBy     VARCHAR(100),
    modifiedDate DATE       DEFAULT CURRENT_TIMESTAMP,
    modifiedBy   VARCHAR(100)
);

CREATE TABLE order_details
(
    oderdetailID INT PRIMARY KEY AUTO_INCREMENT,
    orderID      INT            NOT NULL,
    productID    INT            NOT NULL,
    quantity     INT            NOT NULL,
    price        DECIMAL(10, 2) NOT NULL,
    createdDate  DATE DEFAULT CURRENT_TIMESTAMP,
    createBy     VARCHAR(100),
    modifiedDate DATE DEFAULT CURRENT_TIMESTAMP,
    modifiedBy   VARCHAR(100)
);

INSERT INTO users (userFullname, email, userPhonenumer, userAddress, userGender, username, password)
VALUES ('Nguyen Van A', 'nguyenvana@example.com', '0909123456', '123 Đường ABC, Quận 1, TP. HCM', '1', 'nguyenvana',
        'passwordHash');

INSERT INTO carts (userID)
VALUES (LAST_INSERT_ID());

DELETE
FROM cart_products
WHERE cartID = 1;

INSERT INTO users (userFullname, email, userPhonenumer, userAddress, userGender, username, password, roleID,
                   createdDate, createBy, modifiedDate, modifiedBy)
VALUES ('Nguyen Van A', 'nguyenvana@example.com', '123456789', '123 Street, City', 1, 'user1', 'password1', 1, NOW(),
        'admin', NOW(), 'admin'),
       ('Tran Thi B', 'tranthib@example.com', '987654321', '456 Avenue, Town', 0, 'user2', 'password2', 1, NOW(),
        'admin', NOW(), 'admin'),
       ('Le Van C', 'levanc@example.com', '567891234', '789 Road, Village', 1, 'admin1', 'password3', 2, NOW(), 'admin',
        NOW(), 'admin');

