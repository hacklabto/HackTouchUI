// AJAX call to update the news
function updateNews() {
$.ajax({
        type: "GET",
        url: "/news",
        success: function(data) {
        	obj = jQuery.parseJSON(data); 
		//console.log(obj);
  	for (var id in obj)
			if (obj.hasOwnProperty(id))
				for (var type in obj[id])
					if (obj[id].hasOwnProperty(type))
					{
						//console.log("news-"+type+"-"+id+" = "+ obj[id][type]);
						try {
					    document.getElementById("news-"+type+"-"+id).innerHTML = obj[id][type];
					  }catch(err) {
					  //  console.log(err)
					  }
					  if (id == 0)
					    try {
					      document.getElementById("news-"+type+"-home").innerHTML = obj[id][type];
					    }catch(err) {
					    //  console.log(err)
					    }
					}


      }	
   	});
  }

