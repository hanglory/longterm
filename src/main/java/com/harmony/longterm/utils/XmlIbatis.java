package com.harmony.longterm.utils;

import java.io.StringReader;
import java.util.Iterator;
import java.util.List;
import org.apache.log4j.Logger;
import org.jdom2.Attribute;
import org.jdom2.Content;
import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.input.SAXBuilder;

public class XmlIbatis
{
	private static Logger log = Logger.getLogger(XmlIbatis.class);
	
	private SAXBuilder builder = new SAXBuilder();
	
	private String root_node = "data";
	private String child_node = "item";
	
	public Document iBATISForMake(List<?> result) throws Exception {
		Element data = new Element(this.root_node);
		
		for (int i = 0; i < result.size(); i++) {
			Element element = new Element(this.child_node);
			String xml = (String) result.get(i);
			Document document1 = this.builder.build(new StringReader(xml));
			
			Element root = document1.getRootElement();
			List child = root.getChildren();
			for (Iterator<Element> iter = child.iterator(); iter.hasNext(); ) {
				Element node = iter.next();
				
				String name = node.getName();
				String value = node.getText();
				addElement(element, name, value);
			} 
	
			data.addContent((Content)element);
		} 
	
		Document document = new Document(data);
	
		return document;
	}


	public Element addElement(Element parent, String name, String value) {
		Element element = new Element(name);
		element.setText(value);
		parent.addContent((Content)element);
		
		return parent;
	}
	
	
	public void addAttribute(Element element, String name, String value) {
		Attribute attribute = new Attribute(name, value);
		element.setAttribute(attribute);
	}
}


/* Location:              D:\web\harmonybpm\WebContent\WEB-INF\classes\!\com\bizmteclib\bas\\util\XmlIbatis.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */