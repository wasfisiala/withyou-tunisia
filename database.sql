
-- WithYou - Base de données touristique Tunisie
CREATE DATABASE withyou_tunisia CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE withyou_tunisia;

CREATE TABLE cities (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  governorate VARCHAR(100),
  latitude DECIMAL(10,7),
  longitude DECIMAL(10,7),
  description TEXT,
  hero_image VARCHAR(255),
  population INT
);

CREATE TABLE pois (
  id INT AUTO_INCREMENT PRIMARY KEY,
  city_id INT,
  category ENUM('hotel','restaurant','bar','shopping','musee','site') NOT NULL,
  name VARCHAR(200) NOT NULL,
  description TEXT,
  address VARCHAR(255),
  latitude DECIMAL(10,7),
  longitude DECIMAL(10,7),
  rating DECIMAL(2,1),
  price_range VARCHAR(20),
  photo_url VARCHAR(500),
  phone VARCHAR(30),
  website VARCHAR(255),
  FOREIGN KEY (city_id) REFERENCES cities(id)
);

-- Insertion des 24 villes principales
INSERT INTO cities (name, governorate, latitude, longitude, description) VALUES
('Tunis', 'Tunis', 36.8065, 10.1815, 'Capitale historique et médina classée UNESCO'),
('Siliana', 'Siliana', 36.0833, 9.3667, 'Cœur agricole du Nord-Ouest, proche des sites romains'),
('Makthar', 'Siliana', 35.8547, 9.2044, 'Ancienne Mactaris romaine'),
('Kesra', 'Siliana', 35.8130, 9.3640, 'Plus haut village de Tunisie'),
('Gaffour', 'Siliana', 36.3170, 9.3000, 'Ville natale, porte du Nord-Ouest'),
('Sousse', 'Sousse', 35.8270, 10.6380, 'Perle du Sahel'),
('Kairouan', 'Kairouan', 35.6811, 10.1039, 'Ville sainte'),
('El Jem', 'Mahdia', 35.2964, 10.7069, 'Amphithéâtre romain'),
('Djerba', 'Medenine', 33.8076, 10.8451, 'Île aux rêves');

-- Exemples POIs pour Siliana (données réelles 2026)
INSERT INTO pois (city_id, category, name, description, address, latitude, longitude, rating, price_range, photo_url) VALUES
(2, 'hotel', 'Hotel Mactaris', 'Hôtel simple à Makthar, base idéale pour visiter le site archéologique', 'Route de Makthar', 35.8580, 9.2100, 3.8, '€€', 'https://images.unsplash.com/photo-1566073771259-6a8506099945'),
(2, 'hotel', 'Dar El Henchir', 'Maison d''hôtes authentique à 37km de Siliana, vue montagne', 'El Aroussa', 36.3800, 9.4500, 4.5, '€€€', 'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4'),
(3, 'site', 'Site archéologique de Makthar', 'Ancienne cité numide puis romaine Mactaris, forum, thermes', 'Makthar', 35.8547, 9.2044, 4.7, 'Gratuit', 'https://upload.wikimedia.org/wikipedia/commons/5/5f/Makthar_Forum.jpg'),
(4, 'site', 'Kesra Village Berbère', 'Village perché à 1200m, architecture traditionnelle', 'Kesra', 35.8130, 9.3640, 4.8, 'Gratuit', 'https://images.unsplash.com/photo-1539768942893-daf53e448371'),
(5, 'restaurant', 'Café Restaurant Gaffour Centre', 'Cuisine locale, grillades et couscous', 'Avenue Habib Bourguiba, Gaffour', 36.3175, 9.2980, 4.2, '€', 'https://images.unsplash.com/photo-1555396273-367ea4eb4db5'),
(2, 'musee', 'Musée de Siliana', 'Petit musée régional histoire et archéologie', 'Siliana Ville', 36.0840, 9.3700, 4.0, '2DT', 'https://images.unsplash.com/photo-1554907984-15263bfd63bd');
