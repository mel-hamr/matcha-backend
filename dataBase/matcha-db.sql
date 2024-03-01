--
-- PostgreSQL database dump
--

-- Dumped from database version 13.14 (Debian 13.14-1.pgdg120+2)
-- Dumped by pg_dump version 15.1

-- Started on 2024-03-01 17:45:14 +01

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
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: mel-hamr
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO "mel-hamr";

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 209 (class 1259 OID 41025)
-- Name: conversation; Type: TABLE; Schema: public; Owner: mel-hamr
--

CREATE TABLE public.conversation (
    id integer NOT NULL,
    participant_a integer,
    participant_b integer,
    last_message character varying(255),
    date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    unread_messages integer DEFAULT 0,
    is_read boolean DEFAULT false
);


ALTER TABLE public.conversation OWNER TO "mel-hamr";

--
-- TOC entry 208 (class 1259 OID 41023)
-- Name: conversation_id_seq; Type: SEQUENCE; Schema: public; Owner: mel-hamr
--

CREATE SEQUENCE public.conversation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.conversation_id_seq OWNER TO "mel-hamr";

--
-- TOC entry 3106 (class 0 OID 0)
-- Dependencies: 208
-- Name: conversation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mel-hamr
--

ALTER SEQUENCE public.conversation_id_seq OWNED BY public.conversation.id;


--
-- TOC entry 211 (class 1259 OID 41044)
-- Name: message; Type: TABLE; Schema: public; Owner: mel-hamr
--

CREATE TABLE public.message (
    id integer NOT NULL,
    conversation_id integer,
    sender character varying(255),
    text character varying(255),
    date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.message OWNER TO "mel-hamr";

--
-- TOC entry 210 (class 1259 OID 41042)
-- Name: message_id_seq; Type: SEQUENCE; Schema: public; Owner: mel-hamr
--

CREATE SEQUENCE public.message_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.message_id_seq OWNER TO "mel-hamr";

--
-- TOC entry 3107 (class 0 OID 0)
-- Dependencies: 210
-- Name: message_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mel-hamr
--

ALTER SEQUENCE public.message_id_seq OWNED BY public.message.id;


--
-- TOC entry 213 (class 1259 OID 49195)
-- Name: notifacation; Type: TABLE; Schema: public; Owner: mel-hamr
--

CREATE TABLE public.notifacation (
    id integer NOT NULL,
    user_id integer,
    type character varying(255),
    text character varying(255),
    is_read boolean,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.notifacation OWNER TO "mel-hamr";

--
-- TOC entry 212 (class 1259 OID 49193)
-- Name: notifacation_id_seq; Type: SEQUENCE; Schema: public; Owner: mel-hamr
--

CREATE SEQUENCE public.notifacation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notifacation_id_seq OWNER TO "mel-hamr";

--
-- TOC entry 3108 (class 0 OID 0)
-- Dependencies: 212
-- Name: notifacation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mel-hamr
--

ALTER SEQUENCE public.notifacation_id_seq OWNED BY public.notifacation.id;


--
-- TOC entry 205 (class 1259 OID 40997)
-- Name: sessions; Type: TABLE; Schema: public; Owner: mel-hamr
--

CREATE TABLE public.sessions (
    id integer NOT NULL,
    user_id integer,
    username character varying(255),
    valid boolean
);


ALTER TABLE public.sessions OWNER TO "mel-hamr";

--
-- TOC entry 204 (class 1259 OID 40995)
-- Name: sessions_id_seq; Type: SEQUENCE; Schema: public; Owner: mel-hamr
--

CREATE SEQUENCE public.sessions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sessions_id_seq OWNER TO "mel-hamr";

--
-- TOC entry 3109 (class 0 OID 0)
-- Dependencies: 204
-- Name: sessions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mel-hamr
--

ALTER SEQUENCE public.sessions_id_seq OWNED BY public.sessions.id;


--
-- TOC entry 207 (class 1259 OID 41010)
-- Name: user_verification; Type: TABLE; Schema: public; Owner: mel-hamr
--

CREATE TABLE public.user_verification (
    id integer NOT NULL,
    user_id integer,
    unique_string character varying(255),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    expires_at timestamp without time zone DEFAULT (CURRENT_TIMESTAMP + '1 day'::interval)
);


ALTER TABLE public.user_verification OWNER TO "mel-hamr";

--
-- TOC entry 206 (class 1259 OID 41008)
-- Name: user_verification_id_seq; Type: SEQUENCE; Schema: public; Owner: mel-hamr
--

CREATE SEQUENCE public.user_verification_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_verification_id_seq OWNER TO "mel-hamr";

--
-- TOC entry 3110 (class 0 OID 0)
-- Dependencies: 206
-- Name: user_verification_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mel-hamr
--

ALTER SEQUENCE public.user_verification_id_seq OWNED BY public.user_verification.id;


--
-- TOC entry 201 (class 1259 OID 40964)
-- Name: users; Type: TABLE; Schema: public; Owner: mel-hamr
--

CREATE TABLE public.users (
    id integer NOT NULL,
    email_address character varying(255) NOT NULL,
    last_name character varying(255) NOT NULL,
    first_name character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    username character varying(255) NOT NULL,
    gender character varying(255),
    sexual_preference character varying(255),
    biography character varying(255),
    images character varying(255)[],
    tags character varying(255)[],
    fame_rating integer[],
    latitude character varying(255),
    longitude character varying(255),
    verified boolean,
    is_online boolean,
    profile_completion_status boolean,
    profile_location character varying(255),
    birthdate date
);


ALTER TABLE public.users OWNER TO "mel-hamr";

--
-- TOC entry 200 (class 1259 OID 40962)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: mel-hamr
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO "mel-hamr";

--
-- TOC entry 3111 (class 0 OID 0)
-- Dependencies: 200
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mel-hamr
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 203 (class 1259 OID 40977)
-- Name: views; Type: TABLE; Schema: public; Owner: mel-hamr
--

CREATE TABLE public.views (
    id integer NOT NULL,
    user_id integer,
    view_id integer
);


ALTER TABLE public.views OWNER TO "mel-hamr";

--
-- TOC entry 202 (class 1259 OID 40975)
-- Name: views_id_seq; Type: SEQUENCE; Schema: public; Owner: mel-hamr
--

CREATE SEQUENCE public.views_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.views_id_seq OWNER TO "mel-hamr";

--
-- TOC entry 3112 (class 0 OID 0)
-- Dependencies: 202
-- Name: views_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mel-hamr
--

ALTER SEQUENCE public.views_id_seq OWNED BY public.views.id;


--
-- TOC entry 2922 (class 2604 OID 41028)
-- Name: conversation id; Type: DEFAULT; Schema: public; Owner: mel-hamr
--

ALTER TABLE ONLY public.conversation ALTER COLUMN id SET DEFAULT nextval('public.conversation_id_seq'::regclass);


--
-- TOC entry 2926 (class 2604 OID 41047)
-- Name: message id; Type: DEFAULT; Schema: public; Owner: mel-hamr
--

ALTER TABLE ONLY public.message ALTER COLUMN id SET DEFAULT nextval('public.message_id_seq'::regclass);


--
-- TOC entry 2928 (class 2604 OID 49198)
-- Name: notifacation id; Type: DEFAULT; Schema: public; Owner: mel-hamr
--

ALTER TABLE ONLY public.notifacation ALTER COLUMN id SET DEFAULT nextval('public.notifacation_id_seq'::regclass);


--
-- TOC entry 2918 (class 2604 OID 41000)
-- Name: sessions id; Type: DEFAULT; Schema: public; Owner: mel-hamr
--

ALTER TABLE ONLY public.sessions ALTER COLUMN id SET DEFAULT nextval('public.sessions_id_seq'::regclass);


--
-- TOC entry 2919 (class 2604 OID 41013)
-- Name: user_verification id; Type: DEFAULT; Schema: public; Owner: mel-hamr
--

ALTER TABLE ONLY public.user_verification ALTER COLUMN id SET DEFAULT nextval('public.user_verification_id_seq'::regclass);


--
-- TOC entry 2916 (class 2604 OID 40967)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: mel-hamr
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 2917 (class 2604 OID 40980)
-- Name: views id; Type: DEFAULT; Schema: public; Owner: mel-hamr
--

ALTER TABLE ONLY public.views ALTER COLUMN id SET DEFAULT nextval('public.views_id_seq'::regclass);


--
-- TOC entry 3095 (class 0 OID 41025)
-- Dependencies: 209
-- Data for Name: conversation; Type: TABLE DATA; Schema: public; Owner: mel-hamr
--

INSERT INTO public.conversation (id, participant_a, participant_b, last_message, date, unread_messages, is_read) VALUES (3, 3, 6, 'In the name of truth and justice!', '2023-11-21 10:45:16.175134', NULL, false);
INSERT INTO public.conversation (id, participant_a, participant_b, last_message, date, unread_messages, is_read) VALUES (4, 4, 7, 'Genius, billionaire, playboy, philanthropist reporting in!', '2023-11-21 10:45:16.175134', NULL, false);
INSERT INTO public.conversation (id, participant_a, participant_b, last_message, date, unread_messages, is_read) VALUES (6, 7, 9, 'Avengers, assemble! We have a mission.', '2023-11-21 10:45:16.175134', NULL, false);
INSERT INTO public.conversation (id, participant_a, participant_b, last_message, date, unread_messages, is_read) VALUES (8, 9, 2, 'By Odin’s beard! Lightning and thunder on the horizon.', '2023-11-21 10:45:16.175134', NULL, false);
INSERT INTO public.conversation (id, participant_a, participant_b, last_message, date, unread_messages, is_read) VALUES (2, 2, 5, 'vcx', '2023-11-21 10:45:16.175134', NULL, false);
INSERT INTO public.conversation (id, participant_a, participant_b, last_message, date, unread_messages, is_read) VALUES (5, 6, 8, 'Hello friend', '2023-11-21 10:45:16.175134', NULL, false);
INSERT INTO public.conversation (id, participant_a, participant_b, last_message, date, unread_messages, is_read) VALUES (1, 1, 4, 'fdsafds', '2023-11-21 10:45:16.175134', 53, false);
INSERT INTO public.conversation (id, participant_a, participant_b, last_message, date, unread_messages, is_read) VALUES (7, 8, 1, '?', '2023-11-21 10:45:16.175134', 51, false);


--
-- TOC entry 3097 (class 0 OID 41044)
-- Dependencies: 211
-- Data for Name: message; Type: TABLE DATA; Schema: public; Owner: mel-hamr
--

INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (112, 1, '1', 'hello', '2023-11-22 11:50:06');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (113, 1, '1', 'issam', '2023-11-22 11:56:32.829');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (114, 1, '1', 'fads', '2023-11-22 12:01:17.801');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (115, 1, '1', '54', '2023-11-22 12:01:20.732');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (116, 1, '1', '47', '2023-11-22 12:01:22.852');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (117, 1, '1', 'gtrg', '2023-11-22 12:01:24.604');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (118, 1, '1', 'gdf', '2023-11-22 12:01:25.964');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (119, 1, '1', 'gdfs', '2023-11-22 12:01:27.108');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (120, 1, '1', 'gdsgdfs', '2023-11-22 12:01:28.468');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (121, 1, '1', 'gdfsgdsdfg', '2023-11-22 12:01:30.276');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (122, 1, '1', 'gdfdgs', '2023-11-22 12:01:32.06');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (123, 1, '1', 'gdfsgdf', '2023-11-22 12:01:34.388');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (124, 1, '1', '@', '2023-11-22 15:37:04.248');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (125, 1, '1', '#', '2023-11-22 15:42:35.758');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (126, 1, '1', 'fd', '2023-11-22 15:47:30.407');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (127, 1, '1', '3', '2023-11-22 15:48:13.255');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (128, 1, '1', 'fds', '2023-11-22 15:49:35.936');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (129, 1, '1', '322', '2023-11-22 15:50:03.934');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (130, 1, '1', 'hello', '2023-11-22 15:51:18.248');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (131, 1, '1', 'fds', '2023-11-22 15:51:42.049');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (132, 1, '1', 'fds', '2023-11-22 15:52:07.008');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (133, 1, '1', 'fds', '2023-11-22 15:52:23.598');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (134, 1, '1', '4', '2023-11-22 15:52:52.829');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (135, 1, '1', 'helo', '2023-11-22 15:54:41.428');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (136, 1, '1', 'helo', '2023-11-22 15:55:00.268');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (137, 1, '1', '56', '2023-11-22 15:58:00.494');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (138, 1, '1', '3', '2023-11-22 16:01:00.726');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (139, 1, '1', 'vvvvvv', '2023-11-22 16:40:43.023');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (140, 1, '1', 'fgfgfgfgfg', '2023-11-22 16:40:53.758');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (141, 1, '1', 'rrrrrrrrr', '2023-11-22 16:41:00.597');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (142, 1, '1', 'fd', '2023-11-22 17:07:11.236');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (143, 1, '1', 'vvvv', '2023-11-22 18:22:29.918');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (144, 1, '1', 'xvxvxv', '2023-11-22 18:22:33.177');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (145, 1, '1', 'xvxvxvxvxvxvxvxv', '2023-11-22 18:22:36.329');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (146, 1, '1', 'cfcfcfcfcfcfcfcfcf', '2023-11-22 18:22:40.921');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (147, 1, '1', 'ds', '2023-11-24 10:38:04.242');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (148, 1, '1', 'Hello', '2023-11-24 15:18:23.2');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (149, 1, '1', 'f;as''dfml''kjadsl''fjl''adsjfkl''adjskl''fjakls''djfkl''adjs''flkjads;''kjfads''jf''aj''fjads''jj''l''jkl''fjl'';jadsadsfasf', '2023-11-24 16:17:42.871');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (150, 1, '1', 'gdsgds', '2023-12-05 15:11:13.286');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (151, 1, '1', 'hjkhfds', '2023-12-05 15:34:10.198');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (152, 1, '1', 'helllo', '2023-12-05 15:34:30.396');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (153, 1, '1', 'w', '2023-12-07 18:06:42.573');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (154, 1, '1', 'tws', '2023-12-07 18:13:52.093');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (155, 1, '1', 'Hello', '2023-12-08 14:38:25.37');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (156, 1, '1', 'Test', '2023-12-08 14:40:42.026');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (157, 1, '1', 'hello', '2023-12-08 15:13:17.305');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (158, 1, '1', 'Hello', '2023-12-08 15:13:54.934');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (159, 1, '4', '5', '2023-12-08 15:17:07.508');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (160, 1, '4', 'hello4', '2023-12-08 15:18:58.461');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (161, 1, '1', '7', '2023-12-08 15:19:13.947');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (162, 1, '1', '55', '2023-12-08 15:19:38.05');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (163, 1, '4', 'yes', '2023-12-08 15:19:45.346');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (164, 1, '1', 'Test123', '2023-12-08 15:30:16.353');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (165, 1, '1', '🎁', '2023-12-08 16:03:12.625');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (166, 1, '1', 'Hello', '2023-12-12 13:31:24.018');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (167, 2, '2', 'vcx', '2023-12-12 13:31:36.633');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (168, 1, '1', 'fd', '2023-12-12 14:54:05.102');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (169, 1, '4', '123e', '2023-12-12 14:54:15.004');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (170, 1, '1', 'fefe', '2023-12-12 14:54:18.258');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (171, 1, '4', '🎁', '2023-12-12 14:54:32');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (172, 5, '8', 'Hello friend', '2023-12-14 11:05:58.929');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (173, 1, '1', 'fds', '2023-12-14 11:08:24.327');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (174, 7, '1', 'fdsa', '2023-12-14 11:11:51.168');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (175, 7, '8', 'he', '2023-12-14 11:12:06.823');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (176, 7, '1', 'd', '2023-12-14 11:12:53.543');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (177, 7, '8', 'e', '2023-12-14 11:13:05.033');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (178, 7, '8', 'fdsr', '2023-12-14 11:16:18.935');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (179, 7, '8', 'df', '2023-12-14 11:17:44.901');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (180, 7, '1', 'hello', '2023-12-14 11:23:41.203');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (181, 7, '8', 'hello', '2023-12-14 11:23:56.731');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (182, 7, '8', 'hi', '2023-12-14 11:24:06.122');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (183, 7, '8', 'ok', '2023-12-14 11:24:11.082');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (184, 7, '1', 'ok ok', '2023-12-14 11:24:19.292');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (185, 7, '8', 'He', '2023-12-14 11:24:51.394');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (186, 7, '1', 'hi thor', '2023-12-14 11:25:39.749');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (187, 7, '8', 'hi ', '2023-12-14 11:25:53.53');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (188, 7, '8', 'Hello', '2023-12-14 11:26:54.233');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (189, 7, '8', 'Hello', '2023-12-14 11:27:06.097');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (191, 7, '1', '', '2023-12-14 16:47:36.682');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (190, 7, '1', '😀😀😀😀😀😀😀😀😀😀😀', '2023-12-14 16:47:36.677');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (192, 7, '1', '', '2023-12-14 16:47:39.888');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (193, 1, '1', '😡😡😃😀', '2023-12-14 16:48:37.046');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (194, 1, '1', '', '2023-12-14 16:57:13.281');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (195, 1, '1', '😀😀🤣🤣😡😃', '2023-12-14 17:10:11.271');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (196, 1, '1', '😃😃😃😃😡🤣🤣😃😀😃🤣😡😡😡😡🤣😃🤣', '2023-12-14 17:25:56.858');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (197, 7, '1', 'fd', '2023-12-14 17:26:58.622');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (198, 7, '8', '?', '2023-12-14 17:28:24.428');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (199, 7, '1', '9', '2023-12-14 17:28:33.889');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (200, 7, '1', '44', '2023-12-14 17:28:42.221');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (201, 7, '1', 'wq', '2023-12-14 17:34:48.389');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (202, 1, '1', 'fd', '2023-12-14 17:39:18.443');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (203, 7, '1', '32', '2023-12-14 17:53:35.866');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (204, 7, '1', '3', '2023-12-14 18:11:04.926');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (205, 1, '1', 'fd', '2023-12-14 18:11:59.847');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (206, 7, '1', 'e', '2023-12-14 18:12:10.798');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (207, 7, '1', '3', '2023-12-14 18:14:02.743');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (208, 7, '1', '23', '2023-12-14 18:14:52.491');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (209, 7, '1', '8', '2023-12-14 18:15:00.101');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (210, 1, '1', '😀😃', '2023-12-15 10:18:08.115');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (211, 7, '1', 'f', '2023-12-15 10:24:38.347');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (212, 7, '1', 'fd', '2023-12-15 10:24:46.895');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (213, 7, '1', 'afd', '2023-12-15 10:24:51.287');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (214, 7, '1', '8', '2023-12-15 10:25:01.335');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (215, 1, '1', 'fd', '2023-12-15 10:45:47.718');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (216, 1, '1', 'd', '2023-12-15 10:48:25.805');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (217, 1, '1', 'fd', '2023-12-15 10:48:42.629');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (218, 1, '1', 'f', '2023-12-15 10:48:57.877');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (219, 1, '1', 'fd', '2023-12-15 10:49:34.165');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (220, 1, '1', '8', '2023-12-15 10:50:51.965');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (221, 1, '1', '8', '2023-12-15 10:51:06.829');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (222, 1, '1', 'fd', '2023-12-15 10:51:26.412');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (223, 1, '1', '4e', '2023-12-15 10:51:30.748');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (224, 1, '1', 'Hello', '2023-12-15 10:51:39.54');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (225, 1, '1', 'HEllo', '2023-12-15 10:57:56.55');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (226, 1, '1', 'ff', '2023-12-15 10:58:21.639');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (227, 7, '1', 'ffr', '2023-12-15 10:58:30.907');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (228, 7, '1', 'dgfd', '2023-12-15 10:58:50.051');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (229, 7, '1', 'gfdgds', '2023-12-15 10:59:26.875');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (230, 7, '1', 'gfdgfdsd', '2023-12-15 10:59:29.843');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (231, 7, '1', 'gfds', '2023-12-15 10:59:36.299');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (232, 7, '1', 'gdsg', '2023-12-15 10:59:38.531');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (233, 7, '1', 'gfgfds', '2023-12-15 10:59:42.259');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (234, 7, '1', '43', '2023-12-15 10:59:46.894');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (235, 7, '1', 'g', '2023-12-15 10:59:58.083');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (236, 7, '1', 'gfd', '2023-12-15 11:00:03.059');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (237, 1, '1', 'Hel', '2023-12-15 11:02:19.291');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (238, 1, '1', 'fd', '2023-12-15 11:02:31.035');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (239, 7, '1', '32', '2023-12-15 11:02:38.339');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (240, 7, '1', 'r', '2023-12-15 11:03:00.267');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (241, 7, '1', 'gfd', '2023-12-15 11:03:14.107');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (242, 7, '1', 'gfd', '2023-12-15 11:03:47.235');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (243, 7, '1', 'jgh', '2023-12-15 11:03:51.003');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (244, 7, '1', 'jgh', '2023-12-15 11:03:55.059');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (245, 7, '1', 'gf', '2023-12-15 11:04:08.091');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (246, 7, '1', '3', '2023-12-15 11:04:12.946');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (247, 1, '1', 'tr', '2023-12-15 11:05:34.667');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (248, 1, '1', 'fd', '2023-12-15 11:20:09.164');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (249, 1, '1', 'ddd', '2023-12-15 11:20:30.883');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (250, 1, '1', 'fd', '2023-12-15 11:21:07.793');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (251, 7, '1', 'fd', '2023-12-15 11:22:40.537');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (252, 7, '1', 'ew', '2023-12-15 11:22:45.217');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (253, 7, '1', '2', '2023-12-15 11:22:47.785');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (254, 7, '1', '4', '2023-12-15 11:22:49.937');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (255, 1, '1', '😀😃', '2023-12-15 11:23:56.012');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (256, 1, '1', 'fd', '2023-12-15 11:28:02.441');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (257, 1, '1', 's', '2023-12-15 11:28:12.835');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (258, 1, '1', 'd', '2023-12-15 11:28:28.699');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (259, 1, '1', 'gf', '2023-12-15 12:34:16.344');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (260, 7, '8', 'f', '2023-12-15 12:34:20.867');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (261, 1, '1', 'dfd', '2023-12-15 13:22:50.467');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (262, 1, '1', 'aa', '2023-12-15 13:22:56.385');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (263, 1, '1', 'f', '2023-12-15 13:23:03.593');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (264, 1, '1', '😃😃', '2023-12-15 13:23:06.392');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (265, 1, '1', 'ls', '2023-12-15 13:41:56.503');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (266, 7, '8', 'ls', '2023-12-15 13:42:12.311');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (267, 1, '1', 'l', '2023-12-15 13:42:27.854');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (268, 1, '1', 'ok', '2023-12-15 13:43:06.326');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (269, 7, '8', '?', '2023-12-15 13:43:14.783');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (270, 7, '8', 'b', '2023-12-15 13:43:21.862');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (271, 7, '1', 'hi', '2023-12-15 13:43:35.214');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (272, 7, '8', 'hello', '2023-12-15 13:43:41.638');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (273, 7, '1', 'klndskl''nfnlubj ', '2023-12-15 13:44:03.263');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (274, 7, '1', 'df', '2023-12-15 13:45:31.383');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (275, 7, '1', 'gfds', '2023-12-15 13:45:33.095');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (276, 7, '1', 'gds', '2023-12-15 13:45:34.983');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (277, 7, '1', 'dfghjkl;''', '2023-12-19 19:26:34.719');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (278, 1, '1', '🤗', '2023-12-19 19:58:09.027');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (279, 1, '1', '🤭🤭🤭😙', '2023-12-19 19:58:20.975');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (280, 1, '1', '😛', '2023-12-19 19:58:57.291');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (281, 1, '1', '😚😚😚😉😉😄😄😱😱😱😂😂😘😙😁😁😁😁😁🥰🥰🥰🥰🥰😛😛😛😛😛🤣🤭', '2023-12-19 20:18:19.187');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (282, 1, '1', '😙😙😙😊😚😚😚😉😉😄😄', '2023-12-19 20:18:51.552');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (283, 1, '1', '', '2023-12-19 20:18:51.809');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (284, 1, '1', '🤣🤣🤣🤣', '2023-12-19 20:18:56.63');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (285, 1, '1', '😙😙😙😙☺️☺️😍😍😍🤣🤣🤣', '2023-12-19 20:20:18.527');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (286, 1, '1', '🤪😘🙂😅', '2023-12-19 20:20:23.558');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (287, 1, '1', '', '2023-12-19 20:20:23.737');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (288, 1, '1', '😇😇😇😇😇😆😆😆😆😆', '2023-12-19 20:28:50.127');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (289, 1, '1', '🫠🫠🫠🫠🫠🫠', '2023-12-19 20:28:53.619');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (290, 1, '1', '😊😊😊😊😊😊😊😊😊', '2023-12-19 20:29:57.987');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (291, 1, '1', '😊😊😊😊😊', '2023-12-19 20:30:13.069');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (292, 1, '1', '🤩🤩🤩', '2023-12-19 20:30:16.619');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (293, 1, '1', '😊😊😊😊😊', '2023-12-19 20:32:42.83');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (294, 1, '1', '😉😉😉😉', '2023-12-19 20:33:27.798');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (295, 1, '1', '😊😊😊😊😉😉', '2023-12-19 20:34:09.911');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (296, 1, '1', '🫠🫠🫠', '2023-12-19 20:35:04.989');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (297, 1, '1', '😃😃😃😃', '2023-12-19 20:35:09.907');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (298, 1, '1', '', '2023-12-19 20:35:10.143');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (299, 1, '1', '😉😉😉🫠🫠🫠🫠🫠🫠', '2023-12-19 20:36:31.192');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (300, 1, '1', '😉😉😉😉', '2023-12-19 20:38:55.635');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (301, 7, '8', 'Hello', '2023-12-20 12:12:55.253');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (302, 1, '1', 'wach', '2023-12-20 12:13:01.517');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (303, 1, '1', '🚷📵📵🥦☪️☪️', '2023-12-20 15:37:23.837');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (304, 1, '1', '🙂😙😙🥰😃😃😃😃😃😃😃😃😃', '2023-12-21 18:09:03.059');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (305, 1, '1', 'Hi', '2023-12-23 14:31:01.178');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (306, 7, '1', '1', '2023-12-23 14:31:13.066');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (307, 7, '8', '2', '2023-12-23 14:31:16.866');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (308, 7, '1', '3', '2023-12-23 14:31:20.954');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (309, 7, '8', '4', '2023-12-23 14:31:25.018');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (310, 7, '1', '5', '2023-12-23 14:31:29.754');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (311, 7, '8', '6', '2023-12-23 14:31:34.346');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (312, 7, '1', '😃', '2023-12-23 14:31:41.906');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (313, 1, '1', 'fdsafds', '2023-12-23 14:54:56.366');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (314, 7, '1', 'hello', '2023-12-23 14:55:17.114');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (315, 7, '8', 'fds', '2023-12-23 14:55:22.045');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (316, 7, '1', 'hr', '2024-01-08 10:31:45.254');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (317, 7, '8', '22', '2024-01-08 10:31:50.389');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (318, 7, '1', 'fd', '2024-01-08 10:35:39.614');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (319, 7, '1', 'sdacadc', '2024-01-12 16:36:18.304');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (320, 7, '1', 'hjlhj', '2024-01-12 16:36:41.799');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (321, 7, '8', 'Hello', '2024-01-15 10:43:30.596');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (322, 7, '8', 'how are you', '2024-01-15 10:43:44.07');
INSERT INTO public.message (id, conversation_id, sender, text, date) VALUES (323, 7, '8', '?', '2024-01-15 10:44:02.11');


--
-- TOC entry 3099 (class 0 OID 49195)
-- Dependencies: 213
-- Data for Name: notifacation; Type: TABLE DATA; Schema: public; Owner: mel-hamr
--

INSERT INTO public.notifacation (id, user_id, type, text, is_read, created_at) VALUES (1, 1, 'view', 'Thor viewd your profile', true, '2024-02-14 00:00:00+00');
INSERT INTO public.notifacation (id, user_id, type, text, is_read, created_at) VALUES (2, 1, 'like', 'Thor Like your profile', true, '2024-02-14 00:00:00+00');


--
-- TOC entry 3091 (class 0 OID 40997)
-- Dependencies: 205
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: mel-hamr
--

INSERT INTO public.sessions (id, user_id, username, valid) VALUES (145, 1, 'Spiderman', true);
INSERT INTO public.sessions (id, user_id, username, valid) VALUES (146, 1, 'Spiderman', true);
INSERT INTO public.sessions (id, user_id, username, valid) VALUES (147, 1, 'Spiderman', true);
INSERT INTO public.sessions (id, user_id, username, valid) VALUES (148, 1, 'Spiderman', true);
INSERT INTO public.sessions (id, user_id, username, valid) VALUES (150, 1, 'Spiderman', true);
INSERT INTO public.sessions (id, user_id, username, valid) VALUES (151, 1, 'Spiderman', true);
INSERT INTO public.sessions (id, user_id, username, valid) VALUES (149, 1, 'Spiderman', true);
INSERT INTO public.sessions (id, user_id, username, valid) VALUES (152, 1, 'Spiderman', true);
INSERT INTO public.sessions (id, user_id, username, valid) VALUES (153, 1, 'Spiderman', true);
INSERT INTO public.sessions (id, user_id, username, valid) VALUES (154, 1, 'Spiderman', true);
INSERT INTO public.sessions (id, user_id, username, valid) VALUES (155, 1, 'Spiderman', true);
INSERT INTO public.sessions (id, user_id, username, valid) VALUES (156, 1, 'Spiderman', true);
INSERT INTO public.sessions (id, user_id, username, valid) VALUES (157, 1, 'Spiderman', true);
INSERT INTO public.sessions (id, user_id, username, valid) VALUES (158, 1, 'Spiderman', true);
INSERT INTO public.sessions (id, user_id, username, valid) VALUES (159, 1, 'Spiderman', true);
INSERT INTO public.sessions (id, user_id, username, valid) VALUES (160, 1, 'Spiderman', true);
INSERT INTO public.sessions (id, user_id, username, valid) VALUES (161, 1, 'Spiderman', true);
INSERT INTO public.sessions (id, user_id, username, valid) VALUES (162, 1, 'Spiderman', true);
INSERT INTO public.sessions (id, user_id, username, valid) VALUES (163, 1, 'Spiderman', true);
INSERT INTO public.sessions (id, user_id, username, valid) VALUES (164, 1, 'Spiderman', true);
INSERT INTO public.sessions (id, user_id, username, valid) VALUES (165, 1, 'Spiderman', true);
INSERT INTO public.sessions (id, user_id, username, valid) VALUES (166, 1, 'Spiderman', true);
INSERT INTO public.sessions (id, user_id, username, valid) VALUES (167, 1, 'Spiderman', true);
INSERT INTO public.sessions (id, user_id, username, valid) VALUES (168, 1, 'Spiderman', true);
INSERT INTO public.sessions (id, user_id, username, valid) VALUES (169, 1, 'Spiderman', true);
INSERT INTO public.sessions (id, user_id, username, valid) VALUES (170, 1, 'Spiderman', true);
INSERT INTO public.sessions (id, user_id, username, valid) VALUES (171, 1, 'Spiderman', true);
INSERT INTO public.sessions (id, user_id, username, valid) VALUES (172, 1, 'Spiderman', true);
INSERT INTO public.sessions (id, user_id, username, valid) VALUES (173, 1, 'Spiderman', true);
INSERT INTO public.sessions (id, user_id, username, valid) VALUES (174, 1, 'Spiderman', true);
INSERT INTO public.sessions (id, user_id, username, valid) VALUES (175, 1, 'Spiderman', true);
INSERT INTO public.sessions (id, user_id, username, valid) VALUES (176, 1, 'Spiderman', true);
INSERT INTO public.sessions (id, user_id, username, valid) VALUES (177, 1, 'Spiderman', true);
INSERT INTO public.sessions (id, user_id, username, valid) VALUES (178, 1, 'Spiderman', true);
INSERT INTO public.sessions (id, user_id, username, valid) VALUES (179, 1, 'Spiderman', true);
INSERT INTO public.sessions (id, user_id, username, valid) VALUES (180, 1, 'Spiderman', true);
INSERT INTO public.sessions (id, user_id, username, valid) VALUES (181, 1, 'Spiderman', true);


--
-- TOC entry 3093 (class 0 OID 41010)
-- Dependencies: 207
-- Data for Name: user_verification; Type: TABLE DATA; Schema: public; Owner: mel-hamr
--



--
-- TOC entry 3087 (class 0 OID 40964)
-- Dependencies: 201
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: mel-hamr
--

INSERT INTO public.users (id, email_address, last_name, first_name, password, username, gender, sexual_preference, biography, images, tags, fame_rating, latitude, longitude, verified, is_online, profile_completion_status, profile_location, birthdate) VALUES (22, 'revixof649@getmola.com', 'test', 'test', '$2b$10$vOEv4jyzjgX06gTLp1YVLezoNCx.cXD9TxrJ8UM089iKbfi2MLqom', 'test1234', 'male', 'female', 'Friendly neighborhood superhero.', '{"https://source.unsplash.com/random/?profile,picture,man,city,man,revixof649&orientation=landscape","https://source.unsplash.com/random/?profile,picture,man,city,man,hijab&orientation=landscape","https://source.unsplash.com/random/?profile,picture,man,city,man,hijab&orientation=landscape","https://source.unsplash.com/random/?profile,picture,man,city,man,hijab&orientation=landscape","https://source.unsplash.com/random/?profile,picture,man,city,man,hijab&orientation=landscape"}', '{"Dark Knight",Gotham,Detective}', '{5}', '33.5792', '-7.6133', true, true, true, 'Khouribga, Morocco', '1990-02-10');
INSERT INTO public.users (id, email_address, last_name, first_name, password, username, gender, sexual_preference, biography, images, tags, fame_rating, latitude, longitude, verified, is_online, profile_completion_status, profile_location, birthdate) VALUES (1, 'spiderman@example.com', 'Parker', 'Peter', '$2b$10$vOEv4jyzjgX06gTLp1YVLezoNCx.cXD9TxrJ8UM089iKbfi2MLqom', 'Spiderman', 'Male', 'Female', 'Friendly neighborhood superhero.', '{"https://source.unsplash.com/random/?profile,picture,man,city,man,spiderman&orientation=landscape","https://source.unsplash.com/random/?profile,picture,man,city,man,hijab&orientation=landscape","https://source.unsplash.com/random/?profile,picture,man,city,man,hijab&orientation=landscape","https://source.unsplash.com/random/?profile,picture,man,city,man,hijab&orientation=landscape","https://source.unsplash.com/random/?profile,picture,man,city,man,hijab&orientation=landscape"}', '{Superhero,Friendly,Web-slinger}', '{5}', '40.7128', '-74.0060', true, true, true, 'Khouribga, Morocco', '1990-02-10');
INSERT INTO public.users (id, email_address, last_name, first_name, password, username, gender, sexual_preference, biography, images, tags, fame_rating, latitude, longitude, verified, is_online, profile_completion_status, profile_location, birthdate) VALUES (2, 'batman@example.com', 'Wayne', 'Bruce', '$2b$10$vOEv4jyzjgX06gTLp1YVLezoNCx.cXD9TxrJ8UM089iKbfi2MLqom', 'Batman', 'Male', 'Female', 'I am vengeance, I am the night.', '{"https://source.unsplash.com/random/?profile,picture,man,city,man,batman&orientation=landscape","https://source.unsplash.com/random/?profile,picture,man,city,man,hijab&orientation=landscape","https://source.unsplash.com/random/?profile,picture,man,city,man,hijab&orientation=landscape","https://source.unsplash.com/random/?profile,picture,man,city,man,hijab&orientation=landscape","https://source.unsplash.com/random/?profile,picture,man,city,man,hijab&orientation=landscape"}', '{"Dark Knight",Gotham,Detective}', '{5}', '40.7128', '-74.0060', true, true, true, 'Khouribga, Morocco', '1990-02-10');
INSERT INTO public.users (id, email_address, last_name, first_name, password, username, gender, sexual_preference, biography, images, tags, fame_rating, latitude, longitude, verified, is_online, profile_completion_status, profile_location, birthdate) VALUES (3, 'wonderwoman@example.com', 'Prince', 'Diana', '$2b$10$vOEv4jyzjgX06gTLp1YVLezoNCx.cXD9TxrJ8UM089iKbfi2MLqom', 'WonderWoman', 'Female', 'male', 'Amazonian warrior for truth and justice.', '{"https://source.unsplash.com/random/?profile,picture,man,city,man,wonderwoman&orientation=landscape","https://source.unsplash.com/random/?profile,picture,man,city,man,hijab&orientation=landscape","https://source.unsplash.com/random/?profile,picture,man,city,man,hijab&orientation=landscape","https://source.unsplash.com/random/?profile,picture,man,city,man,hijab&orientation=landscape","https://source.unsplash.com/random/?profile,picture,man,city,man,hijab&orientation=landscape"}', '{Amazon,Justice,"Lasso of Truth"}', '{5}', '38.8951', '-77.0364', true, true, true, 'Khouribga, Morocco', '1990-02-10');
INSERT INTO public.users (id, email_address, last_name, first_name, password, username, gender, sexual_preference, biography, images, tags, fame_rating, latitude, longitude, verified, is_online, profile_completion_status, profile_location, birthdate) VALUES (4, 'ironman@example.com', 'Stark', 'Tony', '$2b$10$vOEv4jyzjgX06gTLp1YVLezoNCx.cXD9TxrJ8UM089iKbfi2MLqom', 'IronMan', 'Male', 'Female', 'Genius, billionaire, playboy, philanthropist.', '{"https://source.unsplash.com/random/?profile,picture,man,city,man,ironman&orientation=landscape","https://source.unsplash.com/random/?profile,picture,man,city,man,hijab&orientation=landscape","https://source.unsplash.com/random/?profile,picture,man,city,man,hijab&orientation=landscape","https://source.unsplash.com/random/?profile,picture,man,city,man,hijab&orientation=landscape","https://source.unsplash.com/random/?profile,picture,man,city,man,hijab&orientation=landscape"}', '{Genius,Billionaire,Playboy}', '{5}', '34.0522', '-118.2437', true, true, true, 'Khouribga, Morocco', '1990-02-10');
INSERT INTO public.users (id, email_address, last_name, first_name, password, username, gender, sexual_preference, biography, images, tags, fame_rating, latitude, longitude, verified, is_online, profile_completion_status, profile_location, birthdate) VALUES (5, 'superman@example.com', 'Kent', 'Clark', '$2b$10$vOEv4jyzjgX06gTLp1YVLezoNCx.cXD9TxrJ8UM089iKbfi2MLqom', 'Superman', 'Male', 'Female', 'Man of Steel dedicated to protecting Earth.', '{"https://source.unsplash.com/random/?profile,picture,man,city,man,superman&orientation=landscape","https://source.unsplash.com/random/?profile,picture,man,city,man,hijab&orientation=landscape","https://source.unsplash.com/random/?profile,picture,man,city,man,hijab&orientation=landscape","https://source.unsplash.com/random/?profile,picture,man,city,man,hijab&orientation=landscape","https://source.unsplash.com/random/?profile,picture,man,city,man,hijab&orientation=landscape"}', '{"Man of Steel",Kryptonian,"Truth and Justice"}', '{5}', '38.9072', '-77.0370', true, true, true, 'Khouribga, Morocco', '1990-02-10');
INSERT INTO public.users (id, email_address, last_name, first_name, password, username, gender, sexual_preference, biography, images, tags, fame_rating, latitude, longitude, verified, is_online, profile_completion_status, profile_location, birthdate) VALUES (7, 'blackwidow@example.com', 'Romanoff', 'Natasha', '$2b$10$vOEv4jyzjgX06gTLp1YVLezoNCx.cXD9TxrJ8UM089iKbfi2MLqom', 'BlackWidow', 'Female', 'male', 'Espionage expert and skilled assassin.', '{"https://source.unsplash.com/random/?profile,picture,man,city,man,hijab&orientation=landscape","https://source.unsplash.com/random/?profile,picture,man,city,man,hijab&orientation=landscape","https://source.unsplash.com/random/?profile,picture,man,city,man,hijab&orientation=landscape","https://source.unsplash.com/random/?profile,picture,man,city,man,hijab&orientation=landscape","https://source.unsplash.com/random/?profile,picture,man,city,man,hijab&orientation=landscape"}', '{Espionage,Assassin,Avenger}', '{5}', '34.0522', '-118.2437', true, true, true, 'Khouribga, Morocco', '1990-02-10');
INSERT INTO public.users (id, email_address, last_name, first_name, password, username, gender, sexual_preference, biography, images, tags, fame_rating, latitude, longitude, verified, is_online, profile_completion_status, profile_location, birthdate) VALUES (8, 'thor@example.com', 'Odinson', 'Thor', '$2b$10$vOEv4jyzjgX06gTLp1YVLezoNCx.cXD9TxrJ8UM089iKbfi2MLqom', 'Thor', 'Male', 'Female', 'God of Thunder wielding Mjolnir.', '{"https://source.unsplash.com/random/?profile,picture,man,city,man,hijab&orientation=landscape","https://source.unsplash.com/random/?profile,picture,man,city,man,hijab&orientation=landscape","https://source.unsplash.com/random/?profile,picture,man,city,man,hijab&orientation=landscape","https://source.unsplash.com/random/?profile,picture,man,city,man,hijab&orientation=landscape","https://source.unsplash.com/random/?profile,picture,man,city,man,hijab&orientation=landscape"}', '{"God of Thunder",Mjolnir,Asgardian}', '{5}', '40.7128', '-74.0060', true, true, true, 'Khouribga, Morocco', '1990-02-10');
INSERT INTO public.users (id, email_address, last_name, first_name, password, username, gender, sexual_preference, biography, images, tags, fame_rating, latitude, longitude, verified, is_online, profile_completion_status, profile_location, birthdate) VALUES (9, 'wonderwoman2@example.com', 'Prince', 'Diana', '$2b$10$vOEv4jyzjgX06gTLp1YVLezoNCx.cXD9TxrJ8UM089iKbfi2MLqom', 'WonderWoman2', 'Female', 'male', 'Amazonian warrior for truth and justice.', '{"https://source.unsplash.com/random/?profile,picture,man,city,man,hijab&orientation=landscape","https://source.unsplash.com/random/?profile,picture,man,city,man,hijab&orientation=landscape","https://source.unsplash.com/random/?profile,picture,man,city,man,hijab&orientation=landscape","https://source.unsplash.com/random/?profile,picture,man,city,man,hijab&orientation=landscape","https://source.unsplash.com/random/?profile,picture,man,city,man,hijab&orientation=landscape"}', '{Amazon,Justice,"Lasso of Truth"}', '{5}', '38.8951', '-77.0364', true, true, true, 'Khouribga, Morocco', '1990-02-10');
INSERT INTO public.users (id, email_address, last_name, first_name, password, username, gender, sexual_preference, biography, images, tags, fame_rating, latitude, longitude, verified, is_online, profile_completion_status, profile_location, birthdate) VALUES (6, 'captainamerica@example.com', 'Rogers', 'Steve', '$2b$10$vOEv4jyzjgX06gTLp1YVLezoNCx.cXD9TxrJ8UM089iKbfi2MLqom', 'CaptainAmerica', 'Male', 'Female', 'Super-soldier fighting for justice.', '{"https://source.unsplash.com/random/?profile,picture,man,city,man,captainamerica&orientation=landscape","https://source.unsplash.com/random/?profile,picture,man,city,man,hijab&orientation=landscape","https://source.unsplash.com/random/?profile,picture,man,city,man,hijab&orientation=landscape","https://source.unsplash.com/random/?profile,picture,man,city,man,hijab&orientation=landscape","https://source.unsplash.com/random/?profile,picture,man,city,man,hijab&orientation=landscape"}', '{Shield,Avenger}', '{5}', '40.7128', '-74.0060', true, true, true, 'Khouribga, Morocco', '1990-02-10');
INSERT INTO public.users (id, email_address, last_name, first_name, password, username, gender, sexual_preference, biography, images, tags, fame_rating, latitude, longitude, verified, is_online, profile_completion_status, profile_location, birthdate) VALUES (25, 'fatima.aitbenhaddou@example.com', 'Ait Benhaddou', 'Fatima', 'password123', 'fatima', 'female', 'male', 'I am a student and a nature lover. I enjoy spending time outdoors and exploring new places.', '{"https://source.unsplash.com/random/?profile,picture,woman,city,girl,hijab&orientation=landscape","https://source.unsplash.com/random/?profile,picture,woman,city,girl,hijab&orientation=landscape","https://source.unsplash.com/random/?profile,picture,woman,city,girl,hijab&orientation=landscape","https://source.unsplash.com/random/?profile,picture,woman,city,girl,hijab&orientation=landscape","https://source.unsplash.com/random/?profile,picture,woman,city,girl,hijab&orientation=landscape"}', '{city,girl,hijab}', '{5}', '32.8804', '-6.9065', true, true, true, 'Khouribga, Morocco', '1995-08-20');
INSERT INTO public.users (id, email_address, last_name, first_name, password, username, gender, sexual_preference, biography, images, tags, fame_rating, latitude, longitude, verified, is_online, profile_completion_status, profile_location, birthdate) VALUES (26, 'mohamed.chakir@example.com', 'Chakir', 'Mohamed', 'password123', 'mohamed', 'male', 'female', 'I am a software engineer and a music enthusiast. I love coding and playing guitar in my free time.', '{"https://source.unsplash.com/random/?profile,picture,man,city,man,hijab&orientation=landscape","https://source.unsplash.com/random/?profile,picture,man,city,man,hijab&orientation=landscape","https://source.unsplash.com/random/?profile,picture,man,city,man,hijab&orientation=landscape","https://source.unsplash.com/random/?profile,picture,man,city,man,hijab&orientation=landscape","https://source.unsplash.com/random/?profile,picture,man,city,man,hijab&orientation=landscape"}', '{city,man,hijab}', '{5}', '32.8804', '-6.9065', true, true, true, 'Khouribga, Morocco', '1990-02-10');
INSERT INTO public.users (id, email_address, last_name, first_name, password, username, gender, sexual_preference, biography, images, tags, fame_rating, latitude, longitude, verified, is_online, profile_completion_status, profile_location, birthdate) VALUES (27, 'amina.hamdi@example.com', 'Hamdi', 'Amina', 'password123', 'amina', 'female', 'male', 'I am a teacher and an avid reader. I enjoy spending time in nature and discovering new books.', '{"https://source.unsplash.com/random/?profile,picture,woman,city,girl,blonde&orientation=landscape","https://source.unsplash.com/random/?profile,picture,woman,city,girl,blonde&orientation=landscape","https://source.unsplash.com/random/?profile,picture,woman,city,girl,blonde&orientation=landscape","https://source.unsplash.com/random/?profile,picture,woman,city,girl,blonde&orientation=landscape","https://source.unsplash.com/random/?profile,picture,woman,city,girl,blonde&orientation=landscape"}', '{city,girl,blonde}', '{5}', '32.8804', '-6.9065', true, true, true, 'Khouribga, Morocco', '1988-06-25');
INSERT INTO public.users (id, email_address, last_name, first_name, password, username, gender, sexual_preference, biography, images, tags, fame_rating, latitude, longitude, verified, is_online, profile_completion_status, profile_location, birthdate) VALUES (28, 'youssef.elatrassi@example.com', 'El Atrassi', 'Youssef', 'pass1234', 'youssef', 'male', 'female', 'I am a photographer and a travel enthusiast. I love capturing moments and exploring new destinations.', '{"https://source.unsplash.com/random/?profile,picture,man,city,man,hijab&orientation=landscape","https://source.unsplash.com/random/?profile,picture,man,city,man,hijab&orientation=landscape","https://source.unsplash.com/random/?profile,picture,man,city,man,hijab&orientation=landscape","https://source.unsplash.com/random/?profile,picture,man,city,man,hijab&orientation=landscape","https://source.unsplash.com/random/?profile,picture,man,city,man,hijab&orientation=landscape"}', '{city,man,hijab}', '{5}', '32.8804', '-6.9065', true, true, true, 'Khouribga, Morocco', '1993-11-15');
INSERT INTO public.users (id, email_address, last_name, first_name, password, username, gender, sexual_preference, biography, images, tags, fame_rating, latitude, longitude, verified, is_online, profile_completion_status, profile_location, birthdate) VALUES (29, 'sara.benabdallah@example.com', 'Ben Abdallah', 'Sara', 'password123', 'sara', 'female', 'male', 'I am a graphic designer and a coffee lover. I enjoy creating beautiful designs and exploring new coffee shops in my city.', '{"https://source.unsplash.com/random/?profile,picture,woman,city,girl,hijab&orientation=landscape","https://source.unsplash.com/random/?profile,picture,woman,city,girl,hijab&orientation=landscape","https://source.unsplash.com/random/?profile,picture,woman,city,girl,hijab&orientation=landscape","https://source.unsplash.com/random/?profile,picture,woman,city,girl,hijab&orientation=landscape","https://source.unsplash.com/random/?profile,picture,woman,city,girl,hijab&orientation"}', '{city,girl,hijab}', '{5}', '32.8804', '-6.9065', true, true, true, 'Khouribga, Morocco', '1997-03-30');
INSERT INTO public.users (id, email_address, last_name, first_name, password, username, gender, sexual_preference, biography, images, tags, fame_rating, latitude, longitude, verified, is_online, profile_completion_status, profile_location, birthdate) VALUES (30, 'ali.elfassi@example.com', 'El Fassi', 'Ali', 'pass1234', 'ali', 'male', 'female', 'I am a software developer and a sports enthusiast. I love coding and playing football in my free time.', '{"https://source.unsplash.com/random/?profile,picture,man,city,man,hijab&orientation=landscape","https://source.unsplash.com/random/?profile,picture,man,city,man,hijab&orientation=landscape","https://source.unsplash.com/random/?profile,picture,man,city,man,hijab&orientation=landscape","https://source.unsplash.com/random/?profile,picture,man,city,man,hijab&orientation=landscape","https://source.unsplash.com/random/?profile,picture,man,city,man,hijab&orientation=landscape"}', '{city,man,hijab}', '{5}', '32.8804', '-6.9065', true, true, true, 'Khouribga, Morocco', '1987-04-12');
INSERT INTO public.users (id, email_address, last_name, first_name, password, username, gender, sexual_preference, biography, images, tags, fame_rating, latitude, longitude, verified, is_online, profile_completion_status, profile_location, birthdate) VALUES (31, 'loubna.cherkaoui@example.com', 'Cherkaoui', 'Loubna', 'password123', 'loubna', 'female', 'male', 'I am a graphic designer and a nature lover. I enjoy creating beautiful designs inspired by the outdoors.', '{"https://source.unsplash.com/random/?profile,picture,woman,city,girl,hijab&orientation=landscape","https://source.unsplash.com/random/?profile,picture,woman,city,girl,hijab&orientation=landscape","https://source.unsplash.com/random/?profile,picture,woman,city,girl,hijab&orientation=landscape","https://source.unsplash.com/random/?profile,picture,woman,city,girl,hijab&orientation=landscape","https://source.unsplash.com/random/?profile,picture,woman,city,girl,hijab&orientation=landscape"}', '{city,girl,hijab}', '{5}', '32.8804', '-6.9065', true, true, true, 'Khouribga, Morocco', '1991-09-05');
INSERT INTO public.users (id, email_address, last_name, first_name, password, username, gender, sexual_preference, biography, images, tags, fame_rating, latitude, longitude, verified, is_online, profile_completion_status, profile_location, birthdate) VALUES (32, 'abdellah.naimi@example.com', 'Naimi', 'Abdellah', 'pass1234', 'abdellah', 'male', 'female', 'I am a teacher and a book enthusiast. I love sharing knowledge and discovering new stories.', '{"https://source.unsplash.com/random/?profile,picture,man,city,man,hijab&orientation=landscape","https://source.unsplash.com/random/?profile,picture,man,city,man,hijab&orientation=landscape","https://source.unsplash.com/random/?profile,picture,man,city,man,hijab&orientation=landscape","https://source.unsplash.com/random/?profile,picture,man,city,man,hijab&orientation=landscape","https://source.unsplash.com/random/?profile,picture,man,city,man,hijab&orientation=landscape"}', '{city,man,hijab}', '{5}', '32.8804', '-6.9065', true, true, true, 'Khouribga, Morocco', '1983-12-18');


--
-- TOC entry 3089 (class 0 OID 40977)
-- Dependencies: 203
-- Data for Name: views; Type: TABLE DATA; Schema: public; Owner: mel-hamr
--



--
-- TOC entry 3113 (class 0 OID 0)
-- Dependencies: 208
-- Name: conversation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mel-hamr
--

SELECT pg_catalog.setval('public.conversation_id_seq', 20, true);


--
-- TOC entry 3114 (class 0 OID 0)
-- Dependencies: 210
-- Name: message_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mel-hamr
--

SELECT pg_catalog.setval('public.message_id_seq', 323, true);


--
-- TOC entry 3115 (class 0 OID 0)
-- Dependencies: 212
-- Name: notifacation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mel-hamr
--

SELECT pg_catalog.setval('public.notifacation_id_seq', 1, false);


--
-- TOC entry 3116 (class 0 OID 0)
-- Dependencies: 204
-- Name: sessions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mel-hamr
--

SELECT pg_catalog.setval('public.sessions_id_seq', 181, true);


--
-- TOC entry 3117 (class 0 OID 0)
-- Dependencies: 206
-- Name: user_verification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mel-hamr
--

SELECT pg_catalog.setval('public.user_verification_id_seq', 1, true);


--
-- TOC entry 3118 (class 0 OID 0)
-- Dependencies: 200
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mel-hamr
--

SELECT pg_catalog.setval('public.users_id_seq', 32, true);


--
-- TOC entry 3119 (class 0 OID 0)
-- Dependencies: 202
-- Name: views_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mel-hamr
--

SELECT pg_catalog.setval('public.views_id_seq', 1, false);


--
-- TOC entry 2943 (class 2606 OID 41031)
-- Name: conversation conversation_pkey; Type: CONSTRAINT; Schema: public; Owner: mel-hamr
--

ALTER TABLE ONLY public.conversation
    ADD CONSTRAINT conversation_pkey PRIMARY KEY (id);


--
-- TOC entry 2945 (class 2606 OID 41053)
-- Name: message message_pkey; Type: CONSTRAINT; Schema: public; Owner: mel-hamr
--

ALTER TABLE ONLY public.message
    ADD CONSTRAINT message_pkey PRIMARY KEY (id);


--
-- TOC entry 2947 (class 2606 OID 49203)
-- Name: notifacation notifacation_pkey; Type: CONSTRAINT; Schema: public; Owner: mel-hamr
--

ALTER TABLE ONLY public.notifacation
    ADD CONSTRAINT notifacation_pkey PRIMARY KEY (id);


--
-- TOC entry 2939 (class 2606 OID 41002)
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: mel-hamr
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- TOC entry 2941 (class 2606 OID 41017)
-- Name: user_verification user_verification_pkey; Type: CONSTRAINT; Schema: public; Owner: mel-hamr
--

ALTER TABLE ONLY public.user_verification
    ADD CONSTRAINT user_verification_pkey PRIMARY KEY (id);


--
-- TOC entry 2931 (class 2606 OID 40972)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: mel-hamr
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 2933 (class 2606 OID 40974)
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: mel-hamr
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- TOC entry 2935 (class 2606 OID 40982)
-- Name: views views_pkey; Type: CONSTRAINT; Schema: public; Owner: mel-hamr
--

ALTER TABLE ONLY public.views
    ADD CONSTRAINT views_pkey PRIMARY KEY (id);


--
-- TOC entry 2937 (class 2606 OID 40984)
-- Name: views views_user_id_view_id_key; Type: CONSTRAINT; Schema: public; Owner: mel-hamr
--

ALTER TABLE ONLY public.views
    ADD CONSTRAINT views_user_id_view_id_key UNIQUE (user_id, view_id);


--
-- TOC entry 2952 (class 2606 OID 41032)
-- Name: conversation conversation_participant_a_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mel-hamr
--

ALTER TABLE ONLY public.conversation
    ADD CONSTRAINT conversation_participant_a_fkey FOREIGN KEY (participant_a) REFERENCES public.users(id);


--
-- TOC entry 2953 (class 2606 OID 41037)
-- Name: conversation conversation_participant_b_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mel-hamr
--

ALTER TABLE ONLY public.conversation
    ADD CONSTRAINT conversation_participant_b_fkey FOREIGN KEY (participant_b) REFERENCES public.users(id);


--
-- TOC entry 2954 (class 2606 OID 41054)
-- Name: message message_conversation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mel-hamr
--

ALTER TABLE ONLY public.message
    ADD CONSTRAINT message_conversation_id_fkey FOREIGN KEY (conversation_id) REFERENCES public.conversation(id);


--
-- TOC entry 2955 (class 2606 OID 49204)
-- Name: notifacation notifacation_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mel-hamr
--

ALTER TABLE ONLY public.notifacation
    ADD CONSTRAINT notifacation_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 2950 (class 2606 OID 41003)
-- Name: sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mel-hamr
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 2951 (class 2606 OID 41018)
-- Name: user_verification user_verification_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mel-hamr
--

ALTER TABLE ONLY public.user_verification
    ADD CONSTRAINT user_verification_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 2948 (class 2606 OID 40985)
-- Name: views views_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mel-hamr
--

ALTER TABLE ONLY public.views
    ADD CONSTRAINT views_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 2949 (class 2606 OID 40990)
-- Name: views views_view_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mel-hamr
--

ALTER TABLE ONLY public.views
    ADD CONSTRAINT views_view_id_fkey FOREIGN KEY (view_id) REFERENCES public.users(id);


--
-- TOC entry 3105 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: mel-hamr
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2024-03-01 17:45:15 +01

--
-- PostgreSQL database dump complete
--

