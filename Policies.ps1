class LaxPolicy : IPasswordPolicy {
    [bool]TestPassword([string]$Password){
        return $true
    }
}

class RegexPolicy : IPasswordPolicy {
    hidden [regex]$regex

    RegexPolicy([string]$Pattern){
        $this.regex = [regex]$Pattern
    }

    RegexPolicy([regex]$Regex){
        $this.regex = $Regex
    }

    [bool]TestPassword([string]$Password){
        return $this.regex.IsMatch($Password)
    }
}

class BlackListPolicy : IPasswordPolicy {
    hidden [string[]]$terms

    BlackListPolicy([string[]]$BlackListedTerms)
    {
        $this.terms = $BlackListedTerms
    }

    [bool]TestPassword([string]$Password){
        foreach($term in $this.terms){
            if($Password -match [regex]::Escape($term)){
                return $false
            }
        }
        return $true
    }
}

class AdminPolicy : BlackListPolicy {
    AdminPolicy(){
        $this.terms = @(
            'password',
            '1234',
            'hackme'
        )
    }
}

class PCIPolicy : IPasswordPolicy {
    hidden [int]$minLength = 7

    [bool]TestPassword([string]$Password){
        return $Password.Length -ge $this.minLength -and $Password -cmatch '^(?=.*\p{Lu})(?=.*\p{Ll}).*$'
    }
}
