function Get-MachineInfo {
    param (
        [string[]]$ComputerName,
        [string]$LogFailuresToPath,
        [string]$Protocol="Wsman",
        [switch]$ProtocolFallback
    )
    
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
        #Todo
    }#Foreach
}#Function