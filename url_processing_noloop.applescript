tell application "Google Chrome"
	activate
	set currentTab to active tab of front window
	
	-- Get current URL
	set tabURL to URL of currentTab
	
	-- If empty tab, go back once
	if tabURL is "" or tabURL is "chrome://newtab/" or tabURL is "about:blank" then
		tell application "System Events"
			key code 123 using command down -- Cmd+[ to go back
			delay 0.5
		end tell
		-- Update URL after going back
		delay 0.2
		set tabURL to URL of currentTab
	end if
	
	-- Process the URL if it contains "uri="
	if tabURL contains "uri=" then
		-- Find the position of the last "uri="
		set tid to AppleScript's text item delimiters
		set AppleScript's text item delimiters to "uri="
		set urlParts to text items of tabURL
		set AppleScript's text item delimiters to tid
		
		if (count of urlParts) > 1 then
			-- Get everything after the last "uri="
			set extractedURL to last item of urlParts
			
			-- Remove any fragments after #
			set AppleScript's text item delimiters to "#"
			set cleanParts to text items of extractedURL
			set extractedURL to first item of cleanParts
			set AppleScript's text item delimiters to tid
			
			-- Remove any URL-encoded characters (basic replacement)
			set extractedURL to my decodeURL(extractedURL)
			
			-- Ensure the URL has a proper scheme
			if extractedURL does not start with "http" then
				set extractedURL to "https://" & extractedURL
			end if
			
			-- Navigate to the new URL
			try
				set URL of currentTab to extractedURL
			on error
				display dialog "Invalid URL: " & extractedURL buttons {"OK"} default button 1
			end try
		end if
	end if
end tell

-- Basic URL decoding handler
on decodeURL(theText)
	set replacements to {{"%3A", ":"}, {"%2F", "/"}, {"%3F", "?"}, {"%3D", "="}, {"%26", "&"}}
	repeat with r in replacements
		set {find, replace} to r
		set AppleScript's text item delimiters to find
		set theText to text items of theText
		set AppleScript's text item delimiters to replace
		set theText to theText as text
		set AppleScript's text item delimiters to ""
	end repeat
	return theText
end decodeURL