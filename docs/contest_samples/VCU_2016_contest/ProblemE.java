import java.io.*;

public class ProblemE {

	public static void main(String[] args) throws IOException {

			BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));;

			String firstLine=reader.readLine();
			String secondLine=reader.readLine();
			String [] firstArray = null;
			String [] secondArray = null;
				
			//System.out.println(firstLine); 
			//System.out.println(secondLine);
				
			if(firstLine == null){
				//Validate if the 1st Line is empty, or compiler would give NullPointerException
				System.out.println("First Line is empty.");
			}else{
				firstArray = firstLine.split("");
			}
				
			if(secondLine == null){
				//Validate if the 2nd Line is empty, or compiler would give NullPointerException
				System.out.println("Second Line is empty.");
			}else{
				secondArray = secondLine.split("");
			}
			
			int match=0;
			for(int i=0;i<firstArray.length;i++){
				if(firstArray[i].equals(secondArray[i])){
					match++; //if the i-th letter of firstLine matches	the i-th letter of secondLine, match++
				}
			}
			String writeLine=match+"/"+(firstArray.length);

			System.out.println(writeLine);
	}
}
