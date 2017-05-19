import java.util.Scanner;

public class ProblemG {

        public static void main(String[] args){
            Scanner in = new Scanner(System.in);
            int m = 0;
            int n = 0;
            int r1 = 0;
            int r2 = 0;

            Scanner lineScanner = new Scanner(in.nextLine());
            m = lineScanner.nextInt();
            
            for (int k = 0; k < m; k++)
            {
              lineScanner = new Scanner(in.nextLine());
              n = lineScanner.nextInt();
              int clauses[][] = new int[n-1][4];

              for (int i=0 ; i<n-1 ; i++) {
                clauses[i][0]=0;
                clauses[i][1]=0;
                clauses[i][2]=0;
                clauses[i][3]=0;
                
                lineScanner = new Scanner(in.nextLine());
                r1 = lineScanner.nextInt();
                r2 = lineScanner.nextInt();                
                clauses[i][2*r1+r2]=1;
                r1 = lineScanner.nextInt();
                r2 = lineScanner.nextInt();
                clauses[i][2*r1+r2]=1;
              }
           
              //System.out.println("");
              System.out.println(computeOpt(n,clauses));
            }
        }
        public static int computeOpt(int m, int[][] c){         
            int val[][] = new int[m][2]; //Start indexing at 0 for base case to make loop cleaner below
            val[0][0] = 0;
            val[0][1] = 0;
            
            for (int i=1; i<m; i++) {
              val[i][0] = Math.max(val[i-1][0] + c[i-1][0], val[i-1][1] + c[i-1][2]); //assign 00 or 10 to next clause
              val[i][1] = Math.max(val[i-1][0] + c[i-1][1], val[i-1][1] + c[i-1][3]); //assign 01 or 11 to next clause
            }

            return Math.max(val[m-1][0],val[m-1][1]);
        }
}
