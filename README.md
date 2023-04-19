Function Show-MeBeingSuperBusy {
    [CmdletBinding()]
    Param (
        [Parameter()]
        [ValidateRange(1,10)]
        [int]$ConsoleCount = 1
    )

    Begin {
        $Commands = @(
            '-NoProfile -Command & {Get-ChildItem -Path C:\ -Recurse}',
            '-NoProfile -Command & {Get-Process}',
            '-NoProfile -Command & {Get-Service}',
            '-NoProfile -Command & {Get-ChildItem -Path env:\}',
            '-NoProfile -Command & {Get-ChildItem -Path HKLM:\ -Recurse}'
        )

        $TotalCommands = $Commands.Count
        $SleepTime = 1..10 | Get-Random
    }

    Process {
        For ($i = 1; $i -le $ConsoleCount; $i++) {
            $CommandIndex = Get-Random -Minimum 0 -Maximum $TotalCommands
            $Command = $Commands[$CommandIndex]
            Start-Process -FilePath powershell.exe -ArgumentList $Command

            Start-Sleep -Seconds $SleepTime
            Write-Progress -Activity "Processing $i console(s)" -Status "Running command $CommandIndex" -PercentComplete (($i / $ConsoleCount) * 100)
        }
    }

    End {
    }
}

Show-MeBeingSuperBusy -ConsoleCount 5
