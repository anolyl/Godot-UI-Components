extends Control

@export var pcControls : Array[Control] = []
@export var mobileControls : Array[Control] = []

@export var Logs: VBoxContainer

enum MODE {
	PC,
	MOBILE
}
var currentMode: MODE = MODE.PC

enum SCREENS {
	ACTIONBAR,
	OPTIONMENU,
	CHATBOX,
	STORE,
}
var currentScreen: SCREENS = SCREENS.ACTIONBAR

func Log(text: String):
	if Logs:
		Logs.log(text)

func setUIMode(mode: MODE):
	if currentMode != mode:
		Log("MODE SWITCHED TO PC" if mode == MODE.PC else "MODE SWITCHED TO MOBILE")
	currentMode = mode
			
	for pcControlsFound in pcControls:
		var meta = pcControlsFound.get_meta("SCREEN")
		if (meta == str(SCREENS.keys()[currentScreen])):
			pcControlsFound.visible = true if mode == MODE.PC else false
		else:
			pcControlsFound.visible = false
			
	for mobileControlsFound in mobileControls:
		mobileControlsFound.set_process_input(true)
		var meta = mobileControlsFound.get_meta("SCREEN")
		if (meta == str(SCREENS.keys()[currentScreen])):
			mobileControlsFound.visible = true if mode == MODE.MOBILE else false
		else:
			mobileControlsFound.visible = false
			mobileControlsFound.set_process_input(false)

func setScreenMode(mode: SCREENS):
	Log("SCREEN SWITCHED TO " + str(SCREENS.keys()[mode]))
	currentScreen = mode
	setUIMode(currentMode)

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			if event.keycode == KEY_1:
				setScreenMode(SCREENS.ACTIONBAR)
			elif event.keycode == KEY_2:
				setScreenMode(SCREENS.OPTIONMENU)
			elif event.keycode == KEY_3:
				setScreenMode(SCREENS.CHATBOX)
			elif event.keycode == KEY_4:
				setScreenMode(SCREENS.STORE)
