$ ->

  class Prediction extends Backbone.Model
    idAttribute: 'vehicle'

  class StopPredictions extends Backbone.Collection
    model: Prediction,
    initialize: (options) ->
      this.route = options.route
      this.stop = options.stop
      this.id = options.id
    set: (attrs, options) -> # hack to get collection -> collection updates working
      this.update(attrs.response, options)
      this.sort()
    _validate: (attrs, options) -> # just so we can use collections of collections
      true
    parse: (response) ->
      _.map $(response).find('prediction'), (element) ->
        $e = $(element)
        {
          date: new Date parseInt $e.attr 'epochTime'
          seconds: $e.attr 'seconds'
          minutes: $e.attr 'minutes'
          branch: $e.attr 'branch'
          vehicle: $e.attr 'vehicle'
        }
    comparator: (prediction) ->
      prediction.get 'date'

  class MultiStopPredictions extends Backbone.Collection
    model: StopPredictions
    url: "http://webservices.nextbus.com/service/publicXMLFeed",
    initialize: (models) ->
      this.monitored_stops = models
    poll: (interval) ->
      if (this.interval)
        window.clearInterval this.interval
      this.fetch()
      this.interval = window.setInterval _.bind(this.fetch, this), interval
    fetch: ->
      multistop_naming = (stop) ->
        stop.route + '|' + stop.stop
      options =
        dataType: 'xml'
        update: true
        remove: true
        add: true
        traditional: true # repeat multiple "stops" params w/o square brackets
        data:
          command: 'predictionsForMultiStops'
          a: 'ttc'
          stops: _.map(this.monitored_stops, multistop_naming)
      super options
    parse: (response) ->
      _.map this.monitored_stops, (stop) ->
        stop.response = $(response).find("predictions[routeTag=#{stop.route}][stopTag=#{stop.stop}]")
        stop

  class StopPredictionView extends Backbone.View
    initialize: ->
      _.bindAll(this, 'render')
      this.collection.on 'add', this.render
      this.collection.on 'remove', this.render
      this.collection.on 'change', this.render
      this.collection.on 'reset', this.render
      this.interval = window.setInterval this.render, 1000
    render: ->
      human_readable = (date) ->
        date.relative (val,unit) -> "#{val}&nbsp;#{Date.getLocale().units[unit][0..2]}"
      this.$el.html(_.map(this.collection.pluck('date'), human_readable).join("<span class='comma'>, </span>"))

  monitored_stops = [
    {id: 'spadinanorth', route: 510, stop: 6577}
    {id: 'spadinasouth', route: 510, stop: 3159}
    {id: 'collegeeast', route: 506, stop: 1010}
    {id: 'collegewest', route: 506, stop: 9193}
    {id: 'dundaseast', route: 505, stop: 6046}
    {id: 'dundaswest', route: 505, stop: 1212}
  ]

  multistop = new MultiStopPredictions monitored_stops
  multistop.poll(30000)

  for stop in monitored_stops
    new StopPredictionView
      collection: multistop.get(stop.id)
      el: $("##{stop.id}")

  # views for home page
  new StopPredictionView
    collection: multistop.get 'spadinanorth'
    el: $("#timen")
  new StopPredictionView
    collection: multistop.get 'spadinasouth'
    el: $("#times")
