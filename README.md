# Installation

* Clone this repository: `git clone https://github.com/zachtheyek/Less-Marvellous-Suspender.git`
* Go to `chrome://extensions/`
* Turn on `developer mode` (top right corner) > `load unpacked` > navigate to the cloned filepath
* Select the `suspend_tabs` directory (Note: the `suspend_tabs` directory is nested within the cloned repository. Do not select the entire cloned repository)
* The extension should now be available in your Google Chrome profile. I recommend pinning the icon to your extension bar for easy access
* Activate it by simply clicking on the extension's icon, and it will loop through all inactive tabs in your current Chrome window, and "suspend" each one in sequence

# Requirements 

* git
* Chrome
  * This build was tested on Chrome `Version 134.0.6998.166 (Official Build) (arm64)`

# Backstory 

I tend to have hundreds to thousands of Chrome tabs open at any given time. To prevent my machine from exploding, I'd previously used a Chrome extension called [The Marvellous Suspender](https://github.com/gioxx/MarvellousSuspender), which allowed me to
1. automatically suspend inactive tabs after a period of inactivity, and
2. manually suspend tabs with 1 click.

The former functionality was taken over by Chrome's memory saver feature (introduced in [Chrome 108](https://developer.chrome.com/blog/memory-and-energy-saver-mode#:~:text=Chrome%20108%20introduced%20two%20new,Chrome%20utilizes%20their%20system%20resources.)), but I still kept the widget around for the latter functionality. On March 31st, 2025, my world came crashing down when Chrome announced the extension would be deprecated effective immediately (I'd gotten sinister warnings before this, but ignored it like any responsible developer would).

What you see here is a replacement extension I cooked up in the hour before I had to take my dog to the vet. Specifically, it takes over the aforementioned functionality (2). 

The installation instructions should be sufficiently clear. For those that wish to customize the extension further, 
* Navigate to `suspend_tabs/manifest.json`
  * Change `name` to whatever you want the extension to be called
  * Change `default_title` to whatever you want to be displayed when hovering over the extension
* Navigate to `suspend_tabs/icons/`
  * Change `*.png` to whatever you want the extension's icon to be
    * Note: either don't change the filenames, or if you do, propagate that change in `suspend_tabs/manifest.json` (use find & replace)
    * Note: the png files must have dimensions `16x16`, `48x48`, and `128x128`, respectively
* Note: after making any changes to your local repository, navigate back to `chrome://extensions/` and click `refresh` to sync the changes.


## Footnote 
 
The 2 `.applescript` files are utility scripts i used to process the leftover URLs after The Marvellous Suspender was depracated. Without going too in depth, The Marvellous Suspender would suspend a tab by taking the URL, and replacing it with a template page that links back to the original URL. blah blah blah, u can basically get back the original URL from the suspended URL by finding `"uri="` & yanking everything that comes after. I made one script that does this only for the current tab, and another that loops through all tabs in the current window. They both work fine, but can sometimes be wonky (especially the loopy one). I suspect these will be utterly useless for 99% of people reading this, so feel free to ignore/delete these scripts after cloning.
