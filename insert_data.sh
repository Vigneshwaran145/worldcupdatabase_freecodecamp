#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

echo $($PSQL "truncate teams, games;")

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $YEAR != year ]]
  then 
    echo $YEAR $ROUND $WINNER
    #get winner team id
    WINNER_TEAM_ID=$($PSQL "select team_id from teams where name='$WINNER';" )

    if [[ -z $WINNER_TEAM_ID ]]
    then
      WINNER_TEAM_INSERT_RESULT=$($PSQL "insert into teams(name) values('$WINNER') ;")
    fi

    #get opponent team id
    OPPONENT_TEAM_ID=$($PSQL "select team_id from teams where name='$OPPONENT';" )

    if [[ -z $OPPONENT_TEAM_ID ]]
    then
      OPPONENT_TEAM_INSERT_RESULT=$($PSQL "insert into teams(name) values('$OPPONENT') ;")
    fi
    WINNER_TEAM_ID=$($PSQL "select team_id from teams where name='$WINNER';" )
    OPPONENT_TEAM_ID=$($PSQL "select team_id from teams where name='$OPPONENT';" )

    echo $TEAM_OPPONENT_ID and $OPPONENT_TEAM_ID
    echo $($PSQL "insert into  games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) values($YEAR, '$ROUND', $WINNER_TEAM_ID, $OPPONENT_TEAM_ID, $WINNER_GOALS, $OPPONENT_GOALS)  ;")
  fi
done