
******** UNFINISHED ***********
After trying Firebase as a auth method I don't like how it works and I would like to have more freedom, so I will make a version 2 of this project with a custom backend/custom auth methods. 
This will allow me to have a better control on currentUsers

Things I dont like about Firebase (I didnt find a solution for these problems. There might be one, but its well hidden)
- I cant manually modify user account data
- With Phone Auth I want more freedom / I want to use it to verify an account and not as an access method
- Most of the documentation is deprecated



This Login/Registration Test Page made with Flutter and FirebaseAuth.
The User will be able to access without having an account, this will create a anonymous account with no personal information. 
If the user wants to make an account he will be able to do so in 3 different ways: 
  Using his google account
  Using his facebook account
  Using email + password  -> to this method will follow an email verfication + sms verification
  
Inside the mock-application, the user will be able to access the profile page only if registered. From the profile page it is possible to delete the account or logout form the app

CONS: 
The account is always created before the verification, so if the verification fails I have to delete it. This is not the best aproach. It should be better to wait and create the account after it is verified. No accounts can be created without being immediatly verified. 
Unfortunatly seems like firebase wants to create an account before verifying it. 


EMAIL VERIFICATION: 
If the user creates the account with the email and password he can verify it with the email. 
The account is created, then the email is sent to the user for the verification. If the verification is completed good. If after an amount of time it still isnt verified the account is deleted and the user is sent to re registration page. If the user closes the app while verifing the account, the account remains created but the next time the user opens the app, the account will be deleted and the user will need to create a new one. 
Everytime the app is opened it checks is the account of the user is verified, if it is not it deletes the account. 



TODO LIST: 
- !!Quando si crea un account con email, l'account viene creato prima della verifica email. Se la verifica email fallisce l'account è comunque creato ma non è verificato. Quindi decidere se creare account dopo la verifica o se permettere all'utente di verificare l'account in un secondo momento
- Nella Home() cercare una soluzione per non avere all'interno della classe il metodo per conoscere lo stato dell'utente. Eventualmente capire se posso prendere lo stato da RootPage() o se posso evitare di usare il futurebuilder.
- Cambiare il layout della pagina di registrazione. La prima cosa che l'utente deve vedere è la pagina di Login con i anche i metodi di login/registrazione con social. Se poi vuole registrarsi allora può andare sulla pagina di registrazione dove può registrarsi con email e password o con i vari social. 
- Nella RegistrationPage() aggiungere dei controlli aggiuntivi alla email e alla password prima di procedere con la creazione dell account. (es. formato email sia valido, password non sia troppo debole etc.) Stare attenti in caso di email con formato valido ma non esistenti, capire se firebase lancia eccezine o meno. 
- Nella RegistrationPage() usare una form per il campo email, password e bottone Registrati. 
- In SceltaVerificaAccount() gestire le eccezioni che possono essere lanciate alla creazione del'account con email. Se vengono lanciate queste eccezioni devo tornare alla pagina di registrazione ed indicare qual'è il problema. 