import datetime
from django.contrib import admin
from .models import HOTUser, Organization, Building, BuildingDmgVun, Attribute, AttributeType
import logging, logging.handlers
# Get an instance of a logger
logging.basicConfig(filename='{0}.log'.format(__name__),level=logging.DEBUG, format='%(asctime)s - %(name)s - %(levelname)s - %(message)s - %(funcName)s - line %(lineno)d')
log = logging.getLogger(__name__)
# Register your models here.


@admin.register(HOTUser)
class UserAdmin(admin.ModelAdmin):
	fields = ('username', ('first_name', 'last_name'), 'email', 'organization')
	list_display = ['username', 'first_name', 'last_name', 'organization']
	list_display_links = ['username', 'first_name', 'last_name']
	list_filter = ['organization']

@admin.register(Organization)
class OrganizationAdmin(admin.ModelAdmin):
	fields = ('name', 'short_name', 'symbol')
	list_display = ['name', 'short_name']
	list_display_links = ['name', 'short_name']

@admin.register(Building)
class BuildingAdmin(admin.ModelAdmin):
	readonly_fields = ['building_outline']
	fields = ('osm_id', ('name', 'amenity'), 'building_levels', 'building_outline')
	list_display = ['osm_id', 'name', 'amenity', 'building_outline']
	list_display_links = ['osm_id']
	list_filter = ['amenity', 'building_attributes__damaged_property__name', 'building_attributes__damaged_property__attribute_type__name']

@admin.register(BuildingDmgVun)
class BuildingDamageAdmin(admin.ModelAdmin):
	fields = ('date', 'metric_value', 'damaged_building', 'damaged_property')
	list_display = ['date', 'metric_value', 'damaged_building', 'damaged_property']
	list_display_links = ['date', 'metric_value']
	list_filter = ['damaged_property__name', 'damaged_property__attribute_type__name']

@admin.register(Attribute)
class DamageOrVunAdmin(admin.ModelAdmin):
	fields = ('name', 'attribute_type', 'color_code', 'symbol', 'metric', 'default_metric_value', 'min_value', 'max_value', 'cost_per_unit', 'use_area', 'cost_per_area')
	list_display = ['name', 'attribute_type']
	list_display_links = ['name']

@admin.register(AttributeType)
class DamageOrVunTypeAdmin(admin.ModelAdmin):
	fields = ['name']
	list_display = ['name']
	list_display_links = ['name']