import java.util.*;
import java.io.*;

public class ProblemB {
	public static void main(String[] args) {
    
        try{
          BufferedReader r = new BufferedReader(new InputStreamReader(System.in));
            int sum=0,p=1;
            int data[]=new int[4];
            int cha;
            cha = r.read();
            while(cha!=-1){
                if(cha==10||cha==13){
                    sum = 0;
                    cha = r.read();
                    continue;
                }
                else{
                    data[sum]=(cha-'0'+5)%10;
                    sum++;
                    if(sum==4){
                      int temp =data[3];
                          data[3]=data[0];
                          data[0]=temp;
                          temp=data[2];
                          data[2]=data[1];
                          data[1]=temp;
                      sum=0;
                      //w.write("#"+p+' ');
                      for(int i=0;i<4;i++)
                      {       
                          System.out.print(data[i]);
                      }
                      System.out.println("");
                      p++;
                    }
                }
             cha = r.read();
             }
            }
            catch (IOException e){
               e.printStackTrace();     
            }
    }
}
