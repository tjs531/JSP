package com.koreait.pjt;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class MyUtils {
	public static String encryptString(String str) {
		String sha = "";

       try{
          MessageDigest sh = MessageDigest.getInstance("SHA-256");
          sh.update(str.getBytes());
          byte byteData[] = sh.digest();
          StringBuffer sb = new StringBuffer();					//메모리 관리에 효율적. 문자열을 합칠때 메모리공간을 따로 안만들고 계속 뒤에 붙인다. 
          														//(문자열 + 문자열 식으로 쓰면 옛날에는 각각 메모리공간을 만들어서 메모리 낭비 심했다. 요즘에는 저렇게 써도 알아서 호출됨. 근데 for문안에서 쓰면 안됨.?)
          for(int i = 0 ; i < byteData.length ; i++){
              sb.append(Integer.toString((byteData[i]&0xff) + 0x100, 16).substring(1));
          }
          sha = sb.toString();
      }catch(NoSuchAlgorithmException e){
          //e.printStackTrace();
          System.out.println("Encrypt Error - NoSuchAlgorithmException");
          sha = null;
      }

      return sha;
	}
}
