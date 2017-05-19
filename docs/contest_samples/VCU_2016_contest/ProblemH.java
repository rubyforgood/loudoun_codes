import java.util.*;
import java.util.Map.Entry;



class ProblemH
{	public static void main (String[] args) throws java.lang.Exception
	{		 
		//test();
		 Scanner scanner = new Scanner( System.in );
		 
		 do {
		 	int n = scanner.nextInt();
		 	long start = System.nanoTime();
		 	int rmax = -1;
		 	if (n < 0) break;
		 	Circle c[] = new Circle[n];
		 	
		 	double total_area = 0;
		 	for (int i=0;i<n;++i) {
		 		c[i] = new Circle();
		 		c[i].x = scanner.nextInt();
		 		c[i].y = scanner.nextInt();
		 		c[i].r= scanner.nextInt();
		 		if (c[i].r > rmax)
		 			rmax = c[i].r;
		 		c[i].r2 = c[i].r * c[i].r;
		 		total_area += c[i].r2*Math.PI;
		 	}
		 	
		 	HashSet<Square> inside_square = new HashSet<Square>();
		 	HashMap<Square, ArrayList<Circle> > boundary_square= new HashMap<Square, ArrayList<Circle> >();
		 	
		 	classify_square(c, inside_square, boundary_square);
		 	
		 	double est_area = estimate_area(c, boundary_square) + inside_square.size();
		 	System.out.printf("%.1f\n",est_area );
		 	
		 	//System.out.printf("Elapsed time: %.1f\n", (System.nanoTime() - start)/1000000000.0);
		 } while (true);
		 scanner.close();
	}


	private static double estimate_area(Circle[] c,
			HashMap<Square, ArrayList<Circle>> boundary_square) {

		double epsilon = 0.0005, delta = 0.005;
		int ns = boundary_square.size();
		epsilon = Math.max(epsilon, 0.01/ns);
	 	long fdraws = (int)(8*(Math.E - 2)/(epsilon*epsilon)*Math.log(2.0/delta) )+1;
	 	ArrayList<Entry<Square, ArrayList<Circle> > >  entries 
	 		= new ArrayList<Entry<Square, ArrayList<Circle> > >( boundary_square.entrySet());	
	 	
	 	int heads = 0;
		for(int i =0; i < fdraws;++i) {
			int s = (int)(Math.random()*ns);
			Square sq = entries.get(s).getKey();
			ArrayList<Circle> lc =  entries.get(s).getValue();
			float x = (float)(sq.x + Math.random()),
				  y = (float)(sq.y + Math.random());
			for(Circle cc: lc) {
				float dx = x - cc.x,
					  dy = y - cc.y;
				if (dx*dx + dy *dy <= cc.r2) {
					heads += 1;
					break;
				}
			}
		}
		return (heads*1.0/fdraws * ns);
	}


	private static void classify_square(Circle[] c,
			HashSet<Square> inside_square,
			HashMap<Square, ArrayList<Circle>> boundary_square) {
		for (Circle cc : c) {			
			for(int py=cc.r, px=0; py>0; --py) {
				int ny=py -1, nx = px;
				for(int ix=-px; ix < px;++ix) {
					inside_square.add( new Square(ix+cc.x, ny + cc.y) );
					inside_square.add( new Square(ix+cc.x, -ny-1 + cc.y) );
				}
					
				while (nx*nx+ny*ny <cc.r*cc.r) {
					my_insert( boundary_square,  cc, nx, ny);
					my_insert( boundary_square,  cc, -nx-1, ny);
					my_insert( boundary_square,  cc, nx, -ny-1);
					my_insert( boundary_square,  cc, -nx-1, -ny-1);
					++nx;
				}
				px = nx - 1;
				if (nx * nx + ny * ny < cc.r*cc.r)
					px = nx;
				
			}
		}
		
		// Remove the intersections of the two list from the boundary squares
		ArrayList<Square> bsq = new ArrayList<Square>(boundary_square.keySet());
		for(Square sq : bsq){
			if ( inside_square.contains(sq) )
				boundary_square.remove(sq);
		}
	}



	private static void my_insert(
			HashMap<Square, ArrayList<Circle>> boundary_square, Circle cc,
			int nx, int ny) {		
		Square sq= new Square(cc.x + nx, cc.y+ ny);  
		
		ArrayList<Circle> cl;
		if (!boundary_square.containsKey(sq)) {
			cl = new ArrayList<Circle>();
			cl.add(cc);
			boundary_square.put(sq, cl);
		} else {
			cl = boundary_square.get(sq);
			cl.add(cc);			
		}
	}
}

class Square { // Square with bottom left at (x, y) and top right at (x+1, y+1)
	int x, y;
	public Square(int ix, int iy) {
		x = ix; 
		y = iy;
	}
	
	public boolean equals(Object sq) {
		if ( !(sq instanceof Square))
			return false;
		Square that = (Square) sq;
	    return (that.x == this.x) && (that.y == this.y);
	}

	public int hashCode() {	    
	    return x*20000 + y;
	}	
}

class Circle {
	public int x, y, r, r2;
}
