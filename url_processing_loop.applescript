tell application "Google Chrome"
    activate
    set windowRef to front window
    set tabList to tabs of windowRef
    set tabCount to count of tabList
    
    -- Store original tab position
    set originalTabIndex to active tab index of windowRef
    
    -- Process each tab by index
    repeat with i from 1 to tabCount
        try
            -- Switch to tab by position
            set active tab index of windowRef to i
            delay 0.7  -- Important delay for tab switching
            
            set currentTab to tab i of windowRef
            set tabURL to URL of currentTab
            
            -- Handle empty/new tabs
            if tabURL is "" or tabURL is "about:blank" or Â
               tabURL is "chrome://newtab/" or Â
               tabURL starts with "chrome://new-tab-page/" then
                
                -- Use Chrome's native back command
                try
                    tell currentTab to go back
                    delay 1.2  -- Wait for navigation
                    set tabURL to URL of currentTab
                on error
                    log "Couldn't go back in tab " & i
                end try
            end if
            
            -- Process URI if found
            if tabURL contains "uri=" then
                set oldDelimiters to AppleScript's text item delimiters
                set AppleScript's text item delimiters to "uri="
                set urlParts to text items of tabURL
                set AppleScript's text item delimiters to oldDelimiters
                
                if (count of urlParts) > 1 then
                    set extractedURL to last item of urlParts
                    
                    -- Clean URL
                    set AppleScript's text item delimiters to "#"
                    set cleanParts to text items of extractedURL
                    set extractedURL to first item of cleanParts
                    set AppleScript's text item delimiters to oldDelimiters
                    
                    -- Navigate to extracted URL
                    try
                        set URL of currentTab to extractedURL
                        delay 0.5
                    on error e
                        log "Failed to update tab " & i & ": " & e
                    end try
                end if
            end if
            
        on error e
            log "Error processing tab " & i & ": " & e
        end try
    end repeat
    
    -- Return to original tab
    set active tab index of windowRef to originalTabIndex
end tell
