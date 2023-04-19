Function Pretend-To-Be-Busy {
    [CmdletBinding()] # Adds advanced cmdlet binding features to the function
    Param (
        [Parameter()] # Specifies a parameter for the function
        [ValidateRange(1,10)] # Validates the range of values that can be entered for the parameter
        [int]$ConsoleCount = 1 # Sets the default value for the parameter if it's not specified
    )

    Begin { # Defines the code that runs before any input is processed
        $Commands = @( # Creates an array variable that contains a list of PowerShell commands
            '-NoProfile -Command & {Get-ChildItem -Path C:\ -Recurse}',
            '-NoProfile -Command & {Get-Process}',
            '-NoProfile -Command & {Get-Service}',
            '-NoProfile -Command & {Get-ChildItem -Path env:\}',
            '-NoProfile -Command & {Get-ChildItem -Path HKLM:\ -Recurse}'
        )

        $TotalCommands = $Commands.Count # Gets the total number of commands in the $Commands array
        $SleepTime = 1..10 | Get-Random # Creates a variable that randomly selects a value between 1 and 10
    }

    Process { # Defines the code that runs for each input object
        For ($i = 1; $i -le $ConsoleCount; $i++) { # Creates a loop that runs for the specified number of console windows
            $CommandIndex = Get-Random -Minimum 0 -Maximum $TotalCommands # Selects a random command from the $Commands array
            $Command = $Commands[$CommandIndex] # Assigns the selected command to the $Command variable
            Start-Process -FilePath powershell.exe -ArgumentList $Command # Starts a new PowerShell process and runs the selected command

            Start-Sleep -Seconds $SleepTime # Pauses the script for a random number of seconds
            Write-Progress -Activity "Processing $i console(s)" -Status "Running command $CommandIndex" -PercentComplete (($i / $ConsoleCount) * 100) # Writes a progress bar to indicate how many consoles have been processed and which command is being run
        }
    }

    End { # Defines the code that runs after all input has been processed
    }
}

Pretend-To-Be-Busy -ConsoleCount 5 # Calls the function with a parameter value of 5 to open 5 console windows