#! /usr/bin/awk -f

#----------------board_basic_structure-------------------
function board() {
  a=100
  b=90
  for(row=1;row<=10;row++) {
    print "\n-----------------------------------------"
    if (row%2==0) {
      for(column=b+1;column<=b+10;column++) {
        if(boxNumber[column]<10)
          printf "|" boxNumber[column] " |"
        else printf "|" boxNumber[column] "|" 
          }
      }
      else {
        for(column=a;column>a-10;column--){
          printf "|" boxNumber[column] "|"
        }
      }
      a=a-10;
      b=b-10
    }
    print "\n-----------------------------------------"
  }
  #---------assigning_snakes_&_ladders_on_board---------------
  function assign_snake_and_ladder() {
    snakeNumber=1
    for(snake_position=7;snake_position<100;snake_position=snake_position+12){
      boxNumber[snake_position]="🐍"
      snake[snakeNumber++]=snake_position
    }
    ladderNumber=1
    for(ladder_position=9;ladder_position<100;ladder_position=ladder_position+16){
      boxNumber[ladder_position]="🚀"
      ladder[ladderNumber++]=ladder_position
    }
  }
  #--------------------creating_board-------------------------
  function create_board(){
    assign_snake_and_ladder()
    board()
  }
  #--------------------------dice------------------------------
  function dice(){
    srand()
    number=int(rand()*6)+1
    dice_value=number
    return dice_value
  }
  #---------------movement_of_players_position------------------
  function movement_of_player(player,dice_value){
    if (player==1){
      score_of_playerA=score_of_playerA+dice_value
      score=score_of_playerA
    }
    else {
      score_of_playerB=score_of_playerB+dice_value
    score=score_of_playerB
  }
  return score
}

function check_win(player){
  if (score==100)
    return win=1
  if (score > 100)
    score=score-dice_value
}

function check_ladder(player){
  if (score==ladder[6]){
    score=95
    printf "wow you jump from ladder marked as " ladder[6] " to " score
  }
  for (ladderNumber=1; ladderNumber<6; ladderNumber++){
    if (ladder[ladderNumber]==score){
      printf "wow!! you got one jump from ladder marked as "score
      score=ladder[ladderNumber+1]+1
      if(player==1) 
        boxNumber[score]="⚾️"
      else
        boxNumber[score]="🏀"
    }
  }
}

function check_snakes(player){
  if (score==snake[1]) {
    score=2
    printf "ouch snake at " snake[1] "bite you"
  }
  for (snakeNumber=2; snakeNumber<=8; snakeNumber++ ){
    if  (snake[snakeNumber]==score){
      printf "ouch!! snake at"score" bite you"
      score=snake[snakeNumber-1]+1
    }
  }
  if(player==1) 
    boxNumber[score]="⚾️"
  else
    boxNumber[score]="🏀"
}

function check_collision(player){
  if(score!=0 && score<100 && score_of_playerA==score_of_playerB){
    if(player==1) {
      score_of_playerB=1
      boxNumber[score_of_playerB]="🏀"
    }
    else {
      score_of_playerA=1
    boxNumber[score_of_playerA]="⚾️"
  }
}
}
#-----------------------------begin_block----------------------------
BEGIN {
  print "let's play ludo"
  for(number=100;number>=1;number--) {
    boxNumber[number]=number
  }
  score_of_playerA=0
  score_of_playerB=0
  player=1
  create_board()
  win="👑"
  boxNumber[100]=win
  print "player1 turn\n please press enter key to play"
}
#-----------------------------main_block----------------------------
{
  if(player==1)
    boxNumber[score_of_playerA]=score_of_playerA
  else
    boxNumber[score_of_playerB]=score_of_playerB
  dice()
  print "dice_value="dice_value
  score=movement_of_player(player,dice_value)
  check_snakes(player)
  check_ladder(player)
  win=check_win(player)
  if (player==1){
    score_of_playerA=score
    boxNumber[score_of_playerA]="⚾️"
  }
  else {
    score_of_playerB=score
  boxNumber[score_of_playerB]="🏀"
}
check_collision(player)
create_board()
if(win==1){
  printf "congratulations!!! player " player " won the match"
  exit
}
if (player==1){
  player=2
  print "player" player " turn"
}
else{
  player=1
print "player" player " turn"
}
}

END{

  }
