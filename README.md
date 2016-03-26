# Arrive

#### Query flight details and request a car to the airport based on when you land

### Things to improve

- Make use of more of the info returned by the FlightStatus API. (aircraft type, flight time, taxi time, whether, gate, terminal, etc.)
- Make use of the operationalTimes from the FlightStatus API to make a better determination as to when the customer will actually arrive at the airport. (delayed, early, etc...)
- Make searching for airports easier. Allow proper names, tokenize input.
- Make better date selection for flights.
- Better communication to user about the change in time zones. (UTC vs local time. Time change from departure and arrival cities)
- Proper background threading for json->core data entity conversion
- Sanitize airport query input/url escape it


### Things to explain
	
- Explain why pods are under version control

