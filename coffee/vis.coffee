
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
 bunts = d3.selectAll(".bunting").append("svg")
   .attr("width", 940)
   .attr("height", 40)
 
 bunts.append()


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
 L.tileLayer("http://{s}.tile.cloudmade.com/#{KEY}/997/256/{z}/{x}/{y}.png", options).addTo(map)
 
 marker = L.marker(overbrook_location).addTo(map)
 marker.bindPopup('<b>Overbrook House</b><br/>Bourne, MA')
 map.scrollWheelZoom.disable()

$ ->

 fancyBorder()
 fancyHeader()
 setupMap()
 
