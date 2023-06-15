"""Custom Buildings urls."""

from django.urls import path, include
from django.conf.urls import url

from . import views
#from hotMap.customBuildings.views import CustomBuildingsMapView

#app_name = "buildings"

urlpatterns = [
	#path("map/", CustomBuildingsMapView.as_view()),
	url(r'^$', views.index, name='index'),
	url(r'^login', views.user_login, name='user_login'),
	url(r'^logout', views.user_logout, name='user_logout'),
	url(r'test', views.test, name='test'),
	url(r'building/save', views.saveBuilding, name='saveBuilding'),
	url(r'building/:id', views.retrieveBuilding, name='retrieveBuilding'),
	url(r'building/all', views.retrieveAllBuildings, name='retrieveAllBuildings'),
	url(r'filter', views.filterBuildings, name='filterBuildings'),
	url(r'retrieveAllBuildingsInArea', views.retrieveAllBuildingsInArea, name='retrieveAllBuildingsInArea'),
]