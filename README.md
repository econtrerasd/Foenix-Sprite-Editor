# Foenix-Sprite-Editor
By Ernesto Contreras

Requirements:
The Sprite Editor requires a Mouse to operate
Foenix U, Foenix U+ or Foenix FMX computer 

Description: 
This is a simple sprite editor writen in BASIC for the Foenix Series of Computers by Stephany Allaire 
https://c256foenix.com/
The Editor operates on the 320x240 screen mode, this resolution allows users to see a bigger representation of the sprites

The editor is divided in the following sections:

Menu Icons

Tools Icons

Color Palette

Sprite Editor Grid

Sprite Representation


Operation of each section

MENU ICONS               
------------------------------------------------
SAVE                    (down arrow into box)

LOAD                    (up arrow from box)

ADD SPRITE              (plus sign)

DELETE SPRITE           (Trash can)

MOVE TO NEXT SPRITE     (> symbol)

MOVE TO PREVIOUS SPRITE (< symbol)

EXIT PROGRAM            (X symbol)


TOOL ICONS 
------------------------------------------------
BRUSH SIZE              (Three dots of different sizes)

*Alas!, there is currently only one tool, but hey we had to start somewhere!


COLOR PALETTE
-------------------------------------------------

There is a pre-selection of color Gradients on the color palette, this color palette is currently hardcoded in the Editor, further versions of the program are planned to allow you to edit individual colors and save a new modified palette
Left Clicking on any color of the palette will change the brush color to the selected color, a rectangle below the palette will show the currently selected color for easy identification of the selected color
Note that the top left color of the Grid is the transparent color, this is denoted by an X symbol over this color

*The current color palette corresponds to the following palette (https://lospec.com/palette-list/duel) with a few modifications included to add true black, true white and other slight adjustments
Credits to the creation of this palette are due to ARILYN@ARILYNART https://t.co/3Kxr6ZPzmu

SPRITE EDITOR GRID
-------------------------------------------------

Once you have selected a color, just left click on any square on the grid to assign the current color to the pixel, you can hold the mouse button and drag the mouse around to draw faster

Putting down pixels faster!

Using the BRUSH SIZE Tool will change how many pixels are drawn on the SPRITE EDITOR GRID, initial brush size is 1 pixel, but available options are 2x2 pixels and 3x3 pixels. Please note that 3x3 pixels lays down pixels at a reduced rate, this options are provided since they make coloring large sections way easier

What color was that?

When you are editing an Sprite is easy to forget which color you were using on what section, and hunting down for the right color on the palette can consume precious time, so a function was added to the right mouse button to pick up the current color under the mouse, this helps a lot in getting the right color faster!

SPRITE REPRESENTATION
-----------------------
As you Edit the sprite yopu'll see how it looks on the sprite representation

LIMITATIONS & KNOWN ISSUES
--------------------------
The sprite editor is limited to 255 sprites (not that I have tried to define that many)
Load / Save routines have no validations if you type an invalid file name on this operations the program will end with an error 
