--
-- PostgreSQL database dump
--

-- Dumped from database version 15.4
-- Dumped by pg_dump version 17.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: keluar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.keluar (
    idkeluar integer NOT NULL,
    idbarang integer,
    tanggal timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    penerima text,
    qty integer,
    namabarang_k text,
    penginput text,
    kodebarang_k text
);


ALTER TABLE public.keluar OWNER TO postgres;

--
-- Name: keluar_idkeluar_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.keluar_idkeluar_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.keluar_idkeluar_seq OWNER TO postgres;

--
-- Name: keluar_idkeluar_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.keluar_idkeluar_seq OWNED BY public.keluar.idkeluar;


--
-- Name: log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.log (
    idlog integer NOT NULL,
    date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    usr text,
    method text,
    endpoint text,
    status_code text
);


ALTER TABLE public.log OWNER TO postgres;

--
-- Name: log_idlog_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.log_idlog_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.log_idlog_seq OWNER TO postgres;

--
-- Name: log_idlog_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.log_idlog_seq OWNED BY public.log.idlog;


--
-- Name: masuk; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.masuk (
    idmasuk integer NOT NULL,
    idbarang integer,
    tanggal timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    keterangan text,
    qty integer,
    namabarang_m text,
    penginput text,
    kodebarang_m text
);


ALTER TABLE public.masuk OWNER TO postgres;

--
-- Name: masuk_idmasuk_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.masuk_idmasuk_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.masuk_idmasuk_seq OWNER TO postgres;

--
-- Name: masuk_idmasuk_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.masuk_idmasuk_seq OWNED BY public.masuk.idmasuk;


--
-- Name: stock; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stock (
    idbarang integer NOT NULL,
    namabarang text,
    deskripsi text,
    stock integer,
    image text,
    penginput text,
    kodebarang text
);


ALTER TABLE public.stock OWNER TO postgres;

--
-- Name: stock_idbarang_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.stock_idbarang_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.stock_idbarang_seq OWNER TO postgres;

--
-- Name: stock_idbarang_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.stock_idbarang_seq OWNED BY public.stock.idbarang;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    email text NOT NULL,
    password text NOT NULL,
    role text NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: keluar idkeluar; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keluar ALTER COLUMN idkeluar SET DEFAULT nextval('public.keluar_idkeluar_seq'::regclass);


--
-- Name: log idlog; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.log ALTER COLUMN idlog SET DEFAULT nextval('public.log_idlog_seq'::regclass);


--
-- Name: masuk idmasuk; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.masuk ALTER COLUMN idmasuk SET DEFAULT nextval('public.masuk_idmasuk_seq'::regclass);


--
-- Name: stock idbarang; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock ALTER COLUMN idbarang SET DEFAULT nextval('public.stock_idbarang_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: keluar; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.keluar (idkeluar, idbarang, tanggal, penerima, qty, namabarang_k, penginput, kodebarang_k) FROM stdin;
2	1	2023-01-19 05:19:07.271502+07	MEGACOMP Bandung	2	Asus ROG FLOW Z13	superadmin@gmail.com	ADDE1324
3	1	2023-01-19 05:19:54.069291+07	iComp Electronics	3	Asus ROG FLOW Z13	superadmin@gmail.com	ADDE1324
\.


--
-- Data for Name: log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.log (idlog, date, usr, method, endpoint, status_code) FROM stdin;
35	2023-01-18 23:00:58.640881+07	admin@gmail.com	POST	/login	302
36	2023-01-18 23:00:58.721904+07	admin@gmail.com	GET	/	200
37	2023-01-18 23:01:06.703305+07	admin@gmail.com	GET	/account	200
38	2023-01-18 23:03:12.533329+07	admin@gmail.com	GET	/account	200
39	2023-01-18 23:03:52.419697+07	admin@gmail.com	GET	/users	200
40	2023-01-18 23:04:18.101625+07	admin@gmail.com	GET	/users	200
41	2023-01-18 23:05:54.098647+07	admin@gmail.com	GET	/barangmasuk	200
42	2023-01-18 23:14:35.983227+07	admin@gmail.com	GET	/barangmasuk	304
43	2023-01-18 23:14:37.643663+07	admin@gmail.com	GET	/barang	200
44	2023-01-18 23:14:43.057811+07	admin@gmail.com	GET	/barangmasuk	304
45	2023-01-18 23:14:47.293617+07	admin@gmail.com	GET	/barangkeluar	200
46	2023-01-18 23:14:50.783048+07	admin@gmail.com	GET	/users	304
47	2023-01-18 23:14:59.765157+07	admin@gmail.com	GET	/account	304
48	2023-01-18 23:24:36.993595+07	admin@gmail.com	GET	/account	304
49	2023-01-18 23:24:38.515591+07	admin@gmail.com	GET	/	304
50	2023-01-18 23:24:39.568381+07	admin@gmail.com	GET	/barang	304
51	2023-01-18 23:24:41.53763+07	admin@gmail.com	GET	/barangmasuk	200
52	2023-01-18 23:25:22.202953+07	admin@gmail.com	GET	/barangmasuk	304
53	2023-01-18 23:26:17.450603+07	admin@gmail.com	GET	/barangmasuk	304
54	2023-01-18 23:26:17.622974+07	admin@gmail.com	GET	/barangmasuk	304
55	2023-01-18 23:27:33.891176+07	admin@gmail.com	GET	/barang	304
56	2023-01-18 23:29:23.353238+07	admin@gmail.com	POST	/barang	302
57	2023-01-18 23:29:23.361418+07	admin@gmail.com	GET	/barang	200
58	2023-01-18 23:31:21.991949+07	admin@gmail.com	POST	/barang	302
59	2023-01-18 23:31:21.999809+07	admin@gmail.com	GET	/barang	200
60	2023-01-18 23:31:25.327396+07	admin@gmail.com	GET	/barang/2	200
61	2023-01-18 23:31:29.490251+07	admin@gmail.com	GET	/barang/3	200
62	2023-01-18 23:31:33.32996+07	admin@gmail.com	GET	/	200
63	2023-01-18 23:31:34.666723+07	admin@gmail.com	GET	/barang	304
64	2023-01-18 23:31:36.487669+07	admin@gmail.com	GET	/barang/3	304
65	2023-01-18 23:31:39.125193+07	admin@gmail.com	GET	/barang	304
66	2023-01-18 23:33:25.563141+07	admin@gmail.com	POST	/barang	302
67	2023-01-18 23:33:25.571334+07	admin@gmail.com	GET	/barang	200
68	2023-01-18 23:33:34.477604+07	admin@gmail.com	PUT	/barang/4?_method=put	302
69	2023-01-18 23:33:34.484618+07	admin@gmail.com	GET	/barang	200
70	2023-01-18 23:33:34.529047+07	admin@gmail.com	GET	/uploads/APTSE99380%20-%20Acer%20Predator%20Triton%20300%20SE%20(2021).png	404
71	2023-01-18 23:33:51.77266+07	user@gmail.com	POST	/login	302
72	2023-01-18 23:33:51.83441+07	user@gmail.com	GET	/	200
73	2023-01-18 23:33:54.177346+07	user@gmail.com	GET	/barang	200
74	2023-01-18 23:33:54.218765+07	user@gmail.com	GET	/uploads/APTSE99380%20-%20Acer%20Predator%20Triton%20300%20SE%20(2021).png	404
75	2023-01-18 23:42:33.924786+07	admin@gmail.com	POST	/login	302
76	2023-01-18 23:42:34.005555+07	admin@gmail.com	GET	/	200
77	2023-01-18 23:42:35.506325+07	admin@gmail.com	GET	/users	304
78	2023-01-18 23:42:37.336261+07	admin@gmail.com	GET	/barang	200
79	2023-01-18 23:44:04.890146+07	admin@gmail.com	POST	/barang	302
80	2023-01-18 23:44:04.898046+07	admin@gmail.com	GET	/barang	200
81	2023-01-18 23:45:27.362661+07	admin@gmail.com	POST	/barang	302
82	2023-01-18 23:45:27.369715+07	admin@gmail.com	GET	/barang	200
83	2023-01-18 23:46:35.635448+07	admin@gmail.com	POST	/barang	302
84	2023-01-18 23:46:35.643492+07	admin@gmail.com	GET	/barang	200
85	2023-01-18 23:46:53.904725+07	user@gmail.com	POST	/login	302
86	2023-01-18 23:46:53.96989+07	user@gmail.com	GET	/	200
87	2023-01-18 23:47:51.129297+07	user@gmail.com	GET	/barang	200
88	2023-01-18 23:48:58.594468+07	user@gmail.com	POST	/barang	302
89	2023-01-18 23:48:58.601555+07	user@gmail.com	GET	/barang	200
90	2023-01-18 23:51:09.861502+07	admin@gmail.com	POST	/login	302
91	2023-01-18 23:51:09.938186+07	admin@gmail.com	GET	/	200
92	2023-01-18 23:51:11.424404+07	admin@gmail.com	GET	/barang	200
93	2023-01-18 23:57:29.293113+07	user@gmail.com	POST	/login	302
94	2023-01-18 23:57:29.469609+07	user@gmail.com	GET	/	200
95	2023-01-18 23:58:22.628594+07	user@gmail.com	GET	/barang	200
96	2023-01-18 23:59:21.912816+07	user@gmail.com	POST	/barang	302
97	2023-01-18 23:59:21.922464+07	user@gmail.com	GET	/barang	200
98	2023-01-19 00:00:39.519487+07	user@gmail.com	POST	/barang	302
99	2023-01-19 00:00:39.529431+07	user@gmail.com	GET	/barang	200
100	2023-01-19 00:01:23.701397+07	user@gmail.com	POST	/barang	302
101	2023-01-19 00:01:23.71098+07	user@gmail.com	GET	/barang	200
102	2023-01-19 00:02:15.833169+07	user@gmail.com	POST	/barang	302
103	2023-01-19 00:02:15.841823+07	user@gmail.com	GET	/barang	200
104	2023-01-19 00:03:14.228667+07	user@gmail.com	POST	/barang	302
105	2023-01-19 00:03:14.237486+07	user@gmail.com	GET	/barang	200
106	2023-01-19 00:04:05.26915+07	user@gmail.com	POST	/barang	302
107	2023-01-19 00:04:05.277759+07	user@gmail.com	GET	/barang	200
108	2023-01-19 00:04:57.338595+07	admin@gmail.com	POST	/login	302
109	2023-01-19 00:04:57.508086+07	admin@gmail.com	GET	/	200
110	2023-01-19 00:05:06.118463+07	admin@gmail.com	GET	/barang	200
111	2023-01-19 00:05:45.138873+07	admin@gmail.com	GET	/barangmasuk	200
112	2023-01-19 00:05:57.623502+07	admin@gmail.com	GET	/barang	304
113	2023-01-19 00:12:15.322777+07	admin@gmail.com	POST	/login	302
114	2023-01-19 00:12:15.397595+07	admin@gmail.com	GET	/	200
115	2023-01-19 00:12:17.428367+07	admin@gmail.com	GET	/account	200
116	2023-01-19 00:12:30.007781+07	admin123@gmail.com	PUT	/account/changeemail?_method=put	200
117	2023-01-19 00:12:39.151905+07	admin123@gmail.com	PUT	/account/changeemail?_method=put	200
118	2023-01-19 00:12:43.848257+07	admin123@gmail.com	GET	/account	200
119	2023-01-19 00:19:52.169903+07	admin123@gmail.com	POST	/login	302
120	2023-01-19 00:19:52.345995+07	admin123@gmail.com	GET	/	200
121	2023-01-19 00:19:54.464838+07	admin123@gmail.com	GET	/account	200
122	2023-01-19 00:20:00.335548+07	admin@gmail.com	PUT	/account/changeemail?_method=put	302
123	2023-01-19 00:20:00.341951+07	admin@gmail.com	GET	/account/changeemail	404
124	2023-01-19 00:21:44.978658+07	admin@gmail.com	POST	/login	302
125	2023-01-19 00:21:45.056637+07	admin@gmail.com	GET	/	200
126	2023-01-19 00:21:47.153544+07	admin@gmail.com	GET	/account	200
127	2023-01-19 00:21:54.823601+07	admin123@gmail.com	PUT	/account/changeemail?_method=put	302
128	2023-01-19 00:21:54.831196+07	admin123@gmail.com	GET	/account	200
129	2023-01-19 00:22:01.976383+07	admin@gmail.com	PUT	/account/changeemail?_method=put	302
130	2023-01-19 00:22:01.984873+07	admin@gmail.com	GET	/account	200
131	2023-01-19 00:24:25.306283+07	admin@gmail.com	POST	/login	302
132	2023-01-19 00:24:25.4926+07	admin@gmail.com	GET	/	200
133	2023-01-19 00:24:29.815651+07	admin@gmail.com	GET	/account	200
134	2023-01-19 00:24:40.958357+07	admin@gmail.com	PUT	/account/changepassword?_method=put	200
135	2023-01-19 00:24:48.821042+07	admin@gmail.com	GET	/	304
136	2023-01-19 00:26:44.319625+07	admin@gmail.com	POST	/login	302
137	2023-01-19 00:26:44.505687+07	admin@gmail.com	GET	/	200
138	2023-01-19 00:26:46.898946+07	admin@gmail.com	GET	/account	200
139	2023-01-19 00:27:09.269543+07	admin@gmail.com	PUT	/account/changepassword?_method=put	200
140	2023-01-19 00:27:22.211496+07	user@gmail.com	POST	/login	302
141	2023-01-19 00:27:22.380541+07	user@gmail.com	GET	/	200
142	2023-01-19 00:27:26.280041+07	user@gmail.com	GET	/account	200
143	2023-01-19 00:27:35.196738+07	user@gmail.com	PUT	/account/changepassword?_method=put	200
144	2023-01-19 00:27:47.009244+07	user@gmail.com	PUT	/account/changepassword?_method=put	200
145	2023-01-19 00:28:03.05155+07	user@gmail.com	PUT	/account/changepassword?_method=put	200
146	2023-01-19 00:28:21.57114+07	user@gmail.com	PUT	/account/changepassword?_method=put	200
147	2023-01-19 00:28:24.662272+07	user@gmail.com	PUT	/account/changepassword?_method=put	200
148	2023-01-19 00:28:28.212187+07	user@gmail.com	GET	/account	200
149	2023-01-19 00:28:43.083508+07	user@gmail.com	PUT	/account/changepassword?_method=put	200
150	2023-01-19 00:28:52.046482+07	user@gmail.com	PUT	/account/changepassword?_method=put	200
151	2023-01-19 00:29:06.35653+07	user@gmail.com	PUT	/account/changepassword?_method=put	200
152	2023-01-19 00:29:10.793872+07	user@gmail.com	PUT	/account/changepassword?_method=put	200
153	2023-01-19 00:29:14.386017+07	user@gmail.com	GET	/account	200
154	2023-01-19 00:29:24.644514+07	user@gmail.com	PUT	/account/changepassword?_method=put	200
155	2023-01-19 00:29:35.438888+07	user@gmail.com	PUT	/account/changepassword?_method=put	200
156	2023-01-19 00:29:44.742282+07	user@gmail.com	PUT	/account/changepassword?_method=put	200
157	2023-01-19 00:32:57.509226+07	admin@gmail.com	POST	/login	302
158	2023-01-19 00:32:57.693125+07	admin@gmail.com	GET	/	200
159	2023-01-19 00:33:01.373494+07	admin@gmail.com	GET	/users	200
160	2023-01-19 00:33:05.646092+07	admin@gmail.com	POST	/users/resetpassword/2	200
161	2023-01-19 00:33:07.72167+07	admin@gmail.com	GET	/account	200
162	2023-01-19 00:33:25.636499+07	admin@gmail.com	PUT	/account/changepassword?_method=put	302
163	2023-01-19 00:33:25.645031+07	admin@gmail.com	GET	/account	200
164	2023-01-19 00:33:37.293004+07	admin@gmail.com	PUT	/account/changepassword?_method=put	302
165	2023-01-19 00:33:37.358842+07	admin@gmail.com	GET	/account	200
166	2023-01-19 00:33:52.780806+07	admin@gmail.com	PUT	/account/changepassword?_method=put	200
167	2023-01-19 00:37:36.598571+07	admin@gmail.com	POST	/login	302
168	2023-01-19 00:37:36.673335+07	admin@gmail.com	GET	/	200
169	2023-01-19 00:38:17.062359+07	admin@gmail.com	GET	/	304
170	2023-01-19 00:38:19.374257+07	admin@gmail.com	GET	/account	304
171	2023-01-19 00:38:30.933638+07	admin@gmail.com	PUT	/account/changeemail?_method=put	200
172	2023-01-19 00:38:44.907264+07	admin123@gmail.com	POST	/login	302
173	2023-01-19 00:38:44.918679+07	admin123@gmail.com	GET	/	200
174	2023-01-19 00:38:47.458351+07	admin123@gmail.com	GET	/account	200
175	2023-01-19 00:39:14.929165+07	user@gmail.com	POST	/login	302
176	2023-01-19 00:39:14.996573+07	user@gmail.com	GET	/	200
177	2023-01-19 00:39:17.956577+07	user@gmail.com	GET	/account	200
178	2023-01-19 00:39:41.969276+07	user@gmail.com	POST	/login	302
179	2023-01-19 00:39:42.035726+07	user@gmail.com	GET	/	304
180	2023-01-19 00:39:44.539665+07	user@gmail.com	GET	/account	200
181	2023-01-19 00:39:56.943323+07	user@gmail.com	PUT	/account/changepassword?_method=put	200
182	2023-01-19 00:40:27.671965+07	user@gmail.com	POST	/login	302
183	2023-01-19 00:40:27.74163+07	user@gmail.com	GET	/	304
184	2023-01-19 00:40:29.702163+07	user@gmail.com	GET	/barang	200
185	2023-01-19 00:40:31.64898+07	user@gmail.com	GET	/	304
186	2023-01-19 00:40:32.71152+07	user@gmail.com	GET	/barangmasuk	200
187	2023-01-19 00:40:34.421583+07	user@gmail.com	GET	/	304
188	2023-01-19 00:40:35.334791+07	user@gmail.com	GET	/barangkeluar	200
189	2023-01-19 00:42:19.404426+07	user@gmail.com	GET	/barangkeluar	304
190	2023-01-19 00:45:04.618177+07	user@gmail.com	GET	/barangkeluar	200
191	2023-01-19 00:45:12.349052+07	user@gmail.com	GET	/barangmasuk	200
192	2023-01-19 00:45:35.802431+07	user@gmail.com	GET	/barang	304
193	2023-01-19 00:45:37.331758+07	user@gmail.com	GET	/barangmasuk	304
194	2023-01-19 00:45:37.714612+07	user@gmail.com	GET	/barangkeluar	304
195	2023-01-19 00:45:38.185645+07	user@gmail.com	GET	/barangmasuk	304
196	2023-01-19 00:45:38.523951+07	user@gmail.com	GET	/barang	304
197	2023-01-19 00:46:21.710833+07	user@gmail.com	POST	/barang	302
198	2023-01-19 00:46:21.719625+07	user@gmail.com	GET	/barang	200
199	2023-01-19 00:47:07.374391+07	user@gmail.com	POST	/barang	302
200	2023-01-19 00:47:07.382024+07	user@gmail.com	GET	/barang	200
201	2023-01-19 00:49:44.292241+07	user@gmail.com	POST	/barang	302
202	2023-01-19 00:49:44.299422+07	user@gmail.com	GET	/barang	200
203	2023-01-19 00:50:30.978113+07	user@gmail.com	POST	/barang	302
204	2023-01-19 00:50:31.040667+07	user@gmail.com	GET	/barang	200
205	2023-01-19 00:51:07.721003+07	user@gmail.com	POST	/barang	302
206	2023-01-19 00:51:07.728921+07	user@gmail.com	GET	/barang	200
207	2023-01-19 00:51:33.394369+07	user@gmail.com	GET	/barang/3	200
208	2023-01-19 00:51:36.598672+07	user@gmail.com	GET	/	200
209	2023-01-19 00:51:38.68747+07	user@gmail.com	GET	/barang	304
210	2023-01-19 00:51:40.308293+07	user@gmail.com	GET	/barang/1	200
211	2023-01-19 00:51:43.553294+07	user@gmail.com	GET	/	304
212	2023-01-19 00:51:45.011341+07	user@gmail.com	GET	/barang	304
213	2023-01-19 00:51:46.679918+07	user@gmail.com	GET	/barang/4	200
214	2023-01-19 00:51:57.237035+07	user@gmail.com	GET	/barang	304
215	2023-01-19 00:51:59.631723+07	user@gmail.com	GET	/barang/5	200
216	2023-01-19 00:52:06.533605+07	user@gmail.com	GET	/	304
217	2023-01-19 00:52:07.683504+07	user@gmail.com	GET	/barang	304
218	2023-01-19 00:52:35.570217+07	user@gmail.com	GET	/barangmasuk	200
219	2023-01-19 00:52:36.193538+07	user@gmail.com	GET	/barangkeluar	200
220	2023-01-19 00:52:37.32455+07	user@gmail.com	GET	/	304
221	2023-01-19 04:52:05.040381+07	admin@gmail.com	POST	/login	302
222	2023-01-19 04:52:05.233251+07	admin@gmail.com	GET	/	200
223	2023-01-19 04:52:08.11197+07	admin@gmail.com	GET	/barang	200
224	2023-01-19 04:52:21.808583+07	admin@gmail.com	GET	/barang/1	200
225	2023-01-19 04:52:28.487404+07	admin@gmail.com	GET	/barangmasuk	200
226	2023-01-19 04:52:29.30769+07	admin@gmail.com	GET	/barangkeluar	200
227	2023-01-19 04:52:36.085142+07	admin@gmail.com	GET	/users	200
228	2023-01-19 04:52:38.14466+07	admin@gmail.com	GET	/log	200
229	2023-01-19 04:52:40.9623+07	admin@gmail.com	GET	/barang	304
230	2023-01-19 04:53:03.272694+07	admin@gmail.com	GET	/barangmasuk	304
231	2023-01-19 04:53:04.757838+07	admin@gmail.com	GET	/barangkeluar	304
232	2023-01-19 04:53:06.584182+07	admin@gmail.com	GET	/users	304
233	2023-01-19 04:53:08.770426+07	admin@gmail.com	GET	/log	200
234	2023-01-19 04:53:12.346863+07	admin@gmail.com	GET	/barang	304
235	2023-01-19 04:54:43.88432+07	admin@gmail.com	POST	/barang	302
236	2023-01-19 04:54:43.945608+07	admin@gmail.com	GET	/barang	200
237	2023-01-19 04:56:06.994955+07	admin@gmail.com	POST	/barang	302
238	2023-01-19 04:56:07.003146+07	admin@gmail.com	GET	/barang	200
239	2023-01-19 04:56:16.536866+07	admin@gmail.com	PUT	/barang/6?_method=put	302
240	2023-01-19 04:56:16.543959+07	admin@gmail.com	GET	/barang	200
241	2023-01-19 04:56:49.427333+07	superadmin@gmail.com	POST	/login	302
242	2023-01-19 04:56:49.489484+07	superadmin@gmail.com	GET	/	200
243	2023-01-19 04:56:51.617851+07	superadmin@gmail.com	GET	/barang	200
244	2023-01-19 04:57:49.64424+07	superadmin@gmail.com	GET	/barang/5	200
245	2023-01-19 04:58:03.964842+07	superadmin@gmail.com	GET	/	304
246	2023-01-19 04:58:07.365406+07	superadmin@gmail.com	GET	/account	200
247	2023-01-19 04:58:11.581346+07	superadmin@gmail.com	GET	/barang	304
248	2023-01-19 04:58:29.625513+07	superadmin@gmail.com	PUT	/barang/7?_method=put	500
249	2023-01-19 05:02:35.943398+07	superadmin@gmail.com	POST	/login	302
250	2023-01-19 05:02:36.014038+07	superadmin@gmail.com	GET	/	200
251	2023-01-19 05:02:37.441092+07	superadmin@gmail.com	GET	/barang	304
252	2023-01-19 05:02:58.444417+07	superadmin@gmail.com	PUT	/barang/7?_method=put	200
253	2023-01-19 05:03:43.720994+07	superadmin@gmail.com	PUT	/barang/7?_method=put	200
254	2023-01-19 05:04:05.759344+07	superadmin@gmail.com	POST	/barang	200
255	2023-01-19 05:05:37.929696+07	superadmin@gmail.com	POST	/barang	302
256	2023-01-19 05:05:37.997255+07	superadmin@gmail.com	GET	/barang	200
257	2023-01-19 05:11:23.107965+07	superadmin@gmail.com	POST	/login	302
258	2023-01-19 05:11:23.28744+07	superadmin@gmail.com	GET	/	200
259	2023-01-19 05:11:25.997952+07	superadmin@gmail.com	GET	/barang	304
260	2023-01-19 05:11:41.336213+07	superadmin@gmail.com	PUT	/barang/8?_method=put	302
261	2023-01-19 05:11:41.398443+07	superadmin@gmail.com	GET	/barang	200
262	2023-01-19 05:12:41.263565+07	superadmin@gmail.com	PUT	/barang/8?_method=put	302
263	2023-01-19 05:12:41.325448+07	superadmin@gmail.com	GET	/barang	200
264	2023-01-19 05:12:46.456331+07	superadmin@gmail.com	PUT	/barang/8?_method=put	302
265	2023-01-19 05:12:46.464644+07	superadmin@gmail.com	GET	/barang	200
266	2023-01-19 05:12:46.519064+07	superadmin@gmail.com	GET	/uploads/SSGN981%20-%20Samsung%20Galaxy%20S23%20Ultra%205Gs.png	404
267	2023-01-19 05:12:56.011904+07	superadmin@gmail.com	PUT	/barang/8?_method=put	302
268	2023-01-19 05:12:56.019653+07	superadmin@gmail.com	GET	/barang	200
269	2023-01-19 05:13:22.982619+07	superadmin@gmail.com	GET	/barangmasuk	200
270	2023-01-19 05:13:26.049449+07	superadmin@gmail.com	GET	/barang	304
271	2023-01-19 05:15:46.893983+07	superadmin@gmail.com	GET	/barangmasuk	304
272	2023-01-19 05:18:20.36716+07	superadmin@gmail.com	POST	/barangmasuk	302
273	2023-01-19 05:18:20.434752+07	superadmin@gmail.com	GET	/barangmasuk	200
274	2023-01-19 05:18:27.261003+07	superadmin@gmail.com	GET	/barang	200
275	2023-01-19 05:18:29.935998+07	superadmin@gmail.com	GET	/barang/1	200
276	2023-01-19 05:18:33.222324+07	superadmin@gmail.com	GET	/barangmasuk	304
277	2023-01-19 05:18:38.051403+07	superadmin@gmail.com	GET	/barang	304
278	2023-01-19 05:18:41.08469+07	superadmin@gmail.com	GET	/barangmasuk	304
279	2023-01-19 05:18:43.641198+07	superadmin@gmail.com	GET	/barangkeluar	200
280	2023-01-19 05:19:07.275318+07	superadmin@gmail.com	POST	/barangkeluar	302
281	2023-01-19 05:19:07.284889+07	superadmin@gmail.com	GET	/barangkeluar	200
282	2023-01-19 05:19:09.969832+07	superadmin@gmail.com	GET	/barang	200
283	2023-01-19 05:19:12.120254+07	superadmin@gmail.com	GET	/barangmasuk	304
284	2023-01-19 05:19:16.769648+07	superadmin@gmail.com	GET	/barangkeluar	304
285	2023-01-19 05:19:54.071634+07	superadmin@gmail.com	POST	/barangkeluar	302
286	2023-01-19 05:19:54.080828+07	superadmin@gmail.com	GET	/barangkeluar	200
287	2023-01-19 05:19:56.632874+07	superadmin@gmail.com	GET	/barang	200
288	2023-01-19 05:19:59.465845+07	superadmin@gmail.com	GET	/barangkeluar	304
289	2023-01-19 05:20:10.664423+07	superadmin@gmail.com	POST	/barangkeluar	200
290	2023-01-19 05:20:14.156238+07	superadmin@gmail.com	GET	/barangmasuk	304
291	2023-01-19 05:20:16.884534+07	superadmin@gmail.com	POST	/barangmasuk/delete/2	200
292	2023-01-19 05:20:30.241168+07	superadmin@gmail.com	GET	/barangkeluar	200
293	2023-01-19 05:20:31.151732+07	superadmin@gmail.com	GET	/barangmasuk	304
294	2023-01-19 05:20:35.283768+07	superadmin@gmail.com	PUT	/barangmasuk/2?_method=put	200
295	2023-01-19 05:20:37.588717+07	superadmin@gmail.com	GET	/barang	304
296	2023-01-19 05:22:08.433604+07	superadmin@gmail.com	GET	/barangmasuk	304
297	2023-01-19 05:22:10.209127+07	superadmin@gmail.com	GET	/barangkeluar	304
298	2023-01-19 05:22:22.987102+07	superadmin@gmail.com	PUT	/barangkeluar/3?_method=put	302
299	2023-01-19 05:22:22.994532+07	superadmin@gmail.com	GET	/barangkeluar	200
300	2023-01-19 05:22:26.690124+07	superadmin@gmail.com	PUT	/barangkeluar/3?_method=put	302
301	2023-01-19 05:22:26.698871+07	superadmin@gmail.com	GET	/barangkeluar	200
302	2023-01-19 05:22:28.347182+07	superadmin@gmail.com	GET	/	200
303	2023-01-19 05:22:29.154682+07	superadmin@gmail.com	GET	/barang	200
304	2023-01-19 05:22:31.130501+07	superadmin@gmail.com	GET	/barangkeluar	304
305	2023-01-19 05:22:34.241921+07	superadmin@gmail.com	GET	/barangmasuk	304
306	2023-01-19 05:22:36.064954+07	superadmin@gmail.com	POST	/barangmasuk/delete/2	200
307	2023-01-19 05:22:42.198616+07	superadmin@gmail.com	PUT	/barangmasuk/2?_method=put	302
308	2023-01-19 05:22:42.205363+07	superadmin@gmail.com	GET	/barangmasuk	200
309	2023-01-19 05:22:47.820691+07	superadmin@gmail.com	PUT	/barangmasuk/2?_method=put	302
310	2023-01-19 05:22:47.828004+07	superadmin@gmail.com	GET	/barangmasuk	200
311	2023-01-19 05:22:52.268593+07	superadmin@gmail.com	PUT	/barangmasuk/2?_method=put	302
312	2023-01-19 05:22:52.275281+07	superadmin@gmail.com	GET	/barangmasuk	200
313	2023-01-19 05:22:53.243829+07	superadmin@gmail.com	GET	/barangkeluar	304
314	2023-01-19 05:22:55.814482+07	superadmin@gmail.com	GET	/barang	304
315	2023-01-19 05:22:57.332703+07	superadmin@gmail.com	GET	/barangkeluar	304
316	2023-01-19 05:23:00.711184+07	superadmin@gmail.com	PUT	/barangkeluar/3?_method=put	302
317	2023-01-19 05:23:00.719995+07	superadmin@gmail.com	GET	/barangkeluar	200
318	2023-01-19 05:23:18.350235+07	superadmin@gmail.com	PUT	/barangkeluar/3?_method=put	302
319	2023-01-19 05:23:18.360415+07	superadmin@gmail.com	GET	/barangkeluar	200
320	2023-01-19 05:23:26.696051+07	superadmin@gmail.com	GET	/	200
321	2023-01-19 05:23:29.305404+07	superadmin@gmail.com	GET	/barang	200
322	2023-01-19 05:23:37.867416+07	superadmin@gmail.com	GET	/barangkeluar	304
323	2023-01-19 05:23:39.996032+07	superadmin@gmail.com	GET	/barangmasuk	304
324	2023-01-19 05:23:40.741993+07	superadmin@gmail.com	GET	/barang	304
325	2023-01-19 05:23:43.578374+07	superadmin@gmail.com	GET	/	304
326	2023-01-19 05:23:45.671144+07	superadmin@gmail.com	GET	/users	200
327	2023-01-19 05:24:03.765803+07	superadmin@gmail.com	POST	/users	200
328	2023-01-19 05:24:14.083194+07	superadmin@gmail.com	PUT	/users/5?_method=put	200
329	2023-01-19 05:24:17.153826+07	superadmin@gmail.com	GET	/log	200
330	2023-01-19 05:24:18.309267+07	superadmin@gmail.com	GET	/barang	304
331	2023-01-19 05:24:28.802765+07	superadmin@gmail.com	GET	/barangkeluar	304
332	2023-01-19 05:24:29.59398+07	superadmin@gmail.com	GET	/users	200
333	2023-01-19 05:24:33.118089+07	superadmin@gmail.com	GET	/barang	304
334	2023-01-19 05:24:34.419308+07	superadmin@gmail.com	GET	/barangmasuk	304
335	2023-01-19 05:25:00.152002+07	superadmin@gmail.com	GET	/barangkeluar	304
336	2023-01-19 05:25:17.134102+07	superadmin@gmail.com	GET	/barangmasuk	304
337	2023-01-19 05:25:18.564846+07	superadmin@gmail.com	GET	/barang	304
338	2023-01-19 05:25:19.523757+07	superadmin@gmail.com	GET	/barangmasuk	304
339	2023-01-19 05:25:20.465877+07	superadmin@gmail.com	GET	/barangmasuk	304
340	2023-01-19 05:25:20.870215+07	superadmin@gmail.com	GET	/barangkeluar	304
341	2023-01-19 05:25:21.792779+07	superadmin@gmail.com	GET	/	304
342	2023-01-19 05:25:25.162699+07	superadmin@gmail.com	GET	/barang	304
343	2023-01-19 05:25:47.507736+07	superadmin@gmail.com	GET	/barang/1	200
344	2023-01-19 05:26:09.520829+07	superadmin@gmail.com	GET	/barang	304
345	2023-01-19 05:26:14.552497+07	superadmin@gmail.com	GET	/barang/1	304
346	2023-01-19 05:26:16.450691+07	superadmin@gmail.com	GET	/barang	304
347	2023-01-19 05:26:44.269788+07	user@gmail.com	POST	/login	302
348	2023-01-19 05:26:44.333326+07	user@gmail.com	GET	/	200
349	2023-01-19 05:26:47.110905+07	user@gmail.com	GET	/barangkeluar	200
350	2023-01-19 05:26:55.069049+07	user@gmail.com	POST	/barangkeluar	200
351	2023-01-19 05:27:03.485321+07	user@gmail.com	GET	/barangmasuk	200
352	2023-01-19 05:27:06.261357+07	user@gmail.com	GET	/barang	200
353	2023-01-19 05:27:08.216172+07	user@gmail.com	GET	/barang/1	200
354	2023-01-19 05:27:27.377005+07	user@gmail.com	GET	/barang	304
355	2023-01-19 05:27:28.445174+07	user@gmail.com	GET	/barangmasuk	304
356	2023-01-19 05:27:31.788684+07	user@gmail.com	GET	/barang	304
357	2023-01-19 05:27:37.724624+07	user@gmail.com	GET	/barangmasuk	304
358	2023-01-19 05:27:41.502325+07	user@gmail.com	GET	/barangkeluar	200
359	2023-01-19 05:27:46.724724+07	user@gmail.com	GET	/barangmasuk	304
360	2023-01-19 05:27:47.546491+07	user@gmail.com	GET	/barang	304
361	2023-01-19 05:27:55.908204+07	user@gmail.com	GET	/	304
362	2023-01-19 05:28:04.048451+07	user@gmail.com	GET	/barangmasuk	304
363	2023-01-19 05:28:06.037923+07	user@gmail.com	GET	/barangkeluar	304
364	2023-01-19 05:28:07.736745+07	user@gmail.com	GET	/	304
365	2023-01-19 05:28:13.375947+07	user@gmail.com	GET	/barangmasuk	304
366	2023-01-19 05:28:13.788644+07	user@gmail.com	GET	/barang	304
367	2023-01-19 05:28:42.738122+07	user@gmail.com	POST	/barang	200
368	2023-01-19 05:28:50.501214+07	user@gmail.com	GET	/account	200
369	2023-01-19 05:28:56.534675+07	user@gmail.com	PUT	/account/changepassword?_method=put	200
370	2023-01-19 05:29:04.985728+07	user@gmail.com	PUT	/account/changepassword?_method=put	200
371	2023-01-19 05:29:26.189394+07	user@gmail.com	POST	/login	302
372	2023-01-19 05:29:26.250273+07	user@gmail.com	GET	/	304
373	2023-01-19 05:29:28.18774+07	user@gmail.com	GET	/account	200
374	2023-01-19 05:29:47.199266+07	admin@gmail.com	POST	/login	302
375	2023-01-19 05:29:47.26113+07	admin@gmail.com	GET	/	200
376	2023-01-19 05:29:49.663928+07	admin@gmail.com	GET	/users	200
377	2023-01-19 05:29:58.65796+07	admin@gmail.com	GET	/account	200
378	2023-01-19 05:30:09.396186+07	admin@gmail.com	GET	/barang	200
379	2023-01-19 05:30:16.258709+07	admin@gmail.com	GET	/barangkeluar	200
380	2023-01-19 05:30:17.263464+07	admin@gmail.com	GET	/barangmasuk	200
381	2023-01-19 05:30:17.80624+07	admin@gmail.com	GET	/barangkeluar	304
382	2023-01-19 05:30:19.621702+07	admin@gmail.com	GET	/users	304
383	2023-01-19 05:30:27.213289+07	admin@gmail.com	POST	/users/resetpassword/5	200
384	2023-01-19 05:30:41.306842+07	usr@gmail.com	POST	/login	302
385	2023-01-19 05:30:41.366461+07	usr@gmail.com	GET	/	200
386	2023-01-19 05:30:43.671426+07	usr@gmail.com	GET	/account	200
387	2023-01-19 05:31:03.909106+07	admin@gmail.com	POST	/login	302
388	2023-01-19 05:31:03.919647+07	admin@gmail.com	GET	/	200
389	2023-01-19 05:31:05.58732+07	admin@gmail.com	GET	/log	200
390	2023-01-19 05:31:06.753344+07	admin@gmail.com	GET	/users	200
391	2023-01-19 05:31:11.620902+07	admin@gmail.com	POST	/users/resetpassword/5	200
392	2023-01-19 05:31:23.956995+07	usr@gmail.com	POST	/login	302
393	2023-01-19 05:31:24.02023+07	usr@gmail.com	GET	/	200
394	2023-01-19 05:31:27.761979+07	usr@gmail.com	GET	/barang	200
395	2023-01-19 05:31:32.271196+07	usr@gmail.com	GET	/barangmasuk	200
396	2023-01-19 05:31:34.666992+07	usr@gmail.com	GET	/barangkeluar	200
397	2023-01-19 05:31:45.635716+07	admin@gmail.com	POST	/login	302
398	2023-01-19 05:31:45.811959+07	admin@gmail.com	GET	/	200
399	2023-01-19 05:31:48.864377+07	admin@gmail.com	GET	/barang	200
400	2023-01-19 05:32:05.907881+07	admin@gmail.com	GET	/barangmasuk	200
401	2023-01-19 05:32:07.576669+07	admin@gmail.com	GET	/barangkeluar	200
402	2023-01-19 05:32:08.609365+07	admin@gmail.com	GET	/users	200
403	2023-01-19 05:32:09.781387+07	admin@gmail.com	GET	/log	200
404	2023-01-19 05:34:30.222723+07	admin@gmail.com	GET	/log	200
405	2023-01-19 05:34:32.201499+07	admin@gmail.com	GET	/barang	304
406	2023-01-19 05:34:45.366212+07	admin@gmail.com	POST	/barang/delete/8	302
407	2023-01-19 05:34:45.424954+07	admin@gmail.com	GET	/barang	200
408	2023-01-19 05:35:34.87647+07	admin@gmail.com	PUT	/barang/7?_method=put	200
409	2023-01-19 05:35:50.213595+07	admin@gmail.com	POST	/barang	200
410	2023-01-19 05:35:59.465604+07	admin@gmail.com	POST	/barang	200
411	2023-01-19 05:36:05.135723+07	admin@gmail.com	GET	/barang	200
412	2023-01-19 05:36:14.395894+07	admin@gmail.com	POST	/barang	200
413	2023-01-19 05:36:21.975114+07	admin@gmail.com	PUT	/barang/7?_method=put	200
414	2023-01-19 05:36:50.05447+07	admin@gmail.com	GET	/barangmasuk	200
415	2023-01-19 05:36:52.234128+07	admin@gmail.com	GET	/barangkeluar	200
416	2023-01-19 05:36:52.803499+07	admin@gmail.com	GET	/barangmasuk	304
417	2023-01-19 05:36:53.426833+07	admin@gmail.com	GET	/barang	200
418	2023-01-19 05:36:54.572824+07	admin@gmail.com	GET	/log	200
419	2023-01-19 05:37:02.310501+07	admin@gmail.com	GET	/users	304
420	2023-01-19 05:37:04.406699+07	admin@gmail.com	GET	/barang	304
421	2023-01-19 05:37:22.642474+07	admin@gmail.com	GET	/barang	304
422	2023-01-19 05:37:45.68557+07	admin@gmail.com	POST	/barang	200
423	2023-01-19 05:37:54.80306+07	admin@gmail.com	GET	/log	200
424	2023-01-19 05:37:56.64789+07	admin@gmail.com	GET	/barang	200
\.


--
-- Data for Name: masuk; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.masuk (idmasuk, idbarang, tanggal, keterangan, qty, namabarang_m, penginput, kodebarang_m) FROM stdin;
2	1	2023-01-19 05:18:20.362973+07	Beli di  https://www.tokopedia.com/gaminglaptopid/asus-rog-flow-z13-gz301ze-i9-12900h-rtx3050ti-16gb-1tb-120hz-w11-ohs-laptop	3	Asus ROG FLOW Z13	superadmin@gmail.com	ADDE1324
\.


--
-- Data for Name: stock; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.stock (idbarang, namabarang, deskripsi, stock, image, penginput, kodebarang) FROM stdin;
2	Asus ROG Zephyrus Duo 16	Laptop gaming dengan layar kedua.	1	1674064027186.png	user@gmail.com	ACDB1452
3	Apple MacBook Pro M1 Max 16	Laptop apple.	1	1674064184226.jpeg	user@gmail.com	ACVE3142
4	Acer Predator Triton 300 SE	Laptop gaming layar 14 inci.	5	1674064230911.jpg	user@gmail.com	VWVE1425
5	iPhone 14 Pro Max	Handphone apple.	3	1674064267657.jpg	user@gmail.com	VWEE2311
7	Realme 10 Pro Plus	Handphone realme.	3	1674078966925.jpg	admin@gmail.com	RLMXP8042
6	Alienware 34 Curved QD OLED Monitor	Monitor gaming.	1	1674078883777.png	admin@gmail.com	ALCM3917
1	Asus ROG FLOW Z13	Laptop gaming 2-in-1.	0	1674063981511.png	user@gmail.com	ADDE1324
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, email, password, role) FROM stdin;
1	superadmin@email.com	$2b$10$ShX12oaedeoq/3S1PIiqm.QPzPKeU4a8wHONDX7PAnAsiz1J4JtVe	superadmin
2	user@email.com	$2b$10$tN7/ZakujFxMF/MWGfQz2.LqpWQEmKX0V/JnLQNFhUahh1RDoV0Cq	user
3	admin@email.com	$2b$10$8aqj6ZiZzCc.4GB0Z5xtfuKHQB44pnc0M.x.qrBqdoIZnwq1c0HhK	admin
5	usr@email.com	$2b$10$SC2Qx.OBxVDjV5iCi3EVlOYQwFtPsIz9WawD4MQ./cbO2ZRFffZ9C	user
\.


--
-- Name: keluar_idkeluar_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.keluar_idkeluar_seq', 3, true);


--
-- Name: log_idlog_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.log_idlog_seq', 424, true);


--
-- Name: masuk_idmasuk_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.masuk_idmasuk_seq', 2, true);


--
-- Name: stock_idbarang_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.stock_idbarang_seq', 8, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 6, true);


--
-- Name: keluar keluar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keluar
    ADD CONSTRAINT keluar_pkey PRIMARY KEY (idkeluar);


--
-- Name: log log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.log
    ADD CONSTRAINT log_pkey PRIMARY KEY (idlog);


--
-- Name: masuk masuk_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.masuk
    ADD CONSTRAINT masuk_pkey PRIMARY KEY (idmasuk);


--
-- Name: stock stock_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock
    ADD CONSTRAINT stock_pkey PRIMARY KEY (idbarang);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

