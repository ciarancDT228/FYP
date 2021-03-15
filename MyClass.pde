// /* Used operator precedence (universal to Java) to simplify the equations
// * hopefully it doesn't screw with the actual calculations...
// */

// public class MyClass {
//     public static void main(String args[]) {
      
//       int len = 10;
//       int p = 2;
      
//       printArr(sin(len, p), "Sine  ");
//       printArr(cos(len, p), "Cosine");
//       printArr(circle(len), "Circle");
//       printArr(parabola(len), "Parabola");
//       printArr(reverseParabola(len), "R parabola");
//       printArr(squiggle(len), "Squiggle");
      
//     }
    
//     /* Generates an array of int values representing
//      * a sine curve
//      * @param: length of array, number of periods
//     */
//     public static int[] sin(int length, int p){
        
//         int[] arr = new int[length];
        
//         for(int i = 0; i<length; i++){
//             arr[i] = (int)(Math.round((double)length/2*Math.sin(2*Math.PI*p*i/(double)length)+((double)length/2))) + 1;
//         }
        
//         return arr;
//     }
    
//     /* Generates an array of int values representing
//      * a cosine curve
//      * @param: length of array, number of periods
//     */
//     public static int[] cos(int length, int p){
        
//         int[] arr = new int[length];
        
//         for(int i = 0; i<length; i++){
//             arr[i] = (int)(Math.round((double)length/2*Math.cos(2*Math.PI*p*i/(double)length)+((double)length/2))) + 1;
//         }
        
//         return arr;
//     }
    
    
//     /* Generates an array of int values representing
//      * the upper right hand quarter of a circle
//      * @param: length of array
//     */
//     public static int[] circle(int length){
        
//         int[] arr = new int[length];
        
//         for(int i = 0; i<length; i++){
//             arr[i] = (int)(Math.round(length*Math.sqrt(1-Math.pow(((double)i/(double)length),2))))+1;
//         }
        
//         return arr;
//     }
    
    
//      /* Generates an array of int values representing
//      * a positive parabola
//      * @param: length of array
//     */
//     public static int[] parabola(int length){
        
//         int[] arr = new int[length];
        
//         for(int i = 0; i<length; i++){
//             arr[i] = (int)Math.round((4/(double)length)*(Math.pow((i-((double)length/2)),2)))+1;
//         }
//         return arr;
//     }
    
    
//      /* Generates an array of int values representing
//      * a negative parabola
//      * @param: length of array
//     */
//     public static int[] reverseParabola(int length){
        
//         int[] arr = new int[length];
        
//         for(int i = 0; i<length; i++){
//             arr[i] = (int)Math.round((-4/(double)length)*(Math.pow((i-((double)length/2)),2)))+length+1;
//         }
        
//         return arr;
//     }
    
    
//      /* Generates an array of int values representing
//      * a sine wave that increases frequency
//      * @param: length of array
//     */
//     public static int[] squiggle(int length){
        
//         int[] arr = new int[length];
        
//        // for(int i = 0; i<length; i++){
//           //  arr[i] = (int)Math.round(length*(Math.pow((Math.sin(Math.PI+(Math.pow(2,((4*i)/length))))),2)))+1;
//        // }
        
//         int period = 0;
//         for(int i = 0; i<length; i++){
//             arr[i] = (int)Math.round(length*(Math.pow((Math.sin(Math.PI+(Math.pow(2,((4*period)/length))))),2)))+1;
//             period += Math.PI;
//         }
        
//         return arr;
//     }
    


    
//     /* Print array values */
//     public static void printArr(int[] arr, String arrayName){
//         System.out.print(arrayName + ": \t\t");
//          for(int i = 0; i<arr.length; i++){
//             System.out.print(arr[i] + "\t");
//         }
//         System.out.println();
//     }
// }