# DDC Font App for iOS

This is the project code for DDC Font app. Do check out locally and update or refector the code with suitable message.

## Note on iOS part

The installing and uninstalling of the fonts is done with the CoreText API of Apple using the CTFontManager functions.
To communicate to the Native Platform from the FLutter side, we used MethodChanells and injected the native code.

Note: To test it on android studio on a mac, you need additional cocoapods installation to work with it.
There was library dependency issues in our side, so the solution was to edit the code on Android Studio but run it from xCode which worked for testing purposes.

# How To's.

### If you have already cloned, then run the following command to update to latest commit

`cd [repository_name]`

`git add .`

`git commit -m "Put any message here"`

`git pull origin main`


### Else if this is your first time

`cd [folder_name]`

'git clone https://github.com/kinley2-glitch/ddc-font-app.git'

`cd [repository_name]`

- add, update, change and refactor the code, when done run the following commands to push to github 

`git add .`

`git commit -m "Put any message here"`

`git push` if it doesn't work try `git push origin main`

-[For more information check out this link](https://www.earthdatascience.org/workshops/intro-version-control-git/basic-git-commands/)  



# Project Structure 
- This is the rough sketch of the project structure. lables with ".dart" are file name and "ClassName()" are class name in dart.
<img width="914" alt="Untitled2" src="https://user-images.githubusercontent.com/62231990/147034611-396d59e1-3e9a-4aea-a545-22e54c9856d5.png">


## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
