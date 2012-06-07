function updatePrediction(route,stop, callback) {
  var output="<table><tbody>";
  var numroutes = 0;
  $.ajax({
    type: "GET",
    url: "http://webservices.nextbus.com/service/publicXMLFeed?command=predictions&a=ttc&r="+route+"&s="+stop,        	
    dataType: "xml",
    success: function(xml) {
      var schedule = {};
      $(xml).find('direction').each(function(){
        var thisDirectionSchedule = schedule[$(this).attr('title')] = new Array();
        //console.log($(this).attr("title"));			
        $(this).find('prediction').each(function(){
          // Pushing the epoch time of this bus to the list of buses comming in the current direction
          thisDirectionSchedule.push( new Date( parseInt( $(this).attr('epochTime') ) ) );
        });
      });
      callback(schedule);
    }
  });
}

