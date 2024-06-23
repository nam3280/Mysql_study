import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class Main {
    public static void main(String[] args) throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));

        int num = Integer.parseInt(br.readLine());

        for(int i = 0; i < num; i++){
            for(int j = 0; j < (num * 2) - (i * 2 + 1) - 1; j++)
                System.out.print(" ");

            for(int k = num; k < num + (i * 2) + 1; k++)
                System.out.print("*");

            System.out.println();
        }
    }
}