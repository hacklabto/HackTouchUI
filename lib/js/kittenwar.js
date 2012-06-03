
// Accepts a url and a callback function to run.
function getKitten() {

var site="http://kittenwar.com"

	// Take the provided url, and add it to a YQL query. Make sure you encode it!
	var yql = 'http://query.yahooapis.com/v1/public/yql?q=' + encodeURIComponent('select * from html where url="' + site + '"') + '&format=xml';
	
	// Request that YSQL string, and run a callback function.
$.ajax({
        type: "GET",
        url: yql,        	
        dataType: "xml",
        success: function(xml) {
 
  var kitten0="http://kittenwar.com";
  var kitten1="http://kittenwar.com";
  var kitten0name;
  var kitten1name;
  
 $(xml).find("a").each(function(){
    	    if($(this).attr('href')=="JavaScript\:%20kitten\(\'0\'\)\;") {
    	    	$(this).find('img').each(function(){
    	    		kitten0+=$(this).attr('src');
    	    		kitten0name=$(this).attr('title');
    	    	});
    	    }
	    if($(this).attr('href')=="JavaScript\:%20kitten\(\'1\'\)\;") {
    	    	$(this).find('img').each(function(){
    	    		kitten1+=$(this).attr('src');
    	    		kitten1name=$(this).attr('title');
    	    	});
    	    }
    });
  kitten0="url\(\'" + kitten0 + "\'\)";
  kitten1="url\(\'" + kitten1 + "\'\)";
  
  document.getElementById("kitten0").style.backgroundImage=kitten0;
  document.getElementById("kitten1").style.backgroundImage=kitten1;
  document.getElementById("kitten0name").innerHTML=kitten0name;
  document.getElementById("kitten1name").innerHTML=kitten1name;
      		}	
   	});
  }

