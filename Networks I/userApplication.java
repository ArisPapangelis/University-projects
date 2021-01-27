/*
*
* Δίκτυα Υπολογιστών I
*
* Experimental Virtual Lab
*
* 
* ¶ρης Ελευθέριος Παπαγγέλης 
* ΑΕΜ : 8883 
*
*/


//import ithakimodem.*;
import java.io.*;
import java.util.ArrayList;
import java.util.Scanner;


public class userApplication {
	public static void main(String[] param) throws IOException {
		System.out.println("Enter your choice:");

		Scanner input = new Scanner(System.in);
		boolean flag=true;
		while (flag) {
			System.out.println("1. Test the connection with Ithaki server.");
			System.out.println("2. Get and time five minutes of echo packets.");
			System.out.println("3. Get two images from Ithaki, one with errors and one without errors.");
			System.out.println("4. Get a Google Maps image with predefined gps markers.");
			System.out.println("5. Get and time five minutes of error-prone packets with an ARQ mechanism.");
			System.out.println("6. Do all of the above and exit.");
			System.out.println("7. Exit.");

			int choice=input.nextInt();
			switch (choice) {
			case 1:
				(new userApplication()).demo();
				break;
			
			case 2:
				(new userApplication()).echoPackets(input);
				break;
			
			case 3:
				(new userApplication()).images(input);
				break;
			case 4:
				(new userApplication()).gps(input);
				break;
				
			case 5:
				(new userApplication()).arq(input);
				break;
				
			case 6:
				userApplication obj= new userApplication();
				obj.demo();
				obj.echoPackets(input);
				obj.images(input);
				obj.gps(input);
				obj.arq(input);
				flag=false;
				break;
				
			default:
				System.out.println("Exiting program.");
				flag=false;	
			}
		}
		input.close();
	}
	
	public void demo() {
		int k;
		Modem modem;
		modem=new Modem();
		modem.setSpeed(8000);
		modem.setTimeout(1000);
		
		modem.open("ithaki");
		
		String str="TEST\r";
		byte[] bytes = str.getBytes();
		modem.write(bytes);
		
		
		for (;;) {
			try {
				k=modem.read();
				if (k==-1) break;
				System.out.print((char)k);
			} catch (Exception x) {
				break;
			}
		}
		
		// NOTE : Break endless loop by catching sequence "\r\n\n\n".
		// NOTE : Stop program execution when "NO CARRIER" is detected.
		// NOTE : A time-out option will enhance program behavior.
		// NOTE : Continue with further Java code.
		// NOTE : Enjoy :)
		System.out.println();
		modem.close();
	}
	
	public void echoPackets(Scanner input) throws IOException{
		int k;
		Modem modem;
		modem=new Modem();
		modem.setSpeed(80000);
		int timeout=100;
		modem.setTimeout(timeout);
		
		modem.open("ithaki");

		
		for (;;) {
			try {
				k=modem.read();
				if (k==-1) break;
				System.out.print((char)k);
			} catch (Exception x) {
				break;
			}
		}
		
		FileWriter out = new FileWriter("echopackets.txt");
		
		System.out.println("Input the Echo request code:");
		String str = input.next();
		str+="\r";
		byte[] bytes = str.getBytes();
		
		long t1=0,start=0;
		start=System.currentTimeMillis();
		while (System.currentTimeMillis()-start<=1000*5*60) {
			
			t1=System.currentTimeMillis();
			modem.write(bytes);
			while (true) {
				try {
					k=modem.read();
					if (k==-1) {
						break;
					}
					System.out.print((char)k);
				} catch (Exception x) {
					break;
				}
			}
			System.out.println();
			out.write(String.valueOf(System.currentTimeMillis()-t1-timeout));
			out.write("\r\n");
		}
			
		System.out.println("Five minutes of echo packets have been timed.");
		System.out.println();

		out.close();
		modem.close();
		
	}
	
	
	public void images(Scanner input) throws IOException{
		int k;
		Modem modem;
		modem=new Modem();
		modem.setSpeed(80000);
		modem.setTimeout(500);
		
		modem.open("ithaki");

		for (;;) {
			try {
				k=modem.read();
				if (k==-1) break;
				System.out.print((char)k);
			} catch (Exception x) {
				break;
			}
		}
		
		FileOutputStream out = new FileOutputStream("image.jpg");
		
		System.out.println("Input the Image request code (error-free):");
		String str = input.next();
		str+="CAM=FIX\r";
		byte[] bytes = str.getBytes();
		modem.write(bytes);
		
		while (true) {
			try {
				k=modem.read();
				if (k==-1) break;
				out.write(k);
			} catch (Exception x) {
				break;
			}
		}
		
		System.out.println("Error-free image saved.");
		out.close();
		
		out = new FileOutputStream("corrupt_image.jpg");
		System.out.println("Input the Image request code (with errors):");
		str = input.next();
		str+="\r";
		bytes = str.getBytes();
		modem.write(bytes);
		
		while (true) {
			try {
				k=modem.read();
				if (k==-1) break;
				out.write(k);
			} catch (Exception x) {
				break;
			}
		}
		
		System.out.println("Error-prone image saved.");

		System.out.println("Both images from Ithaki camera saved.");
		System.out.println();
		out.close();
		modem.close();
		
	}
	
	public void gps(Scanner input) throws IOException{
		int k;
		Modem modem;
		modem=new Modem();
		modem.setSpeed(80000);
		modem.setTimeout(500);
		
		modem.open("ithaki");

		for (;;) {
			try {
				k=modem.read();
				if (k==-1) break;
				System.out.print((char)k);
			} catch (Exception x) {
				break;
			}
		}
		
		ArrayList<String> code = new ArrayList<String>();
		String coords="";
		
		System.out.println("Input the GPS request code:");
		String str = input.next();
		String temp=str;
		str+="R=1062099\r";
		//ισως και starting step na allaksw
		byte[] bytes = str.getBytes();
		modem.write(bytes);
		
		//450 kalo!
		//620 kalo!
		
		while (true) {
			try {
				k=modem.read();
				if (k==-1) break;
				coords=coords+(char)k;
			} catch (Exception x) {
				break;
			}
		}
		
		String[] parts=coords.split("\\r\\n");
		//for (int j=0;j<parts.length;j++)
			//System.out.println(parts[j]);
		
		//System.out.println(parts.length);
		for (int i=1;i<parts.length-1;i++) {
			String[] splt=parts[i].split(",");
			String lat=dm_to_dms(Double.parseDouble(splt[2])/100);
			String longit=dm_to_dms(Double.parseDouble(splt[4])/100);
			code.add("T="+longit+lat);
			//System.out.println(splt[2]);
			//System.out.println(splt[4]);
			//System.out.println(longit+lat);
		}
		
		str=temp;
		//System.out.println(code.size());
		for (int i=0;i<99;i=i+12) {
			str=str+code.get(i);
		}
		str+="\r";
		//System.out.println(str);
		
		FileOutputStream out = new FileOutputStream("gps.jpg");
		byte[] gpsBytes = str.getBytes();
		modem.write(gpsBytes);
		
		while (true) {
			try {
				k=modem.read();
				if (k==-1) break;
				out.write(k);
			} catch (Exception x) {
				break;
			}
		}
		
		System.out.println("GPS image saved.");
		System.out.println();

		out.close();
		modem.close();
	}
	
	public String dm_to_dms(double deg) {
		int d= (int)deg;
	    double md = Math.abs(deg - d) * 100;
	    int m = (int)md;
	    int sd = (int) ((md - m) * 60);
	    
	    String str="";
	    str=str+String.valueOf(d)+String.valueOf(m)+String.format("%02d", sd);
	    return str;
	}
	
	public void arq(Scanner input) throws IOException {
		int k;
		Modem modem;
		modem=new Modem();
		modem.setSpeed(80000);
		int timeout=100;
		modem.setTimeout(timeout);
		
		modem.open("ithaki");

		
		for (;;) {
			try {
				k=modem.read();
				if (k==-1) break;
				System.out.print((char)k);
			} catch (Exception x) {
				break;
			}
		}
		
		FileWriter out = new FileWriter("arq.txt");
		
		System.out.println("Input the ACK result code:");
		String ack = input.next();
		ack+="\r";
		byte[] bytes = ack.getBytes();
		
		System.out.println("Input the NACK result code:");
		String nack=input.next();
		nack+="\r";
		
		
		long t1=0,start=0;
		
		String packet;
		
		int resends=0;
		int[] resendList = {0,0,0,0,0,0,0,0};
		
		start=System.currentTimeMillis();
		t1=System.currentTimeMillis();
		//change time
		while (System.currentTimeMillis()-start<=1000*5*60) {
			
			packet="";
			modem.write(bytes);
			
			while (true) {
				try {
					k=modem.read();
					if (k==-1) break;
					System.out.print((char)k);
					packet+=(char)k;
				} catch (Exception x) {
					break;
				}
			}
			String cryptoCode = packet.substring(packet.indexOf("<")+1, packet.indexOf(">"));
			String fcs = packet.substring(packet.indexOf(">")+2,packet.indexOf(">")+5);
			System.out.println();
			byte[] xorArray=cryptoCode.getBytes();
			int xorResult=xorArray[0];
			for (int i=1;i<16;i++) {
				xorResult = (xorResult ^ xorArray[i]);
			}
			if (xorResult==Integer.parseInt(fcs)) {
				bytes=(ack+"\r").getBytes();
				out.write(String.valueOf(System.currentTimeMillis()-t1-timeout*(resends+1)));
				out.write("\r\n");
				resendList[resends]+=1;
				resends=0;
				t1=System.currentTimeMillis();
			}
			else {
				bytes=(nack+"\r").getBytes();
				resends+=1;
			}
			
			System.out.println(xorResult);
			System.out.println(Integer.parseInt(fcs));
			System.out.println(resends);
			

		}
			
		System.out.println("Five minutes of ARQ packets have been timed.");
		out.close();
		
		FileWriter out2 = new FileWriter("retransmissions.txt");
		for (int i=0;i<resendList.length;i++) {
			out2.write(String.valueOf(resendList[i]));
			out2.write("\r\n");
		}
		
		System.out.println();
		out2.close();
		modem.close();
		
	}
	
}
