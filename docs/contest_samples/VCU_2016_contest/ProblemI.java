import java.io.*;
import java.util.*;


/* 
Shooting in the Dark - Problem I 


For more details, see:
http://www.cs.cornell.edu/~rdz/papers/kz-pami04.pdf
http://www.cs.toronto.edu/~ucacsjp/ChapUndirField.pptx
*/


/*
Sample Input 
3
2
1 10 50 
2 50 0 
3 10 50 
1 2 30
2 3 30

Sample Output
3 70
*/

/* MATLAB Code:

graph=sparse(pairCost);
graph(n+2,n+2)=0;
graph(n+1,1:n)=sparse(costW);
graph(1:n,n+2)=sparse(costB');

[flowval cut R F] = max_flow(graph, n+1, n+2); % function from MATLAB BGL TOOLBOX
disp(sprintf('%d %d',length(find(cut==1))-1,flowval));

*/



class BFSPath
{
	public int flow;
	public int parents[]=null;
	public int visitedCnt=0;
	public BFSPath(int n)
	{
		int i;
		parents=new int[n];
		for (i=0;i<n;i++)
			parents[i]=-1;
	}
	
  public static BFSPath bfs(int c[][],int n,int s,int t)
  {
  	BFSPath bfsPath=new BFSPath(n);
  	boolean visited[]=new boolean[n];
  	int pathCap[]=new int[n];
  	int cv;
  	int v;
  	for (v=0;v<n;v++)
  	{
  		visited[v]=false;
  		pathCap[v]=0;
  	}
  	visited[s]=true;
  	pathCap[s]=Integer.MAX_VALUE;
  	Integer tmp;
  	Queue<Integer> q=new LinkedList<>();
  	q.add(new Integer(s));
  	while (!q.isEmpty())
  	{
  		tmp=q.poll();
  		cv=tmp.intValue();
  		for (v=0;v<n;v++)
  		{
  			if ( (c[cv][v]>0) && (visited[v]==false) )
  			{
  			  	visited[v]=true;
  				bfsPath.parents[v]=cv;
  				pathCap[v]=Math.min(pathCap[cv],c[cv][v]);
  				//if (v==t) 
  				//	break; // normally we'd have this, but we want to have count of visited nodes
  				if (v!=t)
  				{
	  				q.add(new Integer(v));
  					bfsPath.visitedCnt++;
  				}
  			}
  		}
  	}
  	bfsPath.flow=pathCap[t];
  	return bfsPath;  	
  }
  
}

public class ProblemI
{
  
  public static int[] maxflow(int c[][],int n,int s,int t)
  {
  	int result[]=new int[2];
  	result[0]=-1;
  	result[1]=-1;
  	int flowTotal=0;
    int i,j,k;
    BFSPath bfsPath=null;
    while (true)
    {
		bfsPath=BFSPath.bfs(c,n,s,t);
		if (bfsPath.flow==0)
		{
			break;
		}
		flowTotal+=bfsPath.flow;
		int cv=t;
		int ocv;
		while (cv!=s)
		{	
			ocv=cv;
			cv=bfsPath.parents[ocv];
			c[cv][ocv]-=bfsPath.flow;
			c[ocv][cv]+=bfsPath.flow;
		}	
	}
	result[0]=bfsPath.visitedCnt;
	result[1]=flowTotal;
	return result;
  }

  public static int[] solve(int c[][],int n)
  {
    return maxflow(c,n+2,n,n+1);
  }


  public static void main(String[] args) throws Exception
  {
    Scanner sc=new Scanner(System.in);
    int n=sc.nextInt();
    int m=sc.nextInt();
    int M[][]=new int[n+2][n+2]; // should in fact be implemented using adjacency lists instead of adjacency matrix; that's left as an exercise to readers
	int W[]=new int[n];
	int B[]=new int[n];
	int v,v1,v2;
	for (int i=0;i<n;i++)
	{
		for (int j=0;j<n;j++)
			M[i][j]=0;  // I'm a C programmer ;)
		v=sc.nextInt()-1;
		B[v]=sc.nextInt();
		W[v]=sc.nextInt();
	}
	for (int j=0;j<m;j++)
	{
		v1=sc.nextInt()-1;
		v2=sc.nextInt()-1;
		M[v1][v2]=sc.nextInt(); // set capacities for max flow
		M[v2][v1]=M[v1][v2]; // set capacities for max flow
	}
	for (int k=0;k<n;k++)
	{
		M[n][k]=W[k]; //n is source for max flow, set capacities from it
		M[k][n+1]=B[k]; // n+1 is sink for max flow, set capacities to it
	}
    int result[]=solve(M,n);
    System.out.println(result[0]+" "+result[1]);
  }

}

