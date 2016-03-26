# Arrive

#### Query flight details and request a car to the airport based on when you land

### Things to improve

- Better design pattern for mapping/parsing json responses... using something like Mantle
- Make use of airportResources so the user would know which gate to order their car to
- Make use of the operationalTimes from the FlightStatus API to make a better determination as to when the customer will actually arrive at the airport. (delayed, longer taxiing time, etc...)
- Make searching for airports easier. Allow proper names, tokenize input.
- Make better date selection for flights
- Better communication to user about the local time in their arrival city


### Things to explain

- Explain why pods are under version control

