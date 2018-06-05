class UserAccount
{
    [IPasswordPolicy[]]$PasswordPolicies
    [string]$Name
    [string]$Password

    hidden [bool]$created = $false

    UserAccount([string]$Name,[string]$Password,[IPasswordPolicy[]]$Policies){
        $this.Name = $Name
        $this.Password = $Password
        $this.PasswordPolicies = if($Policies.Count -eq 0){
            @([LaxPolicy]::new())
        } else {
            $Policies
        }
    }

    [void]Create(){
        if($this.created){
            throw "User already created"
            return
        }
        foreach($Policy in $this.PasswordPolicies){
            if(-not $Policy.TestPassword($this.Password)){
                throw "Password does not comply with password policy"
                return
            }
        }

        New-ADUser -Name $this.Name -AccountPassword ($this.Password |ConvertTo-SecureString -AsPlainText -Force) -SamAccountName ($this.Name -replace '[^\.\w]')

        if($?){
            Write-Host "User created successfully!" -ForegroundColor Green
            $this.created = $true
        }
    }
}

function New-User
{
    param(
        [string]$Name,
        [string]$Password,
        [switch]$CardOperator,
        [switch]$Admin
    )

    $Policies = @(
        if($Admin){
            [BlackListPolicy]::new(@(
                "password"
                "1234"
                "hackme"
            ))
        }
        if($CardOperator){
            [PCIPolicy]::new()
        }
    )

    $NewUserAccount = [UserAccount]::new($Name,$Password,$Policies)
    $NewUserAccount.Create()
}
