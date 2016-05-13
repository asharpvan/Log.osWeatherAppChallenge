# Log.osWeatherAppChallenge




# LOG.OS Social Document.


Please find the submitted app that was provided as a part of challenge. Please note that it has been developed using Objective C. This was brought to notice of Mr. Kiran Pasavedala.


The sample app Shows the current weather for Gautam Buddha Nagar, UP, India. aka Noida.

I know the UI looks a bit hopeless, but the app scores well of feature set. 

On pressing the “Forecast” button one can see the weather conditions for next 10 days approx as returned by yahoo api.


I have created data models and custom api clients to interact with the program logic and Remote server. 

The code has been cleaned. Im sorry I haven’t added any comments. Since the coding was taking a lot of time so I went against adding them.


Also, as you might have noticed that I am not showing the weather icons. Originally I had intended to do the same but on going through the doc for condition code (https://developer.yahoo.com/weather/documentation.html) I decided against it as I found it to be very confusing. Thunderstorm appear at 5 and then again at 37. I found it confusing to segregate the icons based on their codes. If you notice the coding I have actively tracked and saved the condition codes for both current weather condition and forecast conditions.

# How To Run the code
To Run the program press cmd + r, after opening Boilerplate.xcodeproj on Xcode, and the program should run on simulator.