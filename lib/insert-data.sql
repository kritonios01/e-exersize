CREATE TABLE IF NOT EXISTS Entries (
  game_id INT AUTO_INCREMENT,
  sport VARCHAR(20),
  region VARCHAR(50),
  time TIMESTAMP,
  duration INT,
  PRIMARY KEY(game_id)
);

INSERT INTO Entries (sport, region, time, duration) VALUES
('Volleyball', 'Zografou', '2024-01-22 12:30:00', 60),
('Volleyball', 'Zografou', '2024-01-22 12:30:00', 60),
('Basketball', 'Nea Erythraia', '2024-02-24 17:30:00', 90),
('Football', 'Peristeri', '2024-01-26 20:30:00', 120),
('Football', 'Peristeri', '2024-01-26 20:30:00', 120),
('Football', 'Peristeri', '2024-01-26 20:30:00', 120),
('Ice Skating', 'Aigaleo', '2024-01-30 18:00:00', 45),
('Football', 'Kifisia', '2024-03-02 17:00:00', 90),
('Football', 'Kifisia', '2024-03-02 17:00:00', 90),
('Basketball', 'Zografou', '2024-02-02 10:00:00', 120),
('Basketball', 'Zografou', '2024-02-02 10:00:00', 120),
('Tennis', 'Petroupoli', '2024-02-03 15:30:00', 60),
('Cycling', 'Piraeus', '2024-01-31 16:30:00', 180),
('Cycling', 'Piraeus', '2024-01-31 16:30:00', 180),
('Cycling', 'Piraeus', '2024-01-31 16:30:00', 180),
('Sailing ', 'Alimos', '2024-03-10 13:00:00', 90),
('Basketball', 'Zografou', '2024-01-25 18:00:00', 90),
('Swimming', 'Voula', '2024-03-25 09:00:00', 60),
('Football', 'Nikaia', '2024-02-08 14:15:00', 120),
('Ping pong', 'Zografou', '2024-01-28 19:30:00', 90),
('Ping pong', 'Zografou', '2024-01-28 19:30:00', 90),
('Bowling', 'Kallithea', '2024-02-10 17:30:00', 60),
('Volleyball', 'Chalandri', '2024-01-30 16:00:00', 90),
('Volleyball', 'Chalandri', '2024-01-30 16:00:00', 90);
