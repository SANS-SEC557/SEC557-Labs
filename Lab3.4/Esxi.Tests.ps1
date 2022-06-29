Describe "ESXi Tests" {
    BeforeAll {
        #Get credentials from the secrets store to connect to the server
        $cred=Get-Secret ESXICreds

        if( $null -eq $cred )
        {
            throw "Credentials not found in secret store. Please set them using Set-Secret first!"
        }
        #Create a connection to the server being tested
        Connect-VIServer -server esxi1 -Credential $cred
    }

    AfterAll{
        #Close any remaining open connections
        Disconnect-VIServer * -Confirm:$false
    } 

    Context "Patching" {
        It "Version matches enterprise standard" {
            #List of approved build numbers for the enterprise
            $approvedBuilds = '17167537','17097218'
            $build = (Get-VMHost).Build
            $build -in $approvedBuilds | Should -Be $true
        }


        It "MegaRAID software is correct version" {
            ((Get-ESXCli -Server esxi1).software.vib.list()).ID -contains `
              'VMW_bootbank_scsi-megaraid-sas_6.603.55.00-2vmw.650.0.0.4564106' | 
              Should -Be $true
        }
    }
    Context "Server Settings" {
        It "DNS servers are correct" {
            $dnsservers = (Get-VMHost).Extensiondata.Config.Network.DNSConfig | Select-Object -ExpandProperty address
            $dnsservers -contains '10.50.7.2' | Should -Be $true
        }

        It "NTP Service Running" {
            $ntpSettings = Get-VMHost | Sort-Object Name | Select-Object Name, `
              @{N="NTPServer";E={$_ | Get-VMHostNtpServer}}, `
              @{N="ServiceRunning";E={(Get-VmHostService -VMHost $_ | Where-Object {$_.key-eq "ntpd"} ).Running}}, `
              @{N="ServiceRequired";E={(Get-VmHostService -VMHost $_ | Where-Object {$_.key-eq "ntpd"} ).Required}}
              $ntpSettings.Running | Should -Be $true
              $ntpSettings.Required | Should -Be $true
        }
    }
    Context "Storage" {  
        BeforeAll {
            $ds = (Get-VMHost -Server esxi1 | Get-Datastore)
        }  
        It "DataStore has > 15% free space" {
            $pctFree = $ds.FreeSpaceGB / $ds.CapacityGB * 100.0
            $pctFree | Should -BeGreaterThan 15.0
        }

        It "FileSystem version >= 6" {
            $ds.FileSystemVersion | Should -BeGreaterOrEqual 6
        }
    }
}