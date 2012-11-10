
root = exports ? this

fancyBorder = () ->
 border = d3.selectAll(".border").append("svg")
   .attr("width", 940)
   .attr("height", 20)
 border.append("line")
   .attr("x1", 10)
   .attr("x2", 930)
   .attr("y1", 10)
   .attr("y2", 10)
   .style("stroke-width", 4)
   #.style("stroke", "#FFD340")
   .style("stroke", "#ddd")
   .style("stroke-linecap", "round")
   .style("stroke-dasharray", "1,12")

bunting = () ->
 width = 940
 height = 160
 bunt = null
 force = null

 gravity = (alpha) ->
   cx = width / 2
   cy = height - 20 

   (d) ->
     #d.x += (cx - d.x) * alpha
     d.y += (cy - d.y) * alpha

 tick = (e) ->
   dampenedAlpha = e.alpha * 0.1
   bunts.selectAll(".bunt").each(gravity(dampenedAlpha))
     .attr("transform", (d) -> "translate(#{d.x},#{d.y})")

 force = d3.layout.force()
   .gravity(0)
   .linkDistance(0)
   .linkStrength(1.0)
   .charge(0)
   .size([width, height])
   .on("tick", tick)

 bunts = d3.selectAll(".bunting").append("svg")
   .attr("width", width)
   .attr("height", height)

 data = []
 [0..22].forEach (i) ->
    data.push({num:i, x:10+40*i,y:0})

 edges = []
 [0..21].forEach (i) ->
   edges.push({source:i, target:i+1})

 data[0].fixed = true
 data[0].y = -25 
 data[22].fixed = true
 data[22].y = -25 
 data[11].fixed = true
 data[11].y = -25 

 force.nodes(data).links(edges).start()
 
 bunt = bunts.selectAll(".bunt").data(data)
 bunt.enter()
   .append("g")
   .attr("class", "bunt")
   .attr("transform", (d,i) -> "translate(#{10 + 40 * i},#{20})")
   .call(force.drag)

 bunt.append("path")
   .attr('d', (d) -> 'M 0 0 l 20 0 l -10 25 z')
   .attr("fill", "#FFD340")

 #bunt.append("circle").attr("fill", "#FFD340").attr('r', 4)



fancyHeader = () ->
 header = d3.selectAll(".fancy-header")
   .datum((d) -> d3.select(this).attr("data-header"))
   .call((d) -> console.log(this))
   .append("svg")
   .attr("width", 940)
   .attr("height", 40)

 header.append("line")
   .attr("x1", 10)
   .attr("x2", 930)
   .attr("y1", 10)
   .attr("y2", 10)
   .style("stroke-width", 4)
   .style("stroke", "#FFD340")

 header.append("line")
   .attr("x1", 10)
   .attr("x2", 930)
   .attr("y1", 20)
   .attr("y2", 20)
   .style("stroke-width", 4)
   .style("stroke", "#FFD340")

 header.append("rect")
   .style("fill", "white")
   .attr("x", (930 / 2) - 100)
   .attr("y", 0)
   .attr("width", 200)
   .attr("height", 40)

 header.append('text')
   .style("fill", '#555')
   .text((d) -> d)
   .attr("x", 930 / 2)
   .attr("y", 25)
   .style("text-anchor", "middle")
   .classed("script", true)

setupMap = () ->
 options = {
   attribution: "",
   maxZoom: 18
 }

 KEY = "a901e8e6d6c04353895e2fede2d4a7c6"
 overbrook_location = [41.768037, -70.6021995]
 map = L.map('map').setView(overbrook_location, 16)
 L.tileLayer("http://{s}.tile.cloudmade.com/#{KEY}/9329/256/{z}/{x}/{y}.png", options).addTo(map)
 
 marker = L.marker(overbrook_location).addTo(map)
 marker.bindPopup('<b>Overbrook House</b><br/>Bourne, MA')
 map.scrollWheelZoom.disable()

$ ->

 fancyBorder()
 fancyHeader()
 bunting()
 setupMap()
 
