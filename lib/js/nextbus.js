function updatePrediction(route,stop,element) {
var times= new Array();
var output="<table><tbody>";
var numroutes = 0;
$.ajax({
        type: "GET",
        url: "http://webservices.nextbus.com/service/publicXMLFeed?command=predictions&a=ttc&r="+route+"&s="+stop,        	
        dataType: "xml",
        success: function(xml) {
        	$(xml).find('direction').each(function(){
			times=new Array();
			console.log($(this).attr("title"));			
			$(this).find('prediction').each(function(){
				var id = $(this).attr('minutes');
				if (id > 1)
					times.push(id);
			});
			times=times.slice(0,3);
			console.log(times.toString());
			if (times.length > 0){
				numroutes++;
				output+="<tr><td>"+$(this).attr("title").split("towards")[1].split("via")[0]+":</td>";
				output+="<td>"+times.toString()+"</td>";
				output+="</tr>";
			}
		});
		output += "</tbody></table>";
		if (numroutes == 1) // Skip table crap for single destination routes
			document.getElementById(element).innerHTML=times.slice(0,3).toString();
		else if (output != "<table><tbody></tbody></table>")
			document.getElementById(element).innerHTML=output;
		else
			document.getElementById(element).innerHTML="No Predictions";
	}	
  });
}

