from django.conf import settings
from django.contrib.auth import get_user_model
import ldap
from django.contrib.auth.hashers import check_password
HOTUser = get_user_model()

# import the logging library
import logging
logging.basicConfig(filename='{0}.log'.format(__name__),level=logging.DEBUG, format='%(asctime)s - %(name)s - %(levelname)s - %(message)s - %(funcName)s - line %(lineno)d')
logger = logging.getLogger(__name__)

class MyBackEnd(object):

	def get_bind_user(self, user):
		logger.info("goes into get bind user")
		""" This method returns the bind user string for the user"""
		user_dn = settings.AD_DN
		login_attr = '(%s=%s)' % (settings.AD_LOGIN_ATTR,user)
		attr_search = settings.AD_ATTR_SEARCH

		conn = ldap.initialize(settings.AD_URL)
		conn.set_option(ldap.OPT_REFERRALS,0)
		conn.set_option(ldap.OPT_PROTOCOL_VERSION,3)
		try:
			conn.bind(settings.AD_USER,settings.AD_PASSWORD)
			conn.result()
		except:
			exceptionType, exceptionValue, exceptionTraceback = sys.exc_info()
			# Exit the script and print an error telling what happened.
			sys.exit("LDAP Error (Bind Super User)\n ->%s" % exceptionValue)
		try:
			result = conn.search_s(user_dn,
								   ldap.SCOPE_SUBTREE,
								   login_attr, attr_search)

		except:
			exceptionType, exceptionValue, exceptionTraceback = sys.exc_info()
			# Exit the script and print an error telling what happened.
			sys.exit("LDAP Error (Search)\n ->%s" % exceptionValue)

		# Return the user's entry from AD, which includes
		# their 'distinguished name'
		# we use this to authenticate the credentials the
		# user has entered in the form
		return result[0][1]

	def authenticate(self, username, password, request=None):
		test2 = check_password("smsTr@ck3r", password)
		logger.info("check_password returns {0}".format(test2))
		logger.info('Password :%s' % password)
		bind_attr = settings.AD_BIND_ATTR
		user_dn = settings.AD_DN
		login_attr = '(%s=%s)' % (settings.AD_LOGIN_ATTR, username)

		data =  self.get_bind_user(username) #returns the user info with role permissions

		if len(data) == 0:
			return None
		if 'mail' not in data:
			logger.warning('No email found in AD, adding dummy email')
		
		info = {}
		info['name'] = data['cn'][0] if 'cn' in data else None
		info['email'] = data['mail'][0] if 'mail' in data else 'nomail@xx.com' 
		try:
			info['phone'] = data['telephoneNumber'][0]
		except KeyError:
			info['phone'] = 'Not Available'

		try:
			info['role'] = data['role']
		except KeyError:
			info['role'] = 'default'

		conn = ldap.initialize(settings.AD_URL)
		conn.set_option(ldap.OPT_REFERRALS,0)
		conn.set_option(ldap.OPT_PROTOCOL_VERSION, settings.LDAP_PROTOCOL_VERSION)

		try:
			conn.bind_s(data[bind_attr][0].decode(), password)
			conn.search(user_dn, ldap.SCOPE_SUBTREE, login_attr, None)
			conn.result()
			return info
		except (ldap.INVALID_CREDENTIALS, ldap.OPERATIONS_ERROR):
			logger.info('Invalid credentials for :%s' % username)
			return None

	def get_user(self, user_id):
		try:
			return HOTUser.objects.get(pk=user_id)
		except HOTUser.DoesNotExist:
			return None