--
--  URL_BrowserAppDelegate.applescript
--  URL Browser
--
--  Created by Christian Sonntag on 18.06.10.
--  Copyright 2010 __MyCompanyName__. All rights reserved.
--

script URL_BrowserAppDelegate
	property parent : class "NSObject"
	
	-- outlets
	property theUrlDisplay : missing value
	property rangeLabel : missing value
	property ACHelpers : missing value
	property filePathControl : missing value
	
	--misc
	property tempUrl : missing value
	property theLoc : missing value
	property theLen : missing value
	property valfldr : missing value
	
	on applicationWillFinishLaunching_(aNotification)
		-- Insert code here to initialize your application before any files are opened 
	end applicationWillFinishLaunching_
	
	on applicationShouldTerminate_(sender)
		-- Insert code here to do any housekeeping before your application quits 
		return current application's NSTerminateNow
	end applicationShouldTerminate_
	
	on awakeFromNib()
		ACHelpers's selectTextInTextfield_(theUrlDisplay)
	end awakeFromNib
	
	
	--get the url out of safari
	on getUrlOfSafari_(sender)
		tell application "Safari"
			set theUrl to URL of document 1
		end tell
		
		theUrlDisplay's setStringValue_(theUrl)
		set tempUrl to theUrl
	end getUrlOfSafari_
	
	--get selected textrange of textfield
	on getNSTextFieldRangeValue_(sender)
		set {theLoc, theLen} to ACHelpers's rangeOfTextFieldSelection_(theUrlDisplay) as list
	end getNSTextFieldRangeValue_
	
	--display status text in NSLabel
	on setNSTextFieldValue_(sender)
		theUrlDisplay's setStringValue_(tempUrl)
	end setNSTextFieldValue_
	
	
	on displayRange_(sender)
		# Returns an array which you can retrieve the values as a list
		if theLoc is not 0 and theLen is not 0 then
			rangeLabel's setStringValue_("Textrange: " & (theLoc as text) & " | " & (theLen as text))
		else
			beep
		end if
	end displayRange_
	
	
	on upUrl_(sender)
		my getNSTextFieldRangeValue_(me)
		if theLoc is not 0 and theLen is not 0 then
			set prefix to (characters 1 thru theLoc of tempUrl) as string
			set counter to ((characters (theLoc + 1) thru (theLoc + theLen) of tempUrl) as string) as integer
			set sufix to (characters (theLoc + 1 + theLen) thru (count of tempUrl) of tempUrl) as string
			
			set counter to counter + 1
			
			tell application "Safari"
				set URL of document 1 to prefix & counter & sufix
				activate
			end tell
			
			set tempUrl to prefix & counter & sufix
			my setNSTextFieldValue_(me)
			my displayRange_(me)
		else
			beep
		end if
	end upUrl_
	
	on downUrl_(sender)
		my getNSTextFieldRangeValue_(me)
		if theLoc is not 0 and theLen is not 0 then
			set prefix to (characters 1 thru theLoc of tempUrl) as string
			set counter to ((characters (theLoc + 1) thru (theLoc + theLen) of tempUrl) as string) as integer
			set sufix to (characters (theLoc + 1 + theLen) thru (count of tempUrl) of tempUrl) as string
			
			set counter to counter - 1
			
			tell application "Safari"
				set URL of document 1 to prefix & counter & sufix
				activate
			end tell
			
			set tempUrl to prefix & counter & sufix
			my setNSTextFieldValue_(me)
			my displayRange_(me)
			
		else
			beep
		end if
	end downUrl_
	
	
	
	
	on saveDocument_(sender)
		tell application "Safari"
			set docUrl to URL of document 1
		end tell
		
		set oldDelims to AppleScript's text item delimiters
		set AppleScript's text item delimiters to "/"
		set urlArray to text items of docUrl
		set AppleScript's text item delimiters to oldDelims
		
		tell application "Safari"
			save document 1 in valfldr & "/" & last item of urlArray
		end tell
		
	end saveDocument_
	
	
	
	on historyBack_(sender)
		tell application "Safari"
			do JavaScript "history.back()" in document 1
			activate
		end tell
	end historyBack_
	
	
	
	
	on subchoosefolder_(sender)
		set valfldr to text 1 thru -2 of ((choose folder with prompt "Choose the default location for the choose file." with showing package contents) as alias as string) --Prevent an extra / on the end.
		filePathControl's |setURL_|(POSIX path of valfldr)
		
		set valfldr to POSIX path of valfldr
	end subchoosefolder_
	
	
end script