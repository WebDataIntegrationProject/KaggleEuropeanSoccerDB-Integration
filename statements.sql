-- The following statements were used to get the data:


-- players
select 
	p.player_api_id as id, 
	p.player_name, 
	p.birthday, 
	p.height, 
	p.weight, 
	pa.preferred_foot, 
	pa.date as valid_as_of 
from Player p 
inner join Player_Attributes pa 
on p.id = pa.id;


-- clubs
select id, team_long_name, team_short_name 
from Team;


-- clubs for players
select * from players_with_recent_club;



--------------------------------------------------------------------------
-- Helper Views
--------------------------------------------------------------------------

drop view home_players;
drop view away_players;
drop view all_players;
drop view players_with_recent_club_ids;
drop view players_with_recent_club;


-- all home_players
create view home_players as

select match.home_player_1 as player_id, team.id as team_id, max(match.date) as valid_date

from Match match

inner join Team team

on team.team_api_id = match.home_team_api_id

where match.home_player_1 is not null


union


select match.home_player_2 as player_id, team.id as team_id, max(match.date) as valid_date

from Match match

inner join Team team

on team.team_api_id = match.home_team_api_id

where match.home_player_2 is not null


union


select match.home_player_3 as player_id, team.id as team_id, max(match.date) as valid_date

from Match match

inner join Team team

on team.team_api_id = match.home_team_api_id

where match.home_player_3 is not null


union


select match.home_player_4 as player_id, team.id as team_id, max(match.date) as valid_date

from Match match

inner join Team team

on team.team_api_id = match.home_team_api_id

where match.home_player_4 is not null


union


select match.home_player_5 as player_id, team.id as team_id, max(match.date) as valid_date

from Match match

inner join Team team

on team.team_api_id = match.home_team_api_id

where match.home_player_5 is not null


union


select match.home_player_6 as player_id, team.id as team_id, max(match.date) as valid_date

from Match match

inner join Team team

on team.team_api_id = match.home_team_api_id

where match.home_player_6 is not null


union


select match.home_player_7 as player_id, team.id as team_id, max(match.date) as valid_date

from Match match

inner join Team team

on team.team_api_id = match.home_team_api_id

where match.home_player_7 is not null


union


select match.home_player_8 as player_id, team.id as team_id, max(match.date) as valid_date

from Match match

inner join Team team

on team.team_api_id = match.home_team_api_id

where match.home_player_8 is not null


union


select match.home_player_9 as player_id, team.id as team_id, max(match.date) as valid_date

from Match match

inner join Team team

on team.team_api_id = match.home_team_api_id

where match.home_player_9 is not null


union


select match.home_player_10 as player_id, team.id as team_id, max(match.date) as valid_date

from Match match

inner join Team team

on team.team_api_id = match.home_team_api_id

where match.home_player_10 is not null


union


select match.home_player_11 as player_id, team.id as team_id, max(match.date) as valid_date

from Match match

inner join Team team

on team.team_api_id = match.home_team_api_id

where match.home_player_11 is not null


group by player_id, team_id;





create view away_players as


select match.away_player_1 as player_id, team.id as team_id, max(match.date) as valid_date

from Match match

inner join Team team

on team.team_api_id = match.away_team_api_id

where match.away_player_1 is not null


union


select match.away_player_2 as player_id, team.id as team_id, max(match.date) as valid_date

from Match match

inner join Team team

on team.team_api_id = match.away_team_api_id

where match.away_player_2 is not null


union


select match.away_player_3 as player_id, team.id as team_id, max(match.date) as valid_date

from Match match

inner join Team team

on team.team_api_id = match.away_team_api_id

where match.away_player_3 is not null


union


select match.away_player_4 as player_id, team.id as team_id, max(match.date) as valid_date

from Match match

inner join Team team

on team.team_api_id = match.away_team_api_id

where match.away_player_4 is not null


union


select match.away_player_5 as player_id, team.id as team_id, max(match.date) as valid_date

from Match match

inner join Team team

on team.team_api_id = match.away_team_api_id

where match.away_player_5 is not null


union


select match.away_player_6 as player_id, team.id as team_id, max(match.date) as valid_date

from Match match

inner join Team team

on team.team_api_id = match.away_team_api_id

where match.away_player_6 is not null


union


select match.away_player_7 as player_id, team.id as team_id, max(match.date) as valid_date

from Match match

inner join Team team

on team.team_api_id = match.away_team_api_id

where match.away_player_7 is not null


union


select match.away_player_8 as player_id, team.id as team_id, max(match.date) as valid_date

from Match match

inner join Team team

on team.team_api_id = match.away_team_api_id

where match.away_player_8 is not null


union


select match.away_player_9 as player_id, team.id as team_id, max(match.date) as valid_date

from Match match

inner join Team team

on team.team_api_id = match.away_team_api_id

where match.away_player_9 is not null


union


select match.away_player_10 as player_id, team.id as team_id, max(match.date) as valid_date

from Match match

inner join Team team

on team.team_api_id = match.away_team_api_id

where match.away_player_10 is not null


union


select match.away_player_11 as player_id, team.id as team_id, max(match.date) as valid_date

from Match match

inner join Team team

on team.team_api_id = match.away_team_api_id

where match.away_player_11 is not null


group by player_id, team_id;


-- all players
create view all_players as

select * from home_players
union
select * from away_players;


-- players and their most recent club (club of latest match in data set)
-- only their ids
create view players_with_recent_club_ids as
select ap1.player_id as player_id, ap1.team_id as team_id, ap1.valid_date as ValidAsOf
from all_players ap1
where 
	ap1.valid_date = 
	(
	select max(ap2.valid_date)
	from all_players ap2
	where
		ap2.player_id = ap1.player_id
		and
		ap2.team_id = ap2.team_id
	);




-- Players with their latest club and text.
create view players_with_recent_club as
select
	pwc.player_id as player_id, 
	p.player_name as player_name,
	pwc.team_id as team_id,
	t.team_long_name as team_long_name,
	pwc.validAsOf as validAsOf
from 
	players_with_recent_club_ids pwc
inner join 
	Player p
	on p.player_api_id = pwc.player_id -- it really is the api_id
inner join
	Team t
	on t.id = pwc.team_id; -- it really is the team id




