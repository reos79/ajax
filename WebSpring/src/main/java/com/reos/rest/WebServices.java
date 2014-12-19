package com.reos.rest;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class WebServices {
	
	private static int ID = 0;
	private static final String CHARSET = ";charset=UTF-8";
	private static final String OK = "OK";

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/services/contacts", method = RequestMethod.GET, produces = { MediaType.APPLICATION_JSON_VALUE + CHARSET })
	@ResponseBody
	public Response findContacts(HttpServletRequest request){
		HttpSession session = request.getSession();
		List<Contact> contacts = null;
		if(session.getAttribute("contacts") == null){
			contacts = new ArrayList<Contact>();
			session.setAttribute("contacts", contacts);
		}else{
			contacts = (List<Contact>)session.getAttribute("contacts");
		}
		
		Response response = new Response();
		response.setStatus(OK);
		response.setContacts(contacts);
		return response;
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/services/contacts", method = RequestMethod.POST, produces = { MediaType.APPLICATION_JSON_VALUE + CHARSET })
	@ResponseBody
	public Response addContact(HttpServletRequest request, @RequestParam("name")String name, 
			@RequestParam("phone")String phoneNumber, @RequestParam("address")String address){
		
		HttpSession session = request.getSession();
		List<Contact> contacts = null;
		if(session.getAttribute("contacts") == null){
			contacts = new ArrayList<Contact>();
			session.setAttribute("contacts", contacts);
		}else{
			contacts = (List<Contact>)session.getAttribute("contacts");
		}
		
		Contact contact = new Contact();
		contact.setId(++ID);
		contact.setName(name);
		contact.setPhoneNumber(phoneNumber);
		contact.setAddress(address);
		contacts.add(contact);
		
		Response response = new Response();
		response.setStatus(OK);
		response.setContacts(contacts);
		return response;
	}
}
