<html>
<head>
	<link href="http://getbootstrap.com/2.3.2/assets/css/bootstrap.css" rel="stylesheet">
	<script>
		function showContacts(response){
			cleanTable();
            for (i = 0; i < response.contacts.length; i++) { 
            	var c = response.contacts[i];
            	addRow(c.name, c.phoneNumber, c.address);
            }
		}
	
		function loadContacts(){
			var xmlhttp = new XMLHttpRequest();
		    xmlhttp.onreadystatechange = function() {
		        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
		        	var response = JSON.parse(xmlhttp.responseText);
		        	showContacts(response);
		        }
		    }
		    xmlhttp.open("GET", "/reos-web/reos/services/contacts", true);
		    xmlhttp.send();	
		}
		
		function addContact(){
			var xmlhttp = new XMLHttpRequest();
		    xmlhttp.onreadystatechange = function() {
		    	if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
		    		var response = JSON.parse(xmlhttp.responseText);
		    		showContacts(response);
		        }
		    }
		    xmlhttp.open("POST", "/reos-web/reos/services/contacts", true);
		    xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		    var name = document.getElementById("name").value;
		    var phone = document.getElementById("phone").value;
		    var address = document.getElementById("address").value;
		    var params = 'name=' + name + '&phone=' + phone + '&address=' + address;
		    xmlhttp.send(params);
		}
		
		function cleanTable(){
			var table = document.getElementById("tableid");
			for(var i = table.rows.length - 1; i > 0; i--)
			{
			    table.deleteRow(i);
			}
		}
		
		function addRow(name, phone, address)
		  {
		    var tbody = document.getElementById("tableid").getElementsByTagName("TBODY")[0];
		    var row = document.createElement("TR");
		    
		    var tdName = document.createElement("TD");
		    tdName.innerHTML = name;
		    
		    var tdPhone = document.createElement("TD");
		    tdPhone.innerHTML = phone;
		   
		    var tdAddress = document.createElement("TD");
		    tdAddress.innerHTML = address;
		   
		    row.appendChild(tdName);
		    row.appendChild(tdPhone);
		    row.appendChild(tdAddress);
		   
		    tbody.appendChild(row);
		  }
	</script>

</head>

<body>

<form class="form-signin">
  <h2 class="form-signin-heading">Nuevo Contacto</h2>
  <input type="text" class="input-block-level" placeholder="Nombre" id="name">
  <input type="text" class="input-block-level" placeholder="Teléfono" id="phone">
  <input type="text" class="input-block-level" placeholder="Dirección" id="address">
  <input type="button" class="btn btn-large btn-primary" onclick="addContact()" value="Crear">
</form>

<table id="tableid">
	<thead>
		<tr>
			<th>Nombre</th>
			<th>Teléfono</th>
			<th>Dirección</th>
		</tr>
	</thead>
	<tbody>
		
	</tbody>
</table>
<script>
loadContacts();
</script>
</body>
</html>