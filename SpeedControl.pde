class SpeedControl {

	int modulus;
	int numSteps;

	// public SpeedControl() {
		
	// }

	// public SpeedControl(int x) {
	// 	modulus = getModulus(x);
	// 	numSteps = getNumSteps(x);
	// }

	int getModulus(int x) {
		if(x < 60) {
			modulus = 60 / x;
		} else {
			modulus = 1;
		}
		return modulus;
	}

	int getNumSteps(int x) {
		if(x < 60) {
			numSteps = 1;
		} else {
			numSteps = x;
		}
		return numSteps;
	}

}