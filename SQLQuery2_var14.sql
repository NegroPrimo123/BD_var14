CREATE TABLE Users (
    user_id INT PRIMARY KEY IDENTITY(1,1),
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    preferences TEXT,
    dietary_restrictions TEXT,
    is_deleted BIT DEFAULT 0,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE()
);

CREATE TABLE Ingredients (
    ingredient_id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(100) NOT NULL,
    is_deleted BIT DEFAULT 0,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE()
);

CREATE TABLE Recipes (
    recipe_id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(100) NOT NULL,
    instructions TEXT NOT NULL,
    is_deleted BIT DEFAULT 0,
    created_by INT NULL,
    deleted_by INT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (created_by) REFERENCES Users(user_id) ON DELETE NO ACTION,
    FOREIGN KEY (deleted_by) REFERENCES Users(user_id) ON DELETE NO ACTION
);

CREATE TABLE Recipe_Ingredients (
    recipe_ingredient_id INT PRIMARY KEY IDENTITY(1,1),
    recipe_id INT NOT NULL,
    ingredient_id INT NOT NULL,
    quantity FLOAT NOT NULL,
    is_deleted BIT DEFAULT 0,
    FOREIGN KEY (recipe_id) REFERENCES Recipes(recipe_id) ON DELETE CASCADE,
    FOREIGN KEY (ingredient_id) REFERENCES Ingredients(ingredient_id) ON DELETE CASCADE
);

CREATE TABLE Seasonal_Ingredients (
    seasonal_ingredient_id INT PRIMARY KEY IDENTITY(1,1),
    ingredient_id INT NOT NULL,
    season VARCHAR(50) NOT NULL,
    is_deleted BIT DEFAULT 0,
    FOREIGN KEY (ingredient_id) REFERENCES Ingredients(ingredient_id) ON DELETE CASCADE
);

INSERT INTO Users (username, email, password_hash, preferences, dietary_restrictions)
VALUES 
('user1', 'user1@example.com', 'hashed_password_1', 'vegetarian', 'none'),
('user2', 'user2@example.com', 'hashed_password_2', 'omnivore', 'gluten-free'),
('user3', 'user3@example.com', 'hashed_password_3', 'vegan', 'none');

INSERT INTO Ingredients (name)
VALUES 
('Tomato'),
('Cucumber'),
('Chicken'),
('Rice'),
('Lentils'),
('Carrot'),
('Potato');

INSERT INTO Recipes (name, instructions, created_by)
VALUES 
('Vegetable Salad', 'Mix all vegetables and dress with olive oil.', 1),
('Chicken Rice', 'Cook rice and add grilled chicken on top.', 2),
('Lentil Soup', 'Boil lentils and add spices.', 3);

INSERT INTO Recipe_Ingredients (recipe_id, ingredient_id, quantity)
VALUES 
(1, 1, 2), -- Vegetable Salad: 2 Tomatoes
(1, 2, 1), -- Vegetable Salad: 1 Cucumber
(2, 3, 1), -- Chicken Rice: 1 Chicken
(2, 4, 1), -- Chicken Rice: 1 Rice
(3, 5, 1); -- Lentil Soup: 1 Lentils

INSERT INTO Seasonal_Ingredients (ingredient_id, season)
VALUES 
(1, 'Summer'),  -- Tomato is available in Summer
(2, 'Summer'),  -- Cucumber is available in Summer
(3, 'All Year'), -- Chicken is available all year
(4, 'All Year'), -- Rice is available all year
(5, 'Fall'),    -- Lentils are usually harvested in Fall
(6, 'Winter'),  -- Carrot is available in Winter
(7, 'Spring');  -- Potato is available in Spring
