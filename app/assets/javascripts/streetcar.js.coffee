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
        if (date < new Date)
          return 'due'
        date.relative (val,unit) -> "#{val}&nbsp;#{Date.getLocale().units[unit][0..2]}"
      this.$el.html(_.map(this.collection.pluck('date'), human_readable).join("<span class='comma'>, </span>"))

  monitored_stops = [
    {id: 'dufferinnorthbound', route: 29, stop: 4031}
    {id: 'dufferinsouthbound', route: 29, stop: 14799}
    {id: 'queeneastbound', route: 501, stop: 9255}
    {id: 'queenwestbound', route: 501, stop: 14701}
    {id: 'kingeastbound', route: 504, stop: 4568}
    {id: 'kingwestbound', route: 504, stop: 4341}
  ]

  multistop = new MultiStopPredictions monitored_stops
  multistop.poll(30000)

  for stop in monitored_stops
    new StopPredictionView
      collection: multistop.get(stop.id)
      el: $("##{stop.id}")

  # views for home page
  new StopPredictionView
    collection: multistop.get 'dufferinnorthbound'
    el: $("#timen")
  new StopPredictionView
    collection: multistop.get 'dufferinsouthbound'
    el: $("#times")
  new StopPredictionView
    collection: multistop.get 'queenwestbound'
    el: $("#timeqw")
  new StopPredictionView
    collection: multistop.get 'queeneastbound'
    el: $("#timeqe")
  new StopPredictionView
    collection: multistop.get 'kingwestbound'
    el: $("#timekw")
  new StopPredictionView
    collection: multistop.get 'kingeastbound'
    el: $("#timeke")
