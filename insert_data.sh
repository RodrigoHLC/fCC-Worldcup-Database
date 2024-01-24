#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINGOALS OPPGOALS
do
  if [[ $YEAR != 'year' ]]
  then
    TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'" )
    if [[ -z $TEAM_ID ]]
    then
    echo  $($PSQL "INSERT INTO teams(name) VALUES ('$WINNER')" )
    fi

    OPP_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'" )
    if [[ -z $OPP_ID ]]
    then
    echo  $($PSQL "INSERT INTO teams(name) VALUES ('$OPPONENT')" )
    fi

    WIN_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'" )
    OPP_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'" )

    echo "$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR, '$ROUND', $WIN_ID, $OPP_ID, $WINGOALS, $OPPGOALS) ")"

  fi
done
# SUBTASKS 1.1 "before all" hook for ":1 "worldcup" database should exist"
