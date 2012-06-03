// AJAX call to update weather data.
function weatherUpdate() {
$.ajax({
        type: "GET",
        url: "/weather",
        success: function(data) {
        	obj = jQuery.parseJSON(data); 
		//console.log(obj);
		for (var main in obj)
			if (obj.hasOwnProperty(main))
				for (var sub in obj[main])
					if (obj[main].hasOwnProperty(sub))
					{
						//console.log(""+main+"_"+sub+" = "+ obj[main][sub]);
						if (sub.indexOf("icon") == -1) // Icons are a special case...
							document.getElementById(""+main+"_"+sub).innerHTML = obj[main][sub];
						else
							document.getElementById(""+main+"_"+sub).className = "icon " + obj[main][sub];
					}
      		}	
   	});
  }

