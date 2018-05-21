public class Locator{
  public Locator(){
  }
  public float[] arrayAdd(float[] arr1, float[] arr2){
    float[] result = new float[arr1.length];
    for(int i=0; i<arr1.length; i++){
      result[i] = arr1[i]+arr2[i];
    }
    return result;
  }
  
  public int[] arrayAdd(int[] arr1, int[] arr2){
    int[] result = new int[arr1.length];
    for(int i=0; i<arr1.length; i++){
      result[i] = arr1[i]+arr2[i];
    }
    return result;
  }
  
  public float[] arrayMulti(float[] arr1, float[] arr2){
    float[] result = new float[arr1.length];
    for(int i=0; i<arr1.length; i++){
      result[i] = arr1[i]*arr2[i];
    }
    return result;
  }
  
  public int[] arrayScalarMulti(int[] arr1, int num){
    int[] result = new int[arr1.length];
    for(int i=0; i<arr1.length; i++){
      result[i] = arr1[i]*num;
    }
    return result;
  }
}
