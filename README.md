This Login/Registration Test Page made with Flutter and FirebaseAuth.
The User will be able to access without having an account, this will create a anonymous account with no personal information. 
If the user wants to make an account he will be able to do so in 3 different ways: 
  Using his google account
  Using his facebook account
  Using email + password  -> to this method will follow an email verfication + sms verification
  
Inside the mock-application, the user will be able to access the profile page only if registered. From the profile page it is possible to delete the account or logout form the app



EMAIL - PASSWORD REGISTRATION
After inserting an email + password an email is sent to the user. Without verifying the email the user can't use the application.
The email can be sent multiple times. 
After veryifing the email the user has to press a button to refresh his state. I might upgrade this with a Stream that provides every x seconds the state of the email verification. 
  This could be more expensive and also I have to set a time limit for the email verification. After that limit the user needs to request a new verification email. 
I will use the same exact registration page and email verification page for the profile-registration-page that is shown when a user without being logged is tries to open the profile page. 



