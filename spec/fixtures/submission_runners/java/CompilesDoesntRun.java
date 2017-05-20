import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Scanner;

public class CompilesAndRuns {

	public static void main(String[] args) {
            throw new java.lang.RuntimeException("Hullo! I'm an error.");

		Scanner sc = new Scanner(System.in);
		int knownObjects   = sc.nextInt();
		int dimensions     = sc.nextInt();
		int unknownObjects = sc.nextInt();
		int k              = sc.nextInt();

		// Dataset of known instances (+1 is for the class label)
		double[][] instances = new double[knownObjects][dimensions+1];

		// Read the known objects, including the class label
		for(int i = 0; i < knownObjects; i++)
			for(int j = 0; j < dimensions+1; j++)
				instances[i][j] = sc.nextDouble();

		// Predict the class label for every unknown object
		for(int i = 0; i < unknownObjects; i++)
		{
			double[] unknown = new double[dimensions];

			// Read the unknown object properties
			for(int j = 0; j < dimensions; j++)
				unknown[j] = sc.nextDouble();

			// Compute the distance to every known object
			HashMap<Integer,Double> distances = new HashMap<Integer,Double>();

			for(int j = 0; j < knownObjects; j++)
				distances.put(j, distance(instances[j], unknown));

			// Sort the distances ascending
			distances = sortByValue(distances, true);
			
			HashMap<Integer,Integer> votes = new HashMap<Integer,Integer>();
			
			// Compute the number of votes for each class within K neighbors
			int votesCount = 0;
			
			for(Map.Entry<Integer, Double> entry : distances.entrySet())
			{
				int classMembership = (int) instances[entry.getKey()][dimensions];
				
				if(votes.containsKey(classMembership))
					votes.put(classMembership, votes.get(classMembership) + 1);
				else
					votes.put(classMembership, 1);
				
				if((++votesCount) == k) break;
			}
			
			// Sort the number of votes descending
			votes = sortByValue(votes, false);
			
			// Show the class with the largest number of votes
			System.out.println(votes.keySet().iterator().next());
		}
		
		sc.close();
	}

	private static double distance(double[] known, double[] unknown)
	{
		double dist = 0;

		for(int i = 0; i < unknown.length; i++)
			dist += (known[i] - unknown[i]) * (known[i] - unknown[i]);

		return Math.sqrt(dist);
	}

	public static <K, V extends Comparable<? super V>> HashMap<K, V> sortByValue( Map<K, V> map , final boolean ascending)
	{
		List<Map.Entry<K, V>> list = new LinkedList<>( map.entrySet() );

		Collections.sort( list, new Comparator<Map.Entry<K, V>>()
		{
			@Override
			public int compare( Map.Entry<K, V> o1, Map.Entry<K, V> o2 ) {
				if(ascending)
					return (o1.getValue()).compareTo( o2.getValue() );
				else
					return (o2.getValue()).compareTo( o1.getValue() );
			}
		});

		HashMap<K, V> result = new LinkedHashMap<>();
		
		for (Map.Entry<K, V> entry : list)
			result.put( entry.getKey(), entry.getValue() );

		return result;
	}
}
