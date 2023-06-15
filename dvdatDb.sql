--
-- PostgreSQL database dump
--

-- Dumped from database version 14.5
-- Dumped by pg_dump version 14.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry and geography spatial types and functions';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: customBuildings_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."customBuildings_attribute" (
    id integer NOT NULL,
    name character varying(20) NOT NULL,
    color_code character varying(10),
    symbol character varying(100),
    metric character varying(50) NOT NULL,
    default_metric_value numeric(10,2) NOT NULL,
    min_value numeric(10,2) NOT NULL,
    max_value numeric(10,2) NOT NULL,
    cost_per_unit numeric(10,2) NOT NULL,
    use_area boolean NOT NULL,
    cost_per_area numeric(10,2) NOT NULL,
    attribute_type_id integer NOT NULL
);


ALTER TABLE public."customBuildings_attribute" OWNER TO postgres;

--
-- Name: customBuildings_attribute_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."customBuildings_attribute_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."customBuildings_attribute_id_seq" OWNER TO postgres;

--
-- Name: customBuildings_attribute_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."customBuildings_attribute_id_seq" OWNED BY public."customBuildings_attribute".id;


--
-- Name: customBuildings_attributetype; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."customBuildings_attributetype" (
    id integer NOT NULL,
    name character varying(20) NOT NULL
);


ALTER TABLE public."customBuildings_attributetype" OWNER TO postgres;

--
-- Name: customBuildings_attributetype_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."customBuildings_attributetype_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."customBuildings_attributetype_id_seq" OWNER TO postgres;

--
-- Name: customBuildings_attributetype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."customBuildings_attributetype_id_seq" OWNED BY public."customBuildings_attributetype".id;


--
-- Name: customBuildings_building; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."customBuildings_building" (
    id integer NOT NULL,
    osm_id bigint NOT NULL,
    name character varying(100),
    amenity character varying(50),
    building_levels integer NOT NULL,
    building_outline public.geometry(Polygon,4326) NOT NULL
);


ALTER TABLE public."customBuildings_building" OWNER TO postgres;

--
-- Name: customBuildings_building_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."customBuildings_building_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."customBuildings_building_id_seq" OWNER TO postgres;

--
-- Name: customBuildings_building_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."customBuildings_building_id_seq" OWNED BY public."customBuildings_building".id;


--
-- Name: customBuildings_buildingdmgvun; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."customBuildings_buildingdmgvun" (
    id integer NOT NULL,
    metric_value numeric(10,2) NOT NULL,
    damaged_building_id integer NOT NULL,
    damaged_property_id integer NOT NULL,
    date date,
    added_by_id integer,
    added_date date NOT NULL
);


ALTER TABLE public."customBuildings_buildingdmgvun" OWNER TO postgres;

--
-- Name: customBuildings_buildingdmgvun_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."customBuildings_buildingdmgvun_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."customBuildings_buildingdmgvun_id_seq" OWNER TO postgres;

--
-- Name: customBuildings_buildingdmgvun_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."customBuildings_buildingdmgvun_id_seq" OWNED BY public."customBuildings_buildingdmgvun".id;


--
-- Name: customBuildings_hotuser; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."customBuildings_hotuser" (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    is_admin integer,
    role character varying(256),
    organization_id integer
);


ALTER TABLE public."customBuildings_hotuser" OWNER TO postgres;

--
-- Name: customBuildings_hotuser_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."customBuildings_hotuser_groups" (
    id integer NOT NULL,
    hotuser_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public."customBuildings_hotuser_groups" OWNER TO postgres;

--
-- Name: customBuildings_hotuser_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."customBuildings_hotuser_groups_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."customBuildings_hotuser_groups_id_seq" OWNER TO postgres;

--
-- Name: customBuildings_hotuser_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."customBuildings_hotuser_groups_id_seq" OWNED BY public."customBuildings_hotuser_groups".id;


--
-- Name: customBuildings_hotuser_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."customBuildings_hotuser_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."customBuildings_hotuser_id_seq" OWNER TO postgres;

--
-- Name: customBuildings_hotuser_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."customBuildings_hotuser_id_seq" OWNED BY public."customBuildings_hotuser".id;


--
-- Name: customBuildings_hotuser_user_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."customBuildings_hotuser_user_permissions" (
    id integer NOT NULL,
    hotuser_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public."customBuildings_hotuser_user_permissions" OWNER TO postgres;

--
-- Name: customBuildings_hotuser_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."customBuildings_hotuser_user_permissions_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."customBuildings_hotuser_user_permissions_id_seq" OWNER TO postgres;

--
-- Name: customBuildings_hotuser_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."customBuildings_hotuser_user_permissions_id_seq" OWNED BY public."customBuildings_hotuser_user_permissions".id;


--
-- Name: customBuildings_organization; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."customBuildings_organization" (
    id integer NOT NULL,
    name character varying(256) NOT NULL,
    short_name character varying(30) NOT NULL,
    symbol character varying(30)
);


ALTER TABLE public."customBuildings_organization" OWNER TO postgres;

--
-- Name: customBuildings_organization_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."customBuildings_organization_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."customBuildings_organization_id_seq" OWNER TO postgres;

--
-- Name: customBuildings_organization_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."customBuildings_organization_id_seq" OWNED BY public."customBuildings_organization".id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO postgres;

--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: customBuildings_attribute id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."customBuildings_attribute" ALTER COLUMN id SET DEFAULT nextval('public."customBuildings_attribute_id_seq"'::regclass);


--
-- Name: customBuildings_attributetype id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."customBuildings_attributetype" ALTER COLUMN id SET DEFAULT nextval('public."customBuildings_attributetype_id_seq"'::regclass);


--
-- Name: customBuildings_building id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."customBuildings_building" ALTER COLUMN id SET DEFAULT nextval('public."customBuildings_building_id_seq"'::regclass);


--
-- Name: customBuildings_buildingdmgvun id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."customBuildings_buildingdmgvun" ALTER COLUMN id SET DEFAULT nextval('public."customBuildings_buildingdmgvun_id_seq"'::regclass);


--
-- Name: customBuildings_hotuser id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."customBuildings_hotuser" ALTER COLUMN id SET DEFAULT nextval('public."customBuildings_hotuser_id_seq"'::regclass);


--
-- Name: customBuildings_hotuser_groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."customBuildings_hotuser_groups" ALTER COLUMN id SET DEFAULT nextval('public."customBuildings_hotuser_groups_id_seq"'::regclass);


--
-- Name: customBuildings_hotuser_user_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."customBuildings_hotuser_user_permissions" ALTER COLUMN id SET DEFAULT nextval('public."customBuildings_hotuser_user_permissions_id_seq"'::regclass);


--
-- Name: customBuildings_organization id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."customBuildings_organization" ALTER COLUMN id SET DEFAULT nextval('public."customBuildings_organization_id_seq"'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add content type	4	add_contenttype
14	Can change content type	4	change_contenttype
15	Can delete content type	4	delete_contenttype
16	Can view content type	4	view_contenttype
17	Can add session	5	add_session
18	Can change session	5	change_session
19	Can delete session	5	delete_session
20	Can view session	5	view_session
21	Can add user	6	add_hotuser
22	Can change user	6	change_hotuser
23	Can delete user	6	delete_hotuser
24	Can view user	6	view_hotuser
25	Can add building	7	add_building
26	Can change building	7	change_building
27	Can delete building	7	delete_building
28	Can view building	7	view_building
29	Can add building dmg vun	8	add_buildingdmgvun
30	Can change building dmg vun	8	change_buildingdmgvun
31	Can delete building dmg vun	8	delete_buildingdmgvun
32	Can view building dmg vun	8	view_buildingdmgvun
33	Can add attribute	9	add_attribute
34	Can change attribute	9	change_attribute
35	Can delete attribute	9	delete_attribute
36	Can view attribute	9	view_attribute
37	Can add attribute type	10	add_attributetype
38	Can change attribute type	10	change_attributetype
39	Can delete attribute type	10	delete_attributetype
40	Can view attribute type	10	view_attributetype
41	Can add organization	11	add_organization
42	Can change organization	11	change_organization
43	Can delete organization	11	delete_organization
44	Can view organization	11	view_organization
\.


--
-- Data for Name: customBuildings_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."customBuildings_attribute" (id, name, color_code, symbol, metric, default_metric_value, min_value, max_value, cost_per_unit, use_area, cost_per_area, attribute_type_id) FROM stdin;
5	flooding	#161EFF	\N	percentage flooded	50.00	0.00	100.00	10.00	t	200.00	1
6	flooding (V)	#FFBB02	\N	percent	50.00	0.00	100.00	200.00	t	100.00	2
7	landslide	#5B450D	\N	percent	50.00	0.00	100.00	100.00	t	100.00	1
8	landslide (V)	#608918	\N	percent	50.00	0.00	100.00	200.00	t	200.00	2
9	overhanging trees	#0CCC9F	\N	percent	50.00	0.00	100.00	50.00	f	50.00	1
10	Fire	red	\N	percent	50.00	0.00	100.00	2000.00	t	2000.00	1
11	earthquake	black	\N	percent	50.00	0.00	100.00	1000.00	t	1000.00	1
\.


--
-- Data for Name: customBuildings_attributetype; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."customBuildings_attributetype" (id, name) FROM stdin;
1	damage
2	vunerability
\.


--
-- Data for Name: customBuildings_hotuser_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."customBuildings_hotuser_groups" (id, hotuser_id, group_id) FROM stdin;
\.


--
-- Data for Name: customBuildings_hotuser_user_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."customBuildings_hotuser_user_permissions" (id, hotuser_id, permission_id) FROM stdin;
\.


--
-- Data for Name: customBuildings_organization; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."customBuildings_organization" (id, name, short_name, symbol) FROM stdin;
1	Youth Emergency Action Commitee	YEAC	yeac_symbol_slu.jpg
2	Saint Lucia Red Cross	Red Cross	saint-lucia-red-cross.jpg
3	National Emergency Management Office	NEMO	NEMO-Logo-Small3.png
\.



--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	contenttypes	contenttype
5	sessions	session
6	customBuildings	hotuser
7	customBuildings	building
8	customBuildings	buildingdmgvun
9	customBuildings	attribute
10	customBuildings	attributetype
11	customBuildings	organization
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2022-10-20 23:43:53.043827-04
2	contenttypes	0002_remove_content_type_name	2022-10-20 23:43:53.065837-04
3	auth	0001_initial	2022-10-20 23:43:53.11332-04
4	auth	0002_alter_permission_name_max_length	2022-10-20 23:43:53.166662-04
5	auth	0003_alter_user_email_max_length	2022-10-20 23:43:53.176906-04
6	auth	0004_alter_user_username_opts	2022-10-20 23:43:53.185901-04
7	auth	0005_alter_user_last_login_null	2022-10-20 23:43:53.196339-04
8	auth	0006_require_contenttypes_0002	2022-10-20 23:43:53.200451-04
9	auth	0007_alter_validators_add_error_messages	2022-10-20 23:43:53.211174-04
10	auth	0008_alter_user_username_max_length	2022-10-20 23:43:53.219568-04
11	auth	0009_alter_user_last_name_max_length	2022-10-20 23:43:53.229541-04
12	auth	0010_alter_group_name_max_length	2022-10-20 23:43:53.242112-04
13	auth	0011_update_proxy_permissions	2022-10-20 23:43:53.253172-04
14	customBuildings	0001_initial	2022-10-20 23:43:53.296853-04
15	admin	0001_initial	2022-10-20 23:43:53.36294-04
16	admin	0002_logentry_remove_auto_add	2022-10-20 23:43:53.391807-04
17	admin	0003_logentry_add_action_flag_choices	2022-10-20 23:43:53.407751-04
18	sessions	0001_initial	2022-10-20 23:43:53.423846-04
19	customBuildings	0002_auto_20221021_0050	2022-10-21 00:51:19.281831-04
20	customBuildings	0003_auto_20230111_2137	2023-01-11 21:42:48.277309-04
21	customBuildings	0004_buildingdmgvun_date	2023-01-11 21:42:48.292933-04
22	customBuildings	0005_attributetype_name	2023-01-12 20:16:09.294424-04
23	customBuildings	0006_auto_20230216_2029	2023-02-16 20:29:32.732375-04
24	customBuildings	0007_auto_20230216_2225	2023-02-16 22:26:08.614322-04
\.



--
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 44, true);


--
-- Name: customBuildings_attribute_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."customBuildings_attribute_id_seq"', 11, true);


--
-- Name: customBuildings_attributetype_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."customBuildings_attributetype_id_seq"', 2, true);


--
-- Name: customBuildings_building_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."customBuildings_building_id_seq"', 114, true);


--
-- Name: customBuildings_buildingdmgvun_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."customBuildings_buildingdmgvun_id_seq"', 83, true);


--
-- Name: customBuildings_hotuser_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."customBuildings_hotuser_groups_id_seq"', 1, false);


--
-- Name: customBuildings_hotuser_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."customBuildings_hotuser_id_seq"', 1, true);


--
-- Name: customBuildings_hotuser_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."customBuildings_hotuser_user_permissions_id_seq"', 1, false);


--
-- Name: customBuildings_organization_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."customBuildings_organization_id_seq"', 3, true);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 10, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 11, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 24, true);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: customBuildings_attribute customBuildings_attribute_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."customBuildings_attribute"
    ADD CONSTRAINT "customBuildings_attribute_pkey" PRIMARY KEY (id);


--
-- Name: customBuildings_attributetype customBuildings_attributetype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."customBuildings_attributetype"
    ADD CONSTRAINT "customBuildings_attributetype_pkey" PRIMARY KEY (id);


--
-- Name: customBuildings_building customBuildings_building_osm_id_f88712b3_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."customBuildings_building"
    ADD CONSTRAINT "customBuildings_building_osm_id_f88712b3_uniq" UNIQUE (osm_id);


--
-- Name: customBuildings_building customBuildings_building_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."customBuildings_building"
    ADD CONSTRAINT "customBuildings_building_pkey" PRIMARY KEY (id);


--
-- Name: customBuildings_buildingdmgvun customBuildings_buildingdmgvun_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."customBuildings_buildingdmgvun"
    ADD CONSTRAINT "customBuildings_buildingdmgvun_pkey" PRIMARY KEY (id);


--
-- Name: customBuildings_hotuser_groups customBuildings_hotuser__hotuser_id_group_id_5de50315_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."customBuildings_hotuser_groups"
    ADD CONSTRAINT "customBuildings_hotuser__hotuser_id_group_id_5de50315_uniq" UNIQUE (hotuser_id, group_id);


--
-- Name: customBuildings_hotuser_user_permissions customBuildings_hotuser__hotuser_id_permission_id_747a7075_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."customBuildings_hotuser_user_permissions"
    ADD CONSTRAINT "customBuildings_hotuser__hotuser_id_permission_id_747a7075_uniq" UNIQUE (hotuser_id, permission_id);


--
-- Name: customBuildings_hotuser_groups customBuildings_hotuser_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."customBuildings_hotuser_groups"
    ADD CONSTRAINT "customBuildings_hotuser_groups_pkey" PRIMARY KEY (id);


--
-- Name: customBuildings_hotuser customBuildings_hotuser_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."customBuildings_hotuser"
    ADD CONSTRAINT "customBuildings_hotuser_pkey" PRIMARY KEY (id);


--
-- Name: customBuildings_hotuser_user_permissions customBuildings_hotuser_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."customBuildings_hotuser_user_permissions"
    ADD CONSTRAINT "customBuildings_hotuser_user_permissions_pkey" PRIMARY KEY (id);


--
-- Name: customBuildings_hotuser customBuildings_hotuser_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."customBuildings_hotuser"
    ADD CONSTRAINT "customBuildings_hotuser_username_key" UNIQUE (username);


--
-- Name: customBuildings_organization customBuildings_organization_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."customBuildings_organization"
    ADD CONSTRAINT "customBuildings_organization_name_key" UNIQUE (name);


--
-- Name: customBuildings_organization customBuildings_organization_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."customBuildings_organization"
    ADD CONSTRAINT "customBuildings_organization_pkey" PRIMARY KEY (id);


--
-- Name: customBuildings_organization customBuildings_organization_short_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."customBuildings_organization"
    ADD CONSTRAINT "customBuildings_organization_short_name_key" UNIQUE (short_name);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: customBuildings_attribute_attribute_type_id_333b1dad; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "customBuildings_attribute_attribute_type_id_333b1dad" ON public."customBuildings_attribute" USING btree (attribute_type_id);


--
-- Name: customBuildings_building_building_outline_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "customBuildings_building_building_outline_id" ON public."customBuildings_building" USING gist (building_outline);


--
-- Name: customBuildings_buildingdmgvun_added_by_id_4314a3b1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "customBuildings_buildingdmgvun_added_by_id_4314a3b1" ON public."customBuildings_buildingdmgvun" USING btree (added_by_id);


--
-- Name: customBuildings_buildingdmgvun_damaged_building_id_42eb1138; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "customBuildings_buildingdmgvun_damaged_building_id_42eb1138" ON public."customBuildings_buildingdmgvun" USING btree (damaged_building_id);


--
-- Name: customBuildings_buildingdmgvun_damaged_property_id_61129a98; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "customBuildings_buildingdmgvun_damaged_property_id_61129a98" ON public."customBuildings_buildingdmgvun" USING btree (damaged_property_id);


--
-- Name: customBuildings_hotuser_groups_group_id_1bdf9d20; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "customBuildings_hotuser_groups_group_id_1bdf9d20" ON public."customBuildings_hotuser_groups" USING btree (group_id);


--
-- Name: customBuildings_hotuser_groups_hotuser_id_9980e9e7; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "customBuildings_hotuser_groups_hotuser_id_9980e9e7" ON public."customBuildings_hotuser_groups" USING btree (hotuser_id);


--
-- Name: customBuildings_hotuser_organization_id_b415ca69; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "customBuildings_hotuser_organization_id_b415ca69" ON public."customBuildings_hotuser" USING btree (organization_id);


--
-- Name: customBuildings_hotuser_user_permissions_hotuser_id_c4e914ba; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "customBuildings_hotuser_user_permissions_hotuser_id_c4e914ba" ON public."customBuildings_hotuser_user_permissions" USING btree (hotuser_id);


--
-- Name: customBuildings_hotuser_user_permissions_permission_id_5d3a87fe; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "customBuildings_hotuser_user_permissions_permission_id_5d3a87fe" ON public."customBuildings_hotuser_user_permissions" USING btree (permission_id);


--
-- Name: customBuildings_hotuser_username_4f27ccde_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "customBuildings_hotuser_username_4f27ccde_like" ON public."customBuildings_hotuser" USING btree (username varchar_pattern_ops);


--
-- Name: customBuildings_organization_name_3818806c_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "customBuildings_organization_name_3818806c_like" ON public."customBuildings_organization" USING btree (name varchar_pattern_ops);


--
-- Name: customBuildings_organization_short_name_18b72a79_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "customBuildings_organization_short_name_18b72a79_like" ON public."customBuildings_organization" USING btree (short_name varchar_pattern_ops);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: customBuildings_attribute customBuildings_attr_attribute_type_id_333b1dad_fk_customBui; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."customBuildings_attribute"
    ADD CONSTRAINT "customBuildings_attr_attribute_type_id_333b1dad_fk_customBui" FOREIGN KEY (attribute_type_id) REFERENCES public."customBuildings_attributetype"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: customBuildings_buildingdmgvun customBuildings_buil_added_by_id_4314a3b1_fk_customBui; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."customBuildings_buildingdmgvun"
    ADD CONSTRAINT "customBuildings_buil_added_by_id_4314a3b1_fk_customBui" FOREIGN KEY (added_by_id) REFERENCES public."customBuildings_hotuser"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: customBuildings_buildingdmgvun customBuildings_buil_damaged_building_id_42eb1138_fk_customBui; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."customBuildings_buildingdmgvun"
    ADD CONSTRAINT "customBuildings_buil_damaged_building_id_42eb1138_fk_customBui" FOREIGN KEY (damaged_building_id) REFERENCES public."customBuildings_building"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: customBuildings_buildingdmgvun customBuildings_buil_damaged_property_id_61129a98_fk_customBui; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."customBuildings_buildingdmgvun"
    ADD CONSTRAINT "customBuildings_buil_damaged_property_id_61129a98_fk_customBui" FOREIGN KEY (damaged_property_id) REFERENCES public."customBuildings_attribute"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: customBuildings_hotuser_groups customBuildings_hotu_group_id_1bdf9d20_fk_auth_grou; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."customBuildings_hotuser_groups"
    ADD CONSTRAINT "customBuildings_hotu_group_id_1bdf9d20_fk_auth_grou" FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: customBuildings_hotuser_groups customBuildings_hotu_hotuser_id_9980e9e7_fk_customBui; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."customBuildings_hotuser_groups"
    ADD CONSTRAINT "customBuildings_hotu_hotuser_id_9980e9e7_fk_customBui" FOREIGN KEY (hotuser_id) REFERENCES public."customBuildings_hotuser"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: customBuildings_hotuser_user_permissions customBuildings_hotu_hotuser_id_c4e914ba_fk_customBui; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."customBuildings_hotuser_user_permissions"
    ADD CONSTRAINT "customBuildings_hotu_hotuser_id_c4e914ba_fk_customBui" FOREIGN KEY (hotuser_id) REFERENCES public."customBuildings_hotuser"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: customBuildings_hotuser customBuildings_hotu_organization_id_b415ca69_fk_customBui; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."customBuildings_hotuser"
    ADD CONSTRAINT "customBuildings_hotu_organization_id_b415ca69_fk_customBui" FOREIGN KEY (organization_id) REFERENCES public."customBuildings_organization"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: customBuildings_hotuser_user_permissions customBuildings_hotu_permission_id_5d3a87fe_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."customBuildings_hotuser_user_permissions"
    ADD CONSTRAINT "customBuildings_hotu_permission_id_5d3a87fe_fk_auth_perm" FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_customBuildings_hotuser_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT "django_admin_log_user_id_c564eba6_fk_customBuildings_hotuser_id" FOREIGN KEY (user_id) REFERENCES public."customBuildings_hotuser"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

