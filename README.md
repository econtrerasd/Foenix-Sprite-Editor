# Foenix-Sprite-Editor V1.0
By Ernesto Contreras

Requirements
--------------
The Sprite Editor requires the following to operate

1. Foenix U, Foenix U+ or Foenix FMX computer 
2. PS/2 Mouse to operate
3. SD card or Hard Disk if you want to save your creations

You need to have three files for executing the Sprite Editor
1. SPREDIT.BAS
2. SPREDIT.ML
3. ICONS.SPR

While most of the program is in BASIC a few Machine Language Routines are required for redrawing Sprites on the Grid & mirroring sprites. 
The BASIC program loads the Machine Language routines from SPREDIT.ML when initializing
A sprite file 'ICONS.SPR', now contains the graphic icons used in the program, these icons can be edited to change the look of the icons in the program! 

DESCRIPTION
----------------------------

SPREDIT is a simple sprite editor writen in BASIC for the Foenix Series of Computers by Stefany Allaire,  
check her website for more information https://c256foenix.com/

The Motivations to create this program were:

1. Investigate the capabilities of BASIC in the Foenix
2. Explore the Hardware capabilities of the Foenix computer itself
3. Learn some 65816 Assembler and banking 
4. Provide Native tools in the Computer itself to break some dependency from external tools

Design:

The Program is mouse driven and operates on the 320x240 graphical screen mode, this resolution allows users to see a bigger representation of the sprite they are working on.

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
* SAVE                    (3.5 Disc with incoming arrow)
* LOAD                    (3.5 Disc with outgoing arrow)
* ADD SPRITE              (Space Invader with '+' sign)
* DELETE SPRITE           (Space Invader with 'x' sign)
* MOVE TO NEXT SPRITE     (-> arrow)
* MOVE TO PREVIOUS SPRITE (<- arrow)
* EXIT PROGRAM            (Exit Sign)

*When Saving keep in mind that the ther current filesystem allows only 8 character names, consider this when saving your sprite files. A ".SPR" extension will be appended automatically to the name provided 
*Validations when saving and loading are executed so that the program doesn't crash when you try to save with a filename already in use!

DRAWING TOOLS ICONS 
------------------------------------------------
The Drawing tools contains tools that help you in drawing your sprites (description of the icon in parenthesis):
* BRUSH SIZE              (Three pencils of increasing point size)
* COPY                    (Copy Icon with space invader inside) 
* PASTE                   (Board with space invader)
* CLEAR                   (Empty space with CLR letters)
* GRIDLINES               (Ruler with guidelines)
* MIRROR X                (Ball Mirrored Horizontally)
* MIRROR Y                (Ball Mirrored Vertically)

COLOR PALETTE
-------------------------------------------------

The color palette includes a pre-selection of color Gradients, this color palette is currently hardcoded in the Editor. *(Future versions of the program will allow you to edit individual colors and save the new modified palette)

Left Clicking on any color on the palette will change the brush color to the selected color, a rectangle below the palette will show the currently selected color for easy identification of the selected color
*Note that the top left color of the Grid is the transparent color, this is denoted by an X symbol over this color

A new section at the bottom of the screen shows the color components (RGB) of the current selected color with handles on the corresponding bar relating to the value of each component.
Moving the handles with the mouse modifies the current color Value

Icons at the rightmost part of the Drawing tools Bar allow you to either load a palette from disk or save a palette to disk (The filename provided is truncated to 8 letters and is appendedn a '.PAL' extension)

Palette Color Credits
* The current color palette was taken from (https://lospec.com/palette-list/duel) with a few modifications to add true black, true white and other slight color adjustments
* Credits to the creation of this palette are due to ARILYN@ARILYNART https://t.co/3Kxr6ZPzmu

SPRITE EDITOR GRID
-------------------------------------------------

Once you have selected a color, just left click on any square on the grid to assign the current color to the pixel, you can hold the mouse button and drag the mouse around to draw faster

Need to put down pixels even faster?

Using the BRUSH SIZE Tool will change how many pixels are drawn on the SPRITE EDITOR GRID, initial brush size is 1 pixel, but available options are 2x2 pixels and 3x3 pixels. Please note that 3x3 pixels lays down pixels at a reduced rate, this options are provided to allow quicker coverage of large sections.

What color did I used there?

When you are editing an Sprite is easy to forget which color you were using on what section (yes even with 256 colors things can get confusing!), and hunting down for the right color on the palette can consume precious time. To alleviate this a color pickup function was added to the right mouse button, when you click it you'll pick up the color under the mouse (BTW: I made sure that you can't pick the grid color), this helps a lot in getting the right color faster!

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
* Theoretically the sprite editor is limited to editing 255 sprites (not that I have tried to test that many yet)

