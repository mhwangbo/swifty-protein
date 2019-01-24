# Swifty-Protein
This project aims to introduce a Scene Kit, and Apple framework to create scenes in 3D. This is an application that models ligands in 3D.

#
![](swifty-protein.gif)
#

## Requirement
### Mandatory part
#### Login View Controller
- [x] A user must be able to login with Touch ID using a button
- [x] If login fails it must display a popup warning
- [x] If the iPhone is not Touch ID compatible, Touch ID login button should be hidden
- [x] The LoginViewController should ALWAYS be displayed when launching the app. If you press the Home button and relaunch the app without quitting it, it should show the LoginViewController.
#### Protein List View Controller
- [x] List all the ligands provides in ligands.txt
- [x] User should be able to search a ligand through the list
- [x] If app cannot load the ligand throught the website, display a warning popup
- [x] When loading the ligand, app should display the spinning wheel of the activity monitor
#### Protein View Controller
- [x] Display the ligand model in 3D
- [x] Must use CPK coloring
- [x] Represent the ligand using Balls and Sticks model
- [x] When clicking on an atom, display the atom type
- [x] Share button
- [x] User should be able to 'play' with the ligand in Scene Kit
### Bonus
- [x] Custom cells
- [x] Design
- [x] Custom popup
- [x] Other modelisation available
- [x] Custom message when sharing your screenshot
