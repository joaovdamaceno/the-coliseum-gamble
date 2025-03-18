///@func approach
///@args current,goal,amount

function approach(argument0, argument1, argument2){
	return argument0 - clamp(argument0 - argument1, -argument2, argument2);
}