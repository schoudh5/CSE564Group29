import org.eclipse.swt.widgets.Display;
import org.eclipse.swt.widgets.Shell;


import org.eclipse.swt.widgets.Display;
import org.eclipse.swt.widgets.MessageBox;
import org.eclipse.swt.widgets.Shell;
import org.eclipse.swt.widgets.Text;
import org.eclipse.swt.SWT;
import org.eclipse.swt.widgets.Label;
import org.eclipse.swt.widgets.Button;
import org.eclipse.swt.events.SelectionAdapter;
import org.eclipse.swt.events.SelectionEvent;
import org.eclipse.swt.layout.RowLayout;

import java.io.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Set;
import java.util.StringTokenizer;

import javax.swing.JButton;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.apache.commons.io.FileUtils;
import org.w3c.dom.Document;
import org.w3c.dom.DocumentType;
import org.w3c.dom.NodeList;
import org.w3c.dom.Node;
import org.w3c.dom.Element;

public class ValidatorUI {

	protected Shell shell;
	private Text template;
	private HashMap<String, ArrayList<Service>> application = new HashMap<String, ArrayList<Service>>();
	

	/**
	 * Launch the application.
	 * @param args
	 */
	public static void main(String[] args) {
		try {
			
			
			ValidatorUI window = new ValidatorUI();
			window.open();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * Open the window.
	 */
	public void open() {
		Display display = Display.getDefault();
		shell = new Shell();
		shell.setSize(450, 300);
		createContents();
		shell.open();
		shell.layout();
		while (!shell.isDisposed()) {
			if (!display.readAndDispatch()) {
				display.sleep();
			}
		}
	}
	
	public void easySaaSValidator(String app){
		try {
			
			
			File bpelFile = new File(app);
			DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
			DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
			Document doc = dBuilder.parse(bpelFile);
			
			doc.getDocumentElement().normalize();
			String applicationName = null;
			Node node = doc.getElementsByTagName("bpel:process").item(0);
			if (node.getNodeType() == Node.ELEMENT_NODE) {			 
				Element elem = (Element) node;
				applicationName = elem.getAttribute("name");
			}	 
			
				 
			NodeList nodeList = doc.getElementsByTagName("bpel:sequence");
					
			for(int i = 0; i < nodeList.getLength(); i++){
				ArrayList<Service> serviceList = new ArrayList<Service>();
				System.out.println("sequence : " + i);
				Node nodeElem = nodeList.item(i);
				if (nodeElem.getNodeType() == Node.ELEMENT_NODE && nodeElem.getNodeName() == "bpel:sequence") 
				{	
					Element elem = (Element) nodeElem;
					String sequenceName = elem.getAttribute("name");
					NodeList invokeNodes = elem.getElementsByTagName("bpel:invoke");
	
					for(int j = 0; j < invokeNodes.getLength(); j++){
						Element invokeElem = (Element) invokeNodes.item(j);
						String serviceName = invokeElem.getAttribute("name");
						
						String input = invokeElem.getAttribute("inputVariable");
						StringTokenizer st = new StringTokenizer(input, ", ");
						ArrayList<String> inputVariable = new ArrayList<String>();
						int k = 0;
						while(st.hasMoreElements()){
							inputVariable.add((String)st.nextElement());
						}
						String output = invokeElem.getAttribute("outputVariable");
						String status = invokeElem.getAttribute("statusVariable");
						String requiresService = invokeElem.getAttribute("requiresService");
						Service serviceObj = new Service(serviceName, inputVariable, output, requiresService);
						serviceList.add(serviceObj);
					}
					
					//System.out.println("Printing list of services within sequences of " + applicationName);
					application.put(sequenceName, serviceList);
							
				}
			}		
			
			//print();
			interoperableTest();
			//randomizedTest();
				//sequenceFunction(nodeList);
					
		}catch (Exception e) {
	    	e.printStackTrace();
		}
	}
			
	public void interoperableTest() throws IOException{
		Set<String> keySet = application.keySet();
		for(String s : keySet){
			System.out.println("Sequence: " + s);
			ArrayList<Service> services = application.get(s);
			int j=0;
			for(Service serv : services){		
				ArrayList<String> input = serv.getInput();
				int i=0;
				ArrayList<String> paramValues=new ArrayList<String>();
						
				File file=new File("TextFile.txt");
				List<String> fileLines= FileUtils.readLines(file);
				String[] paramValuesFromFile=fileLines.get(j).split(",");
				for(String inputvar:input)
				{
					paramValues.add(paramValuesFromFile[i]);
					i++;
				}
				
				/*change this*/
				boolean valid = validateService(serv,input,paramValues);
				MessageBox msg = new MessageBox(shell);
				if(valid == true){
					
					msg.setMessage(serv.serviceName+" Validation Successful");
					//msg.open();
					
					//System.out.println(serv.getServiceName() + " service validated successfully");
				}
				else{
					msg.setMessage(serv.serviceName+" Validation Failed");
					//msg.open();
					
				}
				msg.open();
				j++;
			}
		}
	}
	
	public void randomizedTest() throws IOException{
		Set<String> keySet = application.keySet();
		for(String s : keySet){
			System.out.println("Sequence: " + s);
			ArrayList<Service> services = application.get(s);
			int j=0, k;
			for(k=services.size()-1; k > 0; k--){
				Service serv = services.get(k);
				ArrayList<String> input = serv.getInput();
				int i=0;
				ArrayList<String> paramValues=new ArrayList<String>();
						
				File file=new File("Random.txt");
				List<String> fileLines= FileUtils.readLines(file);
				String[] paramValuesFromFile=fileLines.get(j).split(",");
				for(String inputvar:input)
				{
					paramValues.add(paramValuesFromFile[i]);
					i++;
				}
				MessageBox msg = new MessageBox(shell);
				/*change this*/
				boolean valid = validateService(serv,input,paramValues);
				if(valid){
					msg.setMessage(serv.serviceName+" Validation Successful");
					//System.out.println(serv.getServiceName() + " service validated successfully");
				}
				else{
					msg.setMessage(serv.serviceName+" Validation Failed");
					//System.out.println(serv.getServiceName() + " service validated successfully");
				}
				j++;
				msg.open();
			}
		}
	}
	
	public boolean validateService(Service serv,ArrayList<String> parameter,ArrayList<String> parmatereValues) {
		
		boolean rvalue=true;
		String serviceName = serv.getServiceName();
		ArrayList<String> input = serv.getInput();
		String output = serv.getOutput();
		String urlString = serviceName;
			
		int i=0;
		for(String parameterNames: input)
		{
			urlString = urlString + parameterNames + "=" + parmatereValues.get(i) + "&";
			i++;
		}
			
		urlString=urlString.substring(0,urlString.length()-1);
		String response = "";
		try
		{
			response = Utility.doHttpUrlConnection(urlString);
		}
		catch (Exception e)
		{
			//e.printStackTrace();
			rvalue= false;
			
		}			
			
		
		if(response=="")
		{
			rvalue=false;
		}
		MessageBox msg = new MessageBox(shell);
		msg.setMessage(serviceName);
		msg.open();
		
		System.out.println("Service: " + serviceName);
		System.out.println("input: " + input);
		System.out.println("output: " + output);
		System.out.println("respone: " + response);
		shell.open();
		shell.layout();
		
		return rvalue;
	}
			
	public void print(){
		Set<String> keySet = application.keySet();
		for(String s : keySet){
			System.out.println("Sequence " + s);
			ArrayList<Service> display = application.get(s);
			for(Service serv : display){
				System.out.println(serv.getServiceInfo());
			}
		}
	}
			
	public String nodeToString(Node node) {
		StringWriter sw = new StringWriter();
		try {
		 Transformer t = TransformerFactory.newInstance().newTransformer();
		 t.setOutputProperty(OutputKeys.OMIT_XML_DECLARATION, "yes");
		 t.setOutputProperty(OutputKeys.INDENT, "yes");
		 t.transform(new DOMSource(node), new StreamResult(sw));
		}catch (TransformerException te) {
			 System.out.println("nodeToString Transformer Exception");
		}
		return sw.toString();
	}
			
	public void sequenceFunction(NodeList nodeList){
		for(int i = 0; i < nodeList.getLength(); i++)
		{
			Node nodeElem = nodeList.item(i);
			if (nodeElem.getNodeType() == Node.ELEMENT_NODE && nodeElem.getNodeName() == "bpel:sequence") 
			{	
				System.out.println("Instance : " + i);
				Element elem = (Element) nodeElem;
				String serviceName = elem.getAttribute("name");
				if(serviceName == "bpel:sequence"){
						
				}
				System.out.println(serviceName);
			}
		}
		System.out.println("----------------------------");
			
	}

	/**
	 * Create contents of the window.
	 */
	protected void createContents() {
		
		shell.setText("Welcome to EasySaaS validator!!!");
		
		template = new Text(shell, SWT.BORDER);
		template.setBounds(213, 195, 76, 21);
		
		Label lblEnterTemplate = new Label(shell, SWT.NONE);
		lblEnterTemplate.setBounds(213, 174, 86, 15);
		lblEnterTemplate.setText("Enter Template");
		
		Button btnRunValidator = new Button(shell, SWT.NONE);
		btnRunValidator.addSelectionListener(new SelectionAdapter() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				String application = template.getText();
				easySaaSValidator(application);
				
			}
		});
		btnRunValidator.setBounds(213, 226, 75, 25);
		btnRunValidator.setText("Run validator");
		
		org.eclipse.swt.widgets.List list = new org.eclipse.swt.widgets.List(shell, SWT.BORDER);
		list.setBounds(185, 46, 140, 114);
		
		Label lblListOfApplication = new Label(shell, SWT.NONE);
		lblListOfApplication.setBounds(159, 10, 214, 21);
		lblListOfApplication.setText("List of application templates available");
		
		File file=new File("");
		
		
		
		file=file.getAbsoluteFile();
		
		String[] files = file.list();
		for(String s : files){
			if(s.endsWith(".bpel")){
				list.add(s);	
			}
		}
	}
}

class Service{

	String serviceName;
	ArrayList<String> input;
	String output;
	String requiresService;
	
	Service(String s1, ArrayList<String> s2, String s3, String s4){
		serviceName = s1;
		input = s2;
		output = s3;
		requiresService = s4;
	}
	
	public String getServiceName(){
		return serviceName;
	}
	
	public ArrayList<String> getInput(){
		return input;
	}
	
	public String getOutput(){
		return output;
	}
	
	public String getRequiresService(){
		return requiresService;
	}
	
	public ArrayList<String> getServiceInfo() {
		ArrayList<String> info = new ArrayList<String>();
		info.add(serviceName);
		for(String s : input){
			info.add(s);
		}
		info.add(output);
		info.add(requiresService);
		return info;
	}
}
