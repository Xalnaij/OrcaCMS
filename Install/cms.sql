CREATE DATABASE orcacms;
USE orcacms;

CREATE TABLE IF NOT EXISTS clan
(
  clan_id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  clan_name VARCHAR(255) NOT NULL,
  clan_founding_year int,
  clan_short_description VARCHAR(255),
  clan_description TEXT
)
ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS players
(
  player_id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  player_nickname VARCHAR(50) NOT NULL,
  player_avatar VARCHAR (255),
  player_birthday DATE,
  first_name VARCHAR(50),
  last_name VARCHAR(100),
  player_steam VARCHAR(255),
  player_league_of_legends_username VARCHAR(255),
  player_origin VARCHAR(255),
  player_uplay VARCHAR(255),
  player_join_date DATETIME DEFAULT NOW(),
  player_active BOOLEAN DEFAULT 0 NOT NULL
)
ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS users
(
  user_id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_nickname VARCHAR(50) NOT NULL,
  user_email VARCHAR(191) NOT NULL UNIQUE,
  user_password CHAR(64) NOT NULL,
  user_avatar VARCHAR (255),
  user_active BOOLEAN DEFAULT 0 NOT NULL
)
ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS positions
(
  position_id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  position_name VARCHAR(191) NOT NULL UNIQUE,
  position_description VARCHAR(1000)
)
ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS rights
(
  right_id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  right_def VARCHAR (255) NOT NULL,
  right_description VARCHAR (1000)
)
ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS games
(
  game_id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  game_name VARCHAR(255) NOT NULL,
  game_icon VARCHAR(255),
  game_active BOOLEAN NOT NULL DEFAULT 1,
  game_since DATE
)
ENGINE = INNODB;

DROP TRIGGER IF EXISTS games_date;
DELIMITER ;;
CREATE TRIGGER `games_date` BEFORE INSERT ON `games` FOR EACH ROW
BEGIN
    SET NEW.game_since = NOW();
END;;
DELIMITER ;

CREATE TABLE IF NOT EXISTS teams
(
  team_id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  team_name VARCHAR(191) NOT NULL UNIQUE
)
ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS roles
(
  role_id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  role_name VARCHAR(191) NOT NULL UNIQUE, 
)

CREATE TABLE IF NOT EXISTS streams
(
  stream_id     INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  stream_name   VARCHAR(191)  NOT NULL UNIQUE,
  stream_link   VARCHAR(1000) NOT NULL,
  stream_active BOOLEAN DEFAULT 1
)
ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS servers
(
  server_id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  server_title VARCHAR(255) NOT NULL,
  server_ip VARCHAR(191) NOT NULL UNIQUE,
  server_active BOOLEAN DEFAULT 1
)
ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS servertypes
(
  servertype_id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  servertype_name VARCHAR (191) NOT NULL UNIQUE,
  servertype_icon VARCHAR (255) NOT NULL
)
ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS news
(
  news_id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  news_title VARCHAR (255) NOT NULL,
  news_header VARCHAR (255) NOT NULL,
  news_content MEDIUMTEXT NOT NULL,
  news_created DATETIME DEFAULT NOW(),
  news_active BOOLEAN DEFAULT 1
)
ENGINE = INNODB;

CREATE TABLE tags (
    tag_id INT AUTO_INCREMENT PRIMARY KEY,
    tag_name VARCHAR(191) UNIQUE
)
ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS sponsors
(
  sponsor_id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  sponsor_name VARCHAR (255) NOT NULL,
  sponsor_logo VARCHAR (255) NOT NULL,
  sponsor_since DATETIME DEFAULT NOW(),
  sponsor_active BOOLEAN DEFAULT 1
)
ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS clanwars
(
  clanwar_id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  clanwar_title VARCHAR(255) NOT NULL,
  clanwar_date DATE,
  clanwar_active BOOLEAN DEFAULT 1
)
ENGINE = INNODB;

DROP TRIGGER IF EXISTS `clanwars_date`;
DELIMITER ;;
CREATE TRIGGER `clanwars_date` BEFORE INSERT ON `clanwars` FOR EACH ROW
BEGIN
    SET NEW.clanwar_date = NOW();
END;;
DELIMITER ;

CREATE TABLE IF NOT EXISTS cw_match
(
  cw_match_id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  cw_match_rounds_first_team int NOT NULL,
  cw_match_rounds_second_team int NOT NULL
)
ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS cw_enemy
(
  cw_enemy_id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  cw_enemy_name VARCHAR(191) NOT NULL UNIQUE,
  cw_enemy_icon VARCHAR(255),
  cw_enemy_active BOOLEAN DEFAULT 1
)
ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS player_statistics
(
  player_id int NOT NULL,
  cw_match_id int NOT NULL,
  player_kills int,
  player_assists int,
  player_deaths int,
  player_three_kills int,
  player_four_kills int,
  player_aces int,
  player_rws decimal,
  player_hltv decimal,
  CONSTRAINT pk_ps_player_statistics PRIMARY KEY (player_id,cw_match_id),
  CONSTRAINT fk_ps_user FOREIGN KEY (player_id) REFERENCES players (player_id),
  CONSTRAINT fk_ps_cw_match FOREIGN KEY (cw_match_id) REFERENCES cw_match (cw_match_id)
)
ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS users_2_positions
(
  user_id int NOT NULL,
  position_id int NOT NULL,
  CONSTRAINT pk_u2p_user_position PRIMARY KEY (player_id,position_id),
  CONSTRAINT fk_u2p_user FOREIGN KEY (user_id) REFERENCES users (users_id),
  CONSTRAINT fp_u2p_position FOREIGN KEY (position_id) REFERENCES positions (position_id)
)
ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS players_2_teams
(
  player_id int NOT NULL,
  team_id int NOT NULL,
  CONSTRAINT pk_u2t_player_team PRIMARY KEY (player_id,team_id),
  CONSTRAINT fk_u2t_user FOREIGN KEY (player_id) REFERENCES players (player_id),
  CONSTRAINT fk_u2t_team FOREIGN KEY (team_id) REFERENCES teams (team_id)
)
ENGINE = INNODB;
CREATE TABLE IF NOT EXISTS players_2_streams
(
  player_id int NOT NULL,
  stream_id int NOT NULL ,
  CONSTRAINT pk_u2s_player_stream PRIMARY KEY (player_id,stream_id),
  CONSTRAINT fk_u2s_user FOREIGN KEY (player_id) REFERENCES players (player_id),
  CONSTRAINT fk_u2s_stream FOREIGN KEY (stream_id) REFERENCES streams (stream_id)
)
ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS users_2_news
(
  user_id int NOT NULL,
  news_id int NOT NULL,
  CONSTRAINT pk_u2n_users_news PRIMARY KEY (user_id,news_id),
  CONSTRAINT fk_u2n_user FOREIGN KEY (user_id) REFERENCES users (user_id),
  CONSTRAINT fk_u2n_news FOREIGN KEY (news_id) REFERENCES news (news_id)
)
ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS news_2_tag
(
  news_id int NOT NULL,
  tag_id int NOT NULL,
  CONSTRAINT pk_n2t_news_tag PRIMARY KEY (news_id,tag_id),
  CONSTRAINT fk_n2t_news FOREIGN KEY (news_id) REFERENCES news (news_id),
  CONSTRAINT fk_n2t_tag FOREIGN KEY (tag_id) REFERENCES tags (tag_id)
)
ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS positions_2_rights
(
  position_id int NOT NULL,
  right_id int NOT NULL,
  CONSTRAINT pk_p2r_position_right PRIMARY KEY (position_id,right_id),
  CONSTRAINT fk_p2r_position FOREIGN KEY (position_id) REFERENCES positions (position_id),
  CONSTRAINT fk_p2r_right FOREIGN KEY (right_id) REFERENCES rights (right_id)
)
ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS teams_2_games
(
  team_id int NOT NULL,
  game_id int NOT NULL,
  CONSTRAINT pk_t2g_team_game PRIMARY KEY (team_id,game_id),
  CONSTRAINT fk_t2g_team FOREIGN KEY (team_id) REFERENCES teams (team_id),
  CONSTRAINT fk_t2g_game FOREIGN KEY (game_id) REFERENCES games (game_id)
)
ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS streams_2_games
(
  stream_id int NOT NULL,
  game_id int NOT NULL,
  CONSTRAINT pk_s2g_stream_game PRIMARY KEY (stream_id,game_id),
  CONSTRAINT fk_s2g_stream FOREIGN KEY (stream_id) REFERENCES streams (stream_id),
  CONSTRAINT fk_s2g_game FOREIGN KEY (game_id) REFERENCES games (game_id)
)
ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS servers_2_servertypes
(
  server_id int NOT NULL,
  servertype_id int NOT NULL,
  CONSTRAINT pk_s2s_server_servertype PRIMARY KEY (server_id,servertype_id),
  CONSTRAINT fk_s2s_server FOREIGN KEY (server_id) REFERENCES servers (server_id),
  CONSTRAINT fk_s2s_servertype FOREIGN KEY (servertype_id) REFERENCES servertypes (servertype_id)
)
ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS servers_2_games
(
  server_id int NOT NULL,
  game_id int NOT NULL,
  CONSTRAINT pk_sv2g_server_game PRIMARY KEY (server_id,game_id),
  CONSTRAINT fk_sv2g_server FOREIGN KEY (server_id) REFERENCES servers (server_id),
  CONSTRAINT fk_sv2g_game FOREIGN KEY (game_id) REFERENCES games (game_id)
)
ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS clanwars_2_teams
(
  clanwar_id int NOT NULL,
  team_id int NOT NULL,
  CONSTRAINT pk_c2t_clanwar_team PRIMARY KEY (clanwar_id,team_id),
  CONSTRAINT fk_c2t_clanwar FOREIGN KEY (clanwar_id) REFERENCES clanwars (clanwar_id),
  CONSTRAINT fk_c2t_team FOREIGN KEY (team_id) REFERENCES teams (team_id)
)
ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS clanwars_2_cw_match
(
  clanwar_id int NOT NULL,
  cw_match_id int NOT NULL,
  CONSTRAINT pk_c2cm_clanwar_cw_match PRIMARY KEY (clanwar_id,cw_match_id),
  CONSTRAINT fk_c2cm_clanwar FOREIGN KEY (clanwar_id) REFERENCES clanwars (clanwar_id),
  CONSTRAINT fk_c2cm_cw_match FOREIGN KEY (cw_match_id) REFERENCES cw_match (cw_match_id)
)
ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS clanwars_2_cw_enemy
(
  clanwar_id int NOT NULL,
  cw_enemy_id int NOT NULL,
  CONSTRAINT pk_c2ce_clanwar_cw_enemy PRIMARY KEY (clanwar_id,cw_enemy_id),
  CONSTRAINT fk_c2ce_clanwar FOREIGN KEY (clanwar_id) REFERENCES clanwars (clanwar_id),
  CONSTRAINT fk_c2ce_cw_enemy FOREIGN KEY (cw_enemy_id) REFERENCES cw_enemy (cw_enemy_id)
)
ENGINE = INNODB;

INSERT INTO users
(
  user_nickname,
  user_email,
  user_password
)
VALUES
(
  'dev',
  'dennis.haunschild@web.de',
  'toor'
);

INSERT INTO news
  (
    news_title,
    news_header,
    news_content
  )
VALUES
  (
    'Tutorial News',
    'Dies ist ein Tutorial!',
    'Diese News wollen wir dazu verwenden das CakePHP Tutorial zu kompletieren.'
  );

INSERT INTO tags (tag_name) VALUE ('Tutorial');
INSERT INTO users_2_news (user_id, news_id) VALUES (1,1);
INSERT INTO news_2_tag (news_id, tag_id) VALUES (1,1);
