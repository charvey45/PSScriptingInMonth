function Get-MachineInfo {
    
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline=$true,Manditory=$true,ValueFromPipelineByPropertyName=$true)]
        [Alias('CN','MachineName','Name')]
        [string[]]$ComputerName,
        [string]$LogFailuresToPath,
        [ValidateSet('Wsman','Dcom')]
        [string]$Protocol="Wsman",
        [switch]$ProtocolFallback
    )
    
    Begin{}

    PROCESS{
        foreach ($computer in $ComputerName) {
            #Establish Session Protocol
            if ($Protocol -eq 'Dcom'){
                $option = New-CimSessionOption -Protocol Dcom
            } else {
                $option = New-CimSessionOption -Protocol Wsman
            }

            #Connect session
            $Session = New-CimSession -ComputerName $computer -SessionOption $option

            #query data
            $os= Get-CimInstance -ClassName Win32_OperatingSystem -CimSession $Session

            #Close session
            $Session|Remove-CimSession

            #OutpuData
            $os |Select-Object -Property @{n='ComputerName'; e={$ComputerName}},Version,ServicePackMajorVersion
        }#Foreach
    } #Process

    End {}

}#Function