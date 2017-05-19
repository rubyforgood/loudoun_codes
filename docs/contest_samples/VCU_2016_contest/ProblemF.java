import java.io.*;
import java.util.*;


/* 
Problem F

Polish Notation

Sample Input 
+ * 3 + + 4 5 6 7

Sample Output
((3*((4+5)+6))+7)

Further exploration: 

1) same problem, but printing "(" and ")" only where necessary, 
i.e.  print "3*(4+5+6)+7"  instead of "((3*((4+5)+6))+7)"

2) the reverse problem, with "(" and ")" only where necessary on input, 
i.e., convert "3*(4+5+6)+7" to "+ * 3 + + 4 5 6 7"

3) check out ANTLR ( http://www.antlr.org/ ) for a Java-based tool for parsing complex input
*/



class PNTree
{
	PNTree left=null;
	PNTree right=null;
	String digit="";
	String op="";
	
	// build tree based on input
	public void scan(Scanner sc)
	{
		String input=sc.next();
		char ic=input.charAt(0)
		;
		if (ic=='+')
		{
			op="+";
			left=new PNTree();
			left.scan(sc);
			right=new PNTree();
			right.scan(sc);
		}
		else if (ic=='*')
		{
			op="*";
			left=new PNTree();
			left.scan(sc);
			right=new PNTree();
			right.scan(sc);
		}
		else
		{
			digit=input;
		}	
	}
	
	// infix traversal of tree, with printing
	public void print()
	{
		if (left==null && right==null)
		{
			System.out.print(digit);
		}
		else
		{
			System.out.print("(");
			left.print();
			System.out.print(op);
			right.print();
			System.out.print(")");
		}
	}
}

public class ProblemF
{
  public static void main(String[] args) throws Exception
  {
    Scanner sc=new Scanner(System.in);
    PNTree pn=new PNTree();
    pn.scan(sc);
    pn.print();
    System.out.println("\n");
  }

}

