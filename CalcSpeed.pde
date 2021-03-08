static class CalcSpeed {

	static int modulus;
	static int numSteps;

	static int getNumSteps(int x) {
		if(x < 60) {
			numSteps = 1;
		} else {
			numSteps = x;
		}
		return numSteps;
	}

	static int getModulus(int x) {
		if(x < 60) {
			modulus = 60 / x;
		} else {
			modulus = 1;
		}
		return modulus;
	}

}