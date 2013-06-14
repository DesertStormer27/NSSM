@ECHO OFF
CLS


::Change this variable to change the location of the SteamCMD installation!
set steamcmddir=C:\Program Files (x86)\SteamCMD\

::Log into steam servers
echo.
echo Would you like to log into Steam Servers, or just be anonymous?
echo 1 - Log In
echo 2 - Be anonymous
set /p login=Please type the number of your answer here: 
IF %login%==1 GOTO LOGIN
IF %login%==2 GOTO anonlogin
:login
set /p username=What is your username?
set /p password=What is your password?
set logindetails=%username% %password%
goto MENU
:anonlogin
set logindetails=anonymous
goto MENU

set programname=neXus Source Server Manager v0.1
color a
echo.
echo ##########################################################
echo # This program requires SteamCMD to be in the directory: #
echo # "C:\Program Files (x86)\SteamCMD". If it is not there, #
echo # this program will not work properly without moving it  #
echo # there, or changing the variable in the batch file. If  #
echo # SteamCMD is not in that directory, please do either of #
echo # the two options before using this program. Thank you.  #
echo ##########################################################
pause
:MENU
cls
ECHO.
ECHO ...............................................
ECHO Welcome to the neXus Source Server Manager. Select your task below.
ECHO.
ECHO Note- during any menu, type "home" to return to this menu.
ECHO.
ECHO Current version= 0.1
ECHO ...............................................
ECHO.
ECHO 1 - Install/Update a server
ECHO 2 - Start a Server
ECHO 3 - Delete a Server installation
ECHO 4 - Backup an existing installation
ECHO 5 - About NSSM
ECHO exit - Exit
ECHO.
SET /P M=Type 1, 2, or 3, then press ENTER: 
IF %M%==1 GOTO INSTALL/UPDATE
IF %M%==2 GOTO EXECUTE
IF %M%==3 GOTO 404
IF %M%==4 GOTO 404
IF %M$==5 GOTO ABOUT
IF %M%==exit GOTO EOS
IF %M%==42 GOTO ANSWER
:INSTALL/UPDATE
cls
ECHO.
ECHO What server would you like to install?
echo.
ECHO 1 - Team Fortress 2
ECHO 2 - Garry's Mod
ECHO 3 - Counter-Strike: Source
ECHO 4 - Counter-Strike: Global Offensive
ECHO 5 - Other
SET /P SERVER=Type the number of the option you would like to install, then press ENTER.
IF %SERVER%==1 GOTO INSTALLTF2
IF %SERVER%==2 GOTO INSTALLGMOD
IF %SERVER%==3 GOTO INSTALLCSS
IF %SERVER%==4 GOTO INSTALLCSGO
IF %SERVER%==5 GOTO INSTALLOTHER
IF %SERVER%==home GOTO MENU
GOTO MENU
:INSTALLTF2
CLS
cd %steamcmddir%
steamcmd +login %logindetails% +force_install_dir "C:\Servers\Team Fortress 2" +app_update 232250 validate +quit
ECHO Team Fortress 2 has been successfully installed/updated in the directory "C:\Servers\Team Fortress 2"
pause
GOTO MENU
:INSTALLGMOD
CLS
cd %steamcmddir%
steamcmd +login %logindetails% +force_install_dir "C:\Servers\Garry's Mod" +app_update 4020 validate +quit
ECHO Garry's Mod has been successfully installed/updated in the directory "C:\Servers\Garry's Mod"
pause
GOTO MENU
:INSTALLCSS
CLS
cd %steamcmddir%
steamcmd +login %logindetails% +force_install_dir "C:\Servers\Counter-Strike: Source" +app_update 232330 validate +quit
ECHO Counter-Strike: Source has been successfully installed/updated to the directory "C:\Servers\Counter-Strike: Source".
pause
GOTO MENU
:INSTALLCSGO
CLS
cd %steamcmddir%
steamcmd +login %logindetails% +force_install_dir "C:\Servers\Counter-Strike: Global Offensive" +app_update 740 validate +quit
ECHO Counter-Strike: Globall Offensive has been successfully installed/updated to the directory "C:\Servers\Counter-Strike: Global Offensive".
pause
GOTO MENU
:INSTALLOTHER
CLs
ECHO.
ECHO What update tool is the server on?
ECHO.
ECHO 1 - HLDSUpdateTool
ECHO 2- SteamCMD
ECHO.
set /p software=Type the number of the option here, or type "back" to go to the previous menu:
IF %software%==1 GOTO HLDS
IF %software%==2 GOTO steamcmd
IF %software%==back GOTO INSTALL/UPDATE
IF %software%==home GOTO MENU
:hlds
ECHO.
set /p hldsname=What is the exact name of the server you would like to install?
cd "C:\program files (x86)\valve\hlserver\"
hldsupdatetool.exe -command update -game %hldsname% -dir "C:\Servers\%hldsname%"
ECHO %hldsname% has been successfully installed/updated to the directory "C:\Servers\%hldsname%"
pause
goto MENU
:steamcmd
echo.
set /p steamcmdname=What is the name of the server you would like to install?
set /p steamcmdappid=What is the appid of the server you would like to install?
cd %steamcmddir%
steamcmd +login anonymous +force_install_dir "C:\Servers\%steamcmdname%\ app_update %steamcmdappid% validate +quit
echo %steamcmdname% has been successfully installed/updated to the directory "C:\Servers\%steamcmdname%\".
pause
goto MENU
:EXECUTE
ECHO.
How would you like your server to execute?
echo.
echo 1 - Normal Options
echo 2 - Custom Options
set /p execoptions=Select which mode: 
IF %execoptions%==1 GOTO SERVEREXECUTE
IF %execoptions%==2 GOTO CUSTOMEXECUTE
:SERVEREXECUTE
set tfoptions=-console -port 27015 -game teamfortress2 +map ctf_2fort +maxplayers 16 -verify_all
set gmodoptions=-console -port 27016 -game garrysmod +map gm_construct +maxplayers 16 -verify_all
set cssoptions=-console -port 27017 -game counterstrikesource +map de_dust +maxplayers 16 -verify_all
set csgooptions=-console -port 27018 -game csgo +map de_nuke +maxplayers 16 -verify_all
goto actualexecute
:customexecute
cls
echo.
echo These options are for custom execution of servers.
echo.
set /p servername=Server Name? 
set /p serverdir=Directory leading to srcds.exe
set /p serverport=Port? 
set /p servermap=Map? 
set /p serverplayers=Max Players? 
echo Those are all the options. Executing server...
cd %serverdir%
srcds.exe -console -game %servername% -port %serverport% +map %servermap% +maxplayers %serverplayers% -verify_all
echo.
echo The server has been executed (Hopefully Successfully).
pause
goto MENU
:ACTUALEXECUTE
ECHO.
ECHO Current Supported Servers:
echo 1 - Team Fortress 2
echo 2 - Garry's Mod
echo 3 - Counter-Strike: Source
echo 4 - Counter-Strike: Global Offensive
echo 5 - Other
set /p serverexec=What server would you like to execute? 
IF %serverexec%==1 GOTO tf2exec
IF %serverexec%==2 GOTO gmodexec
IF %serverexec%==3 GOTO cssexec
IF %serverexec%==4 GOTO csgoexec
IF %serverexec%==5 GOTO 404
:tf2exec
cls
cd "C:\servers\team fortress 2\"
srcds.exe -console -port 27015 -game teamfortress2 +map ctf_2fort +maxplayers 16 -verify_all
echo.
echo Team Fortress 2 Dedicated Server has been launched.
pause
goto menu
:gmodexec
cls
cd "C:\servers\garry's mod\"
srcds.exe -console -port 27015 -game garry's mod +map gm_construct +maxplayers 32 -verify_all
echo.
echo Garry's Mod Dedicated Server has been launched
pause
goto menu
:cssexec
cls
cd "C:\servers\counter-strike: source\"
srcds.exe -console -port 27017 -game counterstrikesource +map de_dust2 +maxplayers 16 -verify_all
echo.
echo Counter-Strike: Source Dedicated Server has been launched.
pause
goto menu
:csgoexec
cls
cd "C:\servers\counter-strike: global offensive\"
srcds.exe -console -game csgo +map de_nuke +maxplayers 16 -verify_all
echo.
echo Counter-Strike: Global Offensive Dedicated Server has been launched.
pause
goto menu
:404
cls
echo.
echo Sorry, this feature is not done yet. You will be returned to the main menu.
pause
goto MENU

:ABOUT
CLS
ECHO.
ECHO The neXus Source Server manager was developed by DesertStormer27 to make installing, updating, and managing source servers easy and fast. Hopefully the NSSM will be updated to a more powerful language (Currently, it is just a big batch file). Something such as Python seems like it would be easiest, but it is not the only option. For now, this will work fine.
ECHO.
ECHO NOTE: In order for this program to work properly, you need both "HLDSUpdateTool" and "SteamCMD". Both can be found on the Valve Developer Community Website.
ECHO.
ECHO Thank you for using the NSSM. If you have any bug reports, or suggestions: contact me at desertstormerj@aol.com.
pause
GOTO MENU
:ANSWER
ECHO.
ECHO That is the answer to life, the universe, and everything.
GOTO MENU
:EOS
exit
