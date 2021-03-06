/// @description What happens when we try to pick up a holdable object
// still trying to make a way to highlight objects - currently running into infinite loops

//creates a list of all holdable objects the player's radius is colliding with
if (!showInv) {
	var itemList = ds_list_create();
	var proxList = collision_circle_list(x, y, 64, oHoldableObject, true, true, itemList, true);
	var ID;

	//indentifies the closest item that is not beind held and sets ID to that
	for (var i = 0; i < ds_list_size(itemList); i++) {
		if (!ds_list_find_value(itemList, i).followingR && 
		!ds_list_find_value(itemList, i).followingL) {
			ID = ds_list_find_value(itemList, i);
			weCanPickUp = true;
		break;
		}
	}

	//gamepad controls
	if (gamepad_is_connected(0)) {
	//if there is an item we can pick up
	if (weCanPickUp) {
		//if both buttons are pressed simultaneously
		if (oPlayerInput.key_left_hand && oPlayerInput.key_right_hand) {
				//default to left hand
				if (oPlayerPickUpRadius.itemInLeftHand == noone && weCanPickUp) {
					ID.followingL = true;
					ID.highlighted = false;
					itemInLeftHand = ID; //now we know what's in our left hand
					weCanPickUp = false; //prevents empty right hand crash
				}
				//next to right hand
				if (oPlayerPickUpRadius.itemInRightHand == noone && weCanPickUp) {
					ID.followingR = true;
					ID.highlighted = false;
					itemInRightHand = ID; //now we know what's in our right hand
					weCanPickUp = false; //prevents empty left hand crash
				}
			}
		//left hand pick up
		if (oPlayerInput.key_left_hand && weCanPickUp) {
			// if player isn't holding something in left hand, get picked up
			if (oPlayerPickUpRadius.itemInLeftHand == noone) {
					ID.followingL = true;
					ID.highlighted = false;
					itemInLeftHand = ID; //now we know what's in our left hand
					weCanPickUp = false; //prevents empty right hand crash
			}
		}
		//right hand pick up
		if (oPlayerInput.key_right_hand && weCanPickUp) {
			//if player isn't holding something in right hand, get picked up
			if (oPlayerPickUpRadius.itemInRightHand == noone) {
					ID.followingR = true;
					ID.highlighted = false;
					itemInRightHand = ID; //now we know what's in our right hand
					weCanPickUp = false; //prevents empty left hand crash
			}
		}
	}
	}

	//keyboard controls
	if (!gamepad_is_connected(0)) {
	//if there is an item we can pick up
	if (weCanPickUp) {
		//if both buttons are pressed simultaneously
		if (oPlayerInput.key_left_hand && oPlayerInput.key_right_hand) {
				//default to left hand
				if (oPlayerPickUpRadius.itemInLeftHand == noone && weCanPickUp) {
					ID.followingL = true;
					ID.highlighted = false;
					itemInLeftHand = ID; //now we know what's in our left hand
					weCanPickUp = false; //prevents empty right hand crash
				}
				//next to right hand
				if (oPlayerPickUpRadius.itemInRightHand == noone && weCanPickUp) {
					ID.followingR = true;
					ID.highlighted = false;
					itemInRightHand = ID; //now we know what's in our right hand
					weCanPickUp = false; //prevents empty left hand crash
				}
			}
		//left hand pick up
		if (oPlayerInput.key_left_hand && weCanPickUp) {
			// if player isn't holding something in left hand, get picked up
			if (oPlayerPickUpRadius.itemInLeftHand == noone) {
					ID.followingL = true;
					ID.highlighted = false;
					itemInLeftHand = ID; //now we know what's in our left hand
					weCanPickUp = false; //prevents empty right hand crash
			}
		}
		//right hand pick up
		if (oPlayerInput.key_right_hand
		&& weCanPickUp) {
			//if player isn't holding something in right hand, get picked up
			if (oPlayerPickUpRadius.itemInRightHand == noone) {
					ID.followingR = true;
					ID.highlighted = false;
					itemInRightHand = ID; //now we know what's in our right hand
					weCanPickUp = false; //prevents empty left hand crash
			}
		}
	}
	}
}
