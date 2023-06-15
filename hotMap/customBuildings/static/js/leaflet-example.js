/*
 the script mus be loaded after the map div is defined.
 otherwise this will not work (we would need a listener to
 wait for the DOM to be fully loaded).

 Just put the script tag below the map div.

 The source code below is the example from the leaflet start page.
 */
//13.84937,-60.90835
//import { districtData } from './saint_lucia_districts_geojson_formatted.js'
var map = L.map('map').setView([13.84937,-60.90835], 16);
var markerCount = 0;
var markerList = [];

L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
		attribution: '&copy; <a href="https://openstreetmap.org/copyright">OpenStreetMap</a> contributors'
}).addTo(map);

L.marker([13.8493,-60.9083]).addTo(map)
		.bindPopup('This is Shems Marker.<br> Easily customizable.')
		.openPopup();

var circle = L.circle([13.8573,-60.9283], {
    color: 'red',
    fillColor: '#f03',
    fillOpacity: 0.5,
    radius: 500
}).addTo(map);

var polygon = L.polygon([
    [13.8513,-60.8983],
    [13.8523,-60.8783],
    [13.8593,-60.8553],
	[13.8513,-60.8983]
]).addTo(map);

circle.bindPopup("I am a circle.");
polygon.bindPopup("I am a polygon.");

var popup = L.popup()
    .setLatLng([13.8623,-60.9083])
    .setContent("I am a standalone popup.")
    .openOn(map);
	

function createMarkerAtLocation(latlng){
	markerCount++;
	var polygonMarker = L.marker([latlng.lat,latlng.lng]).addTo(map)
		.bindPopup('This is marker in position ' + markerCount)
		.openPopup();
	markerList.push(polygonMarker);
}

function setMarkerAtClick(e) {
	createMarkerAtLocation(e.latlng);
	//alert("You clicked the map at Latitude: " + e.latlng.lat);//latlng.substring(latlng.indexOf("(") + 1));
}

function createPolygonFromMarker(){
	demarkedPolygon = []
	$.each(markerList, function(index, marker){
		latlng = marker.getLatLng()
		demarkedPolygon.push([latlng.lat, latlng.lng])
	});
	//console.log(demarkedPolygon)
	selectedArea = L.polygon(demarkedPolygon, {color: "#ff88dc"}).addTo(map);
	$.each(markerList, function(index, marker){
		map.removeLayer(marker);
	});
}

$("#createPolygon").click(createPolygonFromMarker);
map.on('click', setMarkerAtClick);

$(document).ready(function(){ 
//-------------test add geojson layer
	console.log(districtData.geoJson());
	L.geoJSON(districtData.geoJson()).addTo(map);
});