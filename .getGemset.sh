getGemset () {

  FILE=".ruby-gemset"

  local result

  if [ $# -eq 0 ]
  then
    if [ -f $FILE ]
    then
      result=$(head -n 1 $FILE)
      echo "$result"
    else
      echo "daisybill-api"
    fi
  else
    result=$1
    echo "$result"
  fi
}
