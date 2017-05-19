import java.io.*;

public class ProblemD {
    static class Triangle
    {
        private float x1,y1,x2,y2,x3,y3;

        Triangle(float x1, float y1, float x2, float y2, float x3, float y3) {
            this.x1 = x1; this.y1 = y1; 
            this.x2 = x2; this.y2 = y2;
            this.x3 = x3; this.y3 = y3;
        }
        
        double area() {
            return Math.abs((x1*(y2-y3) + x2*(y3-y1)+ x3*(y1-y2))/2.0);
        }
        
        boolean pointInTriangleTest_BarycentricCoords(float[] point)
        {
            float x = point[0]; float y = point[1];
            float denominator = ((y2 - y3)*(x1 - x3) + (x3 - x2)*(y1 - y3));
            float a = ((y2 - y3)*(x - x3) + (x3 - x2)*(y - y3)) / denominator;
            float b = ((y3 - y1)*(x - x3) + (x1 - x3)*(y - y3)) / denominator;
            float c = 1 - a - b;
 
            return 0 <= a && a <= 1 && 0 <= b && b <= 1 && 0 <= c && c <= 1;
        }

        boolean pointInTriangleTest_Area(float[] point)
        {
            float x = point[0]; float y = point[1];            
            Triangle PBC = new Triangle(x, y, x2, y2, x3, y3);
            Triangle PAC = new Triangle(x1, y1, x, y, x3, y3);
            Triangle PAB = new Triangle(x1, y1, x2, y2, x, y);
            
            //Note: directly comparing floating point numbers is bad, in general
            return (this.area() == PBC.area() + PAC.area() + PAB.area());
        }
    }
    
    private static Triangle readTriangleFromInput(BufferedReader reader) throws IOException
    {
        String line = reader.readLine();
        String[] parts = line.split(" ");
        assert(parts.length == 6);
        float[] coords = new float[6];
        for(int i=0; i<parts.length; i++)
        {
            coords[i] = Float.parseFloat(parts[i]);
        }
        return new Triangle(coords[0],coords[1],coords[2],coords[3],coords[4],coords[5]);
    }
    
    private static int readNumberOfPixelsFromInput(BufferedReader reader) throws IOException
    {
        String line = reader.readLine();
        return Integer.parseInt(line);
    }
    
    private static float[] readPointFromInput(BufferedReader reader) throws IOException
    {
        String line = reader.readLine();
        String[] parts = line.split(" ");
        assert(parts.length == 2);
        float[] point = new float[2];
        point[0] = Float.parseFloat(parts[0]);
        point[1] = Float.parseFloat(parts[1]);
        return point;
    }
    
    public static void main(String[] args) 
    {
        try {
            BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));

            Triangle tri = readTriangleFromInput(reader);
            int numberOfPixels = readNumberOfPixelsFromInput(reader);
            for(int i=0; i<numberOfPixels; i++)
            {
                float[] point = readPointFromInput(reader);
                boolean isPointInTri = tri.pointInTriangleTest_Area(point);
                //boolean isPointInTri = tri.pointInTriangleTest_BarycentricCoords(point);
                if(isPointInTri)
                {
                    System.out.println("1");
                }
                else
                {
                    System.out.println("0");
                }
            }
        }
        catch (IOException ex)
        {
            ex.printStackTrace();
        }
    }

}
