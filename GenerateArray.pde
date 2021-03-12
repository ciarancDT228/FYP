static class GenerateArray {

	static int[] sinWave(int length, float p){
        int[] arr = new int[length];
        for(int i = 0; i < length; i++){
            arr[i] = (int)(Math.round((length/2)*sin((2*PI*p*i)/length)+((length/2)*sin(PI/2)))) + 1;
        }
        return arr;
    }

	static int[] random(int length) {
		int[] arr = asc(length);
		for(int i = 0; i < arr.length; i++) {
			int rand = (int)(Math.random() * length);
			int temp = arr[i];
			arr[i] = arr[rand];
			arr[rand] = temp;
		}
		return arr;
	}

	static int[] asc(int length) {
		int[] arr = new int[length];
		for(int i = 0; i < arr.length; i++) {
			arr[i] = i + 1;
		}
		return arr;
	}

	static int[] blanks(int length) {
		int[] arr = new int[length];
		for(int i = 0; i < arr.length; i++) {
			arr[i] = 0;
		}
		return arr;
	}

}