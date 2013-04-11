
root = exports ? this

web_data = []
manual_data = []

all_data = []

# _.templateSettings.variable = "ee"

set_total = (people, div_id) ->
  total = 0
  _.each people, (d) ->
    total += d.total
  $(div_id).html(total)

set_people_table = (people, table_id) ->
  html = "<thead><tr><th>Name</th><th>Count</th></tr></thead>\n<tbody>"
  _.each people, (d) ->
    html += "<tr><td>#{d.name}</td><td>#{d.total}</td></tr>"

  html += "</tbody>"

  $(table_id).html(html)


set_music = (people, table_id) ->
  music_lovers = _.filter people, (d) ->
    d.music.length > 0
  html = "<thead><tr><th>Name</th><th>Song</th></tr></thead>\n<tbody>"
  _.each music_lovers, (d) ->
    html += "<tr><td>#{d.name}</td><td>#{d.music}</td></tr>"

  html += "</tbody>"

  $(table_id).html(html)



display = (mdata, tabletop) ->
  manual_data = mdata
  _.each manual_data, (d) ->
    d.name = d['name']
    d.total = parseInt(d['total'])
    d.attending = (d['attending'] == 'yes')
    d.music = d['music']

  _.each web_data, (d) ->
    d.name = d['namesofattendees']
    d.total = parseInt(d['totalnumberattending'])
    d.attending = (d['willyoubeattending'] == "Can't wait!")
    d.music = d['weretakingrequests']


  data = web_data.concat(manual_data)
  all_data = data

  people_coming = _.filter data, (d) -> d.attending == true
  people_declining = _.filter data, (d) -> d.attending == false

  set_total(people_coming, '#total_count')
  set_people_table(people_coming, '#who_table')

  set_music(data, '#music_table')

  set_total(people_declining, '#decline_count')
  set_people_table(people_declining, '#decline_table')


# https://docs.google.com/spreadsheet/pub?key=0Aphqt-W5Px29dDdxZkxJaDd0dGRGaE02YmNvTDJPYVE&single=true&gid=0&output=html
#
# https://docs.google.com/spreadsheet/pub?key=0Aphqt-W5Px29dDN3NUdKSS1mS0pEQ2JDSkVqN0tlZ3c&single=true&gid=0&output=html

init_manual = (data, tabletop) ->
  web_data = data
  Tabletop.init( {key: '0Aphqt-W5Px29dDN3NUdKSS1mS0pEQ2JDSkVqN0tlZ3c', callback: display, simpleSheet: true})


init = () ->
  Tabletop.init( {key: '0Aphqt-W5Px29dDdxZkxJaDd0dGRGaE02YmNvTDJPYVE', callback: init_manual, simpleSheet: true})

$ ->
  init()

