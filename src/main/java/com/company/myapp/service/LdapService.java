package com.company.myapp.service;

import java.util.Hashtable;

import javax.naming.Context;
import javax.naming.NamingEnumeration;
import javax.naming.directory.Attributes;
import javax.naming.directory.DirContext;
import javax.naming.directory.InitialDirContext;
import javax.naming.directory.SearchControls;
import javax.naming.directory.SearchResult;

import org.springframework.stereotype.Service;

import com.sun.org.apache.xerces.internal.util.SynchronizedSymbolTable;

@Service
public class LdapService {

	static DirContext ldapContext;
	boolean success=false;
	public String getUserDetails(String userName,String password){
		
		
		
		String dn=userName+"@vdashboard.com";
		 try
		    {
		     
		    /*  String userName="Arjun Thakur";
		      String base ="DC=vdashboard,DC=com";
		     String dn = "cn=" + userName + "," + base;  
		      System.out.println(dn);*/
		      Hashtable<String, String> ldapEnv = new Hashtable<String, String>(11);
		      ldapEnv.put(Context.INITIAL_CONTEXT_FACTORY, "com.sun.jndi.ldap.LdapCtxFactory");		  
		      ldapEnv.put(Context.PROVIDER_URL,  "LDAP://10.51.5.53:389");
		      ldapEnv.put(Context.SECURITY_AUTHENTICATION, "simple");		     
		      ldapEnv.put(Context.SECURITY_PRINCIPAL,dn);
		      ldapEnv.put(Context.SECURITY_CREDENTIALS, password);
		    
		      try {
		    	  ldapContext = new InitialDirContext(ldapEnv);
		    	  success=true;
		      } catch (Exception e) {
		    	  success=false;
		    	  userName=null;
				// TODO: handle exception
			}
		     
	/*	      if(success)
		      {
			      // Create the search controls         
			      SearchControls searchCtls = new SearchControls();
	
			      //Specify the attributes to return
			      String returnedAtts[]={"sn","givenName", "samAccountName"};
			      searchCtls.setReturningAttributes(returnedAtts);
	
			      //Specify the search scope
			      searchCtls.setSearchScope(SearchControls.SUBTREE_SCOPE);
	
			      //specify the LDAP search filter
			      String searchFilter = "(&(objectClass=user))";
	
			      //Specify the Base for the search
			      String searchBase = "dc=vdashboard,dc=com";
			      //initialize counter to total the results
			      int totalResults = 0;
	
			      // Search for objects using the filter
			      NamingEnumeration<SearchResult> answer = ldapContext.search(searchBase, searchFilter, searchCtls);
	
			      //Loop through the search results
			      while (answer.hasMoreElements())
			      {
			        SearchResult sr = (SearchResult)answer.next();
	
			        totalResults++;
	
			      //  System.out.println(">>>" + sr.getName());
			        Attributes attrs = sr.getAttributes();
			        System.out.println(">>>>>>" + attrs.get("samAccountName"));
			        userName=attrs.get("samAccountName").toString();
			      }
	
			      System.out.println("Total results: " + totalResults);
			      ldapContext.close();
		      }*/
			    }
			    catch (Exception e)
			    {
			      System.out.println(" Search error: " + e);
			      e.printStackTrace();
			      System.exit(-1);
			    }
		   
		return userName;
		
	}

}
