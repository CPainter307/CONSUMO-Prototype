/// @description condition clean-up to make sure glitches don't happen with throwing and picking up

//more bug fixing
weCanPickUp = false;

//reset left throw flags
if (throwingL) {
	oPlayer.holdingL = false;
	throwingL = false;
}

//reset right throw flags
if (throwingR) {
	oPlayer.holdingR = false;
	throwingR = false;
}

