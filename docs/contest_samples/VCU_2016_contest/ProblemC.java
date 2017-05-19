import java.util.*;
import java.io.*;

class Edge {
	int from;
	int to;
	double weight;

	Edge(int from, int to, double w) 
        {
		this.from = from;
		this.to = to;
		this.weight = w;
	}
}

public class ProblemC {

    ArrayList<Edge> edges;
    int nNodes;
    int source, target;


   void readInput() {
   	   double speed;
   	   double dist;
   	   int f, t;
   	   edges=new ArrayList<Edge>();
           Scanner stdin = new Scanner(System.in);
           String input=stdin.nextLine();
   	   String[] data = input.split(" ");
   	   nNodes = Integer.parseInt(data[0]);
   	   source = Integer.parseInt(data[1]);
   	   target = Integer.parseInt(data[2]);
           while(stdin.hasNextLine() && !( input = stdin.nextLine() ).equals( "" ))
           {
   	   	   data = input.split(" ");
   	   	   speed = Double.parseDouble(data[0]);
   	   	   f=t=-1;
   	   	   dist=Integer.MAX_VALUE;
   	   	   for(int j=1; j<data.length;) {
   	   	   	   f=t;
   	   	   	   t=Integer.parseInt(data[j]);
    	   	           if(f!=-1&&t!=-1) {
   	   	   	   	   edges.add(new Edge(f, t, dist/speed));
   	   	   	   }
   	   	   	   if(j+1<data.length)
   	   	   	   	   dist=Integer.parseInt(data[j+1]);
   	   	   	   j=j+2;
   	   	   }
   	   }
   }

   // assumes Nodes are numbered 0, 1, ... n and that the source Node is 0
   ArrayList<Integer> findShortestPath() {
       double[][] Weight = initializeWeight(nNodes, edges);
       double[] D = new double[nNodes];
       int[] P = new int[nNodes];
       ArrayList<Integer> C = new ArrayList<Integer>();

       // initialize:
       // (C)andidate set,
       // (D)ijkstra special path length, and
       // (P)revious Node along shortest path
       Arrays.fill(P, -1);
       for(int i=1; i<nNodes; i++){
           C.add(i);
           D[i] = Weight[0][i];
           if(D[i] != Integer.MAX_VALUE){
               P[i] = 0;
           }
       }

       // crawl the graph
       for(int i=0; i<nNodes-1; i++){
           // find the lightest Edge among the candidates
           double l = Integer.MAX_VALUE;
           int n = 0;
           for(int j : C){
               if(D[j] < l){
                   n = j;
                   l = D[j];
               }
           }
           C.remove(new Integer(n));

           // see if any Edges from this Node yield a shorter path than from source->that Node
           for(int j=1; j<nNodes; j++){
               if(D[n] != Integer.MAX_VALUE && Weight[n][j] != Integer.MAX_VALUE && D[n]+Weight[n][j] < D[j]){
                   // found one, update the path
                   D[j] = D[n] + Weight[n][j];
                   P[j] = n;
               }
           }

       }


       System.out.println(D[target]);
       return C;
   }

   private double[][] initializeWeight(int nNodes, ArrayList<Edge> edges){
       double[][] Weight = new double[nNodes][nNodes];
       for(int i=0; i<nNodes; i++){
           Arrays.fill(Weight[i], Integer.MAX_VALUE);
       }
       for(Edge e : edges){
       	   if(Weight[e.from][e.to]>e.weight){
       	   	   Weight[e.from][e.to] = e.weight;
       	   }
       }
       return Weight;
   }

   public static void main(String args[]){
   	   ProblemC di = new ProblemC();
   	   di.readInput();
   	   di.findShortestPath();
   }
}
