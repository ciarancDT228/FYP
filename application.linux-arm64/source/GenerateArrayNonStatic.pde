class GenerateArrayNonStatic {

    int[] perlin(int length){
        // int period = 0;
        int[] arr = new int[length];
        int min = length;
        int max = 0;

        for(int i = 0; i < arr.length; i++){
            arr[i] = int(noise(i/(length/20.0))*length);
            if(arr[i] > max) {
                max = arr[i];
            }
            if(arr[i] < min) {
                min = arr[i];
            }
        }

        for(int i = 0; i < arr.length; i++){
            arr[i] = int(map(arr[i], min, max, 1, length));
        }



        return arr;
    }

}
