@ECHO OFF

SET djangoSitePath=C:\Projects\hotMap
SET pythonExe=C:\Python38\python.exe
SET iisAppName=hot_map
SET handlerName=hot_map
SET port=80

ECHO adding fastCgi Hook
%windir%\system32\inetsrv\appcmd.exe set config -section:system.webServer/fastCgi /+"[fullPath='%pythonExe%',arguments='%djangoSitePath%\wfastcgi.py',maxInstances='4',idleTimeout='1800',activityTimeout='30',requestTimeout='90',instanceMaxRequests='100000',protocol='NamedPipe',flushNamedPipe='False']" /commit:apphost

ECHO adding environment Variables ...
%windir%\system32\inetsrv\appcmd.exe set config -section:system.webServer/fastCgi /+"[fullPath='%pythonExe%',arguments='%djangoSitePath%\wfastcgi.py',maxInstances='4',idleTimeout='1800',activityTimeout='30',requestTimeout='90',instanceMaxRequests='100000',protocol='NamedPipe',flushNamedPipe='False'].environmentVariables.[name='DJANGO_SETTINGS_MODULE',value='hotMap.settings']" /commit:apphost
%windir%\system32\inetsrv\appcmd.exe set config -section:system.webServer/fastCgi /+"[fullPath='%pythonExe%',arguments='%djangoSitePath%\wfastcgi.py',maxInstances='4',idleTimeout='1800',activityTimeout='30',requestTimeout='90',instanceMaxRequests='100000',protocol='NamedPipe',flushNamedPipe='False'].environmentVariables.[name='PYTHONPATH',value='%djangoSitePath%']" /commit:apphost
%windir%\system32\inetsrv\appcmd.exe set config -section:system.webServer/fastCgi /+"[fullPath='%pythonExe%',arguments='%djangoSitePath%\wfastcgi.py',maxInstances='4',idleTimeout='1800',activityTimeout='30',requestTimeout='90',instanceMaxRequests='100000',protocol='NamedPipe',flushNamedPipe='False'].environmentVariables.[name='WSGI_HANDLER',value='hotMap.wsgi.application']" /commit:apphost


ECHO Create the site application pool.
%windir%\system32\inetsrv\appcmd.exe add apppool /name:%iisAppName%
ECHO Create the website.
%windir%\system32\inetsrv\appcmd.exe add site /name:%iisAppName% /bindings:http://*:%port% /physicalPath:"%djangoSitePath%"
ECHO Add the created website to the application p
%windir%\system32\inetsrv\appcmd.exe set app "%iisAppName%/" /applicationPool:%iisAppName%

ECHO add scriptProcessor Handler
%windir%\system32\inetsrv\appcmd.exe set config %iisAppName% -section:system.webServer/handlers /+"[name='%handlerName%',path='*',verb='*',modules='FastCgiModule',scriptProcessor='%pythonExe%|%djangoSitePath%\wfastcgi.py',resourceType='Unspecified',requireAccess='Script']" /commit:apphost