import pyodbc
import logging, logging.handlers
from django.conf import settings
from datetime import datetime

from .models import HOTUser, Building, BuildingDmgVun, Attribute, AttributeType
from django.contrib.gis.geos import Polygon

logging.basicConfig(filename='damage_vunerability.log',level=logging.DEBUG, format = '%(asctime)s-%(name)s-%(levelname)s:%(message)s')
log = logging.getLogger('damage_vunerability')
#cnxn = pyodbc.connect(settings.VUN_DAM_DATABASE)


def saveDamageOrVunerability(building):
	if "id" in building.keys() and building["id"] > 0:
		sbuilding = Building.objects.get(id = building["id"])
		sbuilding.osm_id = building["osm_id"]
		sbuilding.name = building["name"]
		sbuilding.amenity = building["amenity"]
		sbuilding.building_levels = building["building_levels"]
		sbuilding.building_outline = building["building_outline"]
		
	else:#if saved building does not exits
		sbuilding = Building.objects.create(osm_id = building["osm_id"], name = building["name"], amenity=building["amenity"], building_levels = building["building_levels"], building_outline = building["building_outline"])

	#for each attribute create and save to building_attributes
	exiting_bldgDmgs = sbuilding.building_attributes.all()
	for bldgDmg in building["building_attributes"]:
		kwargs = {}
		
		sProperty = {}
		if "attribute_name" in bldgDmg:
			sProperty = Attribute.objects.get(name= bldgDmg["attribute_name"])
			kwargs.update({"damaged_property": sProperty})
			
		sValue = bldgDmg["metric_value"]
		kwargs.update({"metric_value": sValue})
		
		sDate = {}
		if bldgDmg["date"]:
			sDate = datetime.strptime(bldgDmg["date"], "%Y-%m-%d")
			kwargs.update({"date": sDate})
		
		kwargs.update({"damaged_building": sbuilding})
		kwargs.update({"added_by": building["added_by"]})

		if "id" in bldgDmg: #if the Building Damage/Vun already exists
			try: #then save new values to the existing object
				newBldgDmg = exiting_bldgDmgs.get(id=bldgDmg["id"])
				newBldgDmg.metric_value = sValue
				newBldgDmg.damaged_property = sProperty
				if bldgDmg["date"]:
					newBldgDmg.date = sDate
				else:
					newBldgDmg.date = None
					
			except BuildingDmgVun.DoesNotExist as dnE:
				newBldgDmg = BuildingDmgVun.objects.create(**kwargs)
		else:
			newBldgDmg = BuildingDmgVun.objects.create(**kwargs)

		newBldgDmg.save()
		#TODO: add removing of deleted buildingDamages
	sbuilding.save()
		
	return convertBuildingToDict(sbuilding)

def convertBuildingToDict(sbuilding):
	buildingDict = {}
	buildingDict['id'] = sbuilding.id
	buildingDict['osm_id'] = sbuilding.osm_id
	buildingDict['name'] = sbuilding.name
	buildingDict['amenity'] = sbuilding.amenity
	buildingDict['building_levels'] = sbuilding.building_levels
	buildingDict['building_outline'] = sbuilding.building_outline
	buildingDict['building_attributes'] = list(map(returnDamageAsDict, sbuilding.building_attributes.all()))
	return buildingDict
	
def returnDamageAsDict(building_damage):
	buildingdmgDict = {}
	buildingdmgDict["id"] = building_damage.id
	buildingdmgDict["date"] = building_damage.date
	buildingdmgDict["metric_value"] = building_damage.metric_value
	buildingdmgDict["attribute_name"] = building_damage.damaged_property.name
	buildingdmgDict["attribute_type"] = building_damage.damaged_property.attribute_type.name
	buildingdmgDict["color_code"] = building_damage.damaged_property.color_code
	buildingdmgDict["symbol"] = building_damage.damaged_property.symbol
	buildingdmgDict["cost_per_unit"] = building_damage.damaged_property.cost_per_unit
	buildingdmgDict["use_area"] = building_damage.damaged_property.cost_per_unit
	buildingdmgDict["cost_per_area"] = building_damage.damaged_property.cost_per_unit
	return buildingdmgDict
	
def getAllBuildings():
	allBuildings = Building.objects.all()
	return list(map(lambda building: convertBuildingToDict(building), allBuildings))
	
def getFilteredBuildings(kwargs):
	filteredBuildings = map(lambda x: x.damaged_building, BuildingDmgVun.objects.filter(**kwargs))
	return list(map(lambda building: convertBuildingToDict(building), filteredBuildings))

def retrieveDamageOrVunerability():
	pass
	#get Damage or Vunerability

def getAllDamageVunerabilities(by_type=""):
	if by_type == "":
		return Attribute.objects.all()
	else:
		return Attribute.objects.filter(attribute_type__name = by_type)

def getAllAttributeTypes():
	return AttributeType.objects.all()
