import java.io.*;
import java.util.*;


/* 
Problem J

Sample Input 
3
100 50 9 1
100 50 9 2
100 50 9 3



Sample Output
200
550
1625


*/



public class ProblemJ
{
  public static long solve(int E, int p, double R, int Y)
  {
  	double s=(100-(double)p)/100;
	long[] males=new long[Y+1];
	long[] females=new long[Y+1];
	males[1]=E;
	females[1]=E;
	long[] fkids=new long[Y+1];
	long[] mkids=new long[Y+1];
	for (int i=2;i<=Y;i++)
	{
    	males[i]=(long)Math.floor(males[i-1]*s);
    	females[i]=(long)Math.floor(females[i-1]*s);
	    fkids[i]=females[i]*(long)Math.ceil(R/2);
    	mkids[i]=females[i]*(long)Math.floor(R/2);
	    males[i]=males[i]+mkids[i];
	    females[i]=females[i]+fkids[i];
	}	
	return males[Y]+females[Y];  
  }

  public static void main(String[] args) throws Exception
  {
    Scanner sc=new Scanner(System.in);
    int n;
    int E,p,R,Y;
    n=sc.nextInt();
    for (int i=0;i<n;i++)
    {
    	E=sc.nextInt();
    	p=sc.nextInt();
    	R=sc.nextInt();
    	Y=sc.nextInt();
    	System.out.println(solve(E,p,R,Y));
    }
  }

}

