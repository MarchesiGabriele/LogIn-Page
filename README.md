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



TODO LIST: 
- !!Quando si crea un account con email, l'account viene creato prima della verifica email. Se la verifica email fallisce l'account è comunque creato ma non è verificato. Quindi decidere se creare account dopo la verifica o se permettere all'utente di verificare l'account in un secondo momento
- Nella Home() cercare una soluzione per non avere all'interno della classe il metodo per conoscere lo stato dell'utente. Eventualmente capire se posso prendere lo stato da RootPage() o se posso evitare di usare il futurebuilder.
- Cambiare il layout della pagina di registrazione. La prima cosa che l'utente deve vedere è la pagina di Login con i anche i metodi di login/registrazione con social. Se poi vuole registrarsi allora può andare sulla pagina di registrazione dove può registrarsi con email e password o con i vari social. 
- Nella RegistrationPage() aggiungere dei controlli aggiuntivi alla email e alla password prima di procedere con la creazione dell account. (es. formato email sia valido, password non sia troppo debole etc.) Stare attenti in caso di email con formato valido ma non esistenti, capire se firebase lancia eccezine o meno. 
- Nella RegistrationPage() usare una form per il campo email, password e bottone Registrati. 
- In SceltaVerificaAccount() gestire le eccezioni che possono essere lanciate alla creazione del'account con email. Se vengono lanciate queste eccezioni devo tornare alla pagina di registrazione ed indicare qual'è il problema. 