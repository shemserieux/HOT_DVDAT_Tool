from django.shortcuts import render, redirect
import json
from django.core import serializers
import logging
from django.contrib.auth import authenticate, login, logout, get_user_model
from django.contrib.auth.decorators import login_required
from django.http import HttpResponseRedirect, HttpResponse
from django.forms.models import model_to_dict
from django.views.decorators.csrf import csrf_exempt #this is a temporary solution so I can move on
from .models import HOTUser, Building, Attribute, BuildingDmgVun
from django.contrib.gis.geos import Polygon
from . import damage_vunerability as dv
from datetime import date, datetime
from decimal import Decimal
from django.conf import settings
from .mybackend import MyBackEnd
# Get an instance of a logger
logging.basicConfig(filename='{0}.log'.format(__name__),level=logging.DEBUG, format='%(asctime)s - %(name)s - %(levelname)s - %(message)s - %(funcName)s - line %(lineno)d')
log = logging.getLogger(__name__)

# Create your views here.
"""Custom Buildings  view."""

from django.views.generic.base import TemplateView

class MyEncoder(json.JSONEncoder):
	def default(self, obj):
		if isinstance(obj, date):
			return obj.strftime("%Y-%m-%d")
		if isinstance(obj, datetime):
			return obj.strftime("%Y-%m-%d")
		if isinstance(obj, Decimal):
			return str(obj)
		if isinstance(obj, Polygon):
			return list(map(lambda x: [x[1], x[0]], json.loads(obj.geojson)["coordinates"][0]))
		return json.JSONEncoder.default(self, obj)

@login_required
def index(request):
	object = {'attr_types': dv.getAllAttributeTypes(), 'dmg_Vuns': dv.getAllDamageVunerabilities()}
	return render(request, 'map.html', object)


def user_login(request):
	user = request.user
	next = request.GET.get('next')
	if request.POST:
		redirecturl = "/customBuildings/"
		#data = json.loads(request.body.decode('UTF-8'))
		#username = data['username']
		#password = data['password']
		username = request.POST.get('username')
		password = request.POST.get('password')
		if next:
			redirecturl = next
		user = authenticate(username=username, password=password)
		if user is not None:
			login(request, user)
			return redirect(redirecturl)
		  
		else:
			message = {'error_message': 'User name or password is incorrect. Please enter valid username and password.'}
			return render(request, 'login.html', message)
			
	object = {}
	if request.GET:				
		if next:
			object = {'next': next}
			
	return render(request, 'login.html', object)

def user_logout(request):
	logout(request)
	return redirect("/customBuildings/login")
	
def test(request):
	das = list(map(lambda x: model_to_dict(x), dv.getAllDamageVunerabilities()))
	jsonData = json.dumps(das, cls=MyEncoder)
	return HttpResponse(jsonData, content_type='application/json')

@login_required
@csrf_exempt #this is a temporary solution so I can move. #TODO: Replace with correct token solution.
def saveBuilding(request):
	data = json.loads(request.body.decode('UTF-8'))
	building = {}
	hotUser = HOTUser.objects.get(id= request.user.id)
	building['added_by'] = hotUser
	if("id" in data and data['id']):
		building['id'] = int(data['id'])
	
	building['osm_id'] = data['osm_id']
	building['name'] = data['building_name']
	building['amenity'] = data['amenity']
	
	buildingLevels = data['building_levels']
	building['building_levels'] = buildingLevels if buildingLevels else 1 
	buildingAttributes = data['building_attributes']
	building['building_attributes'] = buildingAttributes if buildingAttributes else []
	
	outlineArray = json.loads(data['building_outline'])
	if(type(outlineArray) is list):
		building['building_outline'] = Polygon(tuple(list(map(lambda x:tuple(x), outlineArray))))
		savedBuilding = dv.saveDamageOrVunerability(building)
		jsSavedBuilding = json.dumps(savedBuilding, cls=MyEncoder)
		return HttpResponse(jsSavedBuilding, content_type='application/json')
	else:
		errorMessage = {"error": {"message": "outline is not a list. It is a {0}".format(type(outlineArray))}}
		return HttpResponse(errorMessage, status = '500', content_type='application/json')
	return HttpResponse({"error": {"message": "error occurred"}}, status = '500', content_type='application/json')
	
@login_required
def retrieveBuilding(request):
	osm_id = request.GET.get('osm_id', 0)
	buildingToSave = Building.objects.get_or_create(osm_id=osm_id)

@login_required
def retrieveAllBuildings(request):
	allBuildingsList =  dv.getAllBuildings()
	jsAllBuildingsList = json.dumps(allBuildingsList, cls=MyEncoder)
	return HttpResponse(jsAllBuildingsList, content_type='application/json')
	

@login_required
def filterBuildings(request):
	#filterObj = json.loads(request.body.decode('UTF-8'))
	filterObj = {}
	filterObj["date_from"] = request.GET.get('date_from')
	filterObj["date_to"] = request.GET.get('date_to')
	filterObj["dmg_type"] = request.GET.get('dmg_type')
	filterObj["dmg_or_vun"] = request.GET.get('dmg_or_vun')
	kwargs = {}
	if filterObj["date_from"]:
		kwargs.update({"date__gte": datetime.strptime(filterObj['date_from'], "%Y-%m-%d")})
		
	if filterObj["date_to"]:
		kwargs.update({"date__lte": datetime.strptime(filterObj['date_to'], "%Y-%m-%d")})
		
	if filterObj["dmg_type"]:
		kwargs.update({"damaged_property__attribute_type__name": filterObj['dmg_type']})
		
	if filterObj["dmg_or_vun"]:
		kwargs.update({"damaged_property__name": filterObj['dmg_or_vun']})

	filteredBuildingsList = dv.getFilteredBuildings(kwargs)
	jsFilteredBuildingsList = json.dumps(filteredBuildingsList, cls=MyEncoder)
	return HttpResponse(jsFilteredBuildingsList, content_type='application/json')

@login_required
def retrieveAllBuildingsInArea(request):
	pass
#class CustomBuildingsMapView(TemplateView):
#	"""Custom Buildings map view."""
#
#	template_name = "map.html"