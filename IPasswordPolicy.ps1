#Requires -Modules Legislator
interface IPasswordPolicy {
    method bool TestPassword @([string])
}
