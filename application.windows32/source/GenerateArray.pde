static class GenerateArray {

	static int[] sinWave(int length, float p){
        int[] arr = new int[length];

        length-=1;
        for(int i = 0; i <= length; i++){
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

	static int[] desc(int length) {
		int[] arr = new int[length];

		for(int i = 0; i < arr.length; i++) {
			arr[i] = arr.length - i;
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

	static int[] quadrant(int length){
        int[] arr = new int[length];

        length-=1;
        for(int i = 0; i < arr.length; i++){
            arr[i] = (int)(round(length*sqrt(1-pow(((float)i/(float)length),2.0))))+1;
        }
        return arr;
    }

    static int[] parabola(int length){
        int[] arr = new int[length];

        length-=1;
        for(int i = 0; i < arr.length; i++){
            arr[i] = (int)round((4/(float)length)*(pow((i-((float)length/2)),2)))+1;
        }
        return arr;
    }

    static int[] parabolaInv(int length){
        int[] arr = new int[length];

        length-=1;
        for(int i = 0; i < arr.length; i++){
            arr[i] = (int)round((-4/(float)length)*(pow((i-((float)length/2)),2)))+length+1;
        }
        return arr;
    }

    static int[] squiggle(int length){
    	int period = 0;
        int[] arr = new int[length];

        length-=1;
        for(int i = 0; i < arr.length; i++){
            arr[i] = (int)round(length*(pow((sin(PI+(pow(2,((4*period)/length))))),2)))+1;
            period += PI;
        }
        return arr;
    }

    // static int[] squiggle(int length){
    //     // int period = 0;
    //     int[] arr = new int[length];

    //     for(int i = 0; i < arr.length; i++){
    //         arr[i] = int(noise(i/100));
    //     }
    //     return arr;
    // }

}
