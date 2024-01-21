CREATE TABLE IF NOT EXISTS Entries (
  game_id INT AUTO_INCREMENT,
  sport VARCHAR(20),
  region VARCHAR(50),
  time TIMESTAMP,
  duration INT,
  PRIMARY KEY(game_id)
);

INSERT INTO Entries (sport, region, time, duration) VALUES
('Volleyball', 'Zografou', '2023-01-22 12:30:00', 60);