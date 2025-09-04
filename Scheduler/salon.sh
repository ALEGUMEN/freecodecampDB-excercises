#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=salon --tuples-only --no-align -q -c"

echo -e "\n~~~~~ MY SALON ~~~~~"
echo -e "Welcome to My Salon, how can I help you?\n"


GET_SERVICES() {
  SERVICES=$($PSQL "SELECT service_id, name FROM services ORDER BY service_id")
  while IFS="|" read SERVICE_ID NAME
  do
    echo "$SERVICE_ID) $NAME"
  done <<< "$SERVICES"
}


while true
do
  GET_SERVICES
  echo -e "\nPlease choose a service by number:"
  read SERVICE_ID_SELECTED

  
  if ! [[ $SERVICE_ID_SELECTED =~ ^[0-9]+$ ]]; then
    echo -e "\nInvalid input. Enter a number.\n"
    continue
  fi

  
  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED" | xargs)

  if [[ -z $SERVICE_NAME ]]; then
    echo -e "\nI could not find that service. Please choose again.\n"
  else
    break
  fi
done


echo -e "\nWhat's your phone number?"
read CUSTOMER_PHONE

CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'" | xargs)
CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'" | xargs)

if [[ -z $CUSTOMER_ID ]]; then
  echo -e "\nI don't have a record for that phone number. What's your name?"
  read CUSTOMER_NAME

  $PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME')" > /dev/null
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'" | xargs)
fi


echo -e "\nWhat time would you like your $SERVICE_NAME, $CUSTOMER_NAME?"
read SERVICE_TIME

$PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')" > /dev/null

echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
