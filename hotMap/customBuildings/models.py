from django.contrib.gis.db import models
from django.contrib.auth.models import AbstractUser

# Create your models here.
class Organization(models.Model):
	name = models.CharField(max_length=256, blank=False, null=False, unique=True)
	short_name = models.CharField(max_length=30, blank=False, null=False, unique=True)
	symbol = models.CharField(max_length=30, blank=True, null=True)
	def __str__(self):
		return self.name

class HOTUser(AbstractUser):
	is_admin = models.IntegerField(blank=True, null=True)
	role = models.CharField(max_length=256, blank=True, null=True)
	organization = models.ForeignKey(Organization, on_delete=models.CASCADE, related_name='organization_users', blank=True, null=True)
	def set_is_admin(self, is_admin):
		self.is_admin = is_admin
	
	def set_role(self, role):
		self.last_update = datetime.now()
		self.role = role
	
	def __str__(self):
		return self.first_name  + ' ' + self.last_name
		
class AttributeType(models.Model):
	name = models.CharField(max_length=20, blank=False, null=False)
	def __str__(self):
		return self.name

class Attribute(models.Model):
	name = models.CharField(max_length=20, blank=False, null=False)
	attribute_type = models.ForeignKey(AttributeType, related_name = 'attributes_with_type', on_delete=models.CASCADE)
	color_code = models.CharField(max_length=10, blank=True, null=True)
	symbol = models.CharField(max_length=100, blank=True, null=True)
	metric = models.CharField(max_length=50, blank=False, null=False)
	default_metric_value = models.DecimalField(max_digits=10, decimal_places=2)
	min_value = models.DecimalField(max_digits=10, decimal_places=2)
	max_value = models.DecimalField(max_digits=10, decimal_places=2)
	cost_per_unit = models.DecimalField(max_digits=10, decimal_places=2)
	use_area = models.BooleanField(editable=True, default=False)
	cost_per_area = models.DecimalField(max_digits=10, decimal_places=2)
	def __str__(self):
		return '{0}({1})'.format(self.name, self.attribute_type.name)
	
class Building(models.Model):
	osm_id = models.BigIntegerField(unique=True)
	name = models.CharField(max_length=100, blank=True, null=True)
	amenity = models.CharField(max_length=50, blank=True, null=True)
	building_levels = models.IntegerField(default=1)
	building_outline = models.PolygonField()
	def __str__(self):
		return str(self.osm_id)

class BuildingDmgVun(models.Model):
	date = models.DateField(null=True)
	damaged_building = models.ForeignKey(Building, related_name = 'building_attributes', on_delete=models.CASCADE)
	damaged_property = models.ForeignKey(Attribute, related_name = 'Buildings_with_attributes', on_delete=models.CASCADE)
	metric_value = models.DecimalField(max_digits=10, decimal_places=2)
	added_by = models.ForeignKey(HOTUser, related_name = 'added_damageVunerabilities', on_delete=models.CASCADE, blank=True, null=True)
	added_date = models.DateField(auto_now_add=True)
	def __str__(self):
		return "{0} with {1} {2}, {3}".format(self.damaged_building.osm_id, self.metric_value, self.damaged_property.name, self.damaged_property.attribute_type.name)

class District(models.Model):
	name =  models.CharField(max_length=100, blank=True, null=True)
	boundary = models.PolygonField()
	bounding_box = models.PolygonField()
	