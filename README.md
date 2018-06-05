# IPasswordPolicy
[Legislator](https://github.com/IISResetMe/Legislator) example - strategy pattern

This repository serves as an example of a strategy pattern implementation using Legislator for an `IPasswordPolicy` interface

To see it in action, you'll need to import the files in the right order - Legislator must define the interface before you import any files containing class definitions that make references to the interface:

```powershell
PS C:\> . IPasswordPolicy.ps1
PS C:\> . Policies.ps1
PS C:\> . New-User.ps1
PS C:\> New-User "Joe Nobody" -Password "weak"
User created successfully!

PS C:\> New-User "Andy Admin" -Password "password" -Admin
Password does not comply with password policy
At C:\IPasswordPolicy\New-User.ps1:26 char:17
+                 throw "Password does not comply with password policy"
+                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : OperationStopped: (Password does n...password policy:String) [], RuntimeException
    + FullyQualifiedErrorId : Password does not comply with password policy

PS C:\> New-User "Anna Admin" -Password "2Gu,8[<ppC(fZQ7~" -Admin
User created successfully!

PS C:\> New-User "Peter Payment" -Password "p4sw0d" -CardOperator
Password does not comply with password policy
At C:\IPasswordPolicy\New-User.ps1:26 char:17
+                 throw "Password does not comply with password policy"
+                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : OperationStopped: (Password does n...password policy:String) [], RuntimeException
    + FullyQualifiedErrorId : Password does not comply with password policy

PS C:\> New-User "Peter Payment" -Password "p4ssw0rd" -CardOperator
User created successfully!

```
