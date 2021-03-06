"Demo for SEC557 Classes"

#List only cmdlets
Get-Command -CommandType Cmdlet
Get-Command -CommandType Cmdlet | Measure-Object
Get-Command -CommandType Cmdlet -Name *Job

#List only functions
Get-Command -CommandType Function
Get-Command -CommandType Function -Module Storage*

#Aliases

#ls to list files in directory
ls
#or dir
dir
#or Get-ChildITem
Get-ChildItem
#or gci
gci

Get-Command -CommandType Alias
Get-Alias
Get-Alias gsv

#Applications - PowersShell uses applications from your PATH
#Find the PATH environment variable
$env:Path

# Env: is a PSDrive representing your environment variables
Get-ChildItem Env:

#Parameters modify/enhance the behavior of a command
#The CommandType parameter limits which types of commands will be returned
Get-Command -CommandType Application 
Get-Command -CommandType Application | Measure-Object

#Use the positional paramter for Name
Get-Command -CommandType Application task*

#Cmdlets always use a Verb-Noun name format
Get-Verb
Get-Command -Noun "Service"

#Aside - PowerShell quotation marks
# Quotation marks are generally optional, unless using a string containing a space
# Convention is to use single quotes (') for most strings. Double Quotes (") are used for
# including a variable value in a string or for including a single quote in a string

Write-Host 'Hello'

#Put the PS version in a variable so we can see how quotation marks work with variables
$v = $PSVersionTable.PSVersion

#Single quotes treats strings as literals
Write-Host 'Your PowerShell version is $v'

#Double quotes will expand the contents of a variable
Write-Host "Your PowerShell version is $v"

#Grave accent (`) - under the ~ key on US keyboards - used as "escape character"
#print a tab character
write-host "Col 1`t`tCol 2"

#print an escaped newline character
write-host "line 1`nline 2"

#Getting Help
Get-Help Get-Service

#Man and the help function run get-help | more
#The more function does not work in the ISE, but it does in the console
Get-Alias Man
Get-Command help

#Using the -online flag
Get-Help Get-Service -Online

#Other Get-Help commands
#Get-Help Get-ADComputer -Examples
#Get-Help Get-ADComputer -Full
#Get-Help Get-ADUser -ShowWindow
Get-Help Get-ADUser -Parameter F*


#update your help files to the most current version
#Run these in another shell, since they take a long time...
# Update-Help
# Remove-Item -Path ".\HelpFiles" -Recurse
# New-Item -Name HelpFiles -ItemType Directory -Path "."
# Save-Help -DestinationPath ".\HelpFiles" 
# Update-Help -SourcePath ".\HelpFiles"
