
class ArrayGenerator {

	int[] random2(int length) {
		int[] tempArray = asc(length);
		int[] randArray = new int[length];
		for(int i = 0; i < randArray.length; i++) {
			int rand = (int)(Math.random() * length);
			randArray[i] = tempArray[rand];
			for(int j = rand; j < length - 1; j++) {
				tempArray[j] = tempArray[j+1];
			}
			length--;
		}
		return randArray;
	}

	int[] random(int length) {
		int[] randArray = asc(length);
		for(int i = 0; i < randArray.length; i++) {
			int rand = (int)(Math.random() * length);
			int temp = randArray[i];
			randArray[i] = randArray[rand];
			randArray[rand] = temp;
		}
		return randArray;
	}

	int[] asc(int length) {
		int[] array = new int[length];
		for(int i = 0; i < array.length; i++) {
			array[i] = i + 1;
		}
		return array;
	}

	int[] blanks(int length) {
		int[] array = new int[length];
		for(int i = 0; i < array.length; i++) {
			array[i] = 0;
		}
		return array;
	}

}