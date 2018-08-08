**How to use**
Software needed
Xcode9.3.1
Coccoapods

Installation
Download repostory from Github
Change to the root directory of the project containing Podfile
run pod install
Open weatherapp.xcworkspace
Run the application

How to use the app
Manual lookup 
Enter a place name and select a location from the list shown

Using GPS
click the search bar 
Click the Use current location button
If you have not given permission to teh app for use of location services you will be asked at this point
*If you are using the simulator please remember to set a simulated loation.

The list will then change to show the 5 day forcast

**To Do**
I set of a bit adventrous for 4Hrs work and planed for selection of hou temo should be shown. I have created the functions for this but they are not connected up.

I have wrtten 2 unit tests as examples but in final app there woudld be more

Error handling - at the moment is does not inform the user if somthing fails

UI - I have not had time to design the app so this need lots of work, I found some weather Icons and hoped to put these in the cells but did not get time

I would have split the UI in to 2 pages using page view if I hade more time and shown day on one page and week on the next

I included cocoapods but no pods I was hoping to include  (https://cocoapods.org/pods/Mockingjay) to be able to create test with stubbed APIs

