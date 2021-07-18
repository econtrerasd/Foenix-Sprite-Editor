# Foenix-Sprite-Editor
By Ernesto Contreras

Requirements
--------------
The Sprite Editor requires the following to operate

1. Foenix U, Foenix U+ or Foenix FMX computer 
2. PS/2 Mouse to operate
3. SD card or Hard Disk if you want to save your creations

You need to have two files for executing the Sprite Editor
1. SPREDIT.BAS
2. SPREDIT.ML

While most of the program is in BASIC a Machine Language Routine is required for redrawing Sprites on the Grid when moving from one sprite to another. The BASIC program loads this Machine Language routine from SPREDIT.ML when initializing

DESCRIPTION
----------------------------

SPREDIT is a simple sprite editor writen in BASIC for the Foenix Series of Computers by Stefany Allaire,  
check her website for more information https://c256foenix.com/

The Program operates on the 320x240 graphical screen mode, this resolution allows users to see a bigger representation of the sprite, (I consider this useful for editing)

The editor divides the screen in various sections:

* Menu Icons
* Tools Icons
* 256 Color Palette
* Sprite Editor Grid
* Sprite Representation

The program Operation will be discussed as we review each one of the sections

MENU ICONS               
------------------------------------------------
The Menu Icons allow you to handle the main operations needed to administer your Sprites (description of the icon in parenthesis): 
* SAVE*                   (down arrow into box)
* LOAD                    (up arrow from box)
* ADD SPRITE              (plus sign)
* DELETE SPRITE           (Trash can)
* MOVE TO NEXT SPRITE     (> symbol)
* MOVE TO PREVIOUS SPRITE (< symbol)
* EXIT PROGRAM            (X symbol)

*When Saving keep in mind that the ther current filesystem allows only 8 character names, consider this when saving your sprite files, an extension .SPR will be added automatically to the name provided 

DRAWING TOOLS ICONS 
------------------------------------------------
The Drawing tools are tools that help you in drawing your sprites (description of the icon in parenthesis):
* BRUSH SIZE              (Three dots representing the available brush sizes)

*Alas!, there is currently only one tool, but hey we had to start somewhere!

COLOR PALETTE
-------------------------------------------------

The color palette includes a pre-selection of color Gradients, this color palette is currently hardcoded in the Editor. *(Future versions of the program will allow you to edit individual colors and save the new modified palette)

Left Clicking on any color on the palette will change the brush color to the selected color, a rectangle below the palette will show the currently selected color for easy identification of the selected color

*Note that the top left color of the Grid is the transparent color, this is denoted by an X symbol over this color

Palette Color Credits
* The current color palette was taken from (https://lospec.com/palette-list/duel) with a few modifications to add true black, true white and other slight color adjustments
* Credits to the creation of this palette are due to ARILYN@ARILYNART https://t.co/3Kxr6ZPzmu

SPRITE EDITOR GRID
-------------------------------------------------

Once you have selected a color, just left click on any square on the grid to assign the current color to the pixel, you can hold the mouse button and drag the mouse around to draw faster

Need to put down pixels even faster?

Using the BRUSH SIZE Tool will change how many pixels are drawn on the SPRITE EDITOR GRID, initial brush size is 1 pixel, but available options are 2x2 pixels and 3x3 pixels. Please note that 3x3 pixels lays down pixels at a reduced rate, this options are provided to allow quicker coverage of large sections.

What color did I used there?

When you are editing an Sprite is easy to forget which color you were using on what section (yes even with 256 colors things can get confusing), and hunting down for the right color on the palette can consume precious time, so a function was added when clicking the right mouse button, this allows you to pick up the color under the mouse, this helps a lot in getting the right color faster!

SPRITE REPRESENTATION
-----------------------
As you Edit the sprite in the grid you'll see how it looks in real time on the actual sprite, yeah no guessing!

SPRITE FILE STRUCTURE
---------------------------
The Save file structure is very simple*

* First byte - number of sprites in file
* Sprite data - blocks of 1024 bytes for each sprite in the file

*The file structure might change in the future if more features are introduced, but if this happens compatibility will be maintained with the current file structure

LOADING A SPRITE FROM BASIC
----------------------------
Loading a Sprite File is as simple as using BLOAD to load the save file, for example: 

BLOAD "SPRFILE.SPR", &H100000

This example loads the sprite file into RAM beginning at Address $100000

* The first byte at $100000 will contain the number of sprites in the file
* After figuring out how many sprites use a MEMCOPY command to transfer the adequate number of sprites to VRAM Memory*

For example if you only have one sprite you would use the following command to transfer sprites to VRAM, in this example to $C00000

MEMCOPY LINEAR &H100001,1024 to LINEAR &HC00000,1024

*Currently the BLOAD command can't load data directly into VRAM memory, that's why you need to load to regular RAM first

LIMITATIONS & KNOWN ISSUES
--------------------------
* Theoretically the sprite editor is limited to 255 sprites (not that I have tried to test that many yet)
* Load / Save routines have no validations! (current BASIC implementation has no commands to help in this regard, until I create some Machine language for this we are out of luck), if you type an invalid file name on LOAD or SAVE operations the program will end with an error.

