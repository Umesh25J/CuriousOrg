public class StringArrayTest {
    public static List<String> generateStringArray(Integer n){
    List<String> listString = new List<String>();
    for (Integer i=0;i<n;i++){
        String str= 'Test '+i;
        listString.add(str);
    }
    System.debug(listString);
    return listString;
    }
}