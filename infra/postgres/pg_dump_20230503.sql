--
-- PostgreSQL database dump
--

-- Dumped from database version 13.3 (Debian 13.3-1.pgdg100+1)
-- Dumped by pg_dump version 13.3 (Debian 13.3-1.pgdg100+1)

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
-- Name: alcpt; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA alcpt;


ALTER SCHEMA alcpt OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: alcpt_achievement; Type: TABLE; Schema: alcpt; Owner: postgres
--

CREATE TABLE alcpt.alcpt_achievement (
    id integer NOT NULL,
    name character varying(75) NOT NULL,
    key character varying(75) NOT NULL,
    description text,
    category integer NOT NULL,
    point integer NOT NULL,
    level integer NOT NULL,
    completion integer NOT NULL,
    trophy character varying(100) NOT NULL
);


ALTER TABLE alcpt.alcpt_achievement OWNER TO postgres;

--
-- Name: alcpt_achievement_id_seq; Type: SEQUENCE; Schema: alcpt; Owner: postgres
--

CREATE SEQUENCE alcpt.alcpt_achievement_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE alcpt.alcpt_achievement_id_seq OWNER TO postgres;

--
-- Name: alcpt_achievement_id_seq; Type: SEQUENCE OWNED BY; Schema: alcpt; Owner: postgres
--

ALTER SEQUENCE alcpt.alcpt_achievement_id_seq OWNED BY alcpt.alcpt_achievement.id;


--
-- Name: alcpt_answer; Type: TABLE; Schema: alcpt; Owner: postgres
--

CREATE TABLE alcpt.alcpt_answer (
    id integer NOT NULL,
    selected smallint NOT NULL,
    answer_sheet_id integer NOT NULL,
    question_id integer NOT NULL
);


ALTER TABLE alcpt.alcpt_answer OWNER TO postgres;

--
-- Name: alcpt_answer_id_seq; Type: SEQUENCE; Schema: alcpt; Owner: postgres
--

CREATE SEQUENCE alcpt.alcpt_answer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE alcpt.alcpt_answer_id_seq OWNER TO postgres;

--
-- Name: alcpt_answer_id_seq; Type: SEQUENCE OWNED BY; Schema: alcpt; Owner: postgres
--

ALTER SEQUENCE alcpt.alcpt_answer_id_seq OWNED BY alcpt.alcpt_answer.id;


--
-- Name: alcpt_answersheet; Type: TABLE; Schema: alcpt; Owner: postgres
--

CREATE TABLE alcpt.alcpt_answersheet (
    id integer NOT NULL,
    finish_time timestamp with time zone NOT NULL,
    is_finished boolean NOT NULL,
    score integer,
    exam_id integer NOT NULL,
    user_id integer NOT NULL,
    is_tested boolean NOT NULL
);


ALTER TABLE alcpt.alcpt_answersheet OWNER TO postgres;

--
-- Name: alcpt_answersheet_id_seq; Type: SEQUENCE; Schema: alcpt; Owner: postgres
--

CREATE SEQUENCE alcpt.alcpt_answersheet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE alcpt.alcpt_answersheet_id_seq OWNER TO postgres;

--
-- Name: alcpt_answersheet_id_seq; Type: SEQUENCE OWNED BY; Schema: alcpt; Owner: postgres
--

ALTER SEQUENCE alcpt.alcpt_answersheet_id_seq OWNED BY alcpt.alcpt_answersheet.id;


--
-- Name: alcpt_choice; Type: TABLE; Schema: alcpt; Owner: postgres
--

CREATE TABLE alcpt.alcpt_choice (
    id integer NOT NULL,
    c_content character varying(255) NOT NULL,
    is_answer boolean NOT NULL,
    question_id integer NOT NULL
);


ALTER TABLE alcpt.alcpt_choice OWNER TO postgres;

--
-- Name: alcpt_choice_id_seq; Type: SEQUENCE; Schema: alcpt; Owner: postgres
--

CREATE SEQUENCE alcpt.alcpt_choice_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE alcpt.alcpt_choice_id_seq OWNER TO postgres;

--
-- Name: alcpt_choice_id_seq; Type: SEQUENCE OWNED BY; Schema: alcpt; Owner: postgres
--

ALTER SEQUENCE alcpt.alcpt_choice_id_seq OWNED BY alcpt.alcpt_choice.id;


--
-- Name: alcpt_department; Type: TABLE; Schema: alcpt; Owner: postgres
--

CREATE TABLE alcpt.alcpt_department (
    id integer NOT NULL,
    name character varying(10) NOT NULL
);


ALTER TABLE alcpt.alcpt_department OWNER TO postgres;

--
-- Name: alcpt_department_id_seq; Type: SEQUENCE; Schema: alcpt; Owner: postgres
--

CREATE SEQUENCE alcpt.alcpt_department_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE alcpt.alcpt_department_id_seq OWNER TO postgres;

--
-- Name: alcpt_department_id_seq; Type: SEQUENCE OWNED BY; Schema: alcpt; Owner: postgres
--

ALTER SEQUENCE alcpt.alcpt_department_id_seq OWNED BY alcpt.alcpt_department.id;


--
-- Name: alcpt_exam; Type: TABLE; Schema: alcpt; Owner: postgres
--

CREATE TABLE alcpt.alcpt_exam (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    exam_type integer NOT NULL,
    use_freq integer NOT NULL,
    average_score double precision NOT NULL,
    start_time timestamp with time zone,
    created_time timestamp with time zone NOT NULL,
    duration integer NOT NULL,
    finish_time timestamp with time zone,
    is_public boolean NOT NULL,
    created_by_id integer NOT NULL,
    testpaper_id integer,
    modified_time timestamp with time zone,
    remaining_time bigint,
    is_started boolean NOT NULL
);


ALTER TABLE alcpt.alcpt_exam OWNER TO postgres;

--
-- Name: alcpt_exam_id_seq; Type: SEQUENCE; Schema: alcpt; Owner: postgres
--

CREATE SEQUENCE alcpt.alcpt_exam_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE alcpt.alcpt_exam_id_seq OWNER TO postgres;

--
-- Name: alcpt_exam_id_seq; Type: SEQUENCE OWNED BY; Schema: alcpt; Owner: postgres
--

ALTER SEQUENCE alcpt.alcpt_exam_id_seq OWNED BY alcpt.alcpt_exam.id;


--
-- Name: alcpt_exam_testeelist; Type: TABLE; Schema: alcpt; Owner: postgres
--

CREATE TABLE alcpt.alcpt_exam_testeelist (
    id integer NOT NULL,
    exam_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE alcpt.alcpt_exam_testeelist OWNER TO postgres;

--
-- Name: alcpt_exam_testeelist_id_seq; Type: SEQUENCE; Schema: alcpt; Owner: postgres
--

CREATE SEQUENCE alcpt.alcpt_exam_testeelist_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE alcpt.alcpt_exam_testeelist_id_seq OWNER TO postgres;

--
-- Name: alcpt_exam_testeelist_id_seq; Type: SEQUENCE OWNED BY; Schema: alcpt; Owner: postgres
--

ALTER SEQUENCE alcpt.alcpt_exam_testeelist_id_seq OWNED BY alcpt.alcpt_exam_testeelist.id;


--
-- Name: alcpt_forum; Type: TABLE; Schema: alcpt; Owner: postgres
--

CREATE TABLE alcpt.alcpt_forum (
    id integer NOT NULL,
    f_content text NOT NULL,
    data_time timestamp with time zone,
    f_creator_id integer NOT NULL,
    f_question_id integer NOT NULL
);


ALTER TABLE alcpt.alcpt_forum OWNER TO postgres;

--
-- Name: alcpt_forum_id_seq; Type: SEQUENCE; Schema: alcpt; Owner: postgres
--

CREATE SEQUENCE alcpt.alcpt_forum_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE alcpt.alcpt_forum_id_seq OWNER TO postgres;

--
-- Name: alcpt_forum_id_seq; Type: SEQUENCE OWNED BY; Schema: alcpt; Owner: postgres
--

ALTER SEQUENCE alcpt.alcpt_forum_id_seq OWNED BY alcpt.alcpt_forum.id;


--
-- Name: alcpt_group; Type: TABLE; Schema: alcpt; Owner: postgres
--

CREATE TABLE alcpt.alcpt_group (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    update_time timestamp with time zone NOT NULL,
    created_time timestamp with time zone NOT NULL,
    created_by_id integer NOT NULL
);


ALTER TABLE alcpt.alcpt_group OWNER TO postgres;

--
-- Name: alcpt_group_id_seq; Type: SEQUENCE; Schema: alcpt; Owner: postgres
--

CREATE SEQUENCE alcpt.alcpt_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE alcpt.alcpt_group_id_seq OWNER TO postgres;

--
-- Name: alcpt_group_id_seq; Type: SEQUENCE OWNED BY; Schema: alcpt; Owner: postgres
--

ALTER SEQUENCE alcpt.alcpt_group_id_seq OWNED BY alcpt.alcpt_group.id;


--
-- Name: alcpt_group_member; Type: TABLE; Schema: alcpt; Owner: postgres
--

CREATE TABLE alcpt.alcpt_group_member (
    id integer NOT NULL,
    group_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE alcpt.alcpt_group_member OWNER TO postgres;

--
-- Name: alcpt_group_member_id_seq; Type: SEQUENCE; Schema: alcpt; Owner: postgres
--

CREATE SEQUENCE alcpt.alcpt_group_member_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE alcpt.alcpt_group_member_id_seq OWNER TO postgres;

--
-- Name: alcpt_group_member_id_seq; Type: SEQUENCE OWNED BY; Schema: alcpt; Owner: postgres
--

ALTER SEQUENCE alcpt.alcpt_group_member_id_seq OWNED BY alcpt.alcpt_group_member.id;


--
-- Name: alcpt_proclamation; Type: TABLE; Schema: alcpt; Owner: postgres
--

CREATE TABLE alcpt.alcpt_proclamation (
    id integer NOT NULL,
    title text NOT NULL,
    text text NOT NULL,
    is_public boolean NOT NULL,
    created_time timestamp with time zone NOT NULL,
    created_by_id integer,
    is_read boolean NOT NULL,
    recipient_id integer,
    exam_id bigint NOT NULL,
    report_id bigint NOT NULL
);


ALTER TABLE alcpt.alcpt_proclamation OWNER TO postgres;

--
-- Name: alcpt_proclamation_id_seq; Type: SEQUENCE; Schema: alcpt; Owner: postgres
--

CREATE SEQUENCE alcpt.alcpt_proclamation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE alcpt.alcpt_proclamation_id_seq OWNER TO postgres;

--
-- Name: alcpt_proclamation_id_seq; Type: SEQUENCE OWNED BY; Schema: alcpt; Owner: postgres
--

ALTER SEQUENCE alcpt.alcpt_proclamation_id_seq OWNED BY alcpt.alcpt_proclamation.id;


--
-- Name: alcpt_question; Type: TABLE; Schema: alcpt; Owner: postgres
--

CREATE TABLE alcpt.alcpt_question (
    id integer NOT NULL,
    q_type integer NOT NULL,
    q_file text,
    q_content text,
    difficulty integer NOT NULL,
    issued_freq integer NOT NULL,
    correct_freq integer NOT NULL,
    created_time timestamp with time zone NOT NULL,
    update_time timestamp with time zone NOT NULL,
    is_valid boolean NOT NULL,
    state smallint NOT NULL,
    created_by_id integer NOT NULL,
    last_updated_by_id integer,
    faulted_reason character varying(255),
    q_correct_time integer NOT NULL,
    q_time integer NOT NULL,
    in_forum boolean NOT NULL,
    best_reply text,
    replier_id integer
);


ALTER TABLE alcpt.alcpt_question OWNER TO postgres;

--
-- Name: alcpt_question_favorite; Type: TABLE; Schema: alcpt; Owner: postgres
--

CREATE TABLE alcpt.alcpt_question_favorite (
    id integer NOT NULL,
    question_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE alcpt.alcpt_question_favorite OWNER TO postgres;

--
-- Name: alcpt_question_favorite_id_seq; Type: SEQUENCE; Schema: alcpt; Owner: postgres
--

CREATE SEQUENCE alcpt.alcpt_question_favorite_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE alcpt.alcpt_question_favorite_id_seq OWNER TO postgres;

--
-- Name: alcpt_question_favorite_id_seq; Type: SEQUENCE OWNED BY; Schema: alcpt; Owner: postgres
--

ALTER SEQUENCE alcpt.alcpt_question_favorite_id_seq OWNED BY alcpt.alcpt_question_favorite.id;


--
-- Name: alcpt_question_id_seq; Type: SEQUENCE; Schema: alcpt; Owner: postgres
--

CREATE SEQUENCE alcpt.alcpt_question_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE alcpt.alcpt_question_id_seq OWNER TO postgres;

--
-- Name: alcpt_question_id_seq; Type: SEQUENCE OWNED BY; Schema: alcpt; Owner: postgres
--

ALTER SEQUENCE alcpt.alcpt_question_id_seq OWNED BY alcpt.alcpt_question.id;


--
-- Name: alcpt_reply; Type: TABLE; Schema: alcpt; Owner: postgres
--

CREATE TABLE alcpt.alcpt_reply (
    id integer NOT NULL,
    content text NOT NULL,
    created_time timestamp with time zone NOT NULL,
    created_by_id integer,
    source_id integer
);


ALTER TABLE alcpt.alcpt_reply OWNER TO postgres;

--
-- Name: alcpt_reply_id_seq; Type: SEQUENCE; Schema: alcpt; Owner: postgres
--

CREATE SEQUENCE alcpt.alcpt_reply_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE alcpt.alcpt_reply_id_seq OWNER TO postgres;

--
-- Name: alcpt_reply_id_seq; Type: SEQUENCE OWNED BY; Schema: alcpt; Owner: postgres
--

ALTER SEQUENCE alcpt.alcpt_reply_id_seq OWNED BY alcpt.alcpt_reply.id;


--
-- Name: alcpt_report; Type: TABLE; Schema: alcpt; Owner: postgres
--

CREATE TABLE alcpt.alcpt_report (
    id integer NOT NULL,
    user_notification boolean NOT NULL,
    staff_notification boolean NOT NULL,
    supplement_note text NOT NULL,
    state smallint NOT NULL,
    created_time timestamp with time zone,
    resolved_time timestamp with time zone,
    category_id integer NOT NULL,
    created_by_id integer NOT NULL,
    question_id integer,
    resolved_by_id integer
);


ALTER TABLE alcpt.alcpt_report OWNER TO postgres;

--
-- Name: alcpt_report_id_seq; Type: SEQUENCE; Schema: alcpt; Owner: postgres
--

CREATE SEQUENCE alcpt.alcpt_report_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE alcpt.alcpt_report_id_seq OWNER TO postgres;

--
-- Name: alcpt_report_id_seq; Type: SEQUENCE OWNED BY; Schema: alcpt; Owner: postgres
--

ALTER SEQUENCE alcpt.alcpt_report_id_seq OWNED BY alcpt.alcpt_report.id;


--
-- Name: alcpt_reportcategory; Type: TABLE; Schema: alcpt; Owner: postgres
--

CREATE TABLE alcpt.alcpt_reportcategory (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    responsibility integer NOT NULL
);


ALTER TABLE alcpt.alcpt_reportcategory OWNER TO postgres;

--
-- Name: alcpt_reportcategory_id_seq; Type: SEQUENCE; Schema: alcpt; Owner: postgres
--

CREATE SEQUENCE alcpt.alcpt_reportcategory_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE alcpt.alcpt_reportcategory_id_seq OWNER TO postgres;

--
-- Name: alcpt_reportcategory_id_seq; Type: SEQUENCE OWNED BY; Schema: alcpt; Owner: postgres
--

ALTER SEQUENCE alcpt.alcpt_reportcategory_id_seq OWNED BY alcpt.alcpt_reportcategory.id;


--
-- Name: alcpt_squadron; Type: TABLE; Schema: alcpt; Owner: postgres
--

CREATE TABLE alcpt.alcpt_squadron (
    id integer NOT NULL,
    name character varying(10) NOT NULL
);


ALTER TABLE alcpt.alcpt_squadron OWNER TO postgres;

--
-- Name: alcpt_squadron_id_seq; Type: SEQUENCE; Schema: alcpt; Owner: postgres
--

CREATE SEQUENCE alcpt.alcpt_squadron_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE alcpt.alcpt_squadron_id_seq OWNER TO postgres;

--
-- Name: alcpt_squadron_id_seq; Type: SEQUENCE OWNED BY; Schema: alcpt; Owner: postgres
--

ALTER SEQUENCE alcpt.alcpt_squadron_id_seq OWNED BY alcpt.alcpt_squadron.id;


--
-- Name: alcpt_student; Type: TABLE; Schema: alcpt; Owner: postgres
--

CREATE TABLE alcpt.alcpt_student (
    id integer NOT NULL,
    stu_id character varying(50) NOT NULL,
    grade integer NOT NULL,
    department_id integer,
    squadron_id integer,
    user_id integer NOT NULL
);


ALTER TABLE alcpt.alcpt_student OWNER TO postgres;

--
-- Name: alcpt_student_id_seq; Type: SEQUENCE; Schema: alcpt; Owner: postgres
--

CREATE SEQUENCE alcpt.alcpt_student_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE alcpt.alcpt_student_id_seq OWNER TO postgres;

--
-- Name: alcpt_student_id_seq; Type: SEQUENCE OWNED BY; Schema: alcpt; Owner: postgres
--

ALTER SEQUENCE alcpt.alcpt_student_id_seq OWNED BY alcpt.alcpt_student.id;


--
-- Name: alcpt_testpaper; Type: TABLE; Schema: alcpt; Owner: postgres
--

CREATE TABLE alcpt.alcpt_testpaper (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    created_time timestamp with time zone NOT NULL,
    is_testpaper boolean NOT NULL,
    update_time timestamp with time zone NOT NULL,
    valid boolean NOT NULL,
    created_by_id integer NOT NULL,
    is_used boolean NOT NULL
);


ALTER TABLE alcpt.alcpt_testpaper OWNER TO postgres;

--
-- Name: alcpt_testpaper_id_seq; Type: SEQUENCE; Schema: alcpt; Owner: postgres
--

CREATE SEQUENCE alcpt.alcpt_testpaper_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE alcpt.alcpt_testpaper_id_seq OWNER TO postgres;

--
-- Name: alcpt_testpaper_id_seq; Type: SEQUENCE OWNED BY; Schema: alcpt; Owner: postgres
--

ALTER SEQUENCE alcpt.alcpt_testpaper_id_seq OWNED BY alcpt.alcpt_testpaper.id;


--
-- Name: alcpt_testpaper_question_list; Type: TABLE; Schema: alcpt; Owner: postgres
--

CREATE TABLE alcpt.alcpt_testpaper_question_list (
    id integer NOT NULL,
    testpaper_id integer NOT NULL,
    question_id integer NOT NULL
);


ALTER TABLE alcpt.alcpt_testpaper_question_list OWNER TO postgres;

--
-- Name: alcpt_testpaper_question_list_id_seq; Type: SEQUENCE; Schema: alcpt; Owner: postgres
--

CREATE SEQUENCE alcpt.alcpt_testpaper_question_list_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE alcpt.alcpt_testpaper_question_list_id_seq OWNER TO postgres;

--
-- Name: alcpt_testpaper_question_list_id_seq; Type: SEQUENCE OWNED BY; Schema: alcpt; Owner: postgres
--

ALTER SEQUENCE alcpt.alcpt_testpaper_question_list_id_seq OWNED BY alcpt.alcpt_testpaper_question_list.id;


--
-- Name: alcpt_user; Type: TABLE; Schema: alcpt; Owner: postgres
--

CREATE TABLE alcpt.alcpt_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    reg_id character varying(50) NOT NULL,
    name character varying(20),
    gender integer,
    identity integer,
    privilege integer NOT NULL,
    email character varying(254),
    email_is_verified boolean NOT NULL,
    update_time timestamp with time zone NOT NULL,
    created_time timestamp with time zone NOT NULL,
    last_login timestamp with time zone,
    introduction text,
    photo text,
    experience integer NOT NULL,
    level integer NOT NULL,
    browser text
);


ALTER TABLE alcpt.alcpt_user OWNER TO postgres;

--
-- Name: alcpt_user_id_seq; Type: SEQUENCE; Schema: alcpt; Owner: postgres
--

CREATE SEQUENCE alcpt.alcpt_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE alcpt.alcpt_user_id_seq OWNER TO postgres;

--
-- Name: alcpt_user_id_seq; Type: SEQUENCE OWNED BY; Schema: alcpt; Owner: postgres
--

ALTER SEQUENCE alcpt.alcpt_user_id_seq OWNED BY alcpt.alcpt_user.id;


--
-- Name: alcpt_userachievement; Type: TABLE; Schema: alcpt; Owner: postgres
--

CREATE TABLE alcpt.alcpt_userachievement (
    id integer NOT NULL,
    progress integer NOT NULL,
    unlock boolean NOT NULL,
    registered_at timestamp with time zone NOT NULL,
    achievement_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE alcpt.alcpt_userachievement OWNER TO postgres;

--
-- Name: alcpt_userachievement_id_seq; Type: SEQUENCE; Schema: alcpt; Owner: postgres
--

CREATE SEQUENCE alcpt.alcpt_userachievement_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE alcpt.alcpt_userachievement_id_seq OWNER TO postgres;

--
-- Name: alcpt_userachievement_id_seq; Type: SEQUENCE OWNED BY; Schema: alcpt; Owner: postgres
--

ALTER SEQUENCE alcpt.alcpt_userachievement_id_seq OWNED BY alcpt.alcpt_userachievement.id;


--
-- Name: alcpt_word; Type: TABLE; Schema: alcpt; Owner: postgres
--

CREATE TABLE alcpt.alcpt_word (
    id bigint NOT NULL,
    word character varying(50) NOT NULL,
    definiton text NOT NULL
);


ALTER TABLE alcpt.alcpt_word OWNER TO postgres;

--
-- Name: alcpt_word_id_seq; Type: SEQUENCE; Schema: alcpt; Owner: postgres
--

CREATE SEQUENCE alcpt.alcpt_word_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE alcpt.alcpt_word_id_seq OWNER TO postgres;

--
-- Name: alcpt_word_id_seq; Type: SEQUENCE OWNED BY; Schema: alcpt; Owner: postgres
--

ALTER SEQUENCE alcpt.alcpt_word_id_seq OWNED BY alcpt.alcpt_word.id;


--
-- Name: alcpt_word_library; Type: TABLE; Schema: alcpt; Owner: postgres
--

CREATE TABLE alcpt.alcpt_word_library (
    id bigint NOT NULL,
    words character varying(50) NOT NULL,
    translations text NOT NULL
);


ALTER TABLE alcpt.alcpt_word_library OWNER TO postgres;

--
-- Name: alcpt_word_library_id_seq; Type: SEQUENCE; Schema: alcpt; Owner: postgres
--

CREATE SEQUENCE alcpt.alcpt_word_library_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE alcpt.alcpt_word_library_id_seq OWNER TO postgres;

--
-- Name: alcpt_word_library_id_seq; Type: SEQUENCE OWNED BY; Schema: alcpt; Owner: postgres
--

ALTER SEQUENCE alcpt.alcpt_word_library_id_seq OWNED BY alcpt.alcpt_word_library.id;


--
-- Name: audio_file; Type: TABLE; Schema: alcpt; Owner: postgres
--

CREATE TABLE alcpt.audio_file (
    id integer NOT NULL,
    name character varying(150) NOT NULL,
    audio_file character varying(100) NOT NULL,
    created_date timestamp with time zone NOT NULL,
    updated_date timestamp with time zone NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE alcpt.audio_file OWNER TO postgres;

--
-- Name: audio_file_id_seq; Type: SEQUENCE; Schema: alcpt; Owner: postgres
--

CREATE SEQUENCE alcpt.audio_file_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE alcpt.audio_file_id_seq OWNER TO postgres;

--
-- Name: audio_file_id_seq; Type: SEQUENCE OWNED BY; Schema: alcpt; Owner: postgres
--

ALTER SEQUENCE alcpt.audio_file_id_seq OWNED BY alcpt.audio_file.id;


--
-- Name: auth_group; Type: TABLE; Schema: alcpt; Owner: postgres
--

CREATE TABLE alcpt.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE alcpt.auth_group OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: alcpt; Owner: postgres
--

CREATE SEQUENCE alcpt.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE alcpt.auth_group_id_seq OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: alcpt; Owner: postgres
--

ALTER SEQUENCE alcpt.auth_group_id_seq OWNED BY alcpt.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: alcpt; Owner: postgres
--

CREATE TABLE alcpt.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE alcpt.auth_group_permissions OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: alcpt; Owner: postgres
--

CREATE SEQUENCE alcpt.auth_group_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE alcpt.auth_group_permissions_id_seq OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: alcpt; Owner: postgres
--

ALTER SEQUENCE alcpt.auth_group_permissions_id_seq OWNED BY alcpt.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: alcpt; Owner: postgres
--

CREATE TABLE alcpt.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE alcpt.auth_permission OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: alcpt; Owner: postgres
--

CREATE SEQUENCE alcpt.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE alcpt.auth_permission_id_seq OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: alcpt; Owner: postgres
--

ALTER SEQUENCE alcpt.auth_permission_id_seq OWNED BY alcpt.auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: alcpt; Owner: postgres
--

CREATE TABLE alcpt.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(30) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE alcpt.auth_user OWNER TO postgres;

--
-- Name: auth_user_groups; Type: TABLE; Schema: alcpt; Owner: postgres
--

CREATE TABLE alcpt.auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE alcpt.auth_user_groups OWNER TO postgres;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: alcpt; Owner: postgres
--

CREATE SEQUENCE alcpt.auth_user_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE alcpt.auth_user_groups_id_seq OWNER TO postgres;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: alcpt; Owner: postgres
--

ALTER SEQUENCE alcpt.auth_user_groups_id_seq OWNED BY alcpt.auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: alcpt; Owner: postgres
--

CREATE SEQUENCE alcpt.auth_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE alcpt.auth_user_id_seq OWNER TO postgres;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: alcpt; Owner: postgres
--

ALTER SEQUENCE alcpt.auth_user_id_seq OWNED BY alcpt.auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: alcpt; Owner: postgres
--

CREATE TABLE alcpt.auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE alcpt.auth_user_user_permissions OWNER TO postgres;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: alcpt; Owner: postgres
--

CREATE SEQUENCE alcpt.auth_user_user_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE alcpt.auth_user_user_permissions_id_seq OWNER TO postgres;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: alcpt; Owner: postgres
--

ALTER SEQUENCE alcpt.auth_user_user_permissions_id_seq OWNED BY alcpt.auth_user_user_permissions.id;


--
-- Name: captcha_captchastore; Type: TABLE; Schema: alcpt; Owner: postgres
--

CREATE TABLE alcpt.captcha_captchastore (
    id integer NOT NULL,
    challenge character varying(32) NOT NULL,
    response character varying(32) NOT NULL,
    hashkey character varying(40) NOT NULL,
    expiration timestamp with time zone NOT NULL
);


ALTER TABLE alcpt.captcha_captchastore OWNER TO postgres;

--
-- Name: captcha_captchastore_id_seq; Type: SEQUENCE; Schema: alcpt; Owner: postgres
--

CREATE SEQUENCE alcpt.captcha_captchastore_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE alcpt.captcha_captchastore_id_seq OWNER TO postgres;

--
-- Name: captcha_captchastore_id_seq; Type: SEQUENCE OWNED BY; Schema: alcpt; Owner: postgres
--

ALTER SEQUENCE alcpt.captcha_captchastore_id_seq OWNED BY alcpt.captcha_captchastore.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: alcpt; Owner: postgres
--

CREATE TABLE alcpt.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag integer NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL
);


ALTER TABLE alcpt.django_admin_log OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: alcpt; Owner: postgres
--

CREATE SEQUENCE alcpt.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE alcpt.django_admin_log_id_seq OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: alcpt; Owner: postgres
--

ALTER SEQUENCE alcpt.django_admin_log_id_seq OWNED BY alcpt.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: alcpt; Owner: postgres
--

CREATE TABLE alcpt.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE alcpt.django_content_type OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: alcpt; Owner: postgres
--

CREATE SEQUENCE alcpt.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE alcpt.django_content_type_id_seq OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: alcpt; Owner: postgres
--

ALTER SEQUENCE alcpt.django_content_type_id_seq OWNED BY alcpt.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: alcpt; Owner: postgres
--

CREATE TABLE alcpt.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE alcpt.django_migrations OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: alcpt; Owner: postgres
--

CREATE SEQUENCE alcpt.django_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE alcpt.django_migrations_id_seq OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: alcpt; Owner: postgres
--

ALTER SEQUENCE alcpt.django_migrations_id_seq OWNED BY alcpt.django_migrations.id;


--
-- Name: django_plotly_dash_dashapp; Type: TABLE; Schema: alcpt; Owner: postgres
--

CREATE TABLE alcpt.django_plotly_dash_dashapp (
    id integer NOT NULL,
    instance_name character varying(100) NOT NULL,
    slug character varying(110) NOT NULL,
    base_state text NOT NULL,
    creation timestamp with time zone NOT NULL,
    update timestamp with time zone NOT NULL,
    save_on_change boolean NOT NULL,
    stateless_app_id integer NOT NULL
);


ALTER TABLE alcpt.django_plotly_dash_dashapp OWNER TO postgres;

--
-- Name: django_plotly_dash_dashapp_id_seq; Type: SEQUENCE; Schema: alcpt; Owner: postgres
--

CREATE SEQUENCE alcpt.django_plotly_dash_dashapp_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE alcpt.django_plotly_dash_dashapp_id_seq OWNER TO postgres;

--
-- Name: django_plotly_dash_dashapp_id_seq; Type: SEQUENCE OWNED BY; Schema: alcpt; Owner: postgres
--

ALTER SEQUENCE alcpt.django_plotly_dash_dashapp_id_seq OWNED BY alcpt.django_plotly_dash_dashapp.id;


--
-- Name: django_plotly_dash_statelessapp; Type: TABLE; Schema: alcpt; Owner: postgres
--

CREATE TABLE alcpt.django_plotly_dash_statelessapp (
    id integer NOT NULL,
    app_name character varying(100) NOT NULL,
    slug character varying(110) NOT NULL
);


ALTER TABLE alcpt.django_plotly_dash_statelessapp OWNER TO postgres;

--
-- Name: django_plotly_dash_statelessapp_id_seq; Type: SEQUENCE; Schema: alcpt; Owner: postgres
--

CREATE SEQUENCE alcpt.django_plotly_dash_statelessapp_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE alcpt.django_plotly_dash_statelessapp_id_seq OWNER TO postgres;

--
-- Name: django_plotly_dash_statelessapp_id_seq; Type: SEQUENCE OWNED BY; Schema: alcpt; Owner: postgres
--

ALTER SEQUENCE alcpt.django_plotly_dash_statelessapp_id_seq OWNED BY alcpt.django_plotly_dash_statelessapp.id;


--
-- Name: django_session; Type: TABLE; Schema: alcpt; Owner: postgres
--

CREATE TABLE alcpt.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE alcpt.django_session OWNER TO postgres;

--
-- Name: alcpt_achievement id; Type: DEFAULT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_achievement ALTER COLUMN id SET DEFAULT nextval('alcpt.alcpt_achievement_id_seq'::regclass);


--
-- Name: alcpt_answer id; Type: DEFAULT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_answer ALTER COLUMN id SET DEFAULT nextval('alcpt.alcpt_answer_id_seq'::regclass);


--
-- Name: alcpt_answersheet id; Type: DEFAULT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_answersheet ALTER COLUMN id SET DEFAULT nextval('alcpt.alcpt_answersheet_id_seq'::regclass);


--
-- Name: alcpt_choice id; Type: DEFAULT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_choice ALTER COLUMN id SET DEFAULT nextval('alcpt.alcpt_choice_id_seq'::regclass);


--
-- Name: alcpt_department id; Type: DEFAULT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_department ALTER COLUMN id SET DEFAULT nextval('alcpt.alcpt_department_id_seq'::regclass);


--
-- Name: alcpt_exam id; Type: DEFAULT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_exam ALTER COLUMN id SET DEFAULT nextval('alcpt.alcpt_exam_id_seq'::regclass);


--
-- Name: alcpt_exam_testeelist id; Type: DEFAULT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_exam_testeelist ALTER COLUMN id SET DEFAULT nextval('alcpt.alcpt_exam_testeelist_id_seq'::regclass);


--
-- Name: alcpt_forum id; Type: DEFAULT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_forum ALTER COLUMN id SET DEFAULT nextval('alcpt.alcpt_forum_id_seq'::regclass);


--
-- Name: alcpt_group id; Type: DEFAULT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_group ALTER COLUMN id SET DEFAULT nextval('alcpt.alcpt_group_id_seq'::regclass);


--
-- Name: alcpt_group_member id; Type: DEFAULT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_group_member ALTER COLUMN id SET DEFAULT nextval('alcpt.alcpt_group_member_id_seq'::regclass);


--
-- Name: alcpt_proclamation id; Type: DEFAULT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_proclamation ALTER COLUMN id SET DEFAULT nextval('alcpt.alcpt_proclamation_id_seq'::regclass);


--
-- Name: alcpt_question id; Type: DEFAULT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_question ALTER COLUMN id SET DEFAULT nextval('alcpt.alcpt_question_id_seq'::regclass);


--
-- Name: alcpt_question_favorite id; Type: DEFAULT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_question_favorite ALTER COLUMN id SET DEFAULT nextval('alcpt.alcpt_question_favorite_id_seq'::regclass);


--
-- Name: alcpt_reply id; Type: DEFAULT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_reply ALTER COLUMN id SET DEFAULT nextval('alcpt.alcpt_reply_id_seq'::regclass);


--
-- Name: alcpt_report id; Type: DEFAULT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_report ALTER COLUMN id SET DEFAULT nextval('alcpt.alcpt_report_id_seq'::regclass);


--
-- Name: alcpt_reportcategory id; Type: DEFAULT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_reportcategory ALTER COLUMN id SET DEFAULT nextval('alcpt.alcpt_reportcategory_id_seq'::regclass);


--
-- Name: alcpt_squadron id; Type: DEFAULT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_squadron ALTER COLUMN id SET DEFAULT nextval('alcpt.alcpt_squadron_id_seq'::regclass);


--
-- Name: alcpt_student id; Type: DEFAULT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_student ALTER COLUMN id SET DEFAULT nextval('alcpt.alcpt_student_id_seq'::regclass);


--
-- Name: alcpt_testpaper id; Type: DEFAULT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_testpaper ALTER COLUMN id SET DEFAULT nextval('alcpt.alcpt_testpaper_id_seq'::regclass);


--
-- Name: alcpt_testpaper_question_list id; Type: DEFAULT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_testpaper_question_list ALTER COLUMN id SET DEFAULT nextval('alcpt.alcpt_testpaper_question_list_id_seq'::regclass);


--
-- Name: alcpt_user id; Type: DEFAULT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_user ALTER COLUMN id SET DEFAULT nextval('alcpt.alcpt_user_id_seq'::regclass);


--
-- Name: alcpt_userachievement id; Type: DEFAULT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_userachievement ALTER COLUMN id SET DEFAULT nextval('alcpt.alcpt_userachievement_id_seq'::regclass);


--
-- Name: alcpt_word id; Type: DEFAULT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_word ALTER COLUMN id SET DEFAULT nextval('alcpt.alcpt_word_id_seq'::regclass);


--
-- Name: alcpt_word_library id; Type: DEFAULT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_word_library ALTER COLUMN id SET DEFAULT nextval('alcpt.alcpt_word_library_id_seq'::regclass);


--
-- Name: audio_file id; Type: DEFAULT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.audio_file ALTER COLUMN id SET DEFAULT nextval('alcpt.audio_file_id_seq'::regclass);


--
-- Name: auth_group id; Type: DEFAULT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.auth_group ALTER COLUMN id SET DEFAULT nextval('alcpt.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('alcpt.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.auth_permission ALTER COLUMN id SET DEFAULT nextval('alcpt.auth_permission_id_seq'::regclass);


--
-- Name: auth_user id; Type: DEFAULT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.auth_user ALTER COLUMN id SET DEFAULT nextval('alcpt.auth_user_id_seq'::regclass);


--
-- Name: auth_user_groups id; Type: DEFAULT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.auth_user_groups ALTER COLUMN id SET DEFAULT nextval('alcpt.auth_user_groups_id_seq'::regclass);


--
-- Name: auth_user_user_permissions id; Type: DEFAULT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('alcpt.auth_user_user_permissions_id_seq'::regclass);


--
-- Name: captcha_captchastore id; Type: DEFAULT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.captcha_captchastore ALTER COLUMN id SET DEFAULT nextval('alcpt.captcha_captchastore_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.django_admin_log ALTER COLUMN id SET DEFAULT nextval('alcpt.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.django_content_type ALTER COLUMN id SET DEFAULT nextval('alcpt.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.django_migrations ALTER COLUMN id SET DEFAULT nextval('alcpt.django_migrations_id_seq'::regclass);


--
-- Name: django_plotly_dash_dashapp id; Type: DEFAULT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.django_plotly_dash_dashapp ALTER COLUMN id SET DEFAULT nextval('alcpt.django_plotly_dash_dashapp_id_seq'::regclass);


--
-- Name: django_plotly_dash_statelessapp id; Type: DEFAULT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.django_plotly_dash_statelessapp ALTER COLUMN id SET DEFAULT nextval('alcpt.django_plotly_dash_statelessapp_id_seq'::regclass);


--
-- Data for Name: alcpt_achievement; Type: TABLE DATA; Schema: alcpt; Owner: postgres
--

COPY alcpt.alcpt_achievement (id, name, key, description, category, point, level, completion, trophy) FROM stdin;
13	鑑測新手	模擬測驗1次	模擬測驗1次	1	50	1	1	photos/default_trophy_lHo5TbD.png
14	在鑑測的路上	模擬測驗3次	模擬測驗3次	1	200	1	3	photos/default_trophy_ZMyAq8R.png
15	誰說模擬考很困難	模擬測驗5次	模擬測驗5次	1	500	1	5	photos/default_trophy_Rxmwfxh.png
16	模擬考大佬	模擬測驗7次	模擬測驗7次	1	1000	1	7	photos/default_trophy_3tojuCa.png
17	黑道老大	模擬測驗9次	模擬測驗9次	1	1500	1	9	photos/default_trophy_c6F1D2Y.png
18	CEO	模擬測驗12次	模擬測驗12次	1	2000	1	12	photos/default_trophy_Ga1DFri.png
19	薑還是老的辣	模擬測驗15次	模擬測驗15次	1	2500	1	15	photos/default_trophy_33FRKne.png
20	聽力新手登場	聽力練習1次	聽力練習1次	3	50	1	1	photos/default_trophy_MIIz214.png
21	發掘英文聽力之路	聽力練習5次	聽力練習5次	3	100	1	5	photos/default_trophy_MIIz214.png
22	誰說聽力很困難	聽力練習10次	聽力練習10次	3	100	1	10	photos/default_trophy_rltPrpX.png
23	聽力真正的開始	聽力練習20次	聽力練習20次	3	200	1	20	photos/default_trophy_uFTbtk0.png
24	聽力回不去了	聽力練習30次	聽力練習30次	3	200	1	30	photos/default_trophy_vcZ8mIV.png
25	不可能的聽力	聽力練習50次	聽力練習50次	3	500	1	50	photos/default_trophy_xPOKnsV.png
26	上帝也在聽	聽力練習100次	聽力練習100次	3	1000	1	100	photos/default_trophy_yzLHNea.png
27	閱讀新手登場	閱讀練習1次	閱讀練習1次	4	50	1	1	photos/default_trophy_yzLHNea.png
28	發掘閱讀英文之路	閱讀練習5次	閱讀練習5次	4	100	1	5	photos/default_trophy_yzLHNea.png
29	誰說閱讀英文很困難	閱讀練習10次	閱讀練習10次	4	100	1	10	photos/default_trophy_yzLHNea.png
30	閱讀真正的開始	閱讀練習20次	閱讀練習20次	4	100	1	20	photos/default_trophy_yzLHNea.png
31	回不去的閱讀	閱讀練習30次	閱讀練習30次	4	200	1	30	photos/default_trophy_yzLHNea.png
32	不可能的閱讀	閱讀練習50次	閱讀練習50次	4	500	1	50	photos/default_trophy_yzLHNea.png
33	上帝也閱讀	閱讀練習100次	閱讀練習100次	4	1000	1	100	photos/default_trophy_yzLHNea.png
34	衝鋒敢死隊	模擬考30分以下1次	閱讀練習30分以下1次	5	50	1	1	photos/default_trophy_yzLHNea.png
35	靜心大師	模擬考30分以下3次	閱讀練習30分以下3次	5	100	1	3	photos/default_trophy_yzLHNea.png
36	我能怎麼辦我也很絕望啊	模擬考30分以下5次	閱讀練習30分以下5次	5	200	1	5	photos/default_trophy_yzLHNea.png
37	真沒意思	聽力練習30分以下1次	聽力練習30分以下1次	6	50	1	1	photos/default_trophy_yzLHNea.png
38	我聽不懂	聽力練習30分以下3次	聽力練習30分以下3次	6	100	1	3	photos/default_trophy_yzLHNea.png
39	蛋蛋管理員	聽力練習30分以下5次	聽力練習30分以下5次	6	200	1	5	photos/default_trophy_yzLHNea.png
40	有什麼好怕的	閱讀練習30分以下1次	閱讀練習30分以下1次	7	50	1	1	photos/default_trophy_yzLHNea.png
41	出來混，遲早是要還的	閱讀練習30分以下3次	閱讀練習30分以下3次	7	100	1	3	photos/default_trophy_yzLHNea.png
42	越在乎越珍惜	閱讀練習30分以下5次	閱讀練習30分以下5次	7	200	1	5	photos/default_trophy_yzLHNea.png
\.


--
-- Data for Name: alcpt_answer; Type: TABLE DATA; Schema: alcpt; Owner: postgres
--

COPY alcpt.alcpt_answer (id, selected, answer_sheet_id, question_id) FROM stdin;
1788	-1	68	43
1789	-1	68	47
1790	-1	68	537
1791	-1	68	33
1792	-1	68	41
1793	-1	68	31
1794	-1	68	40
1795	-1	68	45
1796	-1	68	44
1797	-1	68	42
1798	-1	69	190
1799	-1	69	277
1800	-1	69	294
1801	-1	69	289
1802	-1	69	129
1803	-1	69	270
1804	-1	69	264
1805	-1	69	214
1806	-1	69	281
1807	-1	69	132
1808	1	70	34
1809	1	70	29
1810	1	70	60
1811	1	70	5
1812	1	70	35
1813	1	70	1
1814	1	70	37
1815	1	70	33
1816	1	70	42
1817	1	70	31
1818	1	70	44
1819	1	70	47
1820	1	70	41
1821	1	70	46
1822	1	70	537
1823	-1	71	33
1824	-1	71	537
1825	-1	71	60
1826	-1	71	42
1827	-1	71	31
1828	-1	71	37
1829	-1	71	34
1830	-1	71	35
1831	-1	71	41
1832	-1	71	46
1833	-1	71	44
1834	-1	71	29
1835	-1	71	1
1836	-1	71	47
1837	-1	71	5
1838	-1	72	44
1839	-1	72	34
1840	-1	72	537
1841	-1	72	41
1842	-1	72	5
1843	-1	72	42
1844	-1	72	31
1845	-1	72	60
1846	-1	72	1
1847	-1	72	46
1848	-1	72	37
1849	-1	72	35
1850	-1	72	33
1851	-1	72	47
1852	-1	72	29
1853	1	73	35
1854	2	73	37
1855	2	73	29
1856	1	73	5
1857	3	73	41
1858	4	73	44
1859	2	73	42
1860	3	73	34
1861	2	73	537
1862	3	73	1
1863	2	73	33
1864	2	73	47
1865	2	73	60
1866	3	73	31
1867	3	73	46
1868	-1	74	1
1869	-1	74	34
1870	-1	74	35
1871	-1	74	5
1872	-1	74	42
1873	-1	74	33
1874	-1	74	60
1875	-1	74	46
1876	-1	74	44
1877	-1	74	537
1878	-1	74	29
1879	-1	74	31
1880	-1	74	47
1881	-1	74	41
1882	-1	74	37
1883	-1	75	34
1884	-1	75	29
1885	-1	75	47
1886	-1	75	537
1887	-1	75	35
1888	-1	75	41
1889	-1	75	1
1890	-1	75	42
1891	-1	75	33
1892	-1	75	31
1893	-1	75	44
1894	-1	75	46
1895	-1	75	5
1896	-1	75	60
1897	-1	75	37
1898	2	76	47
1899	2	76	537
1900	3	76	41
1901	3	76	37
1902	2	76	46
1903	2	76	1
1904	3	76	42
1905	2	76	34
1906	2	76	33
1907	3	76	5
1908	3	76	29
1909	3	76	35
1910	3	76	31
1911	3	76	44
1912	3	76	60
1913	-1	77	37
1914	-1	77	41
1915	-1	77	33
1916	-1	77	1
1917	-1	77	60
1918	-1	77	29
1919	-1	77	42
1920	-1	77	5
1921	-1	77	35
1922	-1	77	31
1923	-1	77	34
1924	-1	77	46
1925	-1	77	47
1926	-1	77	44
1927	-1	77	537
1928	-1	78	47
1929	-1	78	537
1930	-1	78	35
1931	-1	78	44
1932	-1	78	1
1933	-1	78	29
1934	-1	78	41
1935	-1	78	42
1936	-1	78	33
1937	-1	78	31
1938	-1	78	46
1939	-1	78	60
1940	-1	78	34
1941	-1	78	37
1942	-1	78	5
1943	1	79	37
1944	4	79	43
1945	1	79	32
1946	1	79	33
1947	3	79	46
1948	3	79	31
1949	2	79	60
1950	3	79	1
1951	3	79	5
1952	3	79	29
1953	1	80	44
1954	2	80	46
1955	2	80	29
1956	2	80	1
1957	3	80	41
1958	3	80	33
1959	3	80	42
1960	2	80	31
1961	2	80	47
1962	3	80	37
1963	3	80	60
1964	4	80	5
1965	3	80	537
1966	3	80	34
1967	3	80	35
1968	-1	81	46
1969	-1	81	37
1970	-1	81	537
1971	-1	81	5
1972	-1	81	35
1973	-1	81	42
1974	-1	81	31
1975	-1	81	1
1976	-1	81	60
1977	-1	81	34
1978	-1	81	41
1979	-1	81	33
1980	-1	81	47
1981	-1	81	44
1982	-1	81	29
1983	-1	82	41
1984	-1	82	31
1985	-1	82	1
1986	-1	82	37
1987	-1	82	34
1988	-1	82	42
1989	-1	82	537
1990	-1	82	46
1991	-1	82	35
1992	-1	82	33
1993	-1	82	5
1994	-1	82	47
1995	-1	82	44
1996	-1	82	60
1997	-1	82	29
1998	-1	83	5
1999	-1	83	48
2000	-1	83	32
2001	-1	83	29
2002	-1	83	37
2003	-1	83	34
2004	-1	83	537
2005	-1	83	1
2006	-1	83	45
2007	-1	83	60
2008	-1	84	47
2009	-1	84	37
2010	-1	84	34
2011	-1	84	35
2012	-1	84	32
2013	-1	84	31
2014	-1	84	45
2015	-1	84	42
2016	-1	84	33
2017	-1	84	29
2018	-1	84	48
2019	-1	84	43
2020	-1	84	40
2021	-1	84	537
2022	-1	84	5
2023	-1	85	31
2024	-1	85	37
2025	-1	85	43
2026	-1	85	537
2027	-1	85	33
2028	-1	85	29
2029	-1	85	34
2030	-1	85	42
2031	-1	85	48
2032	-1	85	5
2033	-1	85	47
2034	-1	85	40
2035	-1	85	35
2036	-1	85	45
2037	-1	85	32
2038	1	86	45
2039	2	86	40
2040	1	86	537
2041	-1	86	33
2042	-1	86	42
2043	-1	86	34
2044	-1	86	31
2045	-1	86	37
2046	-1	86	29
2047	-1	86	32
2048	-1	86	35
2049	-1	86	5
2050	-1	86	43
2051	-1	86	47
2052	-1	86	48
2053	-1	87	43
2054	-1	87	45
2055	-1	87	36
2056	-1	87	537
2057	-1	87	5
2058	-1	87	33
2059	-1	87	47
2060	-1	87	48
2061	-1	87	37
2062	-1	87	32
2063	-1	88	32
2064	-1	88	37
2065	-1	88	34
2066	-1	88	537
2067	-1	88	33
2068	-1	88	40
2069	-1	88	44
2070	-1	88	42
2071	-1	88	47
2072	-1	88	60
2073	1	89	40
2074	3	89	46
2075	4	89	1
2076	4	89	35
2077	1	89	34
2078	1	89	48
2079	1	89	537
2080	1	89	45
2081	1	89	43
2082	1	89	36
2083	3	90	41
2084	4	90	1
2085	2	90	31
2086	2	90	42
2087	4	90	47
2088	2	90	5
2089	2	90	44
2090	4	90	33
2091	3	90	46
2092	2	90	537
2093	4	90	29
2094	1	90	37
2095	4	90	34
2096	4	90	35
2097	3	90	60
2098	-1	91	46
2099	-1	91	5
2100	-1	91	34
2101	-1	91	47
2102	-1	91	1
2103	-1	91	35
2104	-1	91	60
2105	-1	91	42
2106	-1	91	41
2107	-1	91	33
2108	-1	91	31
2109	-1	91	44
2110	-1	91	37
2111	-1	91	537
2112	-1	91	29
2113	-1	92	41
2114	-1	92	31
2115	-1	92	46
2116	-1	92	34
2117	-1	92	60
2118	-1	92	537
2119	-1	92	44
2120	-1	92	33
2121	-1	92	29
2122	-1	92	47
2123	-1	92	42
2124	-1	92	37
2125	-1	92	5
2126	-1	92	1
2127	-1	92	35
2128	2	93	290
2129	2	93	214
2130	2	93	153
2131	2	93	157
2132	2	93	146
2133	2	93	294
2134	2	93	192
2135	2	93	289
2136	2	93	155
2137	2	93	263
2138	1	94	28
2139	3	94	145
2140	1	94	282
2141	3	94	208
2142	4	94	256
2143	1	94	154
2144	2	94	219
2145	1	94	128
2146	3	94	206
2147	3	94	126
2148	2	95	104
2149	2	95	74
2150	3	95	88
2151	1	95	67
2152	2	95	49
2153	4	95	77
2154	3	95	90
2155	1	95	75
2156	2	95	55
2157	2	95	111
2158	3	96	339
2159	3	96	236
2160	2	96	282
2161	4	96	277
2162	3	96	213
2163	1	96	202
2164	1	96	298
2165	1	96	85
2166	1	96	148
2167	1	96	31
2168	1	96	297
2169	1	96	6
2170	1	96	165
2171	1	96	155
2172	1	96	128
2173	1	96	279
2174	1	96	201
2175	1	96	100
2176	1	96	110
2177	1	96	299
2178	1	96	347
2179	1	96	166
2180	1	96	42
2181	1	96	303
2182	1	96	296
2183	1	96	72
2184	1	96	139
2185	1	96	33
2186	1	96	341
2187	1	96	48
2188	1	96	184
2189	1	96	36
2190	1	96	178
2191	1	96	209
2192	1	96	109
2193	1	96	159
2194	1	96	210
2195	1	96	344
2196	1	96	1
2197	1	96	211
2198	1	96	50
2199	1	96	130
2200	1	96	182
2201	1	96	37
2202	1	96	238
2203	1	96	80
2204	1	96	53
2205	1	96	284
2206	1	96	343
2207	1	96	134
2208	1	96	143
2209	1	96	194
2210	1	96	345
2211	1	96	29
2212	1	96	266
2213	1	96	113
2214	1	96	176
2215	1	96	164
2216	1	96	52
2217	1	96	87
2218	1	96	340
2219	1	96	177
2220	1	96	179
2221	1	96	180
2222	1	96	204
2223	1	96	346
2224	1	96	196
2225	1	96	103
2226	1	96	261
2227	1	96	47
2228	1	96	203
2229	1	96	115
2230	1	96	304
2231	1	96	218
2232	1	96	78
2233	1	96	280
2234	1	96	40
2235	1	96	181
2236	1	96	43
2237	1	96	154
2238	1	96	288
2239	1	96	243
2240	1	96	167
2241	1	96	183
2242	1	96	46
2243	1	96	32
2244	1	96	54
2245	1	96	142
2246	1	96	175
2247	1	96	172
2248	1	96	190
2249	1	96	193
2250	1	96	192
2251	1	96	141
2252	1	96	302
2253	1	96	44
2254	1	96	189
2255	1	96	537
2256	1	96	348
2257	1	96	171
2258	1	97	40
2259	3	97	47
2260	3	97	5
2261	2	97	37
2262	3	97	45
2263	4	97	60
2264	3	97	46
2265	2	97	31
2266	1	97	539
2267	4	97	44
2268	1	98	44
2269	2	98	29
2270	3	98	37
2271	1	98	47
2272	4	98	41
2273	2	98	33
2274	3	98	46
2275	3	98	60
2276	1	98	42
2277	4	98	31
2278	1	99	82
2279	2	99	42
2280	3	99	111
2281	4	99	72
2282	2	99	33
2283	1	99	81
2284	3	99	1
2285	1	99	29
2286	4	99	2
2287	3	99	47
2288	1	100	125
2289	3	100	130
2290	4	100	134
2291	3	100	150
2292	2	100	141
2293	4	100	289
2294	1	100	282
2295	2	100	204
2296	3	100	148
2297	4	100	196
2298	1	101	236
2299	2	101	305
2300	3	101	303
2301	4	101	184
2302	1	101	304
2303	1	101	175
2304	3	101	297
2305	2	101	177
2306	1	101	299
2307	4	101	300
2308	2	102	537
2309	4	102	33
2310	2	102	44
2311	4	102	34
2312	1	102	31
2313	4	102	46
2314	2	102	42
2315	4	102	47
2316	1	102	37
2317	4	102	29
2318	3	102	41
2319	2	102	5
2320	4	102	35
2321	3	102	60
2322	4	102	1
2323	2	103	41
2324	3	103	35
2325	2	103	29
2326	3	103	37
2327	2	103	537
2328	1	103	34
2329	4	103	1
2330	3	103	5
2331	2	103	60
2332	3	103	42
2333	2	103	31
2334	2	103	46
2335	3	103	44
2336	2	103	33
2337	4	103	47
2338	-1	104	42
2339	-1	104	46
2340	-1	104	537
2341	-1	104	44
2342	-1	104	29
2343	-1	104	5
2344	-1	104	31
2345	-1	104	60
2346	-1	104	1
2347	-1	104	47
2348	-1	104	35
2349	-1	104	41
2350	-1	104	33
2351	-1	104	37
2352	-1	104	34
2353	4	105	46
2354	3	105	60
2355	2	105	36
2356	2	105	5
2357	3	105	32
2358	3	105	41
2359	4	105	47
2360	4	105	29
2361	1	105	43
2362	1	105	48
2363	4	105	1
2364	2	105	44
2365	1	105	40
2366	3	105	34
2367	1	105	539
2368	4	106	32
2369	4	106	47
2370	4	106	29
2371	1	106	539
2372	1	106	40
2373	4	106	46
2374	4	106	34
2375	3	106	36
2376	1	106	48
2377	4	106	1
2378	3	106	41
2379	2	106	5
2380	1	106	43
2381	2	106	44
2382	3	106	60
2383	3	107	46
2384	2	107	5
2385	3	107	41
2386	3	107	32
2387	4	107	1
2388	1	107	48
2389	4	107	34
2390	4	107	47
2391	1	107	43
2392	1	107	40
2393	2	107	44
2394	1	107	539
2395	3	107	60
2396	2	107	36
2397	4	107	29
2398	4	108	1
2399	3	108	36
2400	4	108	46
2401	3	108	43
2402	1	108	539
2403	1	108	34
2404	1	108	40
2405	4	108	32
2406	4	108	60
2407	1	108	5
2408	2	108	44
2409	4	108	29
2410	1	108	48
2411	4	108	47
2412	3	108	41
2413	1	109	48
2414	2	109	5
2415	3	109	32
2416	4	109	47
2417	3	109	60
2418	1	109	539
2419	3	109	46
2420	2	109	44
2421	4	109	34
2422	4	109	29
2423	1	109	40
2424	4	109	1
2425	4	109	43
2426	2	109	36
2427	3	109	41
2428	1	110	33
2429	2	110	35
2430	3	110	29
2431	2	110	44
2432	-1	110	5
2433	-1	110	41
2434	-1	110	31
2435	-1	110	42
2436	-1	110	46
2437	-1	110	47
2438	-1	110	537
2439	-1	110	37
2440	-1	110	34
2441	-1	110	1
2442	-1	110	60
2443	-1	111	1
2444	-1	111	5
2445	-1	111	35
2446	-1	111	537
2447	-1	111	44
2448	-1	111	34
2449	-1	111	42
2450	-1	111	41
2451	-1	111	33
2452	-1	111	29
2453	-1	111	60
2454	-1	111	31
2455	-1	111	47
2456	-1	111	37
2457	-1	111	46
2458	-1	112	31
2459	-1	112	33
2460	-1	112	29
2461	-1	112	34
2462	-1	112	37
2463	-1	112	5
2464	-1	112	537
2465	-1	112	44
2466	-1	112	60
2467	-1	112	35
2468	-1	112	46
2469	-1	112	42
2470	-1	112	41
2471	-1	112	1
2472	-1	112	47
2473	-1	113	44
2474	-1	113	1
2475	-1	113	31
2476	-1	113	537
2477	-1	113	34
2478	-1	113	42
2479	-1	113	37
2480	-1	113	46
2481	-1	113	60
2482	-1	113	33
2483	-1	113	35
2484	-1	113	47
2485	-1	113	29
2486	-1	113	41
2487	-1	113	5
2488	-1	114	60
2489	-1	114	41
2490	-1	114	44
2491	-1	114	5
2492	-1	114	537
2493	-1	114	35
2494	-1	114	33
2495	-1	114	42
2496	-1	114	46
2497	-1	114	31
2498	-1	114	37
2499	-1	114	1
2500	-1	114	29
2501	-1	114	34
2502	-1	114	47
2503	1	115	43
2504	-1	115	300
2505	-1	115	31
2506	-1	115	47
2507	-1	115	60
2508	-1	115	236
2509	-1	115	180
2510	-1	115	539
2511	-1	115	41
2512	-1	115	5
2513	-1	115	40
2514	-1	115	1
2515	-1	115	34
2516	-1	115	183
2517	-1	115	296
2518	-1	115	181
2519	-1	115	299
2520	-1	115	48
2521	-1	115	175
2522	-1	115	179
2523	-1	115	297
2524	-1	115	238
2525	-1	115	302
2526	-1	115	304
2527	-1	115	298
2528	-1	115	45
2529	-1	115	32
2530	-1	115	305
2531	-1	115	177
2532	-1	115	46
2533	-1	115	537
2534	-1	115	182
2535	-1	115	243
2536	-1	115	176
2537	-1	115	303
2538	-1	116	32
2539	-1	116	238
2540	-1	116	300
2541	-1	116	302
2542	-1	116	243
2543	-1	116	183
2544	-1	116	45
2545	-1	116	299
2546	-1	116	47
2547	-1	116	48
2548	-1	116	236
2549	-1	116	40
2550	-1	116	41
2551	-1	116	297
2552	-1	116	182
2553	-1	116	43
2554	-1	116	303
2555	-1	116	305
2556	-1	116	177
2557	-1	116	31
2558	-1	116	34
2559	-1	116	176
2560	-1	116	181
2561	-1	116	537
2562	-1	116	539
2563	-1	116	46
2564	-1	116	5
2565	-1	116	304
2566	-1	116	1
2567	-1	116	175
2568	-1	116	298
2569	-1	116	180
2570	-1	116	296
2571	-1	116	179
2572	-1	116	60
2573	-1	117	296
2574	-1	117	298
2575	-1	117	300
2576	-1	117	46
2577	-1	117	238
2578	-1	117	179
2579	-1	117	297
2580	-1	117	31
2581	-1	117	181
2582	-1	117	47
2583	-1	117	45
2584	-1	117	182
2585	-1	117	539
2586	-1	117	5
2587	-1	117	175
2588	-1	117	180
2589	-1	117	32
2590	-1	117	34
2591	-1	117	299
2592	-1	117	48
2593	-1	117	41
2594	-1	117	1
2595	-1	117	304
2596	-1	117	236
2597	-1	117	537
2598	-1	117	43
2599	-1	117	183
2600	-1	117	243
2601	-1	117	176
2602	-1	117	60
2603	-1	117	40
2604	-1	117	305
2605	-1	117	302
2606	-1	117	177
2607	-1	117	303
2608	-1	118	5
2609	-1	118	180
2610	-1	118	236
2611	-1	118	297
2612	-1	118	303
2613	-1	118	40
2614	-1	118	179
2615	-1	118	183
2616	-1	118	305
2617	-1	118	304
2618	-1	118	302
2619	-1	118	48
2620	-1	118	298
2621	-1	118	296
2622	-1	118	32
2623	-1	118	60
2624	-1	118	176
2625	-1	118	45
2626	-1	118	47
2627	-1	118	539
2628	-1	118	43
2629	-1	118	177
2630	-1	118	243
2631	-1	118	46
2632	-1	118	238
2633	-1	118	34
2634	-1	118	175
2635	-1	118	300
2636	-1	118	537
2637	-1	118	182
2638	-1	118	1
2639	-1	118	299
2640	-1	118	41
2641	-1	118	31
2642	-1	118	181
2643	-1	119	34
2644	-1	119	243
2645	-1	119	47
2646	-1	119	303
2647	-1	119	182
2648	-1	119	41
2649	-1	119	176
2650	-1	119	305
2651	-1	119	300
2652	-1	119	40
2653	-1	119	298
2654	-1	119	179
2655	-1	119	299
2656	-1	119	32
2657	-1	119	238
2658	-1	119	180
2659	-1	119	48
2660	-1	119	46
2661	-1	119	181
2662	-1	119	296
2663	-1	119	537
2664	-1	119	177
2665	-1	119	175
2666	-1	119	43
2667	-1	119	45
2668	-1	119	302
2669	-1	119	31
2670	-1	119	236
2671	-1	119	539
2672	-1	119	297
2673	-1	119	60
2674	-1	119	5
2675	-1	119	304
2676	-1	119	183
2677	-1	119	1
2678	-1	120	35
2679	-1	120	46
2680	-1	120	31
2681	-1	120	47
2682	-1	120	41
2683	-1	120	5
2684	-1	120	37
2685	-1	120	34
2686	-1	120	42
2687	-1	120	44
2688	-1	120	1
2689	-1	120	29
2690	-1	120	537
2691	-1	120	33
2692	-1	120	60
2693	3	121	36
2694	2	121	31
2695	4	121	35
2696	1	121	37
2697	4	121	34
2698	4	121	29
2699	2	121	5
2700	4	121	33
2701	3	121	32
2702	1	121	40
2703	2	122	537
2704	1	122	32
2705	4	122	47
2706	1	122	31
2707	1	122	60
2708	4	122	540
2709	4	122	5
2710	2	122	44
2711	3	122	45
2712	1	122	42
2713	1	123	66
2714	-1	123	116
2715	-1	123	54
2716	-1	123	110
2717	-1	123	85
2718	-1	123	69
2719	-1	123	95
2720	-1	123	71
2721	-1	123	93
2722	-1	123	88
2723	3	124	41
2724	1	124	40
2725	2	124	537
2726	4	124	35
2727	2	124	44
2728	4	124	47
2729	1	124	48
2730	2	124	60
2731	4	124	540
2732	1	124	37
2733	4	125	47
2734	3	125	45
2735	1	125	31
2736	2	125	44
2737	2	125	32
2738	3	125	41
2739	2	125	42
2740	2	125	43
2741	4	125	540
2742	3	125	60
2743	3	126	540
2744	4	126	46
2745	1	126	539
2746	4	126	29
2747	4	126	35
2748	2	126	42
2749	3	126	45
2750	4	126	47
2751	4	126	33
2752	3	126	41
2753	1	127	539
2754	3	127	36
2755	2	127	44
2756	1	127	37
2757	4	127	35
2758	2	127	537
2759	2	127	5
2760	4	127	29
2761	3	127	41
2762	4	127	47
2763	2	128	36
2764	2	128	5
2765	2	128	32
2766	1	128	37
2767	3	128	41
2768	3	128	60
2769	4	128	540
2770	4	128	34
2771	2	128	537
2772	1	128	539
2773	1	129	37
2774	2	129	32
2775	1	129	31
2776	3	129	36
2777	4	129	34
2778	2	129	5
2779	1	129	40
2780	4	129	33
2781	4	129	35
2782	4	129	29
2783	2	130	5
2784	3	130	36
2785	1	130	40
2786	1	130	37
2787	4	130	33
2788	4	130	35
2789	1	130	32
2790	4	130	34
2791	1	130	31
2792	4	130	29
2793	1	131	37
2794	3	131	41
2795	3	131	36
2796	3	131	45
2797	1	131	539
2798	2	131	46
2799	1	131	40
2800	4	131	47
2801	4	131	540
2802	4	131	33
2803	1	132	539
2804	4	132	47
2805	2	132	60
2806	1	132	37
2807	2	132	31
2808	3	132	33
2809	3	132	32
2810	4	132	46
2811	3	132	36
2812	3	132	45
2813	4	133	35
2814	2	133	31
2815	2	133	43
2816	3	133	36
2817	4	133	34
2818	2	133	40
2819	4	133	29
2820	2	133	5
2821	2	133	42
2822	3	133	46
2823	4	134	29
2824	1	134	31
2825	2	134	36
2826	4	134	34
2827	4	134	33
2828	1	134	32
2829	4	134	35
2830	1	134	37
2831	1	134	40
2832	2	134	5
2833	4	135	47
2834	2	135	31
2835	2	135	5
2836	2	135	42
2837	4	135	34
2838	4	135	60
2839	2	135	537
2840	1	135	48
2841	1	135	539
2842	4	135	35
2843	4	136	35
2844	4	136	32
2845	1	136	37
2846	1	136	48
2847	1	136	43
2848	4	136	46
2849	2	136	42
2850	4	136	33
2851	4	136	47
2852	1	136	539
2853	2	137	31
2854	4	137	34
2855	2	137	33
2856	2	137	5
2857	4	137	35
2858	1	137	40
2859	4	137	29
2860	1	137	37
2861	3	137	32
2862	3	137	36
2863	2	138	5
2864	4	138	33
2865	4	138	29
2866	3	138	31
2867	3	138	32
2868	4	138	35
2869	1	138	37
2870	1	138	40
2871	4	138	34
2872	3	138	36
2873	4	139	33
2874	3	139	31
2875	3	139	36
2876	4	139	29
2877	4	139	34
2878	1	139	37
2879	4	139	35
2880	4	139	32
2881	2	139	5
2882	1	139	40
2883	4	140	46
2884	1	140	43
2885	4	140	35
2886	4	140	33
2887	3	140	60
2888	4	140	47
2889	1	140	539
2890	3	140	540
2891	1	140	48
2892	3	140	41
2893	2	141	44
2894	1	141	539
2895	1	141	33
2896	2	141	45
2897	3	141	32
2898	3	141	540
2899	4	141	29
2900	3	141	36
2901	1	141	40
2902	4	141	47
\.


--
-- Data for Name: alcpt_answersheet; Type: TABLE DATA; Schema: alcpt; Owner: postgres
--

COPY alcpt.alcpt_answersheet (id, finish_time, is_finished, score, exam_id, user_id, is_tested) FROM stdin;
68	2020-12-29 15:53:03.036726+00	t	0	62	5	t
69	2020-12-29 15:53:18.843196+00	t	0	63	5	t
70	2020-12-29 19:37:24.8903+00	t	6	64	5	t
71	2020-12-29 19:37:24.910695+00	f	\N	64	8	f
72	2020-12-29 19:37:24.929691+00	f	\N	64	9	f
73	2020-12-29 19:51:06.72957+00	t	26	65	5	t
74	2020-12-29 19:51:06.750211+00	f	\N	65	8	f
75	2020-12-29 19:51:06.768039+00	f	\N	65	9	f
76	2020-12-29 21:00:49.346811+00	t	20	66	5	t
77	2020-12-29 21:00:49.368007+00	f	\N	66	8	f
78	2020-12-29 21:00:49.385882+00	t	\N	66	9	f
79	2021-01-04 10:46:16.1725+00	t	30	67	9	t
80	2021-01-18 10:49:12.368002+00	t	20	68	5	t
81	2021-01-18 10:49:12.391929+00	f	\N	68	8	f
82	2021-01-18 10:49:12.410529+00	t	\N	68	9	f
83	2021-01-25 10:34:44.062548+00	f	\N	69	9	t
84	2021-01-25 10:40:25.303783+00	t	\N	70	5	f
85	2021-01-25 10:40:25.322252+00	f	\N	70	8	f
86	2021-01-25 10:40:25.340439+00	t	0	70	9	t
87	2021-01-25 10:56:38.05159+00	f	\N	71	9	t
88	2021-01-25 11:15:05.608507+00	f	\N	72	9	t
89	2021-01-25 11:31:35.885+00	t	50	73	19	t
90	2021-02-01 10:36:27.08726+00	t	100	74	5	t
91	2021-02-01 10:36:27.108957+00	f	\N	74	8	f
92	2021-02-01 10:36:27.127072+00	f	\N	74	9	f
93	2021-03-13 16:31:16.802486+00	t	20	75	5	t
94	2021-10-12 15:20:26.329289+00	t	30	76	36	t
95	2021-10-12 15:22:57.411913+00	t	0	77	36	t
96	2021-10-12 16:43:25.943277+00	t	32	78	36	t
97	2021-10-19 14:09:56.392562+00	t	40	79	36	t
98	2021-11-04 10:26:34.610367+00	t	20	80	36	t
99	2021-11-04 10:52:50.602507+00	t	10	81	36	t
100	2021-11-04 11:00:21.960511+00	t	30	82	36	t
101	2021-11-04 23:11:06.793729+00	t	30	83	36	t
102	2021-11-30 11:00:04.864412+00	t	86	84	36	t
103	2021-12-02 11:44:56.607617+00	t	26	85	36	t
104	2021-12-07 14:41:51.880153+00	f	\N	86	36	f
105	2022-03-12 23:08:34.860802+00	t	66	87	36	t
106	2022-03-12 23:08:34.896268+00	t	80	87	38	t
107	2022-03-12 23:08:34.920023+00	t	80	87	39	t
108	2022-03-12 23:08:34.941108+00	t	60	87	40	t
109	2022-03-12 23:08:34.961687+00	t	80	87	41	t
110	2022-05-03 11:11:16.902471+00	f	\N	88	36	t
111	2022-05-03 11:11:16.924529+00	f	\N	88	38	f
112	2022-05-03 11:11:16.941415+00	f	\N	88	39	f
113	2022-05-03 11:11:16.962888+00	f	\N	88	40	f
114	2022-05-03 11:11:16.98335+00	f	\N	88	41	f
115	2022-05-03 11:12:49.596202+00	t	0	89	36	t
116	2022-05-03 11:12:49.631552+00	f	\N	89	38	f
117	2022-05-03 11:12:49.668712+00	f	\N	89	39	f
118	2022-05-03 11:12:49.701041+00	f	\N	89	40	f
119	2022-05-03 11:12:49.732552+00	f	\N	89	41	f
120	2022-05-12 15:26:35.276895+00	t	0	90	36	t
121	2022-05-12 15:52:26.090867+00	t	90	91	36	t
122	2022-05-12 16:44:26.828128+00	t	40	92	36	t
123	2022-05-12 17:06:09.749055+00	t	10	93	36	t
124	2022-05-12 18:06:41.746865+00	t	80	94	36	t
125	2022-05-12 18:07:47.741239+00	t	60	95	36	t
126	2022-05-12 18:08:48.615111+00	t	80	96	36	t
127	2022-05-12 18:09:51.810667+00	t	100	97	36	t
128	2022-05-12 18:12:37.09777+00	t	70	98	36	t
129	2022-05-12 18:17:00.18695+00	t	80	99	36	t
130	2022-05-12 23:04:04.981182+00	t	90	100	36	t
131	2022-05-13 10:17:59.963004+00	t	70	101	36	t
132	2022-05-13 10:24:57.84041+00	t	50	102	36	t
133	2022-05-13 10:28:15.90188+00	t	90	103	36	t
134	2022-05-16 01:27:58.029612+00	t	80	104	36	t
135	2022-05-17 12:20:34.661125+00	t	90	105	36	t
136	2022-05-17 14:18:04.110207+00	t	70	106	36	t
137	2022-05-18 18:15:16.946636+00	t	80	107	36	t
138	2022-05-19 00:09:32.124393+00	t	80	108	36	t
139	2022-05-19 00:33:08.3984+00	t	80	109	36	t
140	2022-05-19 18:41:38.996549+00	t	80	110	36	t
141	2022-05-19 18:44:12.540404+00	t	80	111	36	t
\.


--
-- Data for Name: alcpt_choice; Type: TABLE DATA; Schema: alcpt; Owner: postgres
--

COPY alcpt.alcpt_choice (id, c_content, is_answer, question_id) FROM stdin;
1	officer	f	1
2	officers	f	1
3	a officer	f	1
4	an officer	t	1
5	ICBM	f	2
6	IRBM	t	2
7	MRBM	f	2
8	SRBM	f	2
9	machine gun	f	3
10	pistol	t	3
11	grenade	f	3
12	tank	f	3
17	wear	f	5
18	had worn	t	5
19	wears	f	5
20	wearing	f	5
21	infantrymen	t	6
22	artillerymen	f	6
23	paratrooper	f	6
24	scout	f	6
65	Urban Operations	f	23
66	Engineers	f	23
67	engagement	t	23
68	Armor	f	23
69	鄧紫棋	t	28
70	林宥嘉	f	28
71	吳青峰	f	28
72	華晨宇	f	28
89	that	f	29
90	and	f	29
91	but	f	29
92	because	t	29
93	during	f	30
94	since	f	30
95	between	f	30
96	for	t	30
97	likes	f	31
98	like	t	31
99	are like	f	31
100	were alike	f	31
101	see	t	32
102	sees	f	32
103	saw	f	32
104	had seen	f	32
105	listen to	f	33
106	listens by	f	33
107	to listen	f	33
108	listening to	t	33
109	if	f	34
110	unless	f	34
111	that	f	34
112	so	t	34
113	May	f	35
114	Could	f	35
115	If	f	35
116	Would	t	35
117	did	f	36
118	had to	f	36
119	ought to	t	36
120	would	f	36
121	for	t	37
122	since	f	37
123	during	f	37
124	until	f	37
133	couldn't see very far	t	40
134	didn't have much money	f	40
135	was sick	f	40
136	made a bad grade	f	40
137	last	f	41
138	lowest	f	41
139	first	t	41
140	slower	f	41
141	What	f	42
142	It	t	42
143	She	f	42
144	He	f	42
145	for downtown	f	43
146	downtown	t	43
147	at downtown	f	43
148	into downtown	f	43
149	good	f	44
150	better	t	44
151	nice	f	44
152	best	f	44
153	consider	f	45
154	considering	t	45
155	considered	f	45
156	considers	f	45
157	Will use	f	46
158	Use	f	46
159	To use	t	46
160	Using	f	46
161	at	f	47
162	for	f	47
163	during	f	47
164	with	t	47
165	have	t	48
166	had	f	48
167	has	f	48
168	having	f	48
169	rifle	t	49
170	commander	f	49
171	grenade	f	49
172	pistol	f	49
173	rifles	f	50
174	surrenders	f	50
175	service pistols	t	50
176	bullets	f	50
177	large	f	51
178	designed	f	51
179	indirect	f	51
180	portable	t	51
181	They use smoothbore machine guns.	t	52
182	They use tracks to travel over rough land.	f	52
183	They use three different types of weapons.	f	52
184	They can aim their weapons automatically.	f	52
185	disappointed	t	53
186	satisfied	f	53
187	cheerful	f	53
188	capable	f	53
189	complicated	t	54
190	energetic	f	54
191	extravagant	f	54
192	intelligent	f	54
193	cherished	f	55
194	easygoing	f	55
195	flexible	f	55
196	negative	t	55
197	is lacking an address	f	56
198	is lost among my papers	f	56
199	requires your urgent comment	t	56
200	has been posted as you requested	f	56
201	rented out lately	f	57
202	seriously deteriorating	t	57
203	well-cared by its tenants	f	57
204	unfortunately occupied	f	57
205	debated	t	58
206	alternated	f	58
207	founded	f	58
208	inherited	f	58
209	discipline	f	59
210	facility	f	59
211	privacy	t	59
212	representation	f	59
213	eager	f	60
214	liberal 	f	60
215	mean	t	60
216	inferior	f	60
217	conveyed	f	61
218	associated	f	61
219	interpreted	f	61
220	predicted	t	61
221	landmarks	f	62
222	restrictions	t	62
223	percentages	f	62
224	circumstances	f	62
225	advised	f	63
226	occupied	f	63
227	proposed	t	63
228	recognized	f	63
229	 sociable	f	64
230	 expressive	t	64
231	 reasonable	f	64
232	 objective	f	64
233	 particularly	t	65
234	sensibly	f	65
235	moderately	f	65
236	 considerably	f	65
237	 stumble	t	66
238	 graze	f	66
239	navigate	f	66
240	 dwell	f	66
241	 initial 	f	67
242	 annual	t	67
243	 evident	f	67
244	 occasional	f	67
245	 factors	t	68
246	outcomes	f	68
247	 missions	f	68
248	 identities	f	68
249	 distantly	f	69
250	 meaningfully	f	69
251	 cheerfully	f	69
252	 vividly	t	69
253	napping	f	70
254	 scooping	f	70
255	flipping	f	70
256	 chirping	t	70
257	 benefit	f	71
258	 contact	t	71
259	 gesture	f	71
260	 favor	f	71
261	 causal	f	72
262	durable	f	72
263	 manual 	t	72
264	violent	f	72
265	 mature	f	73
266	 usual	f	73
267	 seasonal	t	73
268	 particular	f	73
269	 requirements	t	74
270	 techniques	f	74
271	 situations	f	74
272	principles	f	74
273	 distribute	f	75
274	 fulfill	t	75
275	 convince	f	75
276	monitor	f	75
277	 chilly	f	76
278	 liberal	f	76
279	 hollow	t	76
280	 definite	f	76
281	slipped	f	77
282	dumped	f	77
283	 twisted	t	77
284	recovered	f	77
285	 decisions	f	78
286	 beliefs	t	78
287	 styles	f	78
288	 degrees	f	78
289	 persuasive	f	79
290	 tolerable	f	79
291	 suspicious	f	79
292	 demanding	t	79
293	 anxiously	t	80
294	 precisely	f	80
295	evidently	f	80
296	 distinctly	f	80
297	 deposited	f	81
298	 reserved	f	81
299	 vanished	f	81
300	 surrounded	t	81
301	 credit	f	82
302	 impress	t	82
303	 relieve	f	82
304	 acquire	f	82
305	 flake	f	83
306	 blossom	f	83
307	 blanket	t	83
308	 flash	f	83
309	 angles	f	84
310	 margins	t	84
311	 exceptions	f	84
312	 limitations	f	84
313	 hardship	f	85
314	comment	f	85
315	 bargain	f	85
316	penalty	t	85
317	 conducted	t	86
318	 confirmed	f	86
319	 implied	f	86
320	 improved	f	86
321	 efficient	f	87
322	 reliable	f	87
323	massive	t	87
324	 adequate	f	87
325	 tenderly	f	88
326	 properly	t	88
327	 solidly	f	88
328	 favorably	f	88
329	pursue	t	89
330	swear	f	89
331	 reserve	f	89
332	draft	f	89
333	 native	t	90
334	tricky	f	90
335	 remote	f	90
336	vacant	f	90
337	 appoint	f	91
338	eliminate	f	91
339	 occupy	f	91
340	 identify	t	91
341	relaxing	f	92
342	 embarrassing	t	92
343	 appealing	f	92
344	 defending	f	92
345	 barely	t	93
346	 fairly	f	93
347	 merely	f	93
348	readily	f	93
349	 guide	f	94
350	 trace	t	94
351	 code	f	94
352	print	f	94
353	 accessed	f	95
354	 edited	f	95
355	 imposed	f	95
356	 urged	t	95
357	constitutions	f	96
358	objections	f	96
359	 sculptures	t	96
360	adventures	f	96
361	 dip	f	97
362	 beam	t	97
363	 spark	f	97
364	 path	f	97
365	 enclosed	t	98
366	 installed	f	98
367	 preserved	f	98
368	 rewarded	f	98
369	 signal	f	99
370	glory	f	99
371	medal	t	99
372	 profit	f	99
373	balanced	f	100
374	 calculated	f	100
375	disguised	t	100
376	 registered	f	100
377	 aware	t	101
378	ashamed	f	101
379	doubtful	f	101
380	guilty	f	101
381	 innocence	f	102
382	 estimation	f	102
383	assurance	f	102
384	observation	t	102
385	 journey	f	103
386	 traffic	f	103
387	 concert	t	103
388	record	f	103
389	 awful	f	104
390	 drowsy	f	104
391	 tragic	f	104
392	 upset	t	104
393	 accent	t	105
394	 identity	f	105
395	gratitude	f	105
396	signature	f	105
397	 ceased	f	106
398	 committed	f	106
399	 confined	t	106
400	 conveyed	f	106
401	 injury	t	107
402	 offense	f	107
403	sacrifice	f	107
404	 victim	f	107
405	security	f	108
406	maturity	f	108
407	 facility	f	108
408	 generosity	t	108
409	 tolerates	f	109
410	 associates	f	109
411	 demonstrates	t	109
412	exaggerates	f	109
413	durable	f	110
414	private	f	110
415	realistic	f	110
416	numerous	t	110
417	Occasionally	t	111
418	Automatically	f	111
419	Enormously	f	111
420	 Innocently	f	111
421	 isolation	f	112
422	 promotion	f	112
423	 retirement	t	112
424	 announcement	f	112
425	 alert	f	113
426	 itchy	t	113
427	steady	f	113
428	 flexible	f	113
429	 conquered	t	114
430	estimated	f	114
431	 guaranteed	f	114
432	 intensified	f	114
433	 ruined	t	115
434	cracked	f	115
435	hastened	f	115
436	neglected	f	115
437	 primitive	f	116
438	spiritual	f	116
439	 representative	t	116
440	 informative	f	116
441	 liberally	f	117
442	individually	f	117
443	financially	f	117
444	environmentally	t	117
473	when there is no danger	f	125
474	when the building is on fire	t	125
475	when there is a high-ranking visitor	f	125
476	when the weather is cold	f	125
477	happy	t	126
478	sad	f	126
479	angry	f	126
480	jealous	f	126
481	find	f	127
482	plan	t	127
483	enjoy	f	127
484	suggest	f	127
485	a leader	f	128
486	a commander	f	128
487	an instructor	f	128
488	a specialist	t	128
489	He should increase his speed.	f	129
490	He should continue at the same speed.	f	129
491	He should decrease his speed.	t	129
492	He should stop.	f	129
493	to begin	t	130
494	to change	f	130
495	to process	f	130
496	to finish	f	130
497	a few	f	131
498	none	f	131
499	a little	f	131
500	a lot	t	131
501	It was established.	t	132
502	It stopped operating.	f	132
503	It was making a lot of money.	f	132
504	A new branch office was set up.	f	132
505	Were you involved?	t	133
506	Did you wash him?	f	133
507	Did you assist him?	f	133
508	Did you watch what he did?	f	133
509	an argument	f	134
510	a command	f	134
511	a farm	f	134
512	a report	t	134
513	something expensive	t	135
514	something delicious	f	135
515	something cheap	f	135
516	something heavy	f	135
517	The heat should be very hot.	f	136
518	The heat should be medium.	t	136
519	The heat should be very low.	f	136
520	The heat should be turned off.	f	136
521	to start again	f	137
522	to be stolen	f	137
523	to break into pieces	f	137
524	to stop working suddenly	t	137
525	a stick	t	138
526	a ball	f	138
527	a hole	f	138
528	a box	f	138
529	a little hot	t	139
530	very warm	f	139
531	quite cold	f	139
532	freezing	f	139
533	on top of the refrigerator	f	140
534	in front of the refrigerator	f	140
535	behind the refrigerator	t	140
536	to the left of the refrigerator	f	140
537	houses for sale	f	141
538	houses to let	t	141
539	houses to buy	f	141
540	land to build a house on	f	141
541	The wire is not good.	f	142
542	The wire is not protected.	t	142
543	The wire is not carrying electricity.	f	142
544	The wire is not visible.	f	142
545	an unusual one	f	143
546	the first one	f	143
547	an ordinary one	t	143
548	the last one	f	143
549	It was too expensive.	f	144
550	There was a lot of fruit in stock.	f	144
551	It had gone bad.	t	144
552	She didn't feel like eating fruit.	f	144
553	I'll tell you anything you want to know.	f	145
554	I'll help in any way I can.	t	145
555	I won't be able to stop laughing.	f	145
556	I haven't thought about him in years.	f	145
557	The camera is out of order.	f	146
558	The film is out of order.	t	146
559	There is no film in the camera.	f	146
560	The film is sold out.	f	146
561	through blood	t	147
562	by a human mistake	f	147
563	through an animal	f	147
564	through food	f	147
565	His eye was hit by a baseball.	t	148
566	The light of the sun hurt his eyes.	f	148
567	He sat through last night's game.	f	148
568	He was expelled from last night's game.	f	148
569	I'd like to have them both.	t	149
570	I drink it when it's cold.	f	149
571	We don't have to stay here long.	f	149
572	I'd like a cup of coffee, please.	f	149
573	She has just graduated from college.	f	150
574	She never graduated from college.	f	150
575	She will be studying at college.	f	150
576	She is going to graduate from college.	t	150
577	They were alternated.	f	151
578	They were congratulated.	f	151
579	They were discharged.	t	151
580	They were graduated.	f	151
581	He frightened them.	f	152
582	He repelled them.	t	152
583	He trusted them.	f	152
584	He made friends with them.	f	152
585	Her voice is beautiful.	f	153
586	Her house is beautiful.	f	153
587	Her face is beautiful.	f	153
588	Her body shape is beautiful.	t	153
589	He was chosen to deal with the crisis.	t	154
590	He couldn't get out of the trouble.	f	154
591	He was blamed for the mistake.	f	154
592	He successfully solved the problem.	f	154
593	He drew it up.	f	155
594	He is against it.	t	155
595	He is explaining it.	f	155
596	He will carry it out.	f	155
597	He is searching for a brand-new car.	t	156
598	He is testing his new car.	f	156
599	He is shopping for a second-hand car.	f	156
600	He is selling a second -hand car.	f	156
601	He went ahead of us.	f	157
602	He would come with us.	f	157
603	He wanted to join us.	t	157
604	He could go with us.	f	157
605	A schedule was lost.	f	158
606	A schedule was destroyed.	f	158
607	A schedule was found.	f	158
608	A schedule was established.	t	158
609	I'm grateful to you.	t	159
610	I think nothing of it.	f	159
611	I can't wait to have it.	f	159
612	I totally agree with you.	f	159
613	There is no one in the waiting room.	f	160
614	There are a lot of people in the waiting room.	t	160
615	There are few people in the waiting room.	f	160
616	There are a few people in the waiting room.	f	160
617	She must roll it up.	t	161
618	She must double it over.	f	161
619	She must clean it up.	f	161
620	She must read it again.	f	161
621	It was raining.	f	162
622	There was a lot of snow.	f	162
623	It was getting dark.	f	162
624	The visibility was poor.	t	162
625	She became very happy.	f	163
626	She received a surprise.	f	163
627	She felt unsteady.	t	163
628	She got a good deal.	f	163
629	Mr. Johnson is their cousin.	f	164
630	Mr. Johnson is their father.	t	164
631	Mr. Johnson is their brother.	f	164
632	Mr. Johnson is their uncle.	f	164
633	Harry wanted a sedan.	f	165
634	Harry didn't want a sports car.	f	165
635	Harry bought a sedan.	t	165
636	Harry bought a sports car.	f	165
637	They have to receive extensive training.	t	166
638	They train lightly because of exhaustion.	f	166
639	They skip extensive training.	f	166
640	They dislike extensive training.	f	166
641	It is just around the corner.	t	167
642	It is coming to an end.	f	167
643	It is about to finish.	f	167
644	It is never too late.	f	167
645	It mixed the shells up.	t	168
646	It put in the shells.	f	168
647	It fired the shells out.	f	168
648	It threw away the shells.	f	168
649	Their friends won't use the seats.	t	169
650	Their friends are in the seats.	f	169
651	The seats for their friends are cheap.	f	169
652	The seats are being held for their friends.	f	169
657	It is not working.	t	171
658	It has broken into pieces.	f	171
659	It is ready for sale.	f	171
660	It was broadcast live.	f	171
661	You and I are alike.	f	172
662	I think I've seen you before.	t	172
663	I know you very well.	f	172
664	You look like someone in my family.	f	172
665	He is getting a shot.	t	173
666	He is getting weighed.	f	173
667	He is being examined.	f	173
668	He is being rescued.	f	173
673	cost	f	175
674	length	f	175
675	size	f	175
676	temperature	t	175
677	a steering device	f	176
678	a source of power	t	176
679	a job to do	f	176
680	a way of stopping	f	176
681	show her how to write	f	177
682	give her something to do	f	177
683	give her a pen to use	t	177
684	show her around	f	177
685	look for mistakes	t	178
686	write it again	f	178
687	begin a new job	f	178
688	pay him for his work	f	178
689	a way into the room	f	179
690	a way out of the room	t	179
691	a way to go though the window	f	179
692	a way to lock the door	f	179
693	in a fancy restaurant	f	180
694	at a noodle stand	f	180
695	in a fast food restaurant	t	180
696	in a Chinese restaurant	f	180
697	It was just cooked.	t	181
698	It was a warm day.	f	181
699	I already finished eating.	f	181
700	That's my favorite meal.	f	181
701	The girl looks nothing like her sister	f	182
702	The girl looks a lot like the woman's sister.	t	182
703	The girl acts like she's the woman's sister.	f	182
704	The girl is a little taller.	f	182
705	The cars are too heavy.	f	183
706	The road is quite wide.	f	183
707	The cars cannot go very fast.	f	183
708	The cars cannot pass each other.	t	183
709	It's a good place for exercising.	f	184
710	It's quiet there.	t	184
711	It's noisy there.	f	184
712	It's near their house.	f	184
717	slowly	f	186
718	fast	t	186
719	well	f	186
720	straight	f	186
721	It will probably rain.	t	187
722	It will not rain.	f	187
723	It will rain for sure.	f	187
724	It is impossible to rain this weekend.	f	187
725	They moved to the city.	f	188
726	They left the city.	f	188
727	They did some sightseeing.	t	188
728	The didn't like the city.	f	188
729	It is very important.	f	189
730	It is not woking very well.	t	189
731	It is destroyed.	f	189
732	It needs to be recharged.	f	189
733	A disaster was avoided.	f	190
734	A disaster was predicted.	f	190
735	A disaster occurred.	t	190
736	A disaster passed.	f	190
737	We had breakfast.	f	191
738	We exercised.	f	191
739	We talked.	t	191
740	We relaxed.	f	191
741	She wants us to stop playing around.	f	192
742	She wants us to wake up soon.	f	192
743	She wants us not to ride the horses.	t	192
744	She wants us to stop hanging around.	f	192
745	the dock	t	193
746	the raft	f	193
747	the truck	f	193
748	the swimming pool	f	193
749	drink it 	f	194
750	rub it on	t	194
751	dry it out	f	194
752	paint it	f	194
753	before they learned English	f	195
754	before 2005	f	195
755	in 2005	t	195
756	to attend flight school	f	195
757	a weapon	f	196
758	a signal	f	196
759	an award	f	196
760	an assignment	t	196
761	David drilled it.	t	197
762	David sewed it.	f	197
763	David wrote it.	f	197
764	David bought it.	f	197
765	He wants to wait before going to the beach.	f	198
766	He is excited about going to the beach.	t	198
767	He doesn't care for being outdoors.	f	198
768	He has to wait on the beach.	f	198
769	once a day	f	199
770	two times a day	t	199
771	once each two days	f	199
772	three times a day	f	199
773	It rains very often.	f	200
774	It remains the same.	f	200
775	It is always hot.	f	200
776	It changes often.	t	200
777	Yes, they use traffic lights.	f	201
778	Yes, they use helicopters.	t	201
779	Yes, they use radios.	f	201
780	Yes, they use police cars.	f	201
781	handle the books	f	202
782	test the magazines	f	202
783	have a quick look at them	t	202
784	buy a few of them	f	202
785	I answer James' call.	f	203
786	I fought with James.	f	203
787	I met James	t	203
788	I scolded James.	f	203
789	Yes, she is happy and carefree.	t	204
790	Yes, she is English.	f	204
791	Nom she is carefree and happy.	f	204
792	No, she is saleswoman.	f	204
793	to indicate atmospheric pressure	f	205
794	to record air speed	f	205
795	to measure precipitation	f	205
796	to regulate temperature	t	205
797	because the car is rough	f	206
798	because the car is hot and dry	f	206
799	because the car stops	f	206
800	because the car slides easily	t	206
801	buy a newspaper	f	207
802	take a bus	t	207
803	see a doctor	f	207
804	go to bed early	f	207
805	She thinks she will fail the course.	f	208
806	She thinks she will succeed.	t	208
807	She wants to drop the course.	f	208
808	She wants to take it over.	f	208
809	He can't see very well.	f	209
810	He is mute.	f	209
811	Ir is hard to listen to him sing.	f	209
812	There is a problem with his hearing.	t	209
813	He is worse than David.	f	210
814	He is more handsome than David.	f	210
815	He is much better than David.	t	210
816	He is a better friend than David.	f	210
817	He gave them a briefing.	f	211
818	He organized their vehicles.	f	211
819	He gave them a big hand.	f	211
820	He watched them march.	t	211
821	You will very likely feel cold.	f	212
822	You will very likely feel warm.	f	212
823	You will very likely get sick.	t	212
824	You will very likely buy a coat.	f	212
825	I don't like to read.	f	213
826	I like to read all the time.	f	213
827	I like to read about cars.	f	213
828	I like to read when I am free.	t	213
829	There was an ambulance behind John.	t	214
830	There was a taxi behind John.	f	214
831	There was music behind John.	f	214
832	There was a bicycle behind John.	f	214
833	The weather is bad.	f	215
834	The work is too hard.	t	215
835	The road is rough.	f	215
836	The picture is all right.	f	215
837	He took it away.	t	216
838	He bought it.	f	216
839	He took off its cover.	f	216
840	He read it.	f	216
841	The solution was unknown.	f	217
842	The solution was apparent.	t	217
843	The solution was dangerous.	f	217
844	The solution was essential.	f	217
845	It must be flat.	t	218
846	It must be long.	f	218
847	It must be square.	f	218
848	It must be large.	f	218
849	We confused the enemy.	f	219
850	We met the enemy.	t	219
851	We defeated the enemy.	f	219
852	We avoided the enemy.	f	219
853	Mary will compete with the female candidate.	f	220
854	Mary will choose the female candidate.	t	220
855	Mary doesn't like the female candidate.	f	220
856	Mary will work for the female candidate.	f	220
857	It can't fit.	t	221
858	He doesn't own it.	f	221
859	It was too heavy for him.	f	221
860	He doesn't like it.	f	221
861	He didn't see the passengers.	f	222
862	He didn't like the noise it made.	f	222
863	He didn't see the plane landing.	f	222
864	He didn't know the arrival time.	t	222
865	Peter can't understand them.	t	223
866	Peter can't stand up to them.	f	223
867	Peter will make them stand up.	f	223
868	Peter can't tolerate them.	f	223
869	They're becoming longer.	t	224
870	They're becoming more interesting.	f	224
871	They're becoming more rigid.	f	224
872	They're becoming more important.	f	224
873	They saved him.	t	225
874	They surrounded him.	f	225
875	They located him.	f	225
876	They buried him.	f	225
877	She doesn't know the truth.	t	226
878	She wants to tell the truth.	f	226
879	She is willing to tell the truth.	f	226
880	She doesn't want to tell the truth.	f	226
881	They neglected his warning.	t	227
882	They liked his warning.	f	227
883	They forgot his warning.	f	227
884	They remembered his warning.	f	227
885	this kind of watch is very expensive.	t	228
886	This kind of watch breaks easily.	f	228
887	You cannot buy this kind of watch anymore.	f	228
888	You will not like this kind of watch.	f	228
889	It is good for insulation.	t	229
890	It burns easily.	f	229
891	It is easy to lose.	f	229
892	It is very expensive.	f	229
893	He dislikes them very much.	t	230
894	He makes them angry.	f	230
895	He has great trouble working with them.	f	230
896	He has a high regard for them.	f	230
897	I was sick last night.	t	231
898	I finished last night.	f	231
899	I went running last night.	f	231
900	I was in a rush last night.	f	231
901	I don’t want to see your new home.	t	232
902	I don’t  want anything in your new home.	f	232
903	I really want to see your new home.	f	232
904	I would give anything to have a new home.	f	232
905	The damage wasn’t necessary.	t	233
906	There was only a little damage.	f	233
907	No damage was detected.	f	233
908	There was major damage.	f	233
909	He has enough time	t	234
910	He hasn’t enough time.	f	234
911	He has extra time. 	f	234
912	He has limited time.	f	234
913	She wanted to know the cost. 	t	235
914	She wanted to know the means.	f	235
915	She wanted to know the answer.	f	235
916	She wanted to know the reason.	f	235
917	a house 	f	236
918	a trip	t	236
919	a car	f	236
920	a friend	f	236
921	The man should buy new clothing.	t	237
922	The man has poor taste in clothing.	f	237
923	The man should try to find his belt.	f	237
924	The man should lose weight.	f	237
925	It was expanded five months ago.	f	238
926	It was started five months ago.	t	238
927	It was moved five months ago.	f	238
928	It was closed five months ago.	f	238
929	It matched her furniture.	t	239
930	It was a bargain.	f	239
931	It was nice to site in.	f	239
932	It was a pretty color.	f	239
933	He paid for it ahead of time.	t	240
934	He paid for it little by little.	f	240
935	He paid for it with a loan.	f	240
936	He paid for it with a check.	f	240
937	to work	t	241
938	on a trip	f	241
939	to school	f	241
940	on a picnic	f	241
941	He wanted to go to bed.	t	242
942	He wanted to get cleaned up.	f	242
943	He wanted to drink something cold.	f	242
944	He wanted to get somewhere fast.	f	242
945	His house was pretty.	f	243
946	His house was old.	f	243
947	His house was big.	t	243
948	His house was modern.	f	243
949	She was studying how to build things.	t	244
950	She was studying how to write stories.	f	244
951	She was studying how to teach children.	f	244
952	She was studying how to fix teeth.	f	244
953	descending	t	245
954	shacking	f	245
955	rolling	f	245
956	climbing	f	245
957	He is careless.	t	246
958	He is at fault.	f	246
959	He is lazy.	f	246
960	He likes to criticize.	f	246
961	play ball	t	247
962	eat supper	f	247
963	work	f	247
964	sleep	f	247
965	putting off the meeting	t	248
966	canceling the meeting	f	248
967	attending the meeting	f	248
968	holding a meeting	f	248
969	took some medicine	t	249
970	ran away	f	249
971	got a ticket	f	249
972	said he was sorry	f	249
973	 in a trailer home	t	250
974	far from the base	f	250
975	near from the base	f	250
976	on the other side of town	f	250
977	give them a briefing	t	251
978	see how the class was conduct	f	251
979	teach the class 	f	251
980	interview the student	f	251
985	the speed	t	253
986	the angle	f	253
987	the diameter	f	253
988	the circumference	f	253
989	decorating a house	t	254
990	selling a house	f	254
991	building a house	f	254
992	tearing down a house	f	254
993	to be net	t	255
994	to be fair	f	255
995	to be truthful	f	255
996	to be on time	f	255
997	He threw them away.	t	256
998	He published them.	f	256
999	He put them on.	f	256
1000	He kicked them off.	f	256
1001	go up and down	t	257
1002	stay the same	f	257
1003	rise steadily	f	257
1004	fall steadily	f	257
1005	a sharp mind 	t	258
1006	explosives	f	258
1007	the desire to succeed	f	258
1008	a prolonged illness	f	258
1009	come and pick him up	f	259
1010	cook some food for him	f	259
1011	buy some food	t	259
1012	order some food at home	f	259
1013	to write to the doctor	f	260
1014	to call the doctor	f	260
1015	to find out about the doctor	f	260
1016	to go see the doctor	t	260
1017	She allowed John to take the car.	t	261
1018	She warned John not to take the car.	f	261
1019	She ordered John to drive the car.	f	261
1020	She gave John a ride in the car.	f	261
1021	the time of the meeting	t	262
1022	how to repair the radio	f	262
1023	where Main Street is	f	262
1024	what to buy 	f	262
1025	She’ll ask for the money.	f	263
1026	She’ll complain.	f	263
1027	She’ll stop working so hard.	f	263
1028	She’ll leave her job.	t	263
1029	after a while	f	264
1030	within minutes	t	264
1031	after a week	f	264
1032	in a day	f	264
1033	We agree with them.	f	265
1034	We employ them.	f	265
1035	We unite them.	f	265
1036	We contact them.	t	265
1037	act like their parents 	t	266
1038	help their parents	f	266
1039	admire the parents	f	266
1040	live with their parents	f	266
1041	She turned him down.	f	267
1042	She got lost.	f	267
1043	She didn’t show up.	t	267
1044	She was late.	f	267
1045	He found that his work was hard.	f	268
1046	He started doing his work.	f	268
1047	He started looking for work.	f	268
1048	He made sure his work was right.	t	268
1049	He was not sure of the scores.	f	269
1050	He was unhappy with the scores.	t	269
1051	He was studying the scores.	f	269
1052	He was evaluating the scores.	f	269
1053	There were no results.	f	270
1054	There were no expectations.	f	270
1055	The results were not what Major Wilson expected.	t	270
1056	The results were what Major Wilson expected.	f	270
1057	I’m not surprised by the results.	f	271
1058	I didn’t I would pass the exam.	f	271
1059	I didn’t think I would pass the exam.\t	t	271
1060	I knew I would pass the exam.	f	271
1061	They were praised.	f	272
1062	They were congratulated.	f	272
1063	They were kicked out.	t	272
1064	They graduated.	f	272
1065	They repelled it.	t	273
1066	They prevented it.	f	273
1067	They missed it.	f	273
1068	They started it.	f	273
1069	There was a traffic jam this morning.	t	274
1070	There was a car accident this morning.	f	274
1071	Cars were going at a high speed.	f	274
1072	The traffic light was out of order.	f	274
1073	The song makes her sad.	f	275
1074	The song is about love.	f	275
1075	She knows the singer very well.	f	275
1076	She has memorized the song.	t	275
1077	We must feed them.	f	276
1078	We must hit them.	f	276
1079	We must treat them.	f	276
1080	We must locate them.	t	276
1081	The washing machine is not working properly.	t	277
1082	The machine is user-friendly.	f	277
1083	The price of this washing machine is going up.	f	277
1084	The washing machine is now for sale.	f	277
1085	He won the lottery.	f	278
1086	He always thinks of the lottery.	t	278
1087	He has never bought any lottery tickets.	f	278
1088	Winning the lottery made him rich.	f	278
1089	I hailed a taxi.	f	279
1090	I was diving taxi.	f	279
1091	The taxi almost hit me.	t	279
1092	I was waiting for a taxi.	f	279
1093	A schedule was destroyed.	f	280
1094	A schedule was lost.	f	280
1095	A schedule was established.	t	280
1096	A schedule was found.	f	280
1097	James is confident about himself.	f	281
1098	James is proud of them.	f	281
1099	James is not true to himself.	f	281
1100	James lacks self-confidence.	t	281
1101	They had a normal day.	f	282
1102	They worked hard during the emergency.	t	282
1103	They had a practice drill.	f	282
1104	They had a false alarm.	f	282
1105	Don’t let her tell.	f	283
1106	Don’t tell her.	t	283
1107	Don’t talk about her.	f	283
1108	Don’t forget to tell her.	f	283
1109	It is said that he is having an affair.	t	284
1110	We believe he is having an affair.	f	284
1111	The rumor is not fair.	f	284
1112	We’ve never heard the rumer.	f	284
1113	It was raining.	f	285
1114	The visibility was poor.	t	285
1115	It was getting dark.	f	285
1116	There was a lot of snow.	f	285
1117	She received a surprise.	f	286
1118	She became very happy.	f	286
1119	She got a good deal.	f	286
1120	She felt unsteady.	t	286
1121	That medicine tasted bitter.	f	287
1122	That medicine worked miracles.	t	287
1123	The medicine tasted like wine.	f	287
1124	The medicine was prescribed carefully.	f	287
1125	They deserted their children.	f	288
1126	They moved because of their children.	t	288
1127	Their children didn’t move with them.	f	288
1128	They sent their children to Manhattan.	f	288
1129	Harry bought a sedan.	t	289
1130	Harry bought a sports car.	f	289
1131	Harry wanted a sedan.	f	289
1132	Harry didn’t want a sports car.	f	289
1133	They skip extensive training.	f	290
1134	They dislike extensive training.	f	290
1135	They have to receive extensive training.	t	290
1136	They train lightly because of exhaustion.	f	290
1137	You should have called me.	f	291
1138	You are supposed to call me after meeting me.	f	291
1139	Let me know if you cannot come.	t	291
1140	Call me when you arrive.	f	291
1141	It pulled in the shells.	f	292
1142	It mixed the shells.	f	292
1143	It threw out the shells.	t	292
1144	It fired the shells.	f	292
1145	The table is being held for their friends.	t	293
1146	The table for their friends is cheap.	f	293
1147	Their friends are in the seats.	f	293
1148	Their friends won’t use the seats.	f	293
1149	It is good to hear you say that.	f	294
1150	It’s getting chilly.	f	294
1151	It’s perfect for cooking.	f	294
1152	It feels very hot.	t	294
1153	Don’t forget to write her a letter.	f	295
1154	Don't forget to see her tomorrow.	f	295
1155	Don't forget to send her an e-mail.	f	295
1156	Don't forget to telephone her.	t	295
1157	turn right at the next corner	f	296
1158	give the woman a ride	f	296
1159	look for the taxi	f	296
1160	send a taxi immediately.	t	296
1161	She doesn’t like the man.	f	297
1162	She doesn’t know how to paint.	f	297
1163	It’s in the morning.	f	297
1164	She has an appointment to meet someone.	t	297
1165	He received a present at the meeting.	f	298
1166	He enjoying the meeting.	f	298
1167	He attended the meeting.	t	298
1168	He was the speaker.	f	298
1169	Richard has been standing in the wrong place.	f	299
1170	Richard hasn’t heard it correctly.	f	299
1171	Richard doesn’t know what it means.	t	299
1172	Richard means everything he says.	f	299
1173	She should treat him to dinner.	f	300
1174	It’s very easy .	f	300
1175	He’s hungry.	f	300
1176	It’s too difficult for him.	t	300
1177	He doesn’t like his new apartment.	t	301
1178	Someone is standing behind him.	f	301
1179	He back aches.	f	301
1180	Someone is trying to kill them.	f	301
1181	Colonel Roberts will not to give a speech.	f	302
1182	Colonel Roberts will ignore the speaker.	f	302
1183	Colonel Roberts will be the main speaker.	t	302
1184	Colonel Roberts will introduce the speaker.	f	302
1185	a chief	f	303
1186	a customer	f	303
1187	a waitress 	t	303
1188	a janitor	f	303
1189	one	t	304
1190	a few	f	304
1191	Two	f	304
1192	none	f	304
1193	 stop working 	f	305
1194	do the work better	f	305
1195	continue to work 	t	305
1196	do the work over again	f	305
1329	Steps to get rid of bedbugs.	f	339
1330	Ways to use foggers correctly.	f	339
1331	The ineffectiveness of bug bombs.	t	339
1332	The problems caused by insects.	f	339
1333	 It is a creature living inside our ears.	f	340
1334	It is a tune memorized in a personal way.	f	340
1335	It is a melody repeating in our heads.	t	340
1336	It is a commercial recalled through lyrics.	f	340
1337	Being a cleaner for other fish.	t	341
1338	Being a bodyguard for other fish.	f	341
1339	Being a gardener for roots and plants.	f	341
1340	Being a caretaker for sponge and algae.	f	341
1341	The trees were taller and stronger.	f	342
1342	The soil was softer for seeds to sprout.	f	342
1343	The climate was warmer and more humid.	t	342
1344	The temperature was lower along the Pacific coast.	f	342
1345	A Painful Mistake	f	343
1346	A Great Adventure	f	343
1347	A Lifelong Punishment	f	343
1348	A New Direction in Life	t	343
1349	Maasai people are a threat to elephants.	t	344
1350	Kamba people raise elephants for farming.	f	344
1351	Both Kamba and Maasai people are elephant hunters.	f	344
1352	Both Kamba and Maasai people traditionally wear red clothing.	f	344
1353	Facial expressions.	t	345
1354	Physical contact.	f	345
1355	Rate of speech.	f	345
1356	Eye contact.	f	345
1357	They are quick in movement.	f	346
1358	They are very active in the daytime.	f	346
1359	They are decreasing in number.	t	346
1360	They have a short lifespan for insects.	f	346
1361	They are part of the graduation ceremony.	f	347
1362	They are occasions for teens to show off their limousines.	f	347
1363	They are important events for teenagers to learn social skills.	t	347
1364	They are formal events in which teens share their traumatic experiences.	f	347
1365	personal wearable device	f	348
1366	graphic process unit	t	348
1367	cloud sharing service	f	348
1368	media streaming service	f	348
1377	when there is no danger	f	353
1378	when the building is on fire	t	353
1379	when there is a high-ranking visitor	f	353
1380	when the weather is cold	f	353
1381	happy	t	354
1382	sad	f	354
1383	angry	f	354
1384	jealous	f	354
1385	find	f	355
1386	plan	t	355
1387	enjoy	f	355
1388	suggest	f	355
1389	a leader	f	356
1390	a commander	f	356
1391	an instructor	f	356
1392	a specialist	t	356
1393	He should increase his speed.	f	357
1394	He should continue at the same speed.	f	357
1395	He should decrease his speed.	t	357
1396	He should stop.	f	357
1397	to begin	t	358
1398	to change	f	358
1399	to process	f	358
1400	to finish	f	358
1401	a few	f	359
1402	none	f	359
1403	a little	f	359
1404	a lot	t	359
1405	It was established.	t	360
1406	It stopped operating.	f	360
1407	It was making a lot of money.	f	360
1408	A new branch office was set up.	f	360
1409	Were you involved?	t	361
1410	Did you wash him?	f	361
1411	Did you assist him?	f	361
1412	Did you watch what he did?	f	361
1413	an argument	f	362
1414	a command	f	362
1415	a farm	f	362
1416	a report	t	362
1417	something expensive	t	363
1418	something delicious	f	363
1419	something cheap	f	363
1420	something heavy	f	363
1421	The heat should be very hot.	f	364
1422	The heat should be medium.	t	364
1423	The heat should be very low.	f	364
1424	The heat should be turned off.	f	364
1425	to start again	f	365
1426	to be stolen	f	365
1427	to break into pieces	f	365
1428	to stop working suddenly	t	365
1429	a stick	t	366
1430	a ball	f	366
1431	a hole	f	366
1432	a box	f	366
1433	a little hot	t	367
1434	very warm	f	367
1435	quite cold	f	367
1436	freezing	f	367
1437	on top of the refrigerator	f	368
1438	in front of the refrigerator	f	368
1439	behind the refrigerator	t	368
1440	to the left of the refrigerator	f	368
1441	houses for sale	f	369
1442	houses to let	t	369
1443	houses to buy	f	369
1444	land to build a house on	f	369
1445	The wire is not good.	f	370
1446	The wire is not protected.	t	370
1447	The wire is not carrying electricity.	f	370
1448	The wire is not visible.	f	370
1449	an unusual one	f	371
1450	the first one	f	371
1451	an ordinary one	t	371
1452	the last one	f	371
1453	It was too expensive.	f	372
1454	There was a lot of fruit in stock.	f	372
1455	It had gone bad.	t	372
1456	She didn't feel like eating fruit.	f	372
1457	I'll tell you anything you want to know.	f	373
1458	I'll help in any way I can.	t	373
1459	I won't be able to stop laughing.	f	373
1460	I haven't thought about him in years.	f	373
1461	The camera is out of order.	f	374
1462	The film is out of order.	t	374
1463	There is no film in the camera.	f	374
1464	The film is sold out.	f	374
1465	through blood	t	375
1466	by a human mistake	f	375
1467	through an animal	f	375
1468	through food	f	375
1469	His eye was hit by a baseball.	t	376
1470	The light of the sun hurt his eyes.	f	376
1471	He sat through last night's game.	f	376
1472	He was expelled from last night's game.	f	376
1473	I'd like to have them both.	t	377
1474	I drink it when it's cold.	f	377
1475	We don't have to stay here long.	f	377
1476	I'd like a cup of coffee, please.	f	377
1477	She has just graduated from college.	f	378
1478	She never graduated from college.	f	378
1479	She will be studying at college.	f	378
1480	She is going to graduate from college.	t	378
1481	They were alternated.	f	379
1482	They were congratulated.	f	379
1483	They were discharged.	t	379
1484	They were graduated.	f	379
1485	He frightened them.	f	380
1486	He repelled them.	t	380
1487	He trusted them.	f	380
1488	He made friends with them.	f	380
1489	Her voice is beautiful.	f	381
1490	Her house is beautiful.	f	381
1491	Her face is beautiful.	f	381
1492	Her body shape is beautiful.	t	381
1493	He was chosen to deal with the crisis.	t	382
1494	He couldn't get out of the trouble.	f	382
1495	He was blamed for the mistake.	f	382
1496	He successfully solved the problem.	f	382
1497	He drew it up.	f	383
1498	He is against it.	t	383
1499	He is explaining it.	f	383
1500	He will carry it out.	f	383
1501	He is searching for a brand-new car.	t	384
1502	He is testing his new car.	f	384
1503	He is shopping for a second-hand car.	f	384
1504	He is selling a second-hand car.	f	384
1505	He went ahead of us.	f	385
1506	He would come with us.	f	385
1507	He wanted to join us.	t	385
1508	He could go with us.	f	385
1509	A schedule was lost.	f	386
1510	A schedule was destroyed.	f	386
1511	A schedule was found.	f	386
1512	A schedule was established.	t	386
1513	I'm grateful to you.	t	387
1514	I think nothing of it.	f	387
1515	I can't wait to have it.	f	387
1516	I totally agree with you.	f	387
1517	There is no one in the waiting room.	f	388
1518	There are a lot of people in the waiting room.	t	388
1519	There are few people in the waiting room.	f	388
1520	There are a few people in the waiting room.	f	388
1521	She must roll it up.	t	389
1522	 She must double it over.	f	389
1523	She must clean it up.	f	389
1524	She must read it again.	f	389
1525	It was raining.	f	390
1526	There was a lot of snow.	f	390
1527	It was getting dark.	f	390
1528	The visibility was poor.	t	390
1529	She became very happy.	f	391
1530	She received a surprise.	f	391
1531	She felt unsteady.	t	391
1532	She got a good deal.	f	391
1533	Mr. Johnson is their cousin.	f	392
1534	Mr. Johnson is their father.	t	392
1535	Mr. Johnson is their brother.	f	392
1536	Mr. Johnson is their uncle.	f	392
1537	Harry wanted a sedan.	f	393
1538	Harry didn't want a sports car.	f	393
1539	Harry bought a sedan.	t	393
1540	Harry bought a sports car.	f	393
1541	They have to receive extensive training.	t	394
1542	They train lightly because of exhaustion.	f	394
1543	They skip extensive training.	f	394
1544	They dislike extensive training.	f	394
1545	It is just around the corner.	t	395
1546	It is coming to an end.	f	395
1547	It is about to finish.	f	395
1548	It is never too late.	f	395
1549	It mixed the shells up.	t	396
1550	It put in the shells.	f	396
1551	It fired the shells out.	f	396
1552	It threw away the shells.	f	396
1553	Their friends won't use the seats.	t	397
1554	Their friends are in the seats.	f	397
1555	The seats for their friends are cheap.	f	397
1556	The seats are being held for their friends.	f	397
1557	He is behind in his schoolwork.	t	398
1558	He is good at his schoolwork.	f	398
1559	He is the best student in class.	f	398
1560	He is sitting in the back row of the classroom.	f	398
1561	It is not working.	t	399
1562	It has broken into pieces.	f	399
1563	It is ready for sale.	f	399
1564	It was broadcast live.	f	399
1565	You and I are alike.	f	400
1566	I think I've seen you before.	t	400
1567	I know you very well.	f	400
1568	You look like someone in my family.	f	400
1569	He is getting a shot.	t	401
1570	He is getting weighed.	f	401
1571	He is being examined.	f	401
1572	He is being rescued.	f	401
1573	Don't forget to write her a letter.	f	402
1574	Don't forget to see her tomorrow.	f	402
1575	Don't forget to send her a telegram.	f	402
1576	Don't forget to telephone her.	t	402
1577	cost	f	403
1578	length	f	403
1579	size	f	403
1580	temperature	t	403
1581	a steering device	f	404
1582	a source of power	t	404
1583	a job to do	f	404
1584	a way of stopping	f	404
1585	show her how to write	f	405
1586	give her something to do	f	405
1587	give her a pen to use	t	405
1588	show her around	f	405
1589	look for mistakes	t	406
1590	write it again	f	406
1591	begin a new job	f	406
1592	pay him for his work	f	406
1593	a way into the room	f	407
1594	a way out of the room	t	407
1595	a way to go though the window	f	407
1596	a way to lock the door	f	407
1597	in a fancy restaurant	f	408
1598	at a noodle stand	f	408
1599	in a fast food restaurant	t	408
1600	in a Chinese restaurant	f	408
1601	It was just cooked.	t	409
1602	It was a warm day.	f	409
1603	I already finished eating.	f	409
1604	That's my favorite meal.	f	409
1605	The girl looks nothing like her sister.	f	410
1606	The girl looks a lot like the woman's sister.	t	410
1607	The girl acts like she's the woman's sister.	f	410
1608	The girl is a little taller.	f	410
1609	The cars are too heavy.	f	411
1610	The road is quite wide.	f	411
1611	The cars cannot go very fast.	f	411
1612	The cars cannot pass each other.	t	411
1613	It's a good place for exercising.	f	412
1614	It's quiet there.	t	412
1615	It's noisy there.	f	412
1616	It's near their house.	f	412
1617	slowly	f	413
1618	fast	t	413
1619	well	f	413
1620	straight	f	413
1621	It will probably rain.	t	414
1622	It will not rain.	f	414
1623	It will rain for sure.	f	414
1624	It is impossible to rain this weekend.	f	414
1625	They moved to the city.	f	415
1626	They left the city.	f	415
1627	They did some sightseeing.	t	415
1628	The didn't like the city.	f	415
1629	It is very important.	f	416
1630	It is not woking very well.	t	416
1631	It is destroyed.	f	416
1632	It needs to be recharged.	f	416
1633	A disaster was avoided.	f	417
1634	A disaster was predicted.	f	417
1635	A disaster occurred.	t	417
1636	A disaster passed.	f	417
1637	We had breakfast.	f	418
1638	We exercised.	f	418
1639	We talked.	t	418
1640	We relaxed.	f	418
1641	She wants us to stop playing around.	f	419
1642	She wants us to wake up soon.	f	419
1643	She wants us not to ride the horses.	f	419
1644	She wants us to stop hanging around.	t	419
1645	the dock	t	420
1646	the raft	f	420
1647	the truck	f	420
1648	the swimming pool	f	420
1649	drink it 	f	421
1650	rub it on	t	421
1651	dry it out	f	421
1652	paint it	f	421
1653	before they learned English	f	422
1654	before 2005	f	422
1655	in 2005	t	422
1656	to attend flight school	f	422
1657	a weapon	f	423
1658	a signal	f	423
1659	an award	f	423
1660	an assignment	t	423
1661	David drilled it.	t	424
1662	David sewed it.	f	424
1663	David wrote it.	f	424
1664	David bought it.	f	424
1665	He wants to wait before going to the beach.	f	425
1666	He is excited about going to the beach.	t	425
1667	He doesn't care for being outdoors.	f	425
1668	He has to wait on the beach.	f	425
1669	once a day	f	426
1670	two times a day	t	426
1671	once each two days	f	426
1672	three times a day	f	426
1673	It rains very often.	f	427
1674	It remains the same.	f	427
1675	It is always hot.	f	427
1676	It changes often.	t	427
1677	Yes, they use traffic lights.	t	428
1678	Yes, they use helicopters.	f	428
1679	Yes, they use radios.	f	428
1680	Yes, they use police cars.	f	428
1681	handle the books	f	429
1682	test the magazines	f	429
1683	have a quick look at them	t	429
1684	buy a few of them	f	429
1685	I answer James' call.	f	430
1686	I fought with James.	f	430
1687	I met James	t	430
1688	I scolded James.	f	430
1689	Yes, she is happy and carefree.	t	431
1690	Yes, she is English.	f	431
1691	Nom she is carefree and happy.	f	431
1692	No, she is saleswoman.	f	431
1693	to indicate atmospheric pressure	f	432
1694	to record air speed	f	432
1695	to measure precipitation	f	432
1696	to regulate temperature	t	432
1697	because the car is rough	f	433
1698	because the car is hot and dry	f	433
1699	because the car stops	f	433
1700	because the car slides easily	t	433
1701	buy a newspaper	f	434
1702	take a bus	t	434
1703	see a doctor	f	434
1704	go to bed early	f	434
1705	She thinks she will fail the course.	f	435
1706	She thinks she will succeed.	t	435
1707	She wants to drop the course.	f	435
1708	She wants to take it over.	f	435
1709	Yes, they will provide one for us.	t	436
1710	Yes, they will sell one to us.	f	436
1711	Yes, they will want one from us.	f	436
1712	Yes, they will change one.	f	436
1713	He can't see very well.	f	437
1714	He is mute.	f	437
1715	It is hard to listen to him singing.	f	437
1716	There is a problem with his hearing.	t	437
1717	He is worse than David.	f	438
1718	He is more handsome than David.	f	438
1719	He is much better than David.	t	438
1720	He is a better friend than David.	f	438
1721	He gave them a briefing.	f	439
1722	He organized their vehicles.	f	439
1723	He gave them a big hand.	f	439
1724	He watched them march.	t	439
1725	You will very likely feel cold.	f	440
1726	You will very likely feel warm.	f	440
1727	You will very likely get sick.	t	440
1728	You will very likely buy a coat.	f	440
1729	I don't like to read.	f	441
1730	I like to read all the time.	f	441
1731	I like to read about cars.	f	441
1732	I like to read when I am free.	t	441
1733	There was an ambulance behind John.	t	442
1734	There was a taxi behind John.	f	442
1735	There was music behind John.	f	442
1736	There was a bicycle behind John.	f	442
1737	The weather is bad.	f	443
1738	The work is too hard.	f	443
1739	The road is rough.	t	443
1740	The picture is all right.	f	443
1741	He took it away.	t	444
1742	He bought it.	f	444
1743	He took off its cover.	f	444
1744	He read it.	f	444
1745	The solution was unknown.	f	445
1746	The solution was apparent.	t	445
1747	The solution was dangerous.	f	445
1748	The solution was essential.	f	445
1749	It must be flat.	t	446
1750	It must be long.	f	446
1751	It must be square.	f	446
1752	It must be large.	f	446
1753	We confused the enemy.	f	447
1754	We met the enemy.	t	447
1755	We defeated the enemy.	f	447
1756	We avoided the enemy.	f	447
1757	Mary will compete with the female candidate.	f	448
1758	Mary will choose the female candidate.	t	448
1759	Mary doesn't like the female candidate.	f	448
1760	Mary will work for the female candidate.	f	448
1761	It can't fit.	f	449
1762	He doesn't own it.	t	449
1763	It was too heavy for him.	f	449
1764	He doesn't like it.	f	449
1765	He didn't see the passengers.	f	450
1766	He didn't like the noise it made.	f	450
1767	He didn't see the plane landing.	t	450
1768	He didn't know the arrival time.	f	450
1769	Peter can't understand them.	f	451
1770	Peter can't stand up to them.	f	451
1771	Peter will make them stand up.	f	451
1772	Peter can't tolerate them.	t	451
1773	They're becoming longer.	f	452
1774	They're becoming more interesting.	f	452
1775	They're becoming more rigid.	t	452
1776	They're becoming more important.	f	452
1777	They saved him.	t	453
1778	They surrounded him.	f	453
1779	They located him.	f	453
1780	They buried him.	f	453
1781	She doesn't know the truth.	f	454
1782	She wants to tell the truth.	f	454
1783	She is willing to tell the truth.	f	454
1784	She doesn't want to tell the truth.	t	454
1785	They neglected his warning.	f	455
1786	They liked his warning.	f	455
1787	They forgot his warning.	f	455
1788	They remembered his warning.	t	455
1789	this kind of watch is very expensive.	f	456
1790	This kind of watch breaks easily.	f	456
1791	You cannot buy this kind of watch anymore.	t	456
1792	You will not like this kind of watch.	f	456
1793	It is good for insulation.	f	457
1794	It burns easily.	t	457
1795	It is easy to lose.	f	457
1796	It is very expensive.	f	457
1797	He dislikes them very much.	f	458
1798	He makes them angry.	f	458
1799	He has great trouble working with them.	f	458
1800	He has a high regard for them.	t	458
1801	I was sick last night.	t	459
1802	I finished last night.	f	459
1803	I went running last night.	f	459
1804	I was in a rush last night.	f	459
1805	I don’t want to see your new home.	f	460
1806	I don’t  want anything in your new home.	f	460
1807	I really want to see your new home.	t	460
1808	I would give anything to have a new home.	f	460
1809	The damage wasn’t necessary.	f	461
1810	There was only a little damage.	t	461
1811	No damage was detected.	f	461
1812	There was major damage.	f	461
1813	He has enough time	t	462
1814	He hasn’t enough time.	f	462
1815	He has extra time.	f	462
1816	He has limited time.	f	462
1817	She wanted to know the cost.	f	463
1818	She wanted to know the means.	t	463
1819	She wanted to know the answer.	f	463
1820	She wanted to know the reason.	f	463
1821	a house	f	464
1822	a trip	f	464
1823	a car	t	464
1824	a friend	f	464
1825	The man should buy new clothing.	f	465
1826	The man has poor taste in clothing.	f	465
1827	The man should try to find his belt.	f	465
1828	The man should lose weight.	t	465
1829	It was expanded five months ago.	f	466
1830	It was started five months ago.	t	466
1831	It was moved five months ago.	f	466
1832	It was closed five months ago.	f	466
1833	It matched her furniture.	f	467
1834	It was a bargain.	f	467
1835	It was nice to site in.	t	467
1836	It was a pretty color.	f	467
1837	He paid for it ahead of time.	t	468
1838	He paid for it little by little.	f	468
1839	He paid for it with a loan.	f	468
1840	He paid for it with a check.	f	468
1841	to work	f	469
1842	on a trip	t	469
1843	to school	f	469
1844	on a picnic	f	469
1845	He wanted to go to bed.	f	470
1846	He wanted to get cleaned up.	f	470
1847	He wanted to drink something cold.	f	470
1848	He wanted to get somewhere fast.	t	470
1849	His house was pretty.	f	471
1850	His house was old.	f	471
1851	His house was big.	t	471
1852	His house was modern.	f	471
1853	She was studying how to build things.	t	472
1854	She was studying how to write stories.	f	472
1855	She was studying how to teach children.	f	472
1856	She was studying how to fix teeth.	f	472
1857	descending	f	473
1858	shacking	t	473
1859	rolling	f	473
1860	climbing	f	473
1861	He is careless.	f	474
1862	He is at fault.	f	474
1863	He is lazy.	f	474
1864	He likes to criticize.	t	474
1865	play ball	t	475
1866	eat supper	f	475
1867	work	f	475
1868	sleep	f	475
1869	putting off the meeting	t	476
1870	canceling the meeting	f	476
1871	attending the meeting	f	476
1872	holding a meeting	f	476
1873	took some medicine	f	477
1874	ran away	f	477
1875	got a ticket	f	477
1876	said he was sorry	t	477
1877	in a trailer home	f	478
1878	far from the base	f	478
1879	near from the base	t	478
1880	on the other side of town	f	478
1881	give them a briefing	f	479
1882	see how the class was conduct	f	479
1883	teach the class	t	479
1884	interview the student	f	479
1885	the speed	t	480
1886	the angle	f	480
1887	the diameter	f	480
1888	the circumference	f	480
1889	decorating a house	f	481
1890	selling a house	f	481
1891	building a house	t	481
1892	tearing down a house	f	481
1893	to be net	f	482
1894	to be fair	f	482
1895	to be truthful	f	482
1896	to be on time	t	482
1897	He threw them away.	t	483
1898	He published them.	f	483
1899	He put them on.	f	483
1900	He kicked them off.	f	483
1901	go up and down	t	484
1902	stay the same	f	484
1903	rise steadily	f	484
1904	fall steadily	f	484
1905	a sharp mind	f	485
1906	explosives	f	485
1907	the desire to succeed	t	485
1908	a prolonged illness	f	485
1909	come and pick him up	f	486
1910	cook some food for him	f	486
1911	buy some food	t	486
1912	order some food at home	f	486
1913	to write to the doctor	f	487
1914	to call the doctor	f	487
1915	to find out about the doctor	f	487
1916	to go see the doctor	t	487
1917	She allowed John to take the car.	t	488
1918	She warned John not to take the car.	f	488
1919	She ordered John to drive the car.	f	488
1920	She gave John a ride in the car.	f	488
1921	the time of the meeting	t	489
1922	how to repair the radio	f	489
1923	where Main Street is	f	489
1924	what to buy	f	489
1925	She’ll ask for the money.	f	490
1926	She’ll complain.	f	490
1927	She’ll stop working so hard.	f	490
1928	She’ll leave her job.	t	490
1929	after a while	f	491
1930	within minutes	t	491
1931	after a week	f	491
1932	in a day	f	491
1933	We agree with them.	f	492
1934	We employ them.	f	492
1935	We unite them.	f	492
1936	We contact them.	t	492
1937	act like their parents	t	493
1938	help their parents	f	493
1939	admire the parents	f	493
1940	live with their parents	f	493
1941	She turned him down.	f	494
1942	She got lost.	f	494
1943	She didn’t show up.	t	494
1944	She was late.	f	494
1945	He found that his work was hard.	f	495
1946	He started doing his work.	f	495
1947	He started looking for work.	f	495
1948	He made sure his work was right.	t	495
1949	He was not sure of the scores.	f	496
1950	He was unhappy with the scores.	t	496
1951	He was studying the scores.	f	496
1952	He was evaluating the scores.	f	496
1953	There were no results.	f	497
1954	There were no expectations.	f	497
1955	The results were not what Major Wilson expected.	t	497
1956	The results were what Major Wilson expected.	f	497
1957	I knew I would pass the exam.	f	498
1958	I didn’t make it.	f	498
1959	I didn’t think I would pass the exam.	t	498
1960	I’m not surprised by the results.	f	498
1961	They were praised.	f	499
1962	They were congratulated.	f	499
1963	They were kicked out.	t	499
1964	They graduated.	f	499
1965	They repelled it.	t	500
1966	They prevented it.	f	500
1967	They missed it.	f	500
1968	They started it.	f	500
1969	There was a traffic jam this morning.	t	501
1970	There was a car accident this morning.	f	501
1971	Cars were going at a high speed.	f	501
1972	The traffic light was out of order.	f	501
1973	The song makes her sad.	f	502
1974	The song is about love.	f	502
1975	She knows the singer very well.	f	502
1976	She has memorized the song.	t	502
1977	We must feed them.	f	503
1978	We must hit them.	f	503
1979	We must treat them.	f	503
1980	We must locate them.	t	503
1981	The washing machine is not working properly.	t	504
1982	The machine is user-friendly.	f	504
1983	The price of this washing machine is going up.	f	504
1984	The washing machine is now for sale.	f	504
1985	He won the lottery.	f	505
1986	He always thinks of the lottery.	t	505
1987	He has never bought any lottery tickets.	f	505
1988	Winning the lottery made him rich.	f	505
1989	I hailed a taxi.	f	506
1990	I was diving taxi.	f	506
1991	The taxi almost hit me.	t	506
1992	I was waiting for a taxi.	f	506
1993	A schedule was destroyed.	f	507
1994	A schedule was lost.	f	507
1995	A schedule was established.	t	507
1996	A schedule was found.	f	507
1997	James is confident about himself.	f	508
1998	James is proud of them.	f	508
1999	James is not true to himself.	f	508
2000	James lacks self-confidence.	t	508
2001	They had a normal day.	f	509
2002	They worked hard during the emergency.	t	509
2003	They had a practice drill.	f	509
2004	They had a false alarm.	f	509
2005	Don't let her tell.	f	510
2006	Don't tell her.	t	510
2007	Don't talk about her.	f	510
2008	Don't forget to tell her.	f	510
2009	It is said that he is having an affair.	t	511
2010	We believe he is having an affair.	f	511
2011	The rumor is not fair.	f	511
2012	We've never heard the rumor.	f	511
2013	It was raining.	f	512
2014	The visibility was poor.	t	512
2015	It was getting dark.	f	512
2016	There was a lot of snow.	f	512
2017	She received a surprise.	f	513
2018	She became very happy.	f	513
2019	She got a good deal.	f	513
2020	She felt unsteady.	t	513
2021	That medicine tasted bitter.	f	514
2022	That medicine worked miracles.	t	514
2023	The medicine tasted like wine.	f	514
2024	The medicine was prescribed carefully.	f	514
2025	They deserted their children.	f	515
2026	They moved because of their children.	t	515
2027	Their children didn't move with them.	f	515
2028	They sent their children to Manhattan.	f	515
2029	Harry bought a sedan.	t	516
2030	Harry bought a sports car.	f	516
2031	Harry wanted a sedan.	f	516
2032	Harry didn't want a sports car.	f	516
2033	They skip extensive training.	f	517
2034	They dislike extensive training.	f	517
2035	They have to receive extensive training.	t	517
2036	They train lightly because of exhaustion.	f	517
2037	You should have called me.	f	518
2038	You are supposed to call me after meeting me.	f	518
2039	Let me know if you cannot come.	t	518
2040	Call me when you arrive.	f	518
2041	It put in the shells.	f	519
2042	It mixed the shells.	f	519
2043	It threw out the shells.	f	519
2044	It fired the shells.	t	519
2045	The table is being held for their friends.	t	520
2046	The table for their friends is cheap.	f	520
2047	Their friends are in the seats.	f	520
2048	Their friends won't use the seats.	f	520
2049	It is good to hear you say that.	f	521
2050	It's getting chilly.	f	521
2051	It's perfect for cooking.	f	521
2052	It feels very hot.	t	521
2053	Don't forget to write her a letter.	f	522
2054	Don't forget to see her tomorrow.	f	522
2055	Don't forget to send her an e-mail.	f	522
2056	Don't forget to telephone her.	t	522
2057	turn right at the next corner	f	523
2058	give the woman a ride	f	523
2059	look for a taxi	t	523
2060	send a taxi immediately	f	523
2061	She doesn't like the man.	f	524
2062	She doesn't know how to paint.	f	524
2063	It's in the morning.	f	524
2064	She has an appointment to meet someone.	t	524
2065	He received a present at the meeting.	f	525
2066	He enjoyed the meeting.	f	525
2067	He attended the meeting.	t	525
2068	He was the speaker.	f	525
2069	Richard has been standing in the wrong place.	f	526
2070	Richard hasn't heard it correctly.	f	526
2071	Richard doesn't know what it means.	t	526
2072	Richard means everything he says.	f	526
2073	She should treat him to dinner.	f	527
2074	It's very easy.	f	527
2075	He's hungry.	f	527
2076	It's too difficult for him.	t	527
2077	He doesn't like his new apartment.	f	528
2078	Someone is standing behind him.	f	528
2079	His back aches.	t	528
2080	Someone is trying to kill him.	f	528
2081	Colonel Roberts will not give a speech.	f	529
2082	Colonel Roberts will ignore the speaker.	f	529
2083	Colonel Roberts will be the main speaker.	t	529
2084	Colonel Roberts will introduce the speaker.	f	529
2085	a chef	f	530
2086	a customer	f	530
2087	a waitress	t	530
2088	a janitor	f	530
2089	one	t	531
2090	a few	f	531
2091	two	f	531
2092	none	f	531
2093	stop working	f	532
2094	do the work better	f	532
2095	continue to work	t	532
2096	do the work over again	f	532
2101	during	f	537
2102	since	t	537
2103	between	f	537
2104	for	f	537
2109	Yes, I do.	t	539
2110	Yes, I did.	f	539
2111	No, I do.	f	539
2112	No, I did.	f	539
2113	officer	f	540
2114	officers	f	540
2115	a officer	t	540
2116	an officer	f	540
\.


--
-- Data for Name: alcpt_department; Type: TABLE DATA; Schema: alcpt; Owner: postgres
--

COPY alcpt.alcpt_department (id, name) FROM stdin;
2	法律系
3	財管系
1	資管系
4	運籌系
\.


--
-- Data for Name: alcpt_exam; Type: TABLE DATA; Schema: alcpt; Owner: postgres
--

COPY alcpt.alcpt_exam (id, name, exam_type, use_freq, average_score, start_time, created_time, duration, finish_time, is_public, created_by_id, testpaper_id, modified_time, remaining_time, is_started) FROM stdin;
62	閱讀練習-2020/12/29 15:53:01	4	0	0	\N	2020-12-29 15:53:01.810352+00	0	\N	f	5	54	\N	\N	f
63	聽力練習-2020/12/29 15:53:17	3	0	0	\N	2020-12-29 15:53:17.409845+00	0	\N	f	5	55	\N	\N	f
64	123	1	0	6	2020-12-29 19:35:00+00	2020-12-29 19:37:24.881949+00	4	2020-12-29 19:39:00+00	t	5	56	\N	\N	f
65	12345676879	1	0	26	2020-12-29 19:50:00+00	2020-12-29 19:51:06.719948+00	10	2020-12-29 20:00:00+00	t	5	56	\N	\N	f
66	第一次模擬考	1	0	20	2020-12-29 21:00:00+00	2020-12-29 21:00:49.338994+00	5	2020-12-29 21:05:00+00	t	5	56	\N	\N	f
67	閱讀練習-2021/01/04 10:46:14	4	0	30	\N	2021-01-04 10:46:14.842559+00	0	\N	f	9	57	\N	\N	f
68	123213	1	0	20	2021-01-18 10:45:00+00	2021-01-18 10:49:12.359241+00	10	2021-01-18 10:55:00+00	t	5	56	\N	\N	f
69	閱讀練習-2021/01/25 10:34:42	4	0	0	\N	2021-01-25 10:34:42.813712+00	0	\N	f	9	58	\N	\N	f
70	123123123	1	0	0	2021-01-25 10:40:00+00	2021-01-25 10:40:25.297416+00	10	2021-01-25 10:50:00+00	t	9	59	\N	\N	f
71	閱讀練習-2021/01/25 10:56:36	4	0	0	\N	2021-01-25 10:56:36.140818+00	0	\N	f	9	60	\N	\N	f
72	閱讀練習-2021/01/25 11:15:04	4	0	0	\N	2021-01-25 11:15:04.168914+00	0	\N	f	9	61	\N	\N	f
73	閱讀練習-2021/01/25 11:31:34	4	0	50	\N	2021-01-25 11:31:34.643907+00	0	\N	f	19	62	\N	\N	f
74	1919	1	0	100	2021-02-01 10:35:00+00	2021-02-01 10:36:27.080283+00	5	2021-02-01 10:40:00+00	t	5	56	\N	\N	f
75	聽力練習-2021/03/13 16:31:15	3	0	20	\N	2021-03-13 16:31:15.411493+00	0	2021-03-13 16:41:15+00	f	5	63	\N	\N	f
76	聽力練習-2021/10/12 15:20:23	3	0	30	\N	2021-10-12 15:20:23.721156+00	0	2021-10-12 15:30:26.326833+00	f	36	65	2021-10-12 15:20:26.326833+00	600	t
77	閱讀練習-2021/10/12 15:22:55	4	0	0	\N	2021-10-12 15:22:55.201898+00	0	2021-10-12 15:27:57.408505+00	f	36	66	2021-10-12 15:22:57.408505+00	300	t
78	Angel	1	0	32	2021-10-12 16:45:00+00	2021-10-12 16:43:25.931267+00	30	2021-10-12 17:15:00+00	t	36	67	\N	\N	t
79	閱讀練習-2021/10/19 14:09:13	4	0	40	\N	2021-10-19 14:09:13.505566+00	0	\N	f	36	68	\N	\N	t
80	閱讀練習-2021/11/04 10:26:26	4	0	20	\N	2021-11-04 10:26:26.463132+00	0	2021-11-04 10:36:34.591087+00	f	36	69	2021-11-04 10:26:34.591087+00	600	t
81	閱讀練習-2021/11/04 10:52:44	4	0	10	\N	2021-11-04 10:52:44.562992+00	0	2021-11-04 10:54:50.588715+00	f	36	70	2021-11-04 10:52:50.588715+00	120	t
82	聽力練習-2021/11/04 11:00:18	3	0	30	\N	2021-11-04 11:00:18.196655+00	0	2021-11-04 12:39:21.951871+00	f	36	71	2021-11-04 11:00:21.951871+00	5940	t
83	聽力練習-2021/11/04 23:10:25	3	0	30	\N	2021-11-04 23:10:26.020932+00	0	2021-11-05 00:51:14.919167+00	f	36	72	2021-11-04 23:24:01.919167+00	5233	t
84	1101130	1	0	86	2021-11-30 11:00:00+00	2021-11-30 11:00:04.836102+00	20	2021-11-30 11:20:00+00	t	36	56	\N	\N	t
85	1101201	1	0	26	2021-12-02 11:45:00+00	2021-12-02 11:44:56.574885+00	5	2021-12-02 11:50:00+00	t	36	56	\N	\N	t
86	1101207	1	0	0	2021-12-07 14:40:00+00	2021-12-07 14:41:51.857647+00	10	2021-12-07 14:50:00+00	t	36	56	\N	\N	f
87	模擬考001	1	0	73.2	2022-03-12 23:10:00+00	2022-03-12 23:08:34.853241+00	40	2022-03-12 23:50:00+00	t	36	73	\N	\N	t
88	test12345	1	0	0	2022-05-03 11:10:00+00	2022-05-03 11:11:16.885923+00	2	2022-05-03 11:12:00+00	t	36	56	\N	\N	t
89	listentest	1	0	0	2022-05-03 11:10:00+00	2022-05-03 11:12:49.58997+00	5	2022-05-03 11:15:00+00	t	36	79	\N	\N	t
90	0511	1	0	0	2022-05-12 15:25:00+00	2022-05-12 15:26:35.24624+00	5	2022-05-12 15:30:00+00	t	36	56	\N	\N	t
91	0510	1	0	90	2022-05-12 15:50:00+00	2022-05-12 15:52:26.079961+00	8	2022-05-12 15:58:00+00	t	36	80	\N	\N	t
92	閱讀練習-2022/05/12 16:43:41	4	0	40	\N	2022-05-12 16:43:41.081291+00	0	\N	f	36	81	\N	\N	t
93	閱讀練習-2022/05/12 17:06:07	4	0	10	\N	2022-05-12 17:06:07.907177+00	0	\N	f	36	82	\N	\N	t
94	閱讀練習-2022/05/12 18:06:40	4	0	80	\N	2022-05-12 18:06:40.077058+00	0	\N	f	36	83	\N	\N	t
95	閱讀練習-2022/05/12 18:07:46	4	0	60	\N	2022-05-12 18:07:46.176699+00	0	\N	f	36	84	\N	\N	t
96	閱讀練習-2022/05/12 18:08:46	4	0	80	\N	2022-05-12 18:08:47.040996+00	0	\N	f	36	85	\N	\N	t
97	閱讀練習-2022/05/12 18:09:50	4	0	100	\N	2022-05-12 18:09:50.299249+00	0	\N	f	36	86	\N	\N	t
98	閱讀練習-2022/05/12 18:12:33	4	0	70	\N	2022-05-12 18:12:33.474433+00	0	\N	f	36	87	\N	\N	t
99	test0511	1	0	80	2022-05-12 18:15:00+00	2022-05-12 18:17:00.173031+00	3	2022-05-12 18:18:00+00	t	36	80	\N	\N	t
100	test0512	1	0	90	2022-05-12 23:00:00+00	2022-05-12 23:04:04.945101+00	25	2022-05-12 23:25:00+00	t	36	80	\N	\N	t
101	閱讀練習-2022/05/13 10:17:18	4	0	70	\N	2022-05-13 10:17:18.549057+00	0	\N	f	36	88	\N	\N	t
102	閱讀練習-2022/05/13 10:24:51	4	0	50	\N	2022-05-13 10:24:51.901719+00	0	\N	f	36	89	\N	\N	t
103	閱讀練習-2022/05/13 10:28:10	4	0	90	\N	2022-05-13 10:28:10.874452+00	0	\N	f	36	90	\N	\N	t
104	test0513	1	0	80	2022-05-16 01:25:00+00	2022-05-16 01:27:57.99392+00	15	2022-05-16 01:40:00+00	t	36	80	\N	\N	t
105	閱讀練習-2022/05/17 12:20:31	4	0	90	\N	2022-05-17 12:20:31.342314+00	0	\N	f	36	91	\N	\N	t
106	閱讀練習-2022/05/17 14:18:02	4	0	70	\N	2022-05-17 14:18:02.062264+00	0	\N	f	36	92	\N	\N	t
107	鑑測0518	1	0	80	2022-05-18 18:15:00+00	2022-05-18 18:15:16.898705+00	30	2022-05-18 18:45:00+00	t	36	80	\N	\N	t
108	鑑測0519	1	0	80	2022-05-19 00:10:00+00	2022-05-19 00:09:32.094143+00	20	2022-05-19 00:30:00+00	t	36	80	\N	\N	t
109	鑑測05192	1	0	80	2022-05-19 00:30:00+00	2022-05-19 00:33:08.351424+00	10	2022-05-19 00:40:00+00	t	36	80	\N	\N	t
110	閱讀練習-2022/05/19 18:41:33	4	0	80	\N	2022-05-19 18:41:33.925052+00	0	\N	f	36	93	\N	\N	t
111	閱讀練習-2022/05/19 18:44:07	4	0	80	\N	2022-05-19 18:44:07.841669+00	0	\N	f	36	94	\N	\N	t
\.


--
-- Data for Name: alcpt_exam_testeelist; Type: TABLE DATA; Schema: alcpt; Owner: postgres
--

COPY alcpt.alcpt_exam_testeelist (id, exam_id, user_id) FROM stdin;
253	64	5
254	64	8
255	64	9
256	65	5
257	65	8
258	65	9
259	66	5
260	66	8
261	66	9
262	68	5
263	68	8
264	68	9
265	70	5
266	70	8
267	70	9
268	74	5
269	74	8
270	74	9
271	78	36
272	84	36
273	85	36
274	86	36
275	87	36
276	87	38
277	87	39
278	87	40
279	87	41
280	88	36
281	88	38
282	88	39
283	88	40
284	88	41
285	89	36
286	89	38
287	89	39
288	89	40
289	89	41
291	91	36
292	99	36
293	100	36
294	104	36
295	107	36
296	108	36
297	109	36
\.


--
-- Data for Name: alcpt_forum; Type: TABLE DATA; Schema: alcpt; Owner: postgres
--

COPY alcpt.alcpt_forum (id, f_content, data_time, f_creator_id, f_question_id) FROM stdin;
241	ought to 跟 had to 的差別在哪裡？	2022-05-12 16:00:21+00	36	36
242	為何不能選that?	2022-05-12 16:01:28+00	36	34
254	這題時態要如何判斷呢？	2022-05-13 10:09:32+00	36	32
258	這題時態如何判斷？	2022-05-19 18:36:07+00	36	31
\.


--
-- Data for Name: alcpt_group; Type: TABLE DATA; Schema: alcpt; Owner: postgres
--

COPY alcpt.alcpt_group (id, name, update_time, created_time, created_by_id) FROM stdin;
31	資管系111年班	2022-05-03 15:12:57.685994+00	2022-05-03 15:12:54.327439+00	36
\.


--
-- Data for Name: alcpt_group_member; Type: TABLE DATA; Schema: alcpt; Owner: postgres
--

COPY alcpt.alcpt_group_member (id, group_id, user_id) FROM stdin;
134	31	36
\.


--
-- Data for Name: alcpt_proclamation; Type: TABLE DATA; Schema: alcpt; Owner: postgres
--

COPY alcpt.alcpt_proclamation (id, title, text, is_public, created_time, created_by_id, is_read, recipient_id, exam_id, report_id) FROM stdin;
99	123	Start Time: 2020-12-29 19:35\nDuration: 4 minutes.\n	f	2020-12-29 19:37:24.947659+00	5	f	8	64	0
102	12345676879	Start Time: 2020-12-29 19:50\nDuration: 10 minutes.\n	f	2020-12-29 19:51:06.785913+00	5	f	8	65	0
105	第一次模擬考	Start Time: 2020-12-29 21:0\nDuration: 5 minutes.\n	f	2020-12-29 21:00:49.403954+00	5	f	8	66	0
108	123213	Start Time: 2021-01-18 10:45\nDuration: 10 minutes.\n	f	2021-01-18 10:49:12.428793+00	5	f	8	68	0
111	123123123	Start Time: 2021-01-25 10:40\nDuration: 10 minutes.\n	f	2021-01-25 10:40:25.359526+00	9	f	8	70	0
112	123123123	Start Time: 2021-01-25 10:40\nDuration: 10 minutes.\n	f	2021-01-25 10:40:25.359551+00	9	t	9	70	0
114	1919	Start Time: 2021-02-01 10:35\nDuration: 5 minutes.\n	f	2021-02-01 10:36:27.145386+00	5	f	8	74	0
115	1919	Start Time: 2021-02-01 10:35\nDuration: 5 minutes.\n	f	2021-02-01 10:36:27.14541+00	5	t	9	74	0
118	Angel	Start Time: 2021-10-12 16:45\nDuration: 30 minutes.\n	f	2021-10-12 16:43:26.032346+00	36	t	36	78	0
119	1101130	Start Time: 2021-11-30 11:0\nDuration: 20 minutes.\n	f	2021-11-30 11:00:04.911215+00	36	t	36	84	0
120	1101201	Start Time: 2021-12-02 11:45\nDuration: 5 minutes.\n	f	2021-12-02 11:44:56.641285+00	36	t	36	85	0
121	1101207	Start Time: 2021-12-07 14:40\nDuration: 10 minutes.\n	f	2021-12-07 14:41:51.915191+00	36	t	36	86	0
122	模擬考001	Start Time: 2022-03-12 23:10\nDuration: 40 minutes.\n	f	2022-03-12 23:08:34.988118+00	36	t	36	87	0
123	模擬考001	Start Time: 2022-03-12 23:10\nDuration: 40 minutes.\n	f	2022-03-12 23:08:34.988143+00	36	t	38	87	0
124	模擬考001	Start Time: 2022-03-12 23:10\nDuration: 40 minutes.\n	f	2022-03-12 23:08:34.988155+00	36	t	39	87	0
125	模擬考001	Start Time: 2022-03-12 23:10\nDuration: 40 minutes.\n	f	2022-03-12 23:08:34.988166+00	36	t	40	87	0
126	模擬考001	Start Time: 2022-03-12 23:10\nDuration: 40 minutes.\n	f	2022-03-12 23:08:34.988177+00	36	t	41	87	0
128	test12345	Start Time: 2022-05-03 11:10\nDuration: 2 minutes.\n	f	2022-05-03 11:11:17.004962+00	36	t	36	88	0
129	test12345	Start Time: 2022-05-03 11:10\nDuration: 2 minutes.\n	f	2022-05-03 11:11:17.004988+00	36	f	38	88	0
130	test12345	Start Time: 2022-05-03 11:10\nDuration: 2 minutes.\n	f	2022-05-03 11:11:17.005+00	36	f	39	88	0
131	test12345	Start Time: 2022-05-03 11:10\nDuration: 2 minutes.\n	f	2022-05-03 11:11:17.005012+00	36	f	40	88	0
132	test12345	Start Time: 2022-05-03 11:10\nDuration: 2 minutes.\n	f	2022-05-03 11:11:17.005023+00	36	f	41	88	0
133	listentest	Start Time: 2022-05-03 11:10\nDuration: 5 minutes.\n	f	2022-05-03 11:12:49.758609+00	36	t	36	89	0
134	listentest	Start Time: 2022-05-03 11:10\nDuration: 5 minutes.\n	f	2022-05-03 11:12:49.758631+00	36	f	38	89	0
135	listentest	Start Time: 2022-05-03 11:10\nDuration: 5 minutes.\n	f	2022-05-03 11:12:49.758642+00	36	f	39	89	0
136	listentest	Start Time: 2022-05-03 11:10\nDuration: 5 minutes.\n	f	2022-05-03 11:12:49.758653+00	36	f	40	89	0
137	listentest	Start Time: 2022-05-03 11:10\nDuration: 5 minutes.\n	f	2022-05-03 11:12:49.758664+00	36	f	41	89	0
138	0511	Start Time: 2022-05-12 15:25\nDuration: 5 minutes.\n	f	2022-05-12 15:26:35.304744+00	36	t	36	90	0
139	0511	Start Time: 2022-05-12 15:25\nDuration: 5 minutes.\n	f	2022-05-12 15:26:35.304769+00	36	f	38	90	0
140	0511	Start Time: 2022-05-12 15:25\nDuration: 5 minutes.\n	f	2022-05-12 15:26:35.304782+00	36	f	39	90	0
141	0511	Start Time: 2022-05-12 15:25\nDuration: 5 minutes.\n	f	2022-05-12 15:26:35.304793+00	36	f	40	90	0
142	0511	Start Time: 2022-05-12 15:25\nDuration: 5 minutes.\n	f	2022-05-12 15:26:35.304819+00	36	f	41	90	0
143	0510	Start Time: 2022-05-12 15:50\nDuration: 8 minutes.\n	f	2022-05-12 15:52:26.115207+00	36	t	36	91	0
144	0510	Start Time: 2022-05-12 15:50\nDuration: 8 minutes.\n	f	2022-05-12 15:52:26.115231+00	36	f	38	91	0
145	0510	Start Time: 2022-05-12 15:50\nDuration: 8 minutes.\n	f	2022-05-12 15:52:26.115243+00	36	f	39	91	0
146	0510	Start Time: 2022-05-12 15:50\nDuration: 8 minutes.\n	f	2022-05-12 15:52:26.115255+00	36	f	40	91	0
147	0510	Start Time: 2022-05-12 15:50\nDuration: 8 minutes.\n	f	2022-05-12 15:52:26.115266+00	36	f	41	91	0
148	test0511	Start Time: 2022-05-12 18:15\nDuration: 3 minutes.\n	f	2022-05-12 18:17:00.211113+00	36	t	36	99	0
149	test0511	Start Time: 2022-05-12 18:15\nDuration: 3 minutes.\n	f	2022-05-12 18:17:00.211141+00	36	f	38	99	0
150	test0511	Start Time: 2022-05-12 18:15\nDuration: 3 minutes.\n	f	2022-05-12 18:17:00.211153+00	36	f	39	99	0
151	test0511	Start Time: 2022-05-12 18:15\nDuration: 3 minutes.\n	f	2022-05-12 18:17:00.211164+00	36	f	40	99	0
152	test0511	Start Time: 2022-05-12 18:15\nDuration: 3 minutes.\n	f	2022-05-12 18:17:00.211175+00	36	f	41	99	0
153	test0512	Start Time: 2022-05-12 23:0\nDuration: 25 minutes.\n	f	2022-05-12 23:04:05.02059+00	36	t	36	100	0
154	test0512	Start Time: 2022-05-12 23:0\nDuration: 25 minutes.\n	f	2022-05-12 23:04:05.020675+00	36	f	38	100	0
155	test0512	Start Time: 2022-05-12 23:0\nDuration: 25 minutes.\n	f	2022-05-12 23:04:05.020687+00	36	f	39	100	0
156	test0512	Start Time: 2022-05-12 23:0\nDuration: 25 minutes.\n	f	2022-05-12 23:04:05.020699+00	36	f	40	100	0
157	test0512	Start Time: 2022-05-12 23:0\nDuration: 25 minutes.\n	f	2022-05-12 23:04:05.02071+00	36	f	41	100	0
158	test0513	Start Time: 2022-05-16 1:25\nDuration: 15 minutes.\n	f	2022-05-16 01:27:58.053147+00	36	t	36	104	0
159	test0513	Start Time: 2022-05-16 1:25\nDuration: 15 minutes.\n	f	2022-05-16 01:27:58.053179+00	36	f	38	104	0
160	test0513	Start Time: 2022-05-16 1:25\nDuration: 15 minutes.\n	f	2022-05-16 01:27:58.053191+00	36	f	39	104	0
161	test0513	Start Time: 2022-05-16 1:25\nDuration: 15 minutes.\n	f	2022-05-16 01:27:58.053202+00	36	f	40	104	0
162	test0513	Start Time: 2022-05-16 1:25\nDuration: 15 minutes.\n	f	2022-05-16 01:27:58.053213+00	36	f	41	104	0
163	鑑測0518	Start Time: 2022-05-18 18:15\nDuration: 30 minutes.\n	f	2022-05-18 18:15:16.974341+00	36	t	36	107	0
164	鑑測0518	Start Time: 2022-05-18 18:15\nDuration: 30 minutes.\n	f	2022-05-18 18:15:16.974369+00	36	f	38	107	0
165	鑑測0518	Start Time: 2022-05-18 18:15\nDuration: 30 minutes.\n	f	2022-05-18 18:15:16.974381+00	36	f	39	107	0
166	鑑測0518	Start Time: 2022-05-18 18:15\nDuration: 30 minutes.\n	f	2022-05-18 18:15:16.974393+00	36	f	40	107	0
167	鑑測0518	Start Time: 2022-05-18 18:15\nDuration: 30 minutes.\n	f	2022-05-18 18:15:16.974404+00	36	f	41	107	0
168	鑑測0519	Start Time: 2022-05-19 0:10\nDuration: 20 minutes.\n	f	2022-05-19 00:09:32.145093+00	36	t	36	108	0
169	鑑測0519	Start Time: 2022-05-19 0:10\nDuration: 20 minutes.\n	f	2022-05-19 00:09:32.145123+00	36	f	38	108	0
170	鑑測0519	Start Time: 2022-05-19 0:10\nDuration: 20 minutes.\n	f	2022-05-19 00:09:32.145135+00	36	f	39	108	0
171	鑑測0519	Start Time: 2022-05-19 0:10\nDuration: 20 minutes.\n	f	2022-05-19 00:09:32.145147+00	36	f	40	108	0
172	鑑測0519	Start Time: 2022-05-19 0:10\nDuration: 20 minutes.\n	f	2022-05-19 00:09:32.145158+00	36	f	41	108	0
173	鑑測05192	Start Time: 2022-05-19 0:30\nDuration: 10 minutes.\n	f	2022-05-19 00:33:08.42506+00	36	t	36	109	0
174	鑑測05192	Start Time: 2022-05-19 0:30\nDuration: 10 minutes.\n	f	2022-05-19 00:33:08.425089+00	36	f	38	109	0
175	鑑測05192	Start Time: 2022-05-19 0:30\nDuration: 10 minutes.\n	f	2022-05-19 00:33:08.4251+00	36	f	39	109	0
176	鑑測05192	Start Time: 2022-05-19 0:30\nDuration: 10 minutes.\n	f	2022-05-19 00:33:08.425111+00	36	f	40	109	0
177	鑑測05192	Start Time: 2022-05-19 0:30\nDuration: 10 minutes.\n	f	2022-05-19 00:33:08.425122+00	36	f	41	109	0
\.


--
-- Data for Name: alcpt_question; Type: TABLE DATA; Schema: alcpt; Owner: postgres
--

COPY alcpt.alcpt_question (id, q_type, q_file, q_content, difficulty, issued_freq, correct_freq, created_time, update_time, is_valid, state, created_by_id, last_updated_by_id, faulted_reason, q_correct_time, q_time, in_forum, best_reply, replier_id) FROM stdin;
1	3		He is ____ in the military service.	1	10	31	2019-05-19 16:18:54.592+00	2022-05-04 22:33:10.402456+00	f	5	1	36		9	29	f	\N	\N
2	4		What kind of missile that distance is from 1000 km to 3000km?	1	4	0	2019-12-13 12:34:07.004452+00	2021-11-04 10:54:27.332006+00	f	1	1	1		0	1	f	\N	\N
3	4	\N	Which of the following options matches accuracy, durability, and fitness?	1	2	0	2019-12-14 06:48:42.496852+00	2020-02-24 11:14:44.887823+00	f	1	1	1		0	0	f	\N	\N
5	3		If he  ____ his sweater, he wouldn’t have caught a cold.	1	11	53	2019-12-17 12:03:07.417097+00	2022-05-19 00:35:22.140809+00	f	1	1	1		23	43	f	\N	\N
6	4		"Victory is still measured by foot." is a common saying in the Indian Army.\r\nThis means that, while many types of units fight in a war, it is the __________ who ultimately win or lose wars.	1	5	100	2019-12-17 14:22:04.373493+00	2021-10-26 14:15:58.126916+00	f	1	1	1		9	9	f	\N	\N
23	4		The rule of ______ in UO are often very strict in order to minimize collateral damage.	1	0	0	2019-12-18 13:19:04.544839+00	2020-12-15 16:19:32.017805+00	f	1	1	1		0	7	f	\N	\N
28	1	question_files/question_28.mp3	\N	1	3	100	2019-12-18 16:30:52.424219+00	2021-10-12 15:21:28.693333+00	f	1	1	1	鄧紫棋太正	1	1	f	\N	\N
29	3		I can't go with you ______ I'm busy.	1	6	44	2019-12-18 12:24:40.346544+00	2022-05-19 18:44:52.40335+00	f	1	1	1		20	45	f	\N	\N
30	3		They have been waiting for me ______ 5 o'clock.	1	4	0	2019-12-18 12:26:59.413803+00	2020-04-12 23:42:10.986821+00	f	5	1	1		0	0	f	\N	\N
31	3		Most people ______ to red newspapers.	1	7	30	2019-12-18 12:29:04.000232+00	2022-05-19 00:35:22.118481+00	f	1	1	1		13	43	t	\N	\N
32	3		John would have called the police if he ____ the accident.	1	8	44	2019-12-18 12:41:20.098003+00	2022-05-19 18:44:52.398597+00	f	1	1	1		15	34	t	\N	\N
33	3		He finished _____ his tape.	1	9	33	2019-12-18 12:44:37.305665+00	2022-05-19 18:44:52.393265+00	f	1	1	36		15	45	f	\N	\N
34	3		He left the office early ____ he could do some shopping.	1	6	48	2019-12-18 12:46:07.53802+00	2022-05-19 00:35:22.12842+00	f	1	1	1		17	35	t	\N	\N
35	3		______ you mind closing the window?	1	7	46	2019-12-18 12:46:52.892223+00	2022-05-19 18:42:23.735363+00	f	1	1	1		20	43	f	\N	\N
36	3		You ______ review this lesson before you take the test.	1	6	44	2019-12-18 12:50:56.110807+00	2022-05-19 18:44:52.405725+00	f	1	1	1		15	34	t	\N	\N
37	3		He has been studying English _____ four years.	1	9	73	2019-12-18 12:52:35.977609+00	2022-05-19 00:35:22.131986+00	f	1	1	1		34	46	f	\N	\N
40	3		The visibility was poor yesterday. I _______.	1	9	81	2019-12-18 13:09:06.167496+00	2022-05-19 18:44:52.414083+00	f	1	1	1		27	33	f	\N	\N
41	3		Howard finished ________ because he was the fastest.	1	8	47	2019-12-18 13:11:47.679947+00	2022-05-19 18:42:23.772851+00	f	1	1	1		19	40	f	\N	\N
42	3		Get the red book. _______ is on the shelf.	1	9	40	2019-12-18 13:14:11.897504+00	2022-05-18 08:40:52.8018+00	f	1	1	1		15	37	f	\N	\N
43	3		I am going _______ to buy a new car.	1	5	15	2019-12-18 13:15:43.150014+00	2022-05-19 18:42:23.73106+00	f	1	1	1		5	33	f	\N	\N
44	3		The weather is ______ today than it was last night.	1	7	39	2019-12-18 13:16:38.833223+00	2022-05-19 18:44:52.384822+00	f	1	1	1		13	33	f	\N	\N
45	3		In the U.S., conversation is _______ proper during meals.	1	5	16	2019-12-18 13:34:36.70834+00	2022-05-19 18:44:52.396244+00	f	1	1	1		4	24	f	\N	\N
46	3		______ spears for weapons, the men hunted wild animals.	1	6	27	2019-12-18 13:38:41.44999+00	2022-05-19 18:42:23.725314+00	f	1	1	1		11	40	f	\N	\N
47	3		Aircraft pilots communicate ______ control towers.	1	10	52	2019-12-18 13:39:49.363301+00	2022-05-19 18:44:52.417724+00	f	1	1	1		20	38	f	\N	\N
48	3		Did the students ______ a lot of homework last night?	1	9	88	2019-12-18 13:40:48.026545+00	2022-05-19 18:42:23.767187+00	f	1	1	1		24	27	f	\N	\N
49	4		The ______ is a common military firearm. Soldiers fire it from the shoulder. It has a built-in sight.	1	1	0	2019-12-20 06:58:58.709023+00	2021-10-12 15:23:11.03434+00	f	1	1	1		0	1	f	\N	\N
50	4		In fact, ________ have great symbolic meaning. When a unit is defeated, the commanding officer often gives his sidearm to the enemy commander.	1	3	0	2019-12-20 07:02:22.291929+00	2021-10-26 14:15:58.208075+00	f	1	1	1		0	2	f	\N	\N
51	4	\N	Small mortars are _______ and used by infantry units.	1	1	0	2019-12-20 07:20:14.774868+00	2020-01-05 21:24:59.105996+00	f	1	1	1		0	0	f	\N	\N
52	5		What does the passage say about tanks?	1	10	100	2019-12-20 07:24:04.722459+00	2021-10-26 14:15:58.253674+00	f	1	1	1		2	2	f	\N	\N
53	4		Joe could not find a job that he really wanted. Therefore, he felt very _______.	1	1	66	2019-12-21 19:15:16.742985+00	2021-10-26 14:15:58.227415+00	f	1	1	1		6	9	f	\N	\N
54	4		I need someone to help me solve this _______ math problem. It is not easy for me to understand.	1	1	100	2019-12-21 19:17:11.091771+00	2021-10-26 14:15:58.319739+00	f	1	1	1		2	2	f	\N	\N
55	4		When you are depressed, try to replace all your _______ thoughts with positive ones.	1	1	0	2019-12-21 19:18:18.60399+00	2021-10-12 15:23:11.0495+00	f	1	1	1		0	1	f	\N	\N
56	4	\N	The letter _______, so you should reply to it as soon as possible.	1	0	0	2019-12-21 19:20:47.518982+00	2020-02-16 22:29:44.658914+00	f	1	1	1		0	0	f	\N	\N
57	4	\N	The old building has been discovered to be _______. It is vacant precisely for this reason.	1	2	0	2019-12-21 19:22:11.623838+00	2020-02-20 11:31:36.457369+00	f	1	1	1		0	0	f	\N	\N
58	4		Scientists have _______ that the greenhouse effect caused global warming.	1	2	57	2019-12-21 19:24:19.30912+00	2020-12-15 16:19:32.063094+00	f	1	1	1		4	7	f	\N	\N
59	4	\N	Bobby cared a lot about his _____ at home and asked his parents not to go through his things without his permission.	1	3	0	2019-12-21 19:32:03.154157+00	2020-03-16 02:38:05.230902+00	f	1	1	1		0	0	f	\N	\N
60	3		The new manager is a real gentleman. He is  kind and humble, totally different from the former manager,\r\nwho was _____ and bossy.	1	8	41	2019-12-21 19:33:47.066982+00	2022-05-19 18:42:23.748956+00	f	1	1	1		13	31	f	\N	\N
61	4		The weather bureau _____ that the typhoon would bring strong winds and heavy rains, and warned everyone of the possible danger.	1	1	0	2019-12-21 19:35:38.516608+00	2020-12-15 16:19:32.050659+00	f	1	1	1		0	7	f	\N	\N
62	4		Different airlines have different _____ for carry-on luggage, but many international airlines limit a carry-on piece to 7 kilograms.	1	1	14	2019-12-22 03:06:55.597684+00	2020-12-15 16:19:32.01413+00	f	1	1	1		1	7	f	\N	\N
63	4	\N	To reach the goal of making her company a market leader, Michelle _______ a plan to open ten new stores around the country this year.	1	0	0	2019-12-24 12:54:51.363684+00	2020-02-16 22:29:44.66744+00	f	1	1	1		0	0	f	\N	\N
64	4	\N	Silence in some way is as _____ as speech. It can be used to show, for example, disagreement or lack\r\nof interest.	1	1	0	2019-12-25 08:09:16.84592+00	2020-02-24 11:14:44.885972+00	f	1	1	1		0	0	f	\N	\N
65	4	\N	This TV program is designed for children, _____ for those under five. It contains no violence or strong language.	1	1	0	2019-12-25 08:10:20.484738+00	2019-12-31 07:36:05.334955+00	f	1	1	1		0	0	f	\N	\N
66	4		Tommy, please put away the toys in the box, or you might _____ on them and hurt yourself.\r\n	1	2	100	2019-12-25 08:11:09.275821+00	2022-05-12 17:06:31.104669+00	f	1	1	1		1	1	f	\N	\N
67	4		The _____ costume party, held every September, is one of the biggest events of the school year.	1	0	0	2019-12-25 08:12:06.79979+00	2021-10-12 15:23:11.031501+00	f	1	1	1		0	1	f	\N	\N
68	4	\N	In a job interview, attitude and personality are usually important _____ that influence the decision of the interviewers.	1	4	0	2019-12-25 08:13:02.205312+00	2020-02-16 22:29:44.679837+00	f	1	1	1		0	0	f	\N	\N
69	4	\N	The snow-capped mountain is described so _____ in the book that the scene seems to come alive in\r\nfront of the reader’s eyes.	1	2	0	2019-12-25 08:14:17.086109+00	2020-03-16 02:38:05.23354+00	f	1	1	1		0	0	f	\N	\N
70	4	\N	. Surrounded by flowers blooming and birds _____ merrily, the Wangs had a good time hiking in the\r\nnational park.\r\n	1	2	0	2019-12-25 08:15:19.386222+00	2020-03-17 00:31:53.051285+00	f	1	1	1		0	0	f	\N	\N
71	4		It is essential for us to maintain constant _____ with our friends to ensure that we have someone to talk to in times of need.	1	1	14	2019-12-25 08:16:08.286657+00	2020-12-15 16:19:32.053729+00	f	1	1	1		1	7	f	\N	\N
72	4		The young generation in this country has shown less interest in factory work and other _____ labor jobs, such as house construction and fruit picking.	1	3	0	2019-12-25 08:17:04.767922+00	2021-11-04 10:54:27.311442+00	f	1	1	1		0	3	f	\N	\N
73	4	\N	Mangoes are a _____ fruit here in Taiwan; most of them reach their peak of sweetness in July.	1	3	0	2019-12-25 08:18:41.941366+00	2019-12-31 06:34:15.71773+00	f	1	1	1		0	0	f	\N	\N
74	4		Writing term papers and giving oral reports are typical course _____ for college students.	1	0	0	2019-12-25 08:21:44.015877+00	2021-10-12 15:23:11.02267+00	f	1	1	1		0	1	f	\N	\N
75	4		If we work hard to _____ our dreams when we are young, we will not feel that we missed out on\r\nsomething when we get old.	1	3	0	2019-12-25 08:23:09.64555+00	2021-10-12 15:23:11.047332+00	f	1	1	1		0	1	f	\N	\N
76	4	\N	Few people will trust you if you continue making _____ promises and never make efforts to keep them.	1	1	0	2019-12-25 08:24:12.164544+00	2020-02-16 22:13:51.743378+00	f	1	1	1		0	0	f	\N	\N
77	4		Becky _____ her ankle while she was playing tennis last week. Now it still hurts badly.	1	0	0	2019-12-25 08:25:01.108884+00	2021-10-12 15:23:11.038445+00	f	1	1	1		0	1	f	\N	\N
78	4		Research shows that men and women usually think differently. For example, they have quite different\r\n_____ about what marriage means in their life.	1	3	0	2019-12-25 08:26:18.111187+00	2021-10-26 14:15:58.29214+00	f	1	1	1		0	2	f	\N	\N
79	4	\N	The new manager is very _____. For instance, the employees are given much shorter deadlines for the\r\nsame tasks than before.	1	2	0	2019-12-25 08:27:04.893096+00	2020-01-05 21:24:59.092478+00	f	1	1	1		0	0	f	\N	\N
80	4		While the couple were looking _____ for their missing children, the kids were actually having fun in\r\nthe woods nearby.	1	5	100	2019-12-25 08:28:00.176428+00	2021-10-26 14:15:58.225414+00	f	1	1	1		2	2	f	\N	\N
81	4		After delivering a very powerful speech, the award winner was _____ by a group of fans asking for her signature.	1	2	0	2019-12-25 08:29:05.623123+00	2021-11-04 10:54:27.319913+00	f	1	1	1		0	1	f	\N	\N
82	4		The interviewees were trying very hard to _____ the interviewers that they were very capable and\r\nshould be given the job.	1	2	0	2019-12-25 08:30:01.7844+00	2021-11-04 10:54:27.300379+00	f	1	1	1		0	1	f	\N	\N
83	4		After the first snow of the year, the entire grassland disappeared under a _____ of snow.\r\n	1	2	0	2019-12-25 08:31:04.892996+00	2020-12-15 16:19:32.010739+00	f	1	1	1		0	7	f	\N	\N
84	4	\N	Peter likes books with wide _____, which provide him with enough space to write notes.	1	2	0	2019-12-25 08:31:57.216138+00	2020-02-24 11:14:44.89488+00	f	1	1	1		0	0	f	\N	\N
85	4		At the beginning of the semester, the teacher told the students that late assignments would receive a low grade as a _____.	1	4	0	2019-12-25 08:32:54.928532+00	2021-10-26 14:15:58.11397+00	f	1	1	1		0	2	f	\N	\N
86	4	\N	Various studies have been _____ in this hospital to explore the link between a high-fat diet and cancer.	1	3	0	2019-12-25 08:33:54.946537+00	2020-02-16 22:13:51.707041+00	f	1	1	1		0	0	f	\N	\N
87	4		Intense, fast-moving fires raged across much of California last week. The _____ firestorm has claimed the lives of thirty people.	1	4	0	2019-12-25 08:35:05.531916+00	2021-10-26 14:15:58.256263+00	f	1	1	1		0	9	f	\N	\N
88	4		John’s clock is not functioning _____. The alarm rings even when it’s not set to go off.	1	4	0	2019-12-25 23:49:18.117495+00	2021-10-12 15:23:11.028026+00	f	1	1	1		0	1	f	\N	\N
89	4	\N	Michael has decided to _____ a career in physics and has set his mind on becoming a professor.	1	2	0	2019-12-25 23:50:17.718596+00	2020-01-05 00:04:41.062973+00	f	1	1	1		0	0	f	\N	\N
90	4		Peter plans to hike in a _____ part of Africa, where he might not meet another human being for days.	1	1	0	2019-12-25 23:51:05.015013+00	2021-10-12 15:23:11.044897+00	f	1	1	1		0	1	f	\N	\N
91	4	\N	People in this community tend to _____ with the group they belong to, and often put group interests\r\nbefore personal ones.	1	2	0	2019-12-25 23:51:50.14478+00	2020-03-16 02:38:05.222633+00	f	1	1	1		0	0	f	\N	\N
92	4	\N	I mistook the man for a well-known actor and asked for his autograph; it was really _____.	1	2	0	2019-12-25 23:52:38.895877+00	2020-01-04 23:49:20.856671+00	f	1	1	1		0	0	f	\N	\N
93	4		After spending most of her salary on rent and food, Amelia _____ had any money left for\r\nentertainment and other expenses.	1	6	85	2019-12-25 23:53:25.278731+00	2020-12-15 16:19:32.027404+00	f	1	1	1		6	7	f	\N	\N
94	4	\N	In the Bermuda Triangle, a region in the western part of the North Atlantic Ocean, some airplanes and ships were reported to have mysteriously disappeared without a _____.	1	0	0	2019-12-25 23:54:19.531493+00	2020-02-16 22:31:39.454291+00	f	1	1	1		0	0	f	\N	\N
95	4	\N	Shouting greetings and waving a big sign, Tony _____ the passing shoppers to visit his shop and buy\r\nthe freshly baked bread.	1	2	0	2019-12-25 23:55:00.695972+00	2020-02-16 22:13:51.70117+00	f	1	1	1		0	0	f	\N	\N
96	4	\N	With a continuous 3 km stretch of golden sand, the beach attracts artists around the world each\r\nsummer to create amazing _____ with its fine soft sand.\r\n	1	1	0	2019-12-25 23:55:58.30843+00	2020-02-24 11:14:44.892568+00	f	1	1	1		0	0	f	\N	\N
97	4	\N	The clouds parted and a _____ of light fell on the church, through the windows, and onto the floor.	1	2	0	2019-12-25 23:56:54.583673+00	2020-03-16 02:38:05.239438+00	f	1	1	1		0	0	f	\N	\N
98	4	\N	. Instead of a gift, Tim’s grandmother always _____ some money in the birthday card she gave him.	1	1	0	2019-12-25 23:57:42.61218+00	2020-03-16 02:38:05.224701+00	f	1	1	1		0	0	f	\N	\N
99	4	\N	While winning a gold _____ is what every Olympic athlete dreams of, it becomes meaningless if it is\r\nachieved by cheating.	1	0	0	2019-12-25 23:58:36.839143+00	2020-01-04 21:29:45.164267+00	f	1	1	1		0	0	f	\N	\N
100	4		The thief went into the apartment building and stole some jewelry. He then _____ himself as a\r\nsecurity guard and walked out the front gate.	1	3	0	2019-12-25 23:59:21.652007+00	2021-10-26 14:15:58.143322+00	f	1	1	1		0	2	f	\N	\N
101	4	\N	Due to numerous accidents that occurred while people were playing Pokémon GO, players were\r\nadvised to be _____ of possible dangers in the environment.	1	0	0	2019-12-26 00:00:17.186295+00	2019-12-29 08:02:40.199485+00	f	1	1	1		0	0	f	\N	\N
102	4	\N	Sherlock Holmes, a detective in a popular fiction series, has impressed readers with his amazing\r\npowers of _____ and his knowledge of trivial facts.	1	0	0	2019-12-26 00:01:02.927972+00	2020-02-16 22:29:44.674138+00	f	1	1	1		0	0	f	\N	\N
103	4		Posters of the local rock band were displayed in store windows to promote the sale of their _____ tickets.	1	1	0	2019-12-26 00:02:19.550592+00	2021-10-26 14:15:58.275757+00	f	1	1	1		0	2	f	\N	\N
104	4		Maria didn’t want to deliver the bad news to David about his failing the job interview. She herself was quite _____ about it.	1	4	0	2019-12-26 00:03:11.445915+00	2021-10-12 15:23:11.016256+00	f	1	1	1		0	1	f	\N	\N
105	4	\N	The newcomer speaks with a strong Irish _____; he must be from Ireland.	1	2	0	2019-12-26 00:03:58.41618+00	2020-03-17 00:31:53.04701+00	f	1	1	1		0	0	f	\N	\N
106	4		Although Maggie has been physically _____ to her wheelchair since the car accident, she does not limit herself to indoor activities.	1	2	0	2019-12-26 00:04:53.752826+00	2020-12-15 16:19:31.981437+00	f	1	1	1		0	7	f	\N	\N
107	4		All passengers riding in cars are required to fasten their seatbelts in order to reduce the risk of _____ in case of an accident.	1	1	85	2019-12-26 00:05:52.019692+00	2020-12-15 16:19:32.075687+00	f	1	1	1		6	7	f	\N	\N
108	4	\N	The principal of this school is a man of exceptional _____. He sets aside a part of his salary for a\r\nscholarship fund for children from needy families.	1	0	0	2019-12-26 00:15:53.20541+00	2019-12-31 07:36:05.384021+00	f	1	1	1		0	0	f	\N	\N
109	4		The science teacher always _____ the use of the laboratory equipment before she lets her students use it on their own.	1	2	0	2019-12-26 00:16:45.679511+00	2021-10-26 14:15:58.188061+00	f	1	1	1		0	2	f	\N	\N
110	4		Most of the area is covered by woods, where bird species are so _____ that it is a paradise for\r\nbirdwatchers.	1	3	0	2019-12-26 00:17:32.236214+00	2021-10-26 14:15:58.146039+00	f	1	1	1		0	2	f	\N	\N
111	4		In most cases, the committee members can reach agreement quickly. _____, however, they differ\r\ngreatly in opinion and have a hard time making decisions.\r\n	1	4	0	2019-12-26 00:18:10.994916+00	2021-11-04 10:54:27.308519+00	f	1	1	1		0	2	f	\N	\N
112	4	\N	Many people try to save a lot of money before _____, since having enough money would give them a\r\nsense of security for their future.	1	2	0	2019-12-26 00:18:52.005813+00	2020-02-20 11:31:36.459718+00	f	1	1	1		0	0	f	\N	\N
113	4		In winter, our skin tends to become dry and _____, a problem which is usually treated by applying\r\nlotions or creams.	1	3	11	2019-12-26 00:19:29.820016+00	2021-10-26 14:15:58.24713+00	f	1	1	1		1	9	f	\N	\N
114	4		Benson married Julie soon after he had _____ her heart and gained her parents’ approval.	1	0	57	2019-12-26 00:20:11.296244+00	2020-12-15 16:19:32.05698+00	f	1	1	1		4	7	f	\N	\N
115	4		The recent flood completely _____ my parents’ farm. The farmhouse and fruit trees were all gone and\r\nnothing was left.	1	6	88	2019-12-26 00:20:51.224284+00	2021-10-26 14:15:58.285136+00	f	1	1	1		8	9	f	\N	\N
116	4	\N	The results of this survey are not reliable because the people it questioned were not a typical or _____ sample of the entire population that was studied.	1	1	0	2019-12-26 00:21:34.775035+00	2020-02-16 22:29:44.677404+00	f	1	1	1		0	0	f	\N	\N
117	4	\N	In line with the worldwide green movement, carmakers have been working hard to make their new\r\nmodels more _____ friendly to reduce pollution.	1	1	0	2019-12-26 00:22:25.904673+00	2020-01-04 21:29:45.178508+00	f	1	1	1		0	0	f	\N	\N
125	1	question_files/question_125.mp3	\N	1	2	0	2019-12-26 03:09:41.553574+00	2021-11-04 21:09:17.048594+00	f	1	1	1		0	4	f	\N	\N
126	1	question_files/question_126.mp3	\N	1	3	0	2019-12-26 03:22:19.579554+00	2021-10-12 15:21:28.724354+00	f	1	1	1		0	1	f	\N	\N
127	1	question_files/question_127.mp3	\N	1	3	0	2019-12-26 03:27:43.982979+00	2020-12-11 10:53:28.750899+00	f	1	1	1		0	1	f	\N	\N
128	1	question_files/question_128.mp3	\N	1	3	0	2019-12-26 03:30:18.122344+00	2021-10-26 14:15:58.135964+00	f	1	1	1		0	3	f	\N	\N
129	1	question_files/question_129.mp3	\N	1	5	0	2019-12-26 03:33:19.089663+00	2020-04-05 22:44:21.4572+00	f	1	1	1		0	0	f	\N	\N
130	1	question_files/question_130.mp3	\N	1	4	40	2019-12-26 03:37:09.22928+00	2021-11-04 21:09:17.056743+00	f	1	1	1		2	5	f	\N	\N
131	1	question_files/question_131.mp3	\N	1	1	0	2019-12-26 06:04:50.722261+00	2020-04-05 22:44:21.461611+00	f	1	1	1		0	0	f	\N	\N
132	1	question_files/question_132.mp3	\N	1	0	0	2019-12-26 06:08:58.012976+00	2020-04-05 22:44:21.463488+00	f	1	1	1		0	0	f	\N	\N
133	1	question_files/question_133.mp3	\N	1	4	0	2019-12-26 06:11:53.890894+00	2020-04-05 22:44:21.465715+00	f	1	1	1		0	0	f	\N	\N
134	1	question_files/question_134.mp3	\N	1	3	60	2019-12-26 06:17:00.972463+00	2021-11-04 21:09:17.062449+00	f	1	1	1		3	5	f	\N	\N
135	1	question_files/question_135.mp3	\N	1	1	0	2019-12-26 06:20:19.431249+00	2020-04-05 22:44:21.470644+00	f	1	1	1		0	0	f	\N	\N
136	1	question_files/question_136.mp3	\N	1	0	0	2019-12-26 06:23:48.337419+00	2020-04-05 22:44:21.472969+00	f	1	1	1		0	0	f	\N	\N
137	1	question_files/question_137.mp3	\N	1	4	0	2019-12-26 06:26:58.197782+00	2020-04-05 22:44:21.475687+00	f	1	1	1		0	0	f	\N	\N
138	1	question_files/question_138.mp3	\N	1	0	0	2019-12-26 06:32:30.462517+00	2020-04-05 22:44:21.478066+00	f	2	1	1	聽不太懂	0	0	f	\N	\N
139	1	question_files/question_139.mp3	\N	1	4	100	2019-12-26 06:35:12.781862+00	2021-10-26 14:15:58.167708+00	f	1	1	1		2	2	f	\N	\N
140	1	question_files/question_140.mp3	\N	1	4	0	2019-12-26 06:39:23.96752+00	2020-04-05 22:44:21.483043+00	f	1	1	1		0	0	f	\N	\N
141	1	question_files/question_141.mp3	\N	1	4	60	2019-12-26 06:42:31.268421+00	2021-11-04 21:09:17.076901+00	f	1	1	1		3	5	f	\N	\N
142	1	question_files/question_142.mp3	\N	1	3	0	2019-12-26 06:46:30.796314+00	2021-10-26 14:15:58.321832+00	f	1	1	1		0	3	f	\N	\N
143	1	question_files/question_143.mp3	\N	1	5	0	2019-12-26 06:49:39.177467+00	2021-10-26 14:15:58.236378+00	f	1	1	1		0	2	f	\N	\N
144	1	question_files/question_144.mp3	\N	1	3	0	2019-12-26 06:54:08.787461+00	2020-04-05 22:44:21.492659+00	f	1	1	1		0	0	f	\N	\N
145	1	question_files/question_145.mp3	\N	1	2	0	2019-12-26 07:07:02.339676+00	2021-10-12 15:21:28.701185+00	f	1	1	1		0	1	f	\N	\N
146	1	question_files/question_146.mp3	\N	1	1	100	2019-12-26 07:13:59.679023+00	2021-03-13 16:31:34.977138+00	f	1	1	1		1	1	f	\N	\N
147	1	question_files/question_147.mp3	\N	1	2	0	2019-12-26 07:17:00.663406+00	2020-04-05 22:44:21.500152+00	f	1	1	1		0	0	f	\N	\N
148	1	question_files/question_148.mp3	\N	1	4	40	2019-12-26 07:23:00.51424+00	2021-11-04 21:09:17.101106+00	f	1	1	1		2	5	f	\N	\N
149	1	question_files/question_149.mp3	\N	1	4	0	2019-12-26 07:26:47.400984+00	2020-04-05 22:44:21.504367+00	f	1	1	1		0	0	f	\N	\N
150	1	question_files/question_150.mp3	\N	1	3	0	2019-12-26 07:41:56.109196+00	2021-11-04 21:09:17.069365+00	f	1	1	1	雖然可以選出答案，但是音檔缺少問句的部分	0	4	f	\N	\N
151	1	question_files/question_151.mp3	\N	1	2	0	2019-12-26 07:45:42.139566+00	2020-04-05 22:44:21.509297+00	f	1	1	1		0	0	f	\N	\N
152	1	question_files/question_152.mp3	\N	1	1	0	2019-12-26 07:50:29.39545+00	2020-04-05 22:44:21.51195+00	f	1	1	1		0	0	f	\N	\N
153	1	question_files/question_153.mp3	\N	1	3	0	2019-12-26 07:53:08.891499+00	2021-03-13 16:31:34.970036+00	f	1	1	1		0	1	f	\N	\N
154	1	question_files/question_154.mp3	\N	1	4	100	2019-12-26 07:58:00.692136+00	2021-10-26 14:15:58.30353+00	f	1	1	1		3	3	f	\N	\N
155	1	question_files/question_155.mp3	\N	1	2	25	2019-12-31 00:46:56.236122+00	2021-10-26 14:15:58.132582+00	f	1	1	1		1	4	f	\N	\N
156	1	question_files/question_156.mp3	\N	1	3	0	2019-12-31 00:54:23.53323+00	2020-04-05 22:44:21.52181+00	f	1	1	1		0	0	f	\N	\N
157	1	question_files/question_157.mp3	\N	1	1	0	2019-12-31 00:55:37.802431+00	2021-03-13 16:31:34.973674+00	f	1	1	1		0	1	f	\N	\N
158	1	question_files/question_158.mp3	\N	1	1	0	2019-12-31 00:57:01.360611+00	2020-04-05 22:44:21.526313+00	f	1	1	1		0	0	f	\N	\N
159	1	question_files/question_159.mp3	\N	1	5	100	2019-12-31 00:58:11.312295+00	2021-10-26 14:15:58.190086+00	f	1	1	1		2	2	f	\N	\N
160	1	question_files/question_160.mp3	\N	1	4	0	2019-12-31 01:00:01.545383+00	2020-04-05 22:44:21.530881+00	f	1	1	1		0	0	f	\N	\N
161	1	question_files/question_161.mp3	\N	1	0	0	2019-12-31 01:01:05.176691+00	2020-04-05 22:44:21.533629+00	f	2	1	1	聽不太懂	0	0	f	\N	\N
162	1	question_files/question_162.mp3	\N	1	3	0	2019-12-31 01:02:07.772268+00	2020-04-05 22:44:21.536137+00	f	1	1	1		0	0	f	\N	\N
163	1	question_files/question_163.mp3	\N	1	3	0	2019-12-31 01:03:17.137776+00	2020-04-05 22:44:21.538835+00	f	1	1	1		0	0	f	\N	\N
164	1	question_files/question_164.mp3	\N	1	1	0	2019-12-31 01:04:38.150599+00	2021-10-26 14:15:58.251537+00	f	1	1	1		0	2	f	\N	\N
165	1	question_files/question_165.mp3	\N	1	5	0	2019-12-31 01:06:13.342088+00	2021-10-26 14:15:58.129518+00	f	1	1	1		0	2	f	\N	\N
166	1	question_files/question_166.mp3	\N	1	4	100	2019-12-31 01:08:24.370943+00	2021-10-26 14:15:58.154781+00	f	1	1	1		2	2	f	\N	\N
167	1	question_files/question_167.mp3	\N	1	4	100	2019-12-31 01:10:05.525811+00	2021-10-26 14:15:58.310241+00	f	1	1	1		2	2	f	\N	\N
168	1	question_files/question_168.mp3	\N	1	0	0	2019-12-31 01:11:33.647824+00	2020-04-05 22:44:21.550803+00	f	2	1	1	重複了	0	0	f	\N	\N
169	1	question_files/question_169.mp3	\N	1	0	0	2019-12-31 01:15:53.74734+00	2020-04-05 22:44:21.552984+00	f	2	1	1	重複了	0	0	f	\N	\N
171	1	question_files/question_171.mp3	\N	1	3	100	2019-12-31 01:19:06.620106+00	2021-10-26 14:15:58.348866+00	f	1	1	1		2	2	f	\N	\N
172	1	question_files/question_172.mp3	\N	1	2	0	2019-12-31 01:20:07.903854+00	2021-10-26 14:15:58.326142+00	f	1	1	1		0	2	f	\N	\N
173	1	question_files/question_173.mp3	\N	1	0	0	2019-12-31 01:21:08.906488+00	2020-04-05 22:44:21.561172+00	f	1	1	1		0	0	f	\N	\N
174	1	question_files/question_174.mp3	\N	1	0	0	2019-12-31 01:22:37.554419+00	2021-10-16 14:40:31.435572+00	f	3	1	1	重複	0	0	f	\N	\N
175	2	question_files/question_175.mp3	\N	1	5	0	2019-12-31 01:25:08.452279+00	2021-11-04 23:26:34.03925+00	f	1	1	1		0	3	f	\N	\N
176	2	question_files/question_176.mp3	\N	1	7	0	2019-12-31 01:35:26.171595+00	2021-10-26 14:15:58.249336+00	f	1	1	1		0	2	f	\N	\N
177	2	question_files/question_177.mp3	\N	1	7	0	2019-12-31 01:36:23.550289+00	2021-11-04 23:26:34.045139+00	f	1	1	1		0	3	f	\N	\N
178	2	question_files/question_178.mp3	\N	1	7	100	2019-12-31 03:09:49.996004+00	2021-10-26 14:15:58.181168+00	f	1	1	1		2	2	f	\N	\N
179	2	question_files/question_179.mp3	\N	1	6	0	2019-12-31 03:22:18.400906+00	2021-10-26 14:15:58.263031+00	f	1	1	1		0	2	f	\N	\N
180	2	question_files/question_180.mp3	\N	1	7	0	2019-12-31 03:36:34.520015+00	2021-10-26 14:15:58.264756+00	f	1	1	1		0	2	f	\N	\N
181	2	question_files/question_181.mp3	\N	1	7	100	2019-12-31 03:37:49.760395+00	2021-10-26 14:15:58.298763+00	f	1	1	1		2	2	f	\N	\N
182	2	question_files/question_182.mp3	\N	1	8	0	2019-12-31 03:40:20.103403+00	2021-10-26 14:15:58.214098+00	f	1	1	1		0	2	f	\N	\N
183	2	question_files/question_183.mp3	\N	1	7	0	2019-12-31 03:41:32.399519+00	2021-10-26 14:15:58.312018+00	f	1	1	1		0	2	f	\N	\N
184	2	question_files/question_184.mp3	\N	1	7	0	2019-12-31 03:43:09.988883+00	2021-11-04 23:26:34.034193+00	f	1	1	1		0	3	f	\N	\N
186	1	question_files/question_186.mp3	\N	1	6	0	2020-01-01 16:02:50.237482+00	2020-04-05 22:44:21.586503+00	f	1	1	1		0	0	f	\N	\N
187	1	question_files/question_187.mp3	\N	1	1	100	2020-01-01 16:05:52.08096+00	2020-12-11 10:53:28.744058+00	f	1	1	1		1	1	f	\N	\N
188	1	question_files/question_188.mp3	\N	1	1	0	2020-01-01 16:07:35.962083+00	2020-04-05 22:44:21.590337+00	f	1	1	1		0	0	f	\N	\N
189	1	question_files/question_189.mp3	\N	1	1	0	2020-01-01 16:10:14.396142+00	2021-10-26 14:15:58.341486+00	f	1	1	1		0	2	f	\N	\N
190	1	question_files/question_190.mp3	\N	1	4	0	2020-01-01 16:11:52.28024+00	2021-10-26 14:15:58.328202+00	f	1	1	1		0	2	f	\N	\N
191	1	question_files/question_191.mp3	\N	1	4	0	2020-01-01 16:13:13.976888+00	2020-04-05 22:44:21.597966+00	f	1	1	1		0	0	f	\N	\N
192	1	question_files/question_192.mp3	\N	1	2	0	2020-01-01 16:15:31.756286+00	2021-10-26 14:15:58.332164+00	f	1	1	1		0	3	f	\N	\N
193	1	question_files/question_193.mp3	\N	1	2	100	2020-01-01 16:16:28.205044+00	2021-10-26 14:15:58.330194+00	f	1	1	1		2	2	f	\N	\N
194	1	question_files/question_194.mp3	\N	1	2	0	2020-01-01 16:17:21.729672+00	2021-10-26 14:15:58.239328+00	f	1	1	1		0	2	f	\N	\N
195	1	question_files/question_195.mp3	\N	1	5	0	2020-01-01 16:19:14.579817+00	2020-04-05 22:44:21.60804+00	f	1	1	1		0	0	f	\N	\N
196	1	question_files/question_196.mp3	\N	1	2	60	2020-01-01 16:20:05.224447+00	2021-11-04 21:09:17.105946+00	f	1	1	1		3	5	f	\N	\N
197	1	question_files/question_197.mp3	\N	1	1	0	2020-01-01 16:22:03.61329+00	2020-04-05 22:44:21.612189+00	f	1	1	1		0	0	f	\N	\N
198	1	question_files/question_198.mp3	\N	1	7	0	2020-01-01 16:23:41.872538+00	2020-04-05 22:44:21.614547+00	f	1	1	1		0	0	f	\N	\N
199	1	question_files/question_199.mp3	\N	1	1	0	2020-01-01 16:24:42.730861+00	2020-04-05 22:44:21.616861+00	f	1	1	1		0	0	f	\N	\N
200	1	question_files/question_200.mp3	\N	1	5	0	2020-01-01 16:25:42.844632+00	2020-04-05 22:44:21.619371+00	f	1	1	1		0	0	f	\N	\N
201	1	question_files/question_201.mp3	\N	1	3	0	2020-01-01 23:47:09.94077+00	2021-10-26 14:15:58.14123+00	f	1	1	1		0	2	f	\N	\N
202	1	question_files/question_202.mp3	\N	1	3	0	2020-01-01 23:48:31.777422+00	2021-10-26 14:15:58.108701+00	f	1	1	1		0	2	f	\N	\N
203	1	question_files/question_203.mp3	\N	1	4	0	2020-01-01 23:49:40.747913+00	2021-10-26 14:15:58.282709+00	f	1	1	1		0	2	f	\N	\N
204	1	question_files/question_204.mp3	\N	1	2	40	2020-01-01 23:51:07.607177+00	2021-11-04 21:09:17.095418+00	f	1	1	1		2	5	f	\N	\N
205	1	question_files/question_205.mp3	\N	1	1	0	2020-01-02 00:12:15.013826+00	2020-04-05 22:44:21.632777+00	f	1	1	1		0	0	f	\N	\N
206	1	question_files/question_206.mp3	\N	1	1	0	2020-01-02 00:15:34.706242+00	2021-10-12 15:21:28.722623+00	f	1	1	1		0	1	f	\N	\N
207	1	question_files/question_207.mp3	\N	1	3	0	2020-01-02 00:16:36.994048+00	2020-04-05 22:44:21.637846+00	f	1	1	1		0	0	f	\N	\N
208	1	question_files/question_208.mp3	\N	1	6	0	2020-01-02 00:18:15.199358+00	2021-10-12 15:21:28.713549+00	f	1	1	1		0	1	f	\N	\N
209	1	question_files/question_209.mp3	\N	1	3	0	2020-01-02 00:19:25.499366+00	2021-10-26 14:15:58.185103+00	f	1	1	1		0	2	f	\N	\N
210	1	question_files/question_210.mp3	\N	1	3	0	2020-01-02 03:13:02.89184+00	2021-10-26 14:15:58.191881+00	f	1	1	1		0	2	f	\N	\N
211	1	question_files/question_211.mp3	\N	1	4	0	2020-01-02 03:16:06.20391+00	2021-10-26 14:15:58.20275+00	f	1	1	1		0	2	f	\N	\N
212	1	question_files/question_212.mp3	\N	1	1	0	2020-01-02 03:18:03.862115+00	2020-04-05 22:44:21.648226+00	f	1	1	1		0	0	f	\N	\N
213	1	question_files/question_213.mp3	\N	1	5	0	2020-01-02 03:20:28.900512+00	2021-10-26 14:15:58.106618+00	f	1	1	1		0	2	f	\N	\N
214	1	question_files/question_214.mp3	\N	1	0	0	2020-01-02 03:22:59.682877+00	2021-03-13 16:31:34.966219+00	f	1	1	1		0	1	f	\N	\N
215	1	question_files/question_215.mp3	\N	1	1	0	2020-01-02 03:25:33.637488+00	2020-04-05 22:44:21.655825+00	f	1	1	1		0	0	f	\N	\N
216	1	question_files/question_216.mp3	\N	1	0	0	2020-01-02 03:27:29.396692+00	2020-04-05 22:44:21.657983+00	f	3	1	\N		0	0	f	\N	\N
217	1	question_files/question_217.mp3	\N	1	2	0	2020-01-02 03:29:05.277246+00	2020-04-05 22:44:21.659845+00	f	1	1	1		0	0	f	\N	\N
218	1	question_files/question_218.mp3	\N	1	3	100	2020-01-02 03:30:11.193289+00	2021-10-26 14:15:58.2894+00	f	1	1	1		2	2	f	\N	\N
219	1	question_files/question_219.mp3	\N	1	3	100	2020-01-02 03:31:42.891768+00	2021-10-12 15:21:28.719415+00	f	1	1	1		1	1	f	\N	\N
220	1	question_files/question_220.mp3	\N	1	2	0	2020-01-02 03:35:04.615173+00	2020-04-05 22:44:21.665895+00	f	1	1	1		0	0	f	\N	\N
221	1	question_files/question_221.mp3	\N	1	0	0	2020-01-02 03:43:08.392012+00	2020-04-05 22:44:21.668743+00	f	3	1	\N		0	0	f	\N	\N
222	1	question_files/question_222.mp3	\N	1	2	0	2020-01-02 14:32:19.2121+00	2020-04-05 22:44:21.671503+00	f	1	1	1		0	0	f	\N	\N
223	1	question_files/question_223.mp3	\N	1	0	0	2020-01-02 14:34:10.631745+00	2020-04-05 22:44:21.673358+00	f	3	1	\N		0	0	f	\N	\N
224	1	question_files/question_224.mp3	\N	1	0	0	2020-01-02 14:35:55.005009+00	2020-04-05 22:44:21.675257+00	f	3	1	\N		0	0	f	\N	\N
225	1	question_files/question_225.mp3	\N	1	0	0	2020-01-02 14:37:26.922694+00	2020-04-05 22:44:21.678153+00	f	1	1	1		0	0	f	\N	\N
226	1	question_files/question_226.mp3	\N	1	0	0	2020-01-02 14:39:47.878449+00	2020-04-05 22:44:21.680419+00	f	3	1	\N		0	0	f	\N	\N
227	1	question_files/question_227.mp3	\N	1	0	0	2020-01-02 14:43:14.930114+00	2020-04-05 22:44:21.683214+00	f	3	1	\N		0	0	f	\N	\N
228	1	question_files/question_228.mp3	\N	1	0	0	2020-01-02 14:46:26.02996+00	2020-04-05 22:44:21.685339+00	f	3	1	\N		0	0	f	\N	\N
229	1	question_files/question_229.mp3	\N	1	0	0	2020-01-02 15:18:20.186313+00	2020-04-05 22:44:21.687568+00	f	3	1	\N		0	0	f	\N	\N
230	1	question_files/question_230.mp3	\N	1	0	0	2020-01-02 15:19:26.414794+00	2020-04-05 22:44:21.689705+00	f	3	1	\N		0	0	f	\N	\N
231	1	question_files/question_231.mp3	\N	1	0	0	2020-01-02 15:20:12.842126+00	2020-04-05 22:44:21.691861+00	f	3	1	\N		0	0	f	\N	\N
232	1	question_files/question_232.mp3	\N	1	0	0	2020-01-02 15:21:07.245042+00	2020-04-05 22:44:21.69487+00	f	3	1	\N		0	0	f	\N	\N
233	1	question_files/question_233.mp3	\N	1	0	0	2020-01-02 15:21:45.72604+00	2020-04-05 22:44:21.696924+00	f	3	1	\N		0	0	f	\N	\N
234	1	question_files/question_234.mp3	\N	1	0	0	2020-01-02 15:22:44.45756+00	2020-04-05 22:44:21.698902+00	f	3	1	\N		0	0	f	\N	\N
235	2	question_files/question_235.mp3	\N	1	0	0	2020-01-02 15:23:58.097504+00	2020-04-05 22:44:21.700528+00	f	3	1	\N		0	0	f	\N	\N
236	2	question_files/question_236.mp3	\N	1	4	0	2020-01-02 15:24:37.810894+00	2021-11-04 23:26:34.021732+00	f	1	1	7		0	3	f	\N	\N
237	2	question_files/question_237.mp3	\N	1	0	0	2020-01-02 15:25:48.764638+00	2020-04-05 22:44:21.704986+00	f	3	1	\N		0	0	f	\N	\N
238	2	question_files/question_238.mp3	\N	1	5	0	2020-01-02 15:26:27.47789+00	2021-10-26 14:15:58.223331+00	f	1	1	1		0	2	f	\N	\N
239	2	question_files/question_239.mp3	\N	1	0	0	2020-01-02 15:27:22.08859+00	2020-04-05 22:44:21.709182+00	f	3	1	\N		0	0	f	\N	\N
240	2	question_files/question_240.mp3	\N	1	0	0	2020-01-02 15:28:04.153013+00	2020-04-05 22:44:21.711184+00	f	3	1	\N		0	0	f	\N	\N
241	2	question_files/question_241.mp3	\N	1	0	0	2020-01-02 15:28:41.58409+00	2020-04-05 22:44:21.714673+00	f	3	1	\N		0	0	f	\N	\N
242	2	question_files/question_242.mp3	\N	1	0	0	2020-01-02 15:29:17.535518+00	2020-04-05 22:44:21.716483+00	f	3	1	\N		0	0	f	\N	\N
243	2	question_files/question_243.mp3	\N	1	7	0	2020-01-02 15:29:50.534627+00	2021-10-26 14:15:58.307971+00	f	1	1	1		0	2	f	\N	\N
244	2	question_files/question_244.mp3	\N	1	0	0	2020-01-02 15:30:25.738837+00	2020-04-05 22:44:21.720418+00	f	3	1	\N		0	0	f	\N	\N
245	1	question_files/question_245.mp3	\N	1	0	0	2020-01-02 16:24:50.751925+00	2020-04-05 22:44:21.722047+00	f	3	1	\N		0	0	f	\N	\N
246	1	question_files/question_246.mp3	\N	1	0	0	2020-01-02 16:25:25.555041+00	2020-04-05 22:44:21.72377+00	f	3	1	\N		0	0	f	\N	\N
247	1	question_files/question_247.mp3	\N	1	0	0	2020-01-02 16:26:05.587564+00	2020-04-05 22:44:21.72512+00	f	3	1	\N		0	0	f	\N	\N
248	1	question_files/question_248.mp3	\N	1	0	0	2020-01-02 16:26:43.678631+00	2020-04-05 22:44:21.726928+00	f	3	1	\N		0	0	f	\N	\N
249	1	question_files/question_249.mp3	\N	1	0	0	2020-01-02 16:27:15.779198+00	2020-04-05 22:44:21.728514+00	f	3	1	\N		0	0	f	\N	\N
250	1	question_files/question_250.mp3	\N	1	0	0	2020-01-02 16:27:57.09497+00	2020-04-05 22:44:21.730093+00	f	3	1	\N		0	0	f	\N	\N
251	1	question_files/question_251.mp3	\N	1	0	0	2020-01-02 16:28:31.802595+00	2020-04-05 22:44:21.731615+00	f	3	1	\N		0	0	f	\N	\N
253	1	question_files/question_253.mp3	\N	1	0	0	2020-01-02 16:29:13.338635+00	2020-04-05 22:44:21.733211+00	f	3	1	\N		0	0	f	\N	\N
254	1	question_files/question_254.mp3	\N	1	0	0	2020-01-02 16:34:51.251249+00	2020-04-05 22:44:21.735134+00	f	3	1	\N		0	0	f	\N	\N
255	1	question_files/question_255.mp3	\N	1	0	0	2020-01-02 16:35:21.544493+00	2020-04-05 22:44:21.737066+00	f	3	1	\N		0	0	f	\N	\N
256	1	question_files/question_256.mp3	\N	1	3	0	2020-01-02 16:35:57.793308+00	2021-10-12 15:21:28.715753+00	f	1	1	1		0	1	f	\N	\N
257	1	question_files/question_257.mp3	\N	1	2	0	2020-01-02 16:36:45.200118+00	2020-04-05 22:44:21.740876+00	f	1	1	1		0	0	f	\N	\N
258	1	question_files/question_258.mp3	\N	1	0	0	2020-01-02 16:37:18.785821+00	2020-04-05 22:44:21.742469+00	f	1	1	1		0	0	f	\N	\N
259	1	question_files/question_259.mp3	\N	1	4	0	2020-01-02 16:37:58.174302+00	2020-04-05 22:44:21.744222+00	f	1	1	1		0	0	f	\N	\N
260	1	question_files/question_260.mp3	\N	1	2	0	2020-01-02 16:38:37.076677+00	2020-04-05 22:44:21.746054+00	f	1	1	1		0	0	f	\N	\N
261	1	question_files/question_261.mp3	\N	1	2	100	2020-01-02 16:39:14.654273+00	2021-10-26 14:15:58.277832+00	f	1	1	1		2	2	f	\N	\N
262	1	question_files/question_262.mp3	\N	1	1	0	2020-01-02 16:39:54.846016+00	2020-04-05 22:44:21.749096+00	f	1	1	1		0	0	f	\N	\N
263	1	question_files/question_263.mp3	\N	1	2	0	2020-01-02 16:40:40.790361+00	2021-03-13 16:31:34.99472+00	f	1	1	1		0	1	f	\N	\N
264	1	question_files/question_264.mp3	\N	1	3	0	2020-01-02 16:41:21.84237+00	2020-12-11 10:53:28.740135+00	f	1	1	1		0	1	f	\N	\N
265	1	question_files/question_265.mp3	\N	1	0	0	2020-01-02 16:41:58.145047+00	2020-04-05 22:44:21.755019+00	f	1	1	1		0	0	f	\N	\N
266	1	question_files/question_266.mp3	\N	1	5	100	2020-01-02 16:42:40.402035+00	2021-10-26 14:15:58.244838+00	f	1	1	1		3	3	f	\N	\N
267	1	question_files/question_267.mp3	\N	1	0	0	2020-01-02 16:43:18.001049+00	2020-04-05 22:44:21.758126+00	f	1	1	1		0	0	f	\N	\N
268	1	question_files/question_268.mp3	\N	1	3	0	2020-01-02 16:43:53.009901+00	2020-04-05 22:44:21.759894+00	f	1	1	1		0	0	f	\N	\N
269	1	question_files/question_269.mp3	\N	1	1	0	2020-01-02 16:44:28.553077+00	2020-04-05 22:44:21.761593+00	f	1	1	1		0	0	f	\N	\N
270	1	question_files/question_270.mp3	\N	1	4	0	2020-01-02 16:45:11.022337+00	2020-04-05 22:44:21.763382+00	f	1	1	1		0	0	f	\N	\N
271	1	question_files/question_271.mp3	\N	1	1	0	2020-01-02 16:45:52.218651+00	2020-04-05 22:44:21.764943+00	f	1	1	1		0	0	f	\N	\N
272	1	question_files/question_272.mp3	\N	1	3	0	2020-01-02 16:46:26.843378+00	2020-04-05 22:44:21.766772+00	f	1	1	1		0	0	f	\N	\N
273	1	question_files/question_273.mp3	\N	1	3	0	2020-01-02 16:47:05.13352+00	2020-04-05 22:44:21.768929+00	f	1	1	1		0	0	f	\N	\N
274	1	question_files/question_274.mp3	\N	1	2	100	2020-01-02 16:47:38.56303+00	2020-12-11 10:53:28.736642+00	f	1	1	1		1	1	f	\N	\N
275	1	question_files/question_275.mp3	\N	1	2	0	2020-01-02 16:48:19.844277+00	2020-04-05 22:44:21.772553+00	f	1	1	1		0	0	f	\N	\N
276	1	question_files/question_276.mp3	\N	1	3	0	2020-01-02 16:48:57.950132+00	2020-04-05 22:44:21.774345+00	f	1	1	1		0	0	f	\N	\N
277	1	question_files/question_277.mp3	\N	1	4	0	2020-01-02 16:49:54.338822+00	2021-10-26 14:15:58.104228+00	f	1	1	1		0	2	f	\N	\N
278	1	question_files/question_278.mp3	\N	1	5	0	2020-01-02 16:53:59.92194+00	2020-04-05 22:44:21.778011+00	f	1	1	1		0	0	f	\N	\N
279	1	question_files/question_279.mp3	\N	1	3	0	2020-01-02 16:54:39.007154+00	2021-10-26 14:15:58.138752+00	f	1	1	1		0	2	f	\N	\N
280	1	question_files/question_280.mp3	\N	1	3	0	2020-01-02 16:55:17.770811+00	2021-10-26 14:15:58.2947+00	f	1	1	1		0	2	f	\N	\N
281	1	question_files/question_281.mp3	\N	1	4	0	2020-01-02 16:55:49.089345+00	2020-04-05 22:44:21.783114+00	f	1	1	1		0	0	f	\N	\N
282	1	question_files/question_282.mp3	\N	1	4	33	2020-01-02 16:56:20.370296+00	2021-11-04 21:09:17.090248+00	f	1	1	1		2	6	f	\N	\N
283	1	question_files/question_283.mp3	\N	1	2	0	2020-01-02 16:56:54.991254+00	2020-04-05 22:44:21.787112+00	f	1	1	1		0	0	f	\N	\N
284	1	question_files/question_284.mp3	\N	1	3	100	2020-01-02 16:57:23.739157+00	2021-10-26 14:15:58.229162+00	f	1	1	1		2	2	f	\N	\N
285	1	question_files/question_285.mp3	\N	1	1	0	2020-01-02 16:57:55.602738+00	2020-04-14 11:26:43.677595+00	f	1	1	1		0	0	f	\N	\N
286	1	question_files/question_286.mp3	\N	1	4	0	2020-01-02 16:58:25.652093+00	2020-04-05 22:44:21.79204+00	f	1	1	1		0	0	f	\N	\N
287	1	question_files/question_287.mp3	\N	1	6	0	2020-01-02 16:59:01.474151+00	2020-04-05 22:44:21.793739+00	f	1	1	1		0	0	f	\N	\N
288	1	question_files/question_288.mp3	\N	1	4	0	2020-01-02 16:59:36.062098+00	2021-10-26 14:15:58.305232+00	f	1	1	1		0	2	f	\N	\N
289	1	question_files/question_289.mp3	\N	1	0	20	2020-01-02 17:00:08.406622+00	2021-11-04 21:09:17.083089+00	f	1	1	1		1	5	f	\N	\N
290	1	question_files/question_290.mp3	\N	1	1	0	2020-01-02 17:00:46.717024+00	2021-03-13 16:31:34.961628+00	f	1	1	1		0	1	f	\N	\N
291	1	question_files/question_291.mp3	\N	1	4	0	2020-01-02 17:01:34.535043+00	2020-04-05 22:44:21.80064+00	f	1	1	1		0	0	f	\N	\N
292	1	question_files/question_292.mp3	\N	1	2	0	2020-01-02 17:02:13.898856+00	2020-04-05 22:44:21.802816+00	f	1	1	1		0	0	f	\N	\N
293	1	question_files/question_293.mp3	\N	1	2	0	2020-01-02 17:02:47.13614+00	2020-04-05 22:44:21.804627+00	f	1	1	1		0	0	f	\N	\N
294	1	question_files/question_294.mp3	\N	1	1	0	2020-01-02 17:03:19.33994+00	2021-03-13 16:31:34.980605+00	f	1	1	1		0	1	f	\N	\N
295	1	question_files/question_295.mp3	\N	1	4	0	2020-01-02 17:03:56.039821+00	2020-04-05 22:44:21.808007+00	f	1	1	1		0	0	f	\N	\N
296	2	question_files/question_296.mp3	\N	1	7	0	2020-01-02 17:06:48.471096+00	2021-10-26 14:15:58.161194+00	f	1	1	1		0	2	f	\N	\N
297	2	question_files/question_297.mp3	\N	1	7	0	2020-01-02 17:07:23.639309+00	2021-11-04 23:26:34.042653+00	f	1	1	1		0	3	f	\N	\N
298	2	question_files/question_298.mp3	\N	1	7	0	2020-01-02 17:07:59.474161+00	2021-10-26 14:15:58.111227+00	f	1	1	1		0	2	f	\N	\N
299	2	question_files/question_299.mp3	\N	1	7	0	2020-01-02 17:09:02.910464+00	2021-11-04 23:26:34.046854+00	f	1	1	1		0	3	f	\N	\N
300	2	question_files/question_300.mp3	\N	1	6	100	2020-01-02 17:09:37.001828+00	2021-11-04 23:26:34.04986+00	f	1	1	1		1	1	f	\N	\N
301	2	question_files/question_301.mp3	\N	1	0	0	2020-01-02 17:10:09.957856+00	2020-04-05 22:44:21.820326+00	f	3	1	1	He back aches.選項有問題	0	0	f	\N	\N
302	2	question_files/question_302.mp3	\N	1	7	0	2020-01-02 17:10:43.221566+00	2021-10-26 14:15:58.337358+00	f	1	1	1		0	2	f	\N	\N
303	2	question_files/question_303.mp3	\N	1	7	33	2020-01-02 17:11:27.349246+00	2021-11-04 23:26:34.031188+00	f	1	1	1		1	3	f	\N	\N
304	2	question_files/question_304.mp3	\N	1	7	100	2020-01-02 17:12:00.584808+00	2021-11-04 23:26:34.037211+00	f	1	1	1		3	3	f	\N	\N
305	2	question_files/question_305.mp3	\N	1	6	0	2020-01-02 17:12:35.417227+00	2021-11-04 23:26:34.028156+00	f	1	1	1		0	1	f	\N	\N
339	5		Got a bug bite problem? Many people who are troubled by skin rashes caused by bug bites use\r\n“foggers,” or “bug bombs,” to get rid of the annoying crawlers in their homes. Many people think these bug killers or pesticides will penetrate every place where the insects hide. Actually, quite the opposite is true. Once the pests detect the chemical fog in the room, they’ll hide themselves in walls or other hideaways, where you’ll never be able to treat them effectively.\r\nOhio State University researchers tested three commercially sold foggers in a study on the effect of foggers on bedbugs. After testing these brands on five different groups of live bedbugs for two hours, the scientists saw that the foggers had little—if any—effect on the insects. The researchers said bedbugs hide in cracks and crevices such as under sheets and mattresses, or deep in carpets where foggers won’t reach. Moreover, bugs that do come in contact with the mist may be resistant to the pesticide.\r\nFoggers, or bug bombs, should really be a measure of last resort. First of all, the gases used in bug bombs are highly flammable and thus pose a serious risk of fire or explosion if the product is not used properly. Second, once a bug bomb is used, every surface in your home will be covered with the toxic pesticide. When you use a bug bomb, a chemical mixture rains down on your counters, furniture, floors, and walls, leaving behind oily and toxic substances. Your health might thus be endangered. Therefore, it is suggested that people leave the problem to the professionals.\r\n\r\nWhat is this passage mainly about?	1	9	100	2020-02-20 10:27:20.702517+00	2021-10-26 14:15:58.077661+00	f	1	1	1		2	2	f	\N	\N
340	5		Earworms often take the form of song fragments rather than entire songs, and the song is usually a familiar one. Researchers are not sure why some songs are more likely to get stuck in our heads than others, but everyone has their own tunes. Often those songs have a simple, upbeat melody and catchy, repetitive lyrics, such as popular commercial jingles and slightly annoying radio hits. Recent or repeated exposure to a song or even a small part of a song can also trigger earworms, as can word associations, such as a phrase similar to the lyrics of a song.\r\nWhile earworms might be annoying, most people who experience them nevertheless report that they are pleasant or at least neutral. Only a third of people are disturbed by the song in their heads. How people cope with their earworms seems to depend on how they feel about them. Those who have positive feelings about their stuck songs prefer to just “let them be,” while those with negative feelings turn to more behavioral responses, which include coping strategies such as singing, talking, or even praying.\r\n\r\nAccording to the passage, which of the following is true about an earworm?	1	9	0	2020-02-20 11:03:59.831897+00	2021-10-26 14:15:58.258417+00	f	1	1	1		0	2	f	\N	\N
341	5		Angelfish, often found in the warm seas and coral reefs, are among the most brightly colored fish of\r\nthe ocean. Brilliant colors and stripes form amazing patterns on their body. These patterns actually help the fish to hide from danger among roots and plants. At night, when these fish become inactive, their colors may become pale. Often, the young ones are differently colored than the adults. Some scientists believe that the color difference between the young and the old indicates their different social positions.\r\nAnother interesting fact about angelfish is that they have an occupation in the fish world. Most of them act as cleaners for other fish and pick dead tissue from their bodies. This is not their food, though. Their diet consists mainly of sponge and algae.\r\n\r\nWhat is the job of an angelfish in the sea?	1	9	100	2020-02-20 11:27:34.292146+00	2021-10-26 14:15:58.172214+00	f	1	1	1		2	2	f	\N	\N
377	1	question_files/question_377.mp3	\N	1	0	0	2020-03-30 10:48:48.680798+00	2020-03-30 10:49:10.431317+00	f	3	6	\N		0	0	f	\N	\N
378	1	question_files/question_378.mp3	\N	1	0	0	2020-03-30 10:49:48.323913+00	2020-03-30 10:50:17.413006+00	f	3	6	\N		0	0	f	\N	\N
379	1	question_files/question_379.mp3	\N	1	0	0	2020-03-30 10:50:53.55973+00	2020-03-30 10:51:12.086651+00	f	3	6	\N		0	0	f	\N	\N
380	1	question_files/question_380.mp3	\N	1	0	0	2020-03-30 10:53:31.728789+00	2020-03-30 10:53:43.654725+00	f	3	6	\N		0	0	f	\N	\N
342	5	\N	Redwood trees are the tallest plants on the earth, reaching heights of up to 100 meters. They are also known for their longevity, typically 500 to 1000 years, but sometimes more than 2000 years. A hundred million years ago, in the age of dinosaurs, redwoods were common in the forests of a much more moist and tropical North America. As the climate became drier and colder, they retreated to a narrow strip along the Pacific coast of Northern California.\r\nThe trunk of redwood trees is very stout and usually forms a single straight column. It is covered with a beautiful soft, spongy bark. This bark can be pretty thick, well over two feet in the more mature trees. It gives the older trees a certain kind of protection from insects, but the main benefit is that it keeps the center of the tree intact from moderate forest fires because of its thickness. This fire resistant quality explains why the giant redwood grows to live that long. While most other types of trees are destroyed by forest fires, the giant redwood actually prospers because of them. Moderate fires will clear the ground of competing plant life, and the rising heat dries and opens the ripe cones of the redwood, releasing many thousands of seeds onto the ground below.\r\nNew trees are often produced from sprouts, little baby trees, which form at the base of the trunk. These sprouts grow slowly, nourished by the root system of the “mother” tree. When the main tree dies, the sprouts are then free to grow as full trees, forming a “fairy ring” of trees around the initial tree. These trees, in turn, may give rise to more sprouts, and the cycle continues.\r\n\r\nWhy were redwood trees more prominent in the forests of North America millions of years ago?	1	5	0	2020-02-29 15:34:53.444568+00	2020-02-29 17:45:13.52172+00	f	1	1	5		0	0	f	\N	\N
343	5		It was something she had dreamed of since she was five. Finally, after years of training and intensive workouts, Deborah Duffey was going to compete in her first high school basketball game. The goals of becoming an outstanding player and playing college ball were never far from Deborah’s mind.\r\nThe game was against Mills High School. With 1:42 minutes left in the game, Deborah’s team led by one point. A player of Mills had possession of the ball, and Deborah ran to guard against her. As Deborah shuffled sideways to block the player, her knee went out and she collapsed on the court in burning pain. Just like that, Deborah’s season was over.\r\nAfter suffering the bad injury, Deborah found that, for the first time in her life, she was in a situation beyond her control. Game after game, she could do nothing but sit on the sidelines watching others play the game that she loved so much.\r\nInjuries limited Deborah’s time on the court as she hurt her knees three more times in the next five years. She had to spend countless hours in a physical therapy clinic to receive treatment. Her frequent visits there gave her a passion and respect for the profession. And Deborah began to see a new light in her life.\r\nCurrently a senior in college, Deborah focuses on pursuing a degree in physical therapy. After she graduates, Deborah plans to use her knowledge to educate people how to best take care of their bodies\r\nand cope with the feelings of hopelessness that she remembers so well.\r\n\r\nWhat is the best title for this passage?	1	8	0	2020-02-29 15:39:29.093587+00	2021-10-26 14:15:58.231225+00	f	1	1	5		0	2	f	\N	\N
344	5		It is easy for us to tell our friends from our enemies. But can other animals do the same? Elephants\r\ncan! They can use their sense of vision and smell to tell the difference between people who pose a threat and those who do not.\r\nIn Kenya, researchers found that elephants react differently to clothing worn by men of the Maasai and Kamba ethnic groups. Young Maasai men spear animals and thus pose a threat to elephants; Kamba men are mainly farmers and are not a danger to elephants.\r\nIn an experiment conducted by animal scientists, elephants were first presented with clean clothing or clothing that had been worn for five days by either a Maasai or a Kamba man. When the elephants detected the smell of clothing worn by a Maasai man, they moved away from the smell faster and took longer to relax than when they detected the smells of either clothing worn by Kamba men or clothing that had not been worn at all.\r\nGarment color also plays a role, though in a different way. In the same study, when the elephants saw red clothing not worn before, they reacted angrily, as red is typically worn by Maasai men. Rather than running away as they did with the smell, the elephants acted aggressively toward the red clothing.\r\nThe researchers believe that the elephants’ emotional reactions are due to their different interpretations of the smells and the sights. Smelling a potential danger means that a threat is nearby and the best thing to do is run away and hide. Seeing a potential threat without its smell means that risk is low. Therefore, instead of showing fear and running away, the elephants express their anger and become aggressive.\r\n\r\nAccording to the passage, which of the following statements is true about Kamba and Maasai people?	1	7	100	2020-02-29 15:48:45.946223+00	2021-10-26 14:15:58.193756+00	f	1	1	5		2	2	f	\N	\N
345	5		There is a long-held belief that when meeting someone, the more eye contact we have with the\r\nperson, the better. The result is an unfortunate tendency for people making initial contact—in a job interview, for example—to stare fixedly at the other individual. However, this behavior is likely to make the interviewer feel very uncomfortable. Most of us are comfortable with eye contact lasting a few seconds. But eye contact which persists longer than that can make us nervous.\r\nAnother widely accepted belief is that powerful people in a society—often men—show their dominance over others by touching them in a variety of ways. In fact, research shows that in almost all cases, lower-status people initiate touch. Women also initiate touch more often than men do.\r\nThe belief that rapid speech and lying go together is also widespread and enduring. We react strongly—and suspiciously—to fast talk. However, the opposite is a greater cause for suspicion. Speech that is slow, because it is laced with pauses or errors, is a more reliable indicator of lying than the opposite.\r\n\r\nWhich of the following is NOT discussed in the passage?	1	8	100	2020-02-29 15:55:36.145688+00	2021-10-26 14:15:58.241146+00	f	1	1	5		2	2	f	\N	\N
381	1	question_files/question_381.mp3	\N	1	0	0	2020-03-30 10:54:58.58477+00	2020-03-30 10:55:38.955062+00	f	3	6	\N		0	0	f	\N	\N
382	1	question_files/question_382.mp3	\N	1	0	0	2020-03-30 11:05:40.125707+00	2020-03-30 11:05:53.119697+00	f	3	6	\N		0	0	f	\N	\N
383	1	question_files/question_383.mp3	\N	1	0	0	2020-03-30 11:10:37.977102+00	2020-03-30 11:11:09.894887+00	f	3	6	\N		0	0	f	\N	\N
384	1	question_files/question_384.mp3	\N	1	0	0	2020-03-30 11:11:44.874687+00	2020-03-30 11:11:57.690972+00	f	3	6	\N		0	0	f	\N	\N
385	1	question_files/question_385.mp3	\N	1	0	0	2020-03-30 11:12:36.039738+00	2020-03-30 11:12:53.238834+00	f	3	6	\N		0	0	f	\N	\N
386	1	question_files/question_386.mp3	\N	1	0	0	2020-03-30 11:13:32.135991+00	2020-03-30 11:13:46.722863+00	f	3	6	\N		0	0	f	\N	\N
387	1	question_files/question_387.mp3	\N	1	0	0	2020-03-30 11:14:20.944127+00	2020-03-30 11:14:34.927984+00	f	3	6	\N		0	0	f	\N	\N
388	1	question_files/question_388.mp3	\N	1	0	0	2020-03-30 11:15:20.165403+00	2020-03-30 11:15:36.639465+00	f	3	6	\N		0	0	f	\N	\N
389	1	question_files/question_389.mp3	\N	1	0	0	2020-03-30 11:16:17.464051+00	2020-03-30 11:16:31.207444+00	f	3	6	\N		0	0	f	\N	\N
390	1	question_files/question_390.mp3	\N	1	0	0	2020-03-30 11:18:05.64631+00	2020-03-30 11:18:40.037558+00	f	3	6	\N		0	0	f	\N	\N
391	1	question_files/question_391.mp3	\N	1	0	0	2020-03-30 11:19:20.431982+00	2020-03-30 11:19:33.862901+00	f	3	6	\N		0	0	f	\N	\N
346	5		On the island of New Zealand, there is a grasshopper-like species of insect that is found nowhere else on earth. New Zealanders have given it the nickname weta, which is a native Maori word meaning “god of bad looks.” It’s easy to see why anyone would call this insect a bad-looking bug. Most people feel disgusted at the sight of these bulky, slow-moving creatures.\r\nWetas are nocturnal creatures; they come out of their caves and holes only after dark. A giant weta can grow to over three inches long and weigh as much as 1.5 ounces. Giant wetas can hop up to two feet at a time. Some of them live in trees, and others live in caves. They are very long-lived for insects, and some adult wetas can live as long as two years. Just like their cousins grasshoppers and crickets, wetas are able to “sing” by rubbing their leg parts together, or against their lower bodies.\r\nMost people probably don’t feel sympathy for these endangered creatures, but they do need protecting. The slow and clumsy wetas have been around on the island since the times of the dinosaurs, and have evolved and survived in an environment where they had no enemies until rats came to the island with European immigrants. Since rats love to hunt and eat wetas, the rat population on the island has grown into a real problem for many of the native species that are unaccustomed to its presence, and poses a serious threat to the native weta population.\r\n\r\nWhich of the following descriptions of wetas is accurate?	1	7	0	2020-02-29 16:42:12.673107+00	2021-10-26 14:15:58.270028+00	f	1	1	5		0	2	f	\N	\N
347	5		The high school prom is the first formal social event for most American teenagers. It has also been a\r\nrite of passage for young Americans for nearly a century.\r\nThe word “prom” was first used in the 1890s, referring to formal dances in which the guests of a\r\nparty would display their fashions and dancing skills during the evening’s grand march. In the United States, parents and educators have come to regard the prom as an important lesson in social skills. Therefore, proms have been held every year in high schools for students to learn proper social behavior.\r\nThe first high school proms were held in the 1920s in America. By the 1930s, proms were common across the country. For many older Americans, the prom was a modest, home-grown affair in the school gymnasium. Prom-goers were well dressed but not fancily dressed up for the occasion: boys wore jackets and ties and girls their Sunday dresses. Couples danced to music provided by a local amateur band or a record player. After the 1960s, and especially since the 1980s, the high school prom in many areas has become a serious exercise in excessive consumption, with boys renting expensive tuxedos and girls wearing designer gowns. Stretch limousines were hired to drive the prom-goers to expensive restaurants or discos for an all-night extravaganza.\r\nWhether simple or lavish, proms have always been more or less traumatic events for adolescents who worry about self-image and fitting in with their peers. Prom night can be a dreadful experience for socially awkward teens or for those who do not secure dates. Since the 1990s, alternative proms have been organized in some areas to meet the needs of particular students. For example, proms organized by and for homeless youth were reported. There were also “couple-free” proms to which all students are welcome.\r\n\r\nIn what way are high school proms significant to American teenagers?	1	7	0	2020-02-29 16:48:27.820614+00	2021-10-26 14:15:58.151865+00	f	1	1	5		0	2	f	\N	\N
348	5		Apple Inc. is an American multinational technology company headquartered in Cupertino, California, that designs, develops, and sells consumer electronics, computer software, and online services. It is considered one of the Big Four technology companies, alongside Amazon, Google, and Facebook.\r\n\r\nThe company's hardware products include the iPhone smartphone, the iPad tablet computer, the Mac personal computer, the iPod portable media player, the Apple Watch smartwatch, the Apple TV digital media player, the AirPods wireless earbuds and the HomePod smart speaker. Apple's software includes the macOS, iOS, iPadOS, watchOS, and tvOS operating systems, the iTunes media player, the Safari web browser, the Shazam acoustic fingerprint utility, and the iLife and iWork creativity and productivity suites, as well as professional applications like Final Cut Pro, Logic Pro, and Xcode. Its online services include the iTunes Store, the iOS App Store, Mac App Store, Apple Music, Apple TV+, iMessage, and iCloud. Other services include Apple Store, Genius Bar, AppleCare, Apple Pay, Apple Pay Cash, and Apple Card.\r\n\r\nwhich of the following product may not offer by Apple?	1	7	0	2020-02-29 17:43:24.715578+00	2021-10-26 14:15:58.346252+00	f	1	1	5		0	2	f	\N	\N
353	1	question_files/question_353.mp3	\N	1	0	0	2020-03-30 10:12:42.576193+00	2020-03-30 10:24:07.036262+00	f	3	6	\N		0	0	f	\N	\N
354	1	question_files/question_354.mp3	\N	1	0	0	2020-03-30 10:24:46.397485+00	2020-03-30 10:25:02.620939+00	f	3	6	\N		0	0	f	\N	\N
355	1	question_files/question_355.mp3	\N	1	0	0	2020-03-30 10:25:36.1299+00	2020-03-30 10:25:54.811594+00	f	3	6	\N		0	0	f	\N	\N
356	1	question_files/question_356.mp3	\N	1	0	0	2020-03-30 10:26:27.701408+00	2020-03-30 10:26:47.394044+00	f	3	6	\N		0	0	f	\N	\N
357	1	question_files/question_357.mp3	\N	1	0	0	2020-03-30 10:27:24.463794+00	2020-03-30 10:27:39.152832+00	f	3	6	\N		0	0	f	\N	\N
358	1	question_files/question_358.mp3	\N	1	0	0	2020-03-30 10:28:23.621289+00	2020-03-30 10:28:53.237788+00	f	3	6	\N		0	0	f	\N	\N
359	1	question_files/question_359.mp3	\N	1	0	0	2020-03-30 10:29:38.673084+00	2020-03-30 10:29:53.710939+00	f	3	6	\N		0	0	f	\N	\N
360	1	question_files/question_360.mp3	\N	1	0	0	2020-03-30 10:30:29.360507+00	2020-03-30 10:30:45.326626+00	f	3	6	\N		0	0	f	\N	\N
361	1	question_files/question_361.mp3	\N	1	0	0	2020-03-30 10:31:31.194595+00	2020-03-30 10:32:11.042497+00	f	3	6	\N		0	0	f	\N	\N
362	1	question_files/question_362.mp3	\N	1	0	0	2020-03-30 10:32:54.970692+00	2020-03-30 10:33:13.200453+00	f	3	6	\N		0	0	f	\N	\N
363	1	question_files/question_363.mp3	\N	1	0	0	2020-03-30 10:34:03.525982+00	2020-03-30 10:34:31.959712+00	f	3	6	\N		0	0	f	\N	\N
364	1	question_files/question_364.mp3	\N	1	0	0	2020-03-30 10:35:09.836305+00	2020-03-30 10:35:25.187118+00	f	3	6	\N		0	0	f	\N	\N
365	1	question_files/question_365.mp3	\N	1	0	0	2020-03-30 10:36:11.893831+00	2020-03-30 10:36:35.057711+00	f	3	6	\N		0	0	f	\N	\N
366	1	question_files/question_366.mp3	\N	1	0	0	2020-03-30 10:37:12.334462+00	2020-03-30 10:37:25.34691+00	f	3	6	\N		0	0	f	\N	\N
367	1	question_files/question_367.mp3	\N	1	0	0	2020-03-30 10:38:21.08285+00	2020-03-30 10:38:38.905294+00	f	3	6	\N		0	0	f	\N	\N
368	1	question_files/question_368.mp3	\N	1	0	0	2020-03-30 10:39:22.025197+00	2020-03-30 10:39:41.863617+00	f	3	6	\N		0	0	f	\N	\N
369	1	question_files/question_369.mp3	\N	1	0	0	2020-03-30 10:40:31.809529+00	2020-03-30 10:40:44.944241+00	f	3	6	\N		0	0	f	\N	\N
370	1	question_files/question_370.mp3	\N	1	0	0	2020-03-30 10:41:26.513213+00	2020-03-30 10:41:44.940591+00	f	3	6	\N		0	0	f	\N	\N
371	1	question_files/question_371.mp3	\N	1	0	0	2020-03-30 10:42:41.808911+00	2020-03-30 10:42:57.36036+00	f	3	6	\N		0	0	f	\N	\N
372	1	question_files/question_372.mp3	\N	1	0	0	2020-03-30 10:43:37.757573+00	2020-03-30 10:43:51.711809+00	f	3	6	\N		0	0	f	\N	\N
373	1	question_files/question_373.mp3	\N	1	0	0	2020-03-30 10:44:41.183476+00	2020-03-30 10:44:58.315564+00	f	3	6	\N		0	0	f	\N	\N
374	1	question_files/question_374.mp3	\N	1	0	0	2020-03-30 10:45:35.772454+00	2020-03-30 10:45:51.040799+00	f	3	6	\N		0	0	f	\N	\N
375	1	question_files/question_375.mp3	\N	1	0	0	2020-03-30 10:46:27.705277+00	2020-03-30 10:46:42.549645+00	f	3	6	\N		0	0	f	\N	\N
376	1	question_files/question_376.mp3	\N	1	0	0	2020-03-30 10:47:33.808315+00	2020-03-30 10:47:47.795333+00	f	3	6	\N		0	0	f	\N	\N
392	1	question_files/question_392.mp3	\N	1	0	0	2020-03-30 11:20:08.01526+00	2020-03-30 11:20:19.659781+00	f	3	6	\N		0	0	f	\N	\N
393	1	question_files/question_393.mp3	\N	1	0	0	2020-03-30 11:20:59.030138+00	2020-03-30 11:21:11.699669+00	f	3	6	\N		0	0	f	\N	\N
394	1	question_files/question_394.mp3	\N	1	0	0	2020-03-30 11:21:46.65607+00	2020-03-30 11:21:59.661861+00	f	3	6	\N		0	0	f	\N	\N
395	1	question_files/question_395.mp3	\N	1	0	0	2020-03-30 11:22:30.491798+00	2020-03-30 11:22:45.398043+00	f	3	6	\N		0	0	f	\N	\N
396	1	question_files/question_396.mp3	\N	1	0	0	2020-03-30 11:23:17.4953+00	2020-03-30 11:23:29.69704+00	f	3	6	\N		0	0	f	\N	\N
397	1	question_files/question_397.mp3	\N	1	0	0	2020-03-30 11:24:02.453217+00	2020-03-30 11:24:15.988998+00	f	3	6	\N		0	0	f	\N	\N
398	1	question_files/question_398.mp3	\N	1	0	0	2020-03-30 11:24:47.866242+00	2020-03-30 11:25:00.129503+00	f	3	6	\N		0	0	f	\N	\N
399	1	question_files/question_399.mp3	\N	1	0	0	2020-03-30 11:25:31.8873+00	2020-03-30 11:25:46.616685+00	f	3	6	\N		0	0	f	\N	\N
400	1	question_files/question_400.mp3	\N	1	0	0	2020-03-30 11:26:19.022679+00	2020-03-30 11:26:32.425501+00	f	3	6	\N		0	0	f	\N	\N
401	1	question_files/question_401.mp3	\N	1	0	0	2020-03-30 11:27:04.880603+00	2020-03-30 11:27:16.509442+00	f	3	6	\N		0	0	f	\N	\N
402	1	question_files/question_402.mp3	\N	1	0	0	2020-03-30 11:27:51.983037+00	2020-03-30 11:28:03.73883+00	f	3	6	\N		0	0	f	\N	\N
403	2	question_files/question_403.mp3	\N	1	0	0	2020-03-30 11:28:51.284568+00	2020-03-30 11:29:13.609544+00	f	3	6	\N		0	0	f	\N	\N
404	2	question_files/question_404.mp3	\N	1	0	0	2020-03-30 11:29:55.504574+00	2020-03-30 11:30:20.472267+00	f	3	6	\N		0	0	f	\N	\N
405	2	question_files/question_405.mp3	\N	1	0	0	2020-03-30 11:30:52.760833+00	2020-03-30 11:31:23.149564+00	f	3	6	\N		0	0	f	\N	\N
406	2	question_files/question_406.mp3	\N	1	0	0	2020-03-30 11:32:02.774159+00	2020-03-30 11:32:16.361227+00	f	3	6	\N		0	0	f	\N	\N
407	2	question_files/question_407.mp3	\N	1	0	0	2020-03-30 11:32:53.986204+00	2020-03-30 11:33:09.291073+00	f	3	6	\N		0	0	f	\N	\N
408	2	question_files/question_408.mp3	\N	1	0	0	2020-03-30 11:33:40.291335+00	2020-03-30 11:35:07.878723+00	f	3	6	\N		0	0	f	\N	\N
409	2	question_files/question_409.mp3	\N	1	0	0	2020-03-30 11:35:51.080545+00	2020-03-30 11:36:25.658789+00	f	3	6	\N		0	0	f	\N	\N
410	2	question_files/question_410.mp3	\N	1	0	0	2020-03-30 11:37:12.894903+00	2020-03-30 11:37:30.195754+00	f	3	6	\N		0	0	f	\N	\N
411	2	question_files/question_411.mp3	\N	1	0	0	2020-03-30 11:38:04.832734+00	2020-03-30 11:38:20.737325+00	f	3	6	\N		0	0	f	\N	\N
412	2	question_files/question_412.mp3	\N	1	0	0	2020-03-30 11:38:54.470786+00	2020-03-30 11:39:08.677646+00	f	3	6	\N		0	0	f	\N	\N
413	1	question_files/question_413.mp3	\N	1	0	0	2020-04-04 02:25:48.999508+00	2020-04-04 16:51:57.513443+00	f	3	6	6		0	0	f	\N	\N
414	1	question_files/question_414.mp3	\N	1	0	0	2020-04-04 02:26:45.33721+00	2020-04-04 16:51:30.313113+00	f	3	6	6		0	0	f	\N	\N
415	1	question_files/question_415.mp3	\N	1	0	0	2020-04-04 02:27:24.003739+00	2020-04-04 16:51:03.858101+00	f	3	6	6		0	0	f	\N	\N
416	1	question_files/question_416.mp3	\N	1	0	0	2020-04-04 02:27:57.652239+00	2020-04-04 16:50:38.316905+00	f	3	6	6		0	0	f	\N	\N
417	1	question_files/question_417.mp3	\N	1	0	0	2020-04-04 02:28:48.653614+00	2020-04-04 16:49:47.367011+00	f	3	6	6		0	0	f	\N	\N
418	1	question_files/question_418.mp3	\N	1	0	0	2020-04-04 02:29:23.503424+00	2020-04-04 16:48:20.966736+00	f	3	6	6		0	0	f	\N	\N
419	1	question_files/question_419.mp3	\N	1	0	0	2020-04-04 02:30:27.765244+00	2020-04-04 16:47:47.976072+00	f	3	6	6		0	0	f	\N	\N
420	1	question_files/question_420.mp3	\N	1	0	0	2020-04-04 02:30:59.942843+00	2020-04-04 16:46:53.086532+00	f	3	6	6		0	0	f	\N	\N
421	1	question_files/question_421.mp3	\N	1	0	0	2020-04-04 02:31:43.449326+00	2020-04-04 16:45:35.918983+00	f	3	6	6		0	0	f	\N	\N
422	1	question_files/question_422.mp3	\N	1	0	0	2020-04-04 02:32:12.397454+00	2020-04-04 16:44:49.577224+00	f	3	6	6		0	0	f	\N	\N
423	1	question_files/question_423.mp3	\N	1	0	0	2020-04-04 02:32:44.730804+00	2020-04-04 16:44:18.250121+00	f	3	6	6		0	0	f	\N	\N
424	1	question_files/question_424.mp3	\N	1	0	0	2020-04-04 02:33:17.919168+00	2020-04-04 16:43:53.44285+00	f	3	6	6		0	0	f	\N	\N
425	1	question_files/question_425.mp3	\N	1	0	0	2020-04-04 02:33:51.387018+00	2020-04-04 16:43:22.690587+00	f	3	6	6		0	0	f	\N	\N
426	1	question_files/question_426.mp3	\N	1	0	0	2020-04-04 02:34:22.884512+00	2020-04-04 16:42:57.139529+00	f	3	6	6		0	0	f	\N	\N
427	1	question_files/question_427.mp3	\N	1	0	0	2020-04-04 02:34:56.907151+00	2020-04-04 16:42:26.604349+00	f	3	6	6		0	0	f	\N	\N
428	1	question_files/question_428.mp3	\N	1	0	0	2020-04-04 02:37:00.265056+00	2020-04-04 16:41:48.774641+00	f	3	6	6		0	0	f	\N	\N
429	1	question_files/question_429.mp3	\N	1	0	0	2020-04-04 02:37:35.193038+00	2020-04-04 16:39:55.942483+00	f	3	6	6		0	0	f	\N	\N
430	1	question_files/question_430.mp3	\N	1	0	0	2020-04-04 02:38:11.94207+00	2020-04-04 16:38:55.920911+00	f	3	6	6		0	0	f	\N	\N
431	1	question_files/question_431.mp3	\N	1	0	0	2020-04-04 02:38:51.069882+00	2020-04-04 16:38:27.220728+00	f	3	6	6		0	0	f	\N	\N
432	1	question_files/question_432.mp3	\N	1	0	0	2020-04-04 02:39:22.076141+00	2020-04-04 16:36:54.955818+00	f	3	6	6		0	0	f	\N	\N
433	1	question_files/question_433.mp3	\N	1	0	0	2020-04-04 02:39:57.237147+00	2020-04-04 16:35:51.871127+00	f	3	6	6		0	0	f	\N	\N
434	1	question_files/question_434.mp3	\N	1	0	0	2020-04-04 02:40:28.191692+00	2020-04-04 16:35:13.071234+00	f	3	6	6		0	0	f	\N	\N
435	1	question_files/question_435.mp3	\N	1	0	0	2020-04-04 02:41:00.691171+00	2020-04-04 16:34:16.288459+00	f	3	6	6		0	0	f	\N	\N
436	1	question_files/question_436.mp3	\N	1	0	0	2020-04-04 02:41:30.062443+00	2020-04-04 16:33:50.751095+00	f	3	6	6		0	0	f	\N	\N
437	1	question_files/question_437.mp3	\N	1	0	0	2020-04-04 02:42:11.057074+00	2020-04-04 16:33:10.532042+00	f	3	6	6		0	0	f	\N	\N
438	1	question_files/question_438.mp3	\N	1	0	0	2020-04-04 02:42:42.362099+00	2020-04-04 16:27:49.483727+00	f	3	6	6		0	0	f	\N	\N
439	1	question_files/question_439.mp3	\N	1	0	0	2020-04-04 02:43:13.773638+00	2020-04-04 16:27:21.76481+00	f	3	6	6		0	0	f	\N	\N
440	1	question_files/question_440.mp3	\N	1	0	0	2020-04-04 02:43:46.712907+00	2020-04-04 16:26:16.345535+00	f	3	6	6		0	0	f	\N	\N
441	1	question_files/question_441.mp3	\N	1	0	0	2020-04-04 02:44:19.535603+00	2020-04-04 16:25:43.304034+00	f	3	6	6		0	0	f	\N	\N
442	1	question_files/question_442.mp3	\N	1	0	0	2020-04-04 02:44:53.78223+00	2020-04-04 16:25:19.376055+00	f	3	6	6		0	0	f	\N	\N
443	1	question_files/question_443.mp3	\N	1	0	0	2020-04-04 02:45:29.156434+00	2020-04-04 16:24:52.107407+00	f	3	6	6		0	0	f	\N	\N
444	1	question_files/question_444.mp3	\N	1	0	0	2020-04-04 02:46:01.483958+00	2020-04-04 16:23:33.975814+00	f	3	6	6		0	0	f	\N	\N
445	1	question_files/question_445.mp3	\N	1	0	0	2020-04-04 02:46:34.097831+00	2020-04-04 16:23:07.043613+00	f	3	6	6		0	0	f	\N	\N
446	1	question_files/question_446.mp3	\N	1	0	0	2020-04-04 02:47:10.703833+00	2020-04-04 16:22:30.477004+00	f	3	6	6		0	0	f	\N	\N
447	1	question_files/question_447.mp3	\N	1	0	0	2020-04-04 02:48:01.710268+00	2020-04-04 16:21:49.268165+00	f	3	6	6		0	0	f	\N	\N
448	1	question_files/question_448.mp3	\N	1	0	0	2020-04-04 02:48:37.584852+00	2020-04-04 16:21:20.761055+00	f	3	6	6		0	0	f	\N	\N
449	1	question_files/question_449.mp3	\N	1	0	0	2020-04-04 02:49:09.774453+00	2020-04-04 16:20:48.772908+00	f	3	6	6		0	0	f	\N	\N
450	1	question_files/question_450.mp3	\N	1	0	0	2020-04-04 02:49:40.94375+00	2020-04-04 16:20:22.432025+00	f	3	6	6		0	0	f	\N	\N
451	1	question_files/question_451.mp3	\N	1	0	0	2020-04-04 02:50:15.230946+00	2020-04-04 16:19:56.970358+00	f	3	6	6		0	0	f	\N	\N
452	1	question_files/question_452.mp3	\N	1	0	0	2020-04-04 02:50:51.867701+00	2020-04-04 16:19:03.04488+00	f	3	6	6		0	0	f	\N	\N
453	1	question_files/question_453.mp3	\N	1	0	0	2020-04-04 02:51:26.775996+00	2020-04-04 16:17:03.470392+00	f	3	6	6		0	0	f	\N	\N
454	1	question_files/question_454.mp3	\N	1	0	0	2020-04-04 02:52:02.95236+00	2020-04-04 16:16:24.332496+00	f	3	6	6		0	0	f	\N	\N
455	1	question_files/question_455.mp3	\N	1	0	0	2020-04-04 02:52:31.876871+00	2020-04-04 16:15:57.622564+00	f	3	6	6		0	0	f	\N	\N
456	1	question_files/question_456.mp3	\N	1	0	0	2020-04-04 02:53:02.847365+00	2020-04-04 16:15:32.744428+00	f	3	6	6		0	0	f	\N	\N
457	1	question_files/question_457.mp3	\N	1	0	0	2020-04-04 02:53:36.222416+00	2020-04-04 16:14:57.993386+00	f	3	6	6		0	0	f	\N	\N
458	1	question_files/question_458.mp3	\N	1	0	0	2020-04-04 02:54:08.824102+00	2020-04-04 16:14:22.767477+00	f	3	6	6		0	0	f	\N	\N
459	1	question_files/question_459.mp3	\N	1	0	0	2020-04-04 02:54:43.597906+00	2020-04-04 16:13:36.354452+00	f	3	6	6		0	0	f	\N	\N
460	1	question_files/question_460.mp3	\N	1	0	0	2020-04-04 02:55:17.054061+00	2020-04-04 16:13:10.363891+00	f	3	6	6		0	0	f	\N	\N
461	1	question_files/question_461.mp3	\N	1	0	0	2020-04-04 02:55:47.761474+00	2020-04-04 16:11:44.03472+00	f	3	6	6		0	0	f	\N	\N
462	1	question_files/question_462.mp3	\N	1	0	0	2020-04-04 02:56:19.722922+00	2020-04-04 16:10:58.009189+00	f	3	6	6		0	0	f	\N	\N
463	2	question_files/question_463.mp3	\N	1	0	0	2020-04-04 02:56:55.951865+00	2020-04-04 16:10:04.831887+00	f	3	6	6		0	0	f	\N	\N
464	2	question_files/question_464.mp3	\N	1	0	0	2020-04-04 02:57:26.364989+00	2020-04-04 16:09:03.433682+00	f	3	6	6		0	0	f	\N	\N
465	2	question_files/question_465.mp3	\N	1	0	0	2020-04-04 02:57:57.777908+00	2020-04-04 16:07:57.470282+00	f	3	6	6		0	0	f	\N	\N
466	2	question_files/question_466.mp3	\N	1	0	0	2020-04-04 02:58:27.990564+00	2020-04-04 16:06:59.87445+00	f	3	6	6		0	0	f	\N	\N
467	2	question_files/question_467.mp3	\N	1	0	0	2020-04-04 02:59:01.101587+00	2020-04-04 16:06:06.308298+00	f	3	6	6		0	0	f	\N	\N
468	2	question_files/question_468.mp3	\N	1	0	0	2020-04-04 02:59:34.774367+00	2020-04-04 16:04:46.239144+00	f	3	6	6		0	0	f	\N	\N
469	2	question_files/question_469.mp3	\N	1	0	0	2020-04-04 03:00:05.862923+00	2020-04-04 16:04:00.824038+00	f	3	6	6		0	0	f	\N	\N
470	2	question_files/question_470.mp3	\N	1	0	0	2020-04-04 03:00:38.517842+00	2020-04-04 16:03:18.6111+00	f	3	6	6		0	0	f	\N	\N
471	2	question_files/question_471.mp3	\N	1	0	0	2020-04-04 03:01:08.799221+00	2020-04-04 16:02:33.198873+00	f	3	6	6		0	0	f	\N	\N
472	2	question_files/question_472.mp3	\N	1	0	0	2020-04-04 03:01:46.069326+00	2020-04-04 16:02:05.653612+00	f	3	6	6		0	0	f	\N	\N
473	1	question_files/question_473.mp3	\N	1	0	0	2020-04-04 11:45:05.680088+00	2020-04-04 16:01:19.538152+00	f	3	6	6		0	0	f	\N	\N
474	1	question_files/question_474.mp3	\N	1	0	0	2020-04-04 11:45:34.733166+00	2020-04-04 16:00:50.353489+00	f	3	6	6		0	0	f	\N	\N
475	1	question_files/question_475.mp3	\N	1	0	0	2020-04-04 11:46:06.013864+00	2020-04-04 16:00:02.814097+00	f	3	6	6		0	0	f	\N	\N
476	1	question_files/question_476.mp3	\N	1	0	0	2020-04-04 11:46:41.554679+00	2020-04-04 15:59:38.64413+00	f	3	6	6		0	0	f	\N	\N
477	1	question_files/question_477.mp3	\N	1	0	0	2020-04-04 11:47:13.401295+00	2020-04-04 15:55:32.465613+00	f	3	6	6		0	0	f	\N	\N
478	1	question_files/question_478.mp3	\N	1	0	0	2020-04-04 11:47:44.213594+00	2020-04-04 15:54:44.948311+00	f	3	6	6		0	0	f	\N	\N
479	1	question_files/question_479.mp3	\N	1	0	0	2020-04-04 11:48:15.106323+00	2020-04-04 15:52:47.476517+00	f	3	6	6		0	0	f	\N	\N
480	1	question_files/question_480.mp3	\N	1	0	0	2020-04-04 11:48:48.44832+00	2020-04-04 15:51:43.942609+00	f	3	6	6		0	0	f	\N	\N
481	1	question_files/question_481.mp3	\N	1	0	0	2020-04-04 11:49:19.82247+00	2020-04-04 15:51:11.558559+00	f	3	6	6		0	0	f	\N	\N
482	1	question_files/question_482.mp3	\N	1	0	0	2020-04-04 11:49:49.888989+00	2020-04-04 15:50:39.5527+00	f	3	6	6		0	0	f	\N	\N
483	1	question_files/question_483.mp3	\N	1	0	0	2020-04-04 11:50:22.531962+00	2020-04-04 15:50:11.881504+00	f	3	6	6		0	0	f	\N	\N
484	1	question_files/question_484.mp3	\N	1	0	0	2020-04-04 11:50:54.558458+00	2020-04-04 15:49:11.532383+00	f	3	6	6		0	0	f	\N	\N
485	1	question_files/question_485.mp3	\N	1	0	0	2020-04-04 11:51:27.309118+00	2020-04-04 15:48:41.772239+00	f	3	6	6		0	0	f	\N	\N
486	1	question_files/question_486.mp3	\N	1	0	0	2020-04-04 11:51:59.953436+00	2020-04-04 15:47:38.690949+00	f	3	6	6		0	0	f	\N	\N
487	1	question_files/question_487.mp3	\N	1	0	0	2020-04-04 11:52:32.766767+00	2020-04-04 15:47:02.996952+00	f	3	6	6		0	0	f	\N	\N
488	1	question_files/question_488.mp3	\N	1	0	0	2020-04-04 11:53:04.780275+00	2020-04-04 15:46:34.796525+00	f	3	6	6		0	0	f	\N	\N
489	1	question_files/question_489.mp3	\N	1	0	0	2020-04-04 11:53:38.404508+00	2020-04-04 15:45:51.53031+00	f	3	6	6		0	0	f	\N	\N
490	1	question_files/question_490.mp3	\N	1	0	0	2020-04-04 11:54:13.11433+00	2020-04-04 15:45:23.376544+00	f	3	6	6		0	0	f	\N	\N
491	1	question_files/question_491.mp3	\N	1	0	0	2020-04-04 11:54:44.244333+00	2020-04-04 15:43:58.23327+00	f	3	6	6		0	0	f	\N	\N
492	1	question_files/question_492.mp3	\N	1	0	0	2020-04-04 11:55:26.408065+00	2020-04-04 15:34:15.698227+00	f	3	6	6		0	0	f	\N	\N
493	1	question_files/question_493.mp3	\N	1	0	0	2020-04-04 11:55:57.157565+00	2020-04-04 15:33:51.034062+00	f	3	6	6		0	0	f	\N	\N
494	1	question_files/question_494.mp3	\N	1	0	0	2020-04-04 11:56:31.161894+00	2020-04-04 15:33:18.468395+00	f	3	6	6		0	0	f	\N	\N
495	1	question_files/question_495.mp3	\N	1	0	0	2020-04-04 11:56:59.479229+00	2020-04-04 15:28:56.53009+00	f	3	6	6		0	0	f	\N	\N
496	1	question_files/question_496.mp3	\N	1	0	0	2020-04-04 11:57:28.916574+00	2020-04-04 15:28:31.169275+00	f	3	6	6		0	0	f	\N	\N
497	1	question_files/question_497.mp3	\N	1	0	0	2020-04-04 11:57:57.21801+00	2020-04-04 15:27:51.993906+00	f	3	6	6		0	0	f	\N	\N
498	1	question_files/question_498.mp3	\N	1	0	0	2020-04-04 11:58:29.997965+00	2020-04-04 15:27:11.696729+00	f	3	6	6		0	0	f	\N	\N
499	1	question_files/question_499.mp3	\N	1	0	0	2020-04-04 11:58:59.735703+00	2020-04-04 15:26:40.455532+00	f	3	6	6		0	0	f	\N	\N
500	1	question_files/question_500.mp3	\N	1	0	0	2020-04-04 11:59:29.594061+00	2020-04-04 15:26:08.448849+00	f	3	6	6		0	0	f	\N	\N
501	1	question_files/question_501.mp3	\N	1	0	0	2020-04-04 12:00:01.144727+00	2020-04-04 15:25:30.800668+00	f	3	6	6		0	0	f	\N	\N
502	1	question_files/question_502.mp3	\N	1	0	0	2020-04-04 12:00:31.042068+00	2020-04-04 15:25:03.90449+00	f	3	6	6		0	0	f	\N	\N
503	1	question_files/question_503.mp3	\N	1	0	0	2020-04-04 12:01:10.18324+00	2020-04-04 15:24:32.468416+00	f	3	6	6		0	0	f	\N	\N
504	1	question_files/question_504.mp3	\N	1	0	0	2020-04-04 12:01:44.750875+00	2020-04-04 15:24:04.797515+00	f	3	6	6		0	0	f	\N	\N
505	1	question_files/question_505.mp3	\N	1	0	0	2020-04-04 12:02:14.108025+00	2020-04-04 15:21:38.121004+00	f	3	6	6		0	0	f	\N	\N
506	1	question_files/question_506.mp3	\N	1	0	0	2020-04-04 12:02:45.549742+00	2020-04-04 15:21:03.254304+00	f	3	6	6		0	0	f	\N	\N
507	1	question_files/question_507.mp3	\N	1	0	0	2020-04-04 12:03:17.264038+00	2020-04-04 15:20:24.241095+00	f	3	6	6		0	0	f	\N	\N
508	1	question_files/question_508.mp3	\N	1	0	0	2020-04-04 12:03:45.377164+00	2020-04-04 15:19:41.636181+00	f	3	6	6		0	0	f	\N	\N
509	1	question_files/question_509.mp3	\N	1	0	0	2020-04-04 12:04:16.729668+00	2020-04-04 15:18:22.444084+00	f	3	6	6		0	0	f	\N	\N
510	1	question_files/question_510.mp3	\N	1	0	0	2020-04-04 12:04:46.872378+00	2020-04-04 15:17:26.066925+00	f	3	6	6		0	0	f	\N	\N
511	1	question_files/question_511.mp3	\N	1	0	0	2020-04-04 12:05:19.552313+00	2020-04-04 15:16:56.692269+00	f	3	6	6		0	0	f	\N	\N
512	1	question_files/question_512.mp3	\N	1	0	0	2020-04-04 12:05:49.463556+00	2020-04-04 15:15:47.709607+00	f	3	6	6		0	0	f	\N	\N
513	1	question_files/question_513.mp3	\N	1	0	0	2020-04-04 12:06:16.408462+00	2020-04-04 15:15:08.141985+00	f	3	6	6		0	0	f	\N	\N
514	1	question_files/question_514.mp3	\N	1	0	0	2020-04-04 12:06:52.26887+00	2020-04-04 15:14:20.990258+00	f	3	6	6		0	0	f	\N	\N
515	1	question_files/question_515.mp3	\N	1	0	0	2020-04-04 12:07:23.477293+00	2020-04-04 15:13:35.463337+00	f	3	6	6		0	0	f	\N	\N
516	1	question_files/question_516.mp3	\N	1	0	0	2020-04-04 12:07:56.376204+00	2020-04-04 15:12:41.149531+00	f	3	6	6		0	0	f	\N	\N
517	1	question_files/question_517.mp3	\N	1	0	0	2020-04-04 12:08:28.741104+00	2020-04-04 15:11:53.452082+00	f	3	6	6		0	0	f	\N	\N
518	1	question_files/question_518.mp3	\N	1	0	0	2020-04-04 12:09:01.166806+00	2020-04-04 15:11:10.630794+00	f	3	6	6		0	0	f	\N	\N
519	1	question_files/question_519.mp3	\N	1	0	0	2020-04-04 12:09:31.281067+00	2020-04-04 15:10:18.6841+00	f	3	6	6		0	0	f	\N	\N
520	1	question_files/question_520.mp3	\N	1	0	0	2020-04-04 12:09:59.76513+00	2020-04-04 15:09:24.475889+00	f	3	6	6		0	0	f	\N	\N
521	1	question_files/question_521.mp3	\N	1	0	0	2020-04-04 12:10:32.360666+00	2020-04-04 15:08:54.324045+00	f	3	6	6		0	0	f	\N	\N
522	1	question_files/question_522.mp3	\N	1	0	0	2020-04-04 12:11:02.605948+00	2020-04-04 15:08:00.371152+00	f	3	6	6		0	0	f	\N	\N
523	2	question_files/question_523.mp3	\N	1	0	0	2020-04-04 12:11:33.542354+00	2020-04-04 15:07:13.072014+00	f	3	6	6		0	0	f	\N	\N
524	2	question_files/question_524.mp3	\N	1	0	0	2020-04-04 12:12:04.680755+00	2020-04-04 15:05:00.641169+00	f	3	6	6		0	0	f	\N	\N
525	2	question_files/question_525.mp3	\N	1	0	0	2020-04-04 12:12:35.810981+00	2020-04-04 15:04:19.814574+00	f	3	6	6		0	0	f	\N	\N
526	2	question_files/question_526.mp3	\N	1	0	0	2020-04-04 12:13:07.665848+00	2020-04-04 15:03:35.921124+00	f	3	6	6		0	0	f	\N	\N
527	2	question_files/question_527.mp3	\N	1	0	0	2020-04-04 12:13:37.504855+00	2020-04-04 15:02:51.097617+00	f	3	6	6		0	0	f	\N	\N
528	2	question_files/question_528.mp3	\N	1	0	0	2020-04-04 12:14:10.295439+00	2020-04-04 15:02:13.042685+00	f	3	6	6		0	0	f	\N	\N
529	2	question_files/question_529.mp3	\N	1	0	0	2020-04-04 12:14:40.325391+00	2020-04-04 15:00:47.822866+00	f	3	6	6		0	0	f	\N	\N
530	2	question_files/question_530.mp3	\N	1	0	0	2020-04-04 12:15:14.823758+00	2020-04-04 14:59:42.589002+00	f	3	6	6		0	0	f	\N	\N
531	2	question_files/question_531.mp3	\N	1	0	0	2020-04-04 12:15:49.304561+00	2020-04-04 14:58:55.122065+00	f	3	6	6		0	0	f	\N	\N
532	2	question_files/question_532.mp3	\N	1	0	0	2020-04-04 12:16:23.343586+00	2020-04-04 14:58:12.012163+00	f	3	6	6		0	0	f	\N	\N
537	3		They have been waiting for me ______ 5 o'clock.	1	8	43	2020-04-12 23:42:10.958293+00	2022-05-17 12:21:21.056544+00	f	1	1	1		16	37	f	\N	\N
539	3		Do you like to eat hamburger?	2	0	100	2021-03-13 16:35:12.63529+00	2022-05-19 18:44:52.388541+00	f	1	5	5		16	16	f	\N	\N
540	3		He is ____ in the military service.	1	10	37	2022-05-04 22:33:10.369815+00	2022-05-19 18:44:52.401416+00	f	1	36	36		3	8	f	\N	\N
\.


--
-- Data for Name: alcpt_question_favorite; Type: TABLE DATA; Schema: alcpt; Owner: postgres
--

COPY alcpt.alcpt_question_favorite (id, question_id, user_id) FROM stdin;
15	1	36
14	5	36
45	31	36
32	32	36
17	33	36
12	34	36
20	36	36
18	44	36
19	46	36
1	104	36
11	537	36
\.


--
-- Data for Name: alcpt_reply; Type: TABLE DATA; Schema: alcpt; Owner: postgres
--

COPY alcpt.alcpt_reply (id, content, created_time, created_by_id, source_id) FROM stdin;
\.


--
-- Data for Name: alcpt_report; Type: TABLE DATA; Schema: alcpt; Owner: postgres
--

COPY alcpt.alcpt_report (id, user_notification, staff_notification, supplement_note, state, created_time, resolved_time, category_id, created_by_id, question_id, resolved_by_id) FROM stdin;
24	f	f	答案是否有誤	2	2022-03-10 22:51:31.839404+00	2022-05-04 22:30:07.420534+00	3	36	33	\N
25	f	t	成績是否計算錯誤？	1	2022-03-10 23:02:14.669906+00	2022-03-10 23:02:14.685848+00	2	36	\N	\N
26	t	f	答案怪	3	2022-05-04 22:31:40.041128+00	2022-05-04 22:32:54.964566+00	3	36	1	36
27	f	f	怪	2	2022-05-04 22:32:41.898099+00	2022-05-04 22:32:47.86742+00	3	36	1	\N
\.


--
-- Data for Name: alcpt_reportcategory; Type: TABLE DATA; Schema: alcpt; Owner: postgres
--

COPY alcpt.alcpt_reportcategory (id, name, responsibility) FROM stdin;
1	帳號問題	32
2	成績問題	16
3	試題問題	8
4	其他	32
\.


--
-- Data for Name: alcpt_squadron; Type: TABLE DATA; Schema: alcpt; Owner: postgres
--

COPY alcpt.alcpt_squadron (id, name) FROM stdin;
1	學生一中隊
3	學生三中隊
2	學生二中隊
4	學生四中隊
5	實習旅部
\.


--
-- Data for Name: alcpt_student; Type: TABLE DATA; Schema: alcpt; Owner: postgres
--

COPY alcpt.alcpt_student (id, stu_id, grade, department_id, squadron_id, user_id) FROM stdin;
1	1090630218	109	1	1	1
2	qaz74159	110	1	3	2
3	1090630220	109	1	1	7
4	1100630220	110	1	3	8
5	1100630204	110	1	3	9
6	1090630204	109	1	1	10
7	1100630224	110	1	3	5
8	1090630212	109	1	1	6
21	1100630230	112	1	1	19
22	1100630225	111	2	2	20
24	1100630226	111	1	1	23
25	1100630227	111	2	1	25
26	1100630231	111	2	1	26
27	1100630232	111	\N	\N	27
28	1100630221	110	1	3	28
29	1110630236	111	1	3	36
30	1110630250	110	\N	\N	37
31	1110630201	111	1	3	38
32	1110630202	111	1	3	39
33	1110630203	111	1	3	40
34	1110630205	111	1	3	41
\.


--
-- Data for Name: alcpt_testpaper; Type: TABLE DATA; Schema: alcpt; Owner: postgres
--

COPY alcpt.alcpt_testpaper (id, name, created_time, is_testpaper, update_time, valid, created_by_id, is_used) FROM stdin;
54	閱讀練習-2020/12/29 15:53:01	2020-12-29 15:53:01.794039+00	f	2020-12-29 15:53:01.795813+00	f	5	f
55	聽力練習-2020/12/29 15:53:17	2020-12-29 15:53:17.393246+00	f	2020-12-29 15:53:17.395301+00	f	5	f
56	123	2020-12-29 19:36:35.153768+00	t	2022-05-12 15:26:35.261839+00	t	5	t
57	閱讀練習-2021/01/04 10:46:14	2021-01-04 10:46:14.82236+00	f	2021-01-04 10:46:14.826699+00	f	9	f
58	閱讀練習-2021/01/25 10:34:42	2021-01-25 10:34:42.785873+00	f	2021-01-25 10:34:42.794431+00	f	9	f
59	343	2021-01-25 10:39:50.180709+00	t	2021-01-25 10:40:25.298352+00	t	9	t
60	閱讀練習-2021/01/25 10:56:36	2021-01-25 10:56:36.124544+00	f	2021-01-25 10:56:36.125869+00	f	9	f
61	閱讀練習-2021/01/25 11:15:04	2021-01-25 11:15:04.152169+00	f	2021-01-25 11:15:04.153872+00	f	9	f
62	閱讀練習-2021/01/25 11:31:34	2021-01-25 11:31:34.627576+00	f	2021-01-25 11:31:34.62877+00	f	19	f
63	聽力練習-2021/03/13 16:31:15	2021-03-13 16:31:15.383566+00	f	2021-03-13 16:31:15.387516+00	f	5	f
64	測試1	2021-03-13 16:39:10.040441+00	t	2021-03-15 11:29:58.49086+00	f	5	f
65	聽力練習-2021/10/12 15:20:23	2021-10-12 15:20:23.698876+00	f	2021-10-12 15:20:23.709159+00	f	36	f
66	閱讀練習-2021/10/12 15:22:55	2021-10-12 15:22:55.178217+00	f	2021-10-12 15:22:55.184162+00	f	36	f
67	Test1012	2021-10-12 16:38:07.560149+00	t	2022-04-19 11:14:23.738824+00	f	36	t
68	閱讀練習-2021/10/19 14:09:13	2021-10-19 14:09:13.460169+00	f	2021-10-19 14:09:13.487809+00	f	36	f
69	閱讀練習-2021/11/04 10:26:26	2021-11-04 10:26:26.357623+00	f	2021-11-04 10:26:26.402678+00	f	36	f
70	閱讀練習-2021/11/04 10:52:44	2021-11-04 10:52:44.522653+00	f	2021-11-04 10:52:44.532896+00	f	36	f
71	聽力練習-2021/11/04 11:00:18	2021-11-04 11:00:18.158127+00	f	2021-11-04 11:00:18.175041+00	f	36	f
72	聽力練習-2021/11/04 23:10:25	2021-11-04 23:10:25.978421+00	f	2021-11-04 23:10:25.994818+00	f	36	f
73	001	2022-03-12 22:34:49.820101+00	t	2022-04-19 15:08:30.096824+00	t	36	t
79	111	2022-05-03 11:08:50.682101+00	t	2022-05-03 11:12:49.59129+00	t	36	t
80	0512	2022-05-12 15:51:04.099573+00	t	2022-05-19 00:33:08.376345+00	t	36	t
81	閱讀練習-2022/05/12 16:43:41	2022-05-12 16:43:41.06209+00	f	2022-05-12 16:43:41.0648+00	f	36	f
82	閱讀練習-2022/05/12 17:06:07	2022-05-12 17:06:07.88204+00	f	2022-05-12 17:06:07.888949+00	f	36	f
83	閱讀練習-2022/05/12 18:06:40	2022-05-12 18:06:40.028141+00	f	2022-05-12 18:06:40.045082+00	f	36	f
84	閱讀練習-2022/05/12 18:07:46	2022-05-12 18:07:46.155467+00	f	2022-05-12 18:07:46.158514+00	f	36	f
85	閱讀練習-2022/05/12 18:08:46	2022-05-12 18:08:47.015414+00	f	2022-05-12 18:08:47.023544+00	f	36	f
86	閱讀練習-2022/05/12 18:09:50	2022-05-12 18:09:50.276486+00	f	2022-05-12 18:09:50.278777+00	f	36	f
87	閱讀練習-2022/05/12 18:12:33	2022-05-12 18:12:33.452295+00	f	2022-05-12 18:12:33.457109+00	f	36	f
88	閱讀練習-2022/05/13 10:17:18	2022-05-13 10:17:18.519704+00	f	2022-05-13 10:17:18.529468+00	f	36	f
89	閱讀練習-2022/05/13 10:24:51	2022-05-13 10:24:51.880294+00	f	2022-05-13 10:24:51.882996+00	f	36	f
90	閱讀練習-2022/05/13 10:28:10	2022-05-13 10:28:10.847176+00	f	2022-05-13 10:28:10.848667+00	f	36	f
91	閱讀練習-2022/05/17 12:20:31	2022-05-17 12:20:31.301952+00	f	2022-05-17 12:20:31.319784+00	f	36	f
92	閱讀練習-2022/05/17 14:18:02	2022-05-17 14:18:02.027493+00	f	2022-05-17 14:18:02.040238+00	f	36	f
93	閱讀練習-2022/05/19 18:41:33	2022-05-19 18:41:33.892501+00	f	2022-05-19 18:41:33.900593+00	f	36	f
94	閱讀練習-2022/05/19 18:44:07	2022-05-19 18:44:07.81581+00	f	2022-05-19 18:44:07.820857+00	f	36	f
\.


--
-- Data for Name: alcpt_testpaper_question_list; Type: TABLE DATA; Schema: alcpt; Owner: postgres
--

COPY alcpt.alcpt_testpaper_question_list (id, testpaper_id, question_id) FROM stdin;
1354	54	31
1358	54	33
1363	54	40
1356	54	41
1361	54	42
1357	54	43
1359	54	44
1360	54	45
1355	54	47
1362	54	537
1373	55	129
1368	55	132
1365	55	190
1367	55	214
1371	55	264
1372	55	270
1370	55	277
1366	55	281
1364	55	289
1369	55	294
1376	56	1
1377	56	5
1386	56	29
1388	56	31
1387	56	33
1380	56	34
1383	56	35
1384	56	37
1375	56	41
1385	56	42
1379	56	44
1378	56	46
1382	56	47
1381	56	60
1374	56	537
1393	57	1
1398	57	5
1395	57	29
1392	57	31
1389	57	32
1396	57	33
1397	57	37
1390	57	43
1391	57	46
1394	57	60
1401	58	1
1404	58	5
1405	58	29
1408	58	32
1399	58	34
1407	58	37
1406	58	45
1403	58	48
1402	58	60
1400	58	537
1433	59	5
1443	59	29
1437	59	31
1441	59	32
1432	59	33
1436	59	34
1434	59	35
1430	59	37
1435	59	40
1431	59	42
1439	59	43
1440	59	45
1429	59	47
1442	59	48
1438	59	537
1460	60	5
1461	60	32
1464	60	33
1459	60	36
1462	60	37
1463	60	43
1466	60	45
1465	60	47
1468	60	48
1467	60	537
1471	61	32
1477	61	33
1475	61	34
1474	61	37
1470	61	40
1472	61	42
1478	61	44
1473	61	47
1476	61	60
1469	61	537
1479	62	1
1486	62	34
1481	62	35
1485	62	36
1483	62	40
1482	62	43
1480	62	45
1487	62	46
1484	62	48
1488	62	537
1489	63	146
1494	63	153
1497	63	155
1493	63	157
1498	63	192
1492	63	214
1490	63	263
1491	63	289
1496	63	290
1495	63	294
1784	65	28
1781	65	126
1780	65	128
1783	65	145
1787	65	154
1782	65	206
1779	65	208
1778	65	219
1786	65	256
1785	65	282
1795	66	49
1796	66	55
1788	66	67
1793	66	74
1791	66	75
1789	66	77
1794	66	88
1792	66	90
1797	66	104
1790	66	111
1864	67	1
1876	67	6
1861	67	29
1871	67	31
1872	67	32
1863	67	33
1858	67	36
1869	67	37
1859	67	40
1860	67	42
1870	67	43
1862	67	44
1865	67	46
1866	67	47
1868	67	48
1881	67	50
1889	67	52
1877	67	53
1886	67	54
1874	67	72
1880	67	78
1879	67	80
1887	67	85
1878	67	87
1884	67	100
1885	67	103
1882	67	109
1873	67	110
1883	67	113
1875	67	115
1835	67	128
1820	67	130
1803	67	134
1836	67	139
1833	67	141
1810	67	142
1826	67	143
1816	67	148
1799	67	154
1812	67	155
1821	67	159
1800	67	164
1805	67	165
1798	67	166
1827	67	167
1831	67	171
1829	67	172
1854	67	175
1843	67	176
1855	67	177
1851	67	178
1846	67	179
1857	67	180
1853	67	181
1842	67	182
1841	67	183
1847	67	184
1801	67	189
1823	67	190
1830	67	192
1809	67	193
1834	67	194
1837	67	196
1804	67	201
1806	67	202
1808	67	203
1807	67	204
1832	67	209
1828	67	210
1822	67	211
1811	67	213
1824	67	218
1848	67	236
1840	67	238
1852	67	243
1825	67	261
1818	67	266
1815	67	277
1813	67	279
1802	67	280
1814	67	282
1817	67	284
1819	67	288
1844	67	296
1838	67	297
1839	67	298
1845	67	299
1856	67	302
1849	67	303
1850	67	304
1890	67	339
1893	67	340
1894	67	341
1897	67	343
1888	67	344
1892	67	345
1895	67	346
1891	67	347
1896	67	348
1867	67	537
1901	68	5
1902	68	31
1905	68	37
1906	68	40
1907	68	44
1904	68	45
1898	68	46
1899	68	47
1903	68	60
1900	68	539
1915	69	29
1917	69	31
1916	69	33
1910	69	37
1912	69	41
1908	69	42
1913	69	44
1909	69	46
1911	69	47
1914	69	60
1919	70	1
1927	70	2
1920	70	29
1921	70	33
1918	70	42
1922	70	47
1925	70	72
1923	70	81
1926	70	82
1924	70	111
1932	71	125
1937	71	130
1936	71	134
1928	71	141
1934	71	148
1931	71	150
1933	71	196
1929	71	204
1935	71	282
1930	71	289
1943	72	175
1944	72	177
1938	72	184
1941	72	236
1945	72	297
1947	72	299
1939	72	300
1946	72	303
1940	72	304
1942	72	305
1991	73	1
2001	73	5
1998	73	29
1999	73	32
1994	73	34
1995	73	36
1989	73	40
2002	73	41
1993	73	43
1988	73	44
1992	73	46
1997	73	47
1996	73	48
1990	73	60
2000	73	539
2113	79	1
2114	79	5
2112	79	31
2119	79	32
2111	79	34
2121	79	40
2120	79	41
2116	79	43
2118	79	45
2117	79	46
2109	79	47
2108	79	48
2122	79	60
2098	79	175
2105	79	176
2102	79	177
2099	79	179
2092	79	180
2106	79	181
2095	79	182
2101	79	183
2088	79	236
2094	79	238
2097	79	243
2096	79	296
2093	79	297
2091	79	298
2107	79	299
2090	79	300
2103	79	302
2104	79	303
2100	79	304
2089	79	305
2110	79	537
2115	79	539
2123	80	5
2124	80	29
2125	80	31
2126	80	32
2127	80	33
2128	80	34
2129	80	35
2130	80	36
2131	80	37
2132	80	40
2135	81	5
2133	81	31
2134	81	32
2140	81	42
2136	81	44
2142	81	45
2141	81	47
2137	81	60
2139	81	537
2138	81	540
2151	82	54
2143	82	66
2146	82	69
2152	82	71
2144	82	85
2145	82	88
2149	82	93
2150	82	95
2147	82	110
2148	82	116
2153	83	35
2159	83	37
2154	83	40
2157	83	41
2162	83	44
2155	83	47
2160	83	48
2158	83	60
2156	83	537
2161	83	540
2163	84	31
2170	84	32
2164	84	41
2167	84	42
2169	84	43
2171	84	44
2172	84	45
2168	84	47
2166	84	60
2165	84	540
2178	85	29
2173	85	33
2175	85	35
2182	85	41
2180	85	42
2174	85	45
2177	85	46
2179	85	47
2176	85	539
2181	85	540
2183	86	5
2186	86	29
2190	86	35
2192	86	36
2188	86	37
2187	86	41
2184	86	44
2191	86	47
2189	86	537
2185	86	539
2200	87	5
2197	87	32
2201	87	34
2195	87	36
2196	87	37
2193	87	41
2194	87	60
2198	87	537
2199	87	539
2202	87	540
2212	88	33
2208	88	36
2206	88	37
2210	88	40
2204	88	41
2205	88	45
2203	88	46
2211	88	47
2207	88	539
2209	88	540
2222	89	31
2219	89	32
2214	89	33
2217	89	36
2216	89	37
2215	89	45
2221	89	46
2218	89	47
2220	89	60
2213	89	539
2225	90	5
2229	90	29
2230	90	31
2231	90	34
2226	90	35
2224	90	36
2228	90	40
2232	90	42
2223	90	43
2227	90	46
2236	91	5
2234	91	31
2240	91	34
2233	91	35
2241	91	42
2239	91	47
2238	91	48
2242	91	60
2235	91	537
2237	91	539
2251	92	32
2252	92	33
2245	92	35
2250	92	37
2249	92	42
2243	92	43
2248	92	46
2244	92	47
2246	92	48
2247	92	539
2253	93	33
2255	93	35
2261	93	41
2258	93	43
2257	93	46
2260	93	47
2254	93	48
2256	93	60
2262	93	539
2259	93	540
2267	94	29
2266	94	32
2272	94	33
2265	94	36
2271	94	40
2269	94	44
2270	94	45
2264	94	47
2263	94	539
2268	94	540
\.


--
-- Data for Name: alcpt_user; Type: TABLE DATA; Schema: alcpt; Owner: postgres
--

COPY alcpt.alcpt_user (id, password, reg_id, name, gender, identity, privilege, email, email_is_verified, update_time, created_time, last_login, introduction, photo, experience, level, browser) FROM stdin;
1	pbkdf2_sha256$180000$oTBTGig3RK5k$FhXD0UVPuiTiM+u6BsWeJA4pis6KlnTCIPlN6Z4b/2Q=	Maxium1997	蘇典煒	1	2	59	wei860925@gmail.com	t	2020-04-27 10:21:05.554946+00	2019-10-15 12:44:32.551+00	2020-04-27 10:21:05.545087+00	1090630218\r\nNational Defense University\r\nInformation Management	photos/default_propic.png	0	1	\N
2	pbkdf2_sha256$216000$oUq9HWveAtiA$QyQxpMdkk8eTqeMDfQZ/vuduQcoYrZQK/1saI93SuFs=	qaz74159	黃柏豪	1	2	63	qaz74159@yahoo.com.tw	f	2020-11-30 11:35:54.616266+00	2020-02-11 13:02:52.789648+00	2020-11-30 11:35:54.563597+00	\N	photos/default_propic.png	0	1	\N
4	pbkdf2_sha256$180000$pSz5ws6jqokY$ElB2cOb0dAXOVhZS7qBWBwk5Iv4uAgL0zDBcK2xkQvE=	mcndu0001	袁葆宏	1	3	2	max_yuan_i@gmail.com	f	2020-04-16 09:19:50.836809+00	2020-02-11 14:47:59.132463+00	2020-04-16 09:19:50.834488+00	\N	photos/default_propic.png	0	1	\N
5	pbkdf2_sha256$216000$iXDJtOXY1TDu$vuITuhj1A2HI/j4e2qEN6COMxG2uBUboi0x8U+rXDG8=	joy9517538246	劉昀昕	2	2	63	joy9517538246@gmail.com	f	2021-03-13 16:30:40.634158+00	2020-02-12 13:07:00.411616+00	2021-03-13 16:30:40.630739+00	 MCNDU	photos/joy9517538246_劉昀昕_KyygCQP.jpg	1100	4	\N
6	pbkdf2_sha256$180000$qZyeHIu6TwYz$VR6qvUuvuHudtKxKDpWOrR+jkI0CRNDOAmTX+AiH914=	TonyChen9305	陳信綸	1	2	4	gmvup4xjp6@gmail.com	f	2020-04-16 09:48:03.188463+00	2020-02-12 13:12:58.230412+00	2020-04-15 22:15:15.481541+00	\N	photos/default_propic.png	0	1	\N
7	pbkdf2_sha256$180000$mGWgaVkhdl5T$w2Ae2vzEAXxUSJUm0ZqlI6+x+sP8/WPRrUvZhg0F/HQ=	smile100226	傅晴俞	2	2	8	smile100226@gmail.com	f	2020-04-16 09:50:50.195881+00	2020-02-12 13:16:21.35439+00	2020-04-16 09:50:50.193535+00	\N	photos/default_propic.png	0	1	\N
8	pbkdf2_sha256$180000$1lFO00qItmwO$RKtFjJaOH4wd03XER5Kqs5e8cCGC0aktwcaRf8CFFeM=	mayou66321	賴昱婷	2	2	63	mayou66321@gmail.com	f	2020-04-16 09:54:43.196971+00	2020-02-14 13:24:38.246472+00	2020-04-16 09:54:43.195055+00	\N	photos/default_propic.png	0	1	\N
9	pbkdf2_sha256$260000$NzaLytY3PEzjVMgHbyNmQs$sfMdG8+QrM5RktXlRrHKkfENvTWLAVpwNmhNYtq/JX0=	1100630204	黃子祐	1	2	63	\N	f	2023-01-26 15:19:58.228394+00	2020-02-14 13:25:18.142812+00	2023-01-26 15:19:58.223135+00	\N	photos/default_propic.png	200	2	6nfyisopsgfk7ye2h73y0ekg5oqf6dji
10	pbkdf2_sha256$180000$UxGqLrZnZSDU$5N60fls8VBBuQcJW2vh3Te8LaMGk9Dzrux7m8mm2VUY=	terry90209	楊家齊	1	2	16	terry90209@gmail.com	f	2020-04-16 09:50:20.857451+00	2020-03-18 15:31:27.930608+00	2020-04-16 09:50:20.854515+00		photos/default_propic.png	0	1	\N
19	pbkdf2_sha256$216000$dkWpz7fCFTit$wFjun2ySh8uJ/Ml60mcarsOM1nfEUfMGKJV1IGaCDOs=	1100630230	\N	\N	2	1	\N	f	2021-01-25 11:31:47.056566+00	2021-01-25 11:30:59.918223+00	2021-01-25 11:31:20.450191+00	\N	default_propic/default_propic.png	50	1	\N
20	pbkdf2_sha256$216000$J7EY5HJQVu2k$Vg8w2ugIcV8o2jxuWNqjVZqe68Sm7oppC88Rx+C6t44=	1100630225	\N	\N	2	1	\N	f	2021-02-22 10:50:09.65149+00	2021-02-22 10:50:09.630843+00	\N	\N	default_propic/default_propic.png	0	1	\N
22	pbkdf2_sha256$216000$kWhmixkFmlLU$X0bwKQq2u5tEoxwsYuEfpuaz06kKLfkqjQaNjnONXz8=	1100630226	\N	\N	0	1	\N	f	2021-02-22 10:51:14.096676+00	2021-02-22 10:51:14.09666+00	\N	\N	default_propic/default_propic.png	0	1	\N
23	pbkdf2_sha256$216000$34ufSGw69Xam$MU2e/UzlAPvzrEabW8yoau0Kqs5uLuC0A10WvBDQizc=	1100630227	\N	\N	2	1	\N	f	2021-02-22 11:28:11.561576+00	2021-02-22 11:28:11.542686+00	\N	\N	default_propic/default_propic.png	0	1	\N
25	pbkdf2_sha256$216000$F9b5IaeWZZQj$GpU/oETpbNAr4cN7Fn4laOJhE4EWQz0MYAplmQR6oAY=	1100630228	\N	\N	2	1	\N	f	2021-02-22 11:29:23.429191+00	2021-02-22 11:29:23.411191+00	\N	\N	default_propic/default_propic.png	0	1	\N
26	pbkdf2_sha256$216000$7j2caN8YLUJc$JRnD2RNrKdSZuetygTf3Bptyt4s7A2l0v5SoBbY59jk=	1100630231	\N	\N	2	1	\N	f	2021-02-22 11:36:11.434195+00	2021-02-22 11:36:11.414936+00	\N	\N	default_propic/default_propic.png	0	1	\N
27	pbkdf2_sha256$216000$71Vl4TkYY42t$G7yDg86TGmdKwgPCpTwCiidtEw+VQTD6LjBUPOUr0lA=	1100630232	\N	\N	2	1	\N	f	2021-02-22 11:36:47.293537+00	2021-02-22 11:36:47.276123+00	\N	\N	default_propic/default_propic.png	0	1	\N
28	pbkdf2_sha256$216000$i7fdZQjuez3w$RcN7GYIn07wHBIglW4XKtdsI2+KcIQUmVT60EEMasHU=	mayou1100630	\N	\N	2	63	\N	f	2021-02-22 11:43:36.950758+00	2021-02-22 11:43:36.931787+00	\N	\N	default_propic/default_propic.png	0	1	\N
30	pbkdf2_sha256$216000$p8LpApDIJZbm$uTmNOWzo8UVPUFSG/+IKBl3cyYujznI4fqUP3gX4h0I=	1100630220	\N	\N	1	1	\N	f	2021-02-22 11:44:37.522175+00	2021-02-22 11:44:37.505716+00	\N	\N	default_propic/default_propic.png	0	1	\N
31	pbkdf2_sha256$216000$FfRGqBPAY7Lf$5+2id5h6+GYxF/qlFUyqZZcLhrlQpGClghTHtgfbUhI=	1200630220	\N	\N	1	33	\N	f	2021-02-22 11:46:06.359275+00	2021-02-22 11:46:06.334144+00	\N	\N	default_propic/default_propic.png	0	1	\N
32	pbkdf2_sha256$216000$Mb1hxrzxyMLP$Jsr584h/7eGeCd7MRy7no83H9cOi/+8RenPKIoLIUvg=	1200630000	\N	\N	3	1	\N	f	2021-02-22 11:51:04.734355+00	2021-02-22 11:51:04.717728+00	\N	\N	default_propic/default_propic.png	0	1	\N
35	pbkdf2_sha256$216000$ISR4DEKehi5M$OKzKvfMDoqX6omREshy5DU5vsJR9NVIxPVS36wRl4qY=	mcndu11111	\N	\N	3	1	\N	f	2021-03-08 10:32:39.579743+00	2021-03-08 10:32:39.561631+00	\N	\N	default_propic/default_propic.png	0	1	\N
36	pbkdf2_sha256$216000$mpVh8LL9ogLG$FSK+MthHfA8KKD7lWHYXqyph1zknA70Kz8x/m3K9XXU=	angel8200531	李珮妤	2	2	63	\N	f	2022-08-19 11:11:13.357331+00	2021-08-20 12:17:47.571272+00	2022-08-19 11:11:13.352424+00	\N	default_propic/default_propic.png	8400	8	i4gniur0azepsszo79h8nonx2h4vaqcn
37	pbkdf2_sha256$216000$rwQKwzsi3pi9$PsZ8Iympkh4IgItpCoZBsNbiJrmZoZ4iFF4HQCRZlZs=	1110630250	aaa	2	2	33	aaa	f	2021-10-21 11:25:59.319318+00	2021-10-21 10:57:31.318643+00	2021-10-21 11:25:31.688062+00	\N	default_propic/default_propic.png	0	1	\N
38	pbkdf2_sha256$216000$7PeurowAyQOS$XQ98Sreo9lPq+CL+AEa/vNgODiOc0agh/40gaMUdqp4=	1110630201	李維折	2	2	1	ddd@gmail.com	f	2022-03-27 00:19:57.204995+00	2022-03-12 22:30:08.062877+00	2022-03-27 00:19:43.721604+00	\N	default_propic/default_propic.png	50	1	\N
39	pbkdf2_sha256$216000$MgF5SqgKIlXx$wK0P7EiekqFbKNsZUAGucs4u/J3ohIXMjq7HYP1J1Uw=	1110630202	楊定鎮	2	2	1	ccc@gmail.com	f	2022-03-12 23:22:06.953064+00	2022-03-12 22:30:48.235255+00	2022-03-12 23:20:47.029509+00	\N	default_propic/default_propic.png	50	1	\N
40	pbkdf2_sha256$216000$SPFCOOFVIFw1$GQ382JZHg5Pe0iXcIhR3jz+8imhPYHiHqaXwmX6kh/s=	1110630203	王宏勳	2	2	1	bbb@gmail	f	2022-03-27 00:20:26.499251+00	2022-03-12 22:31:08.720968+00	2022-03-27 00:20:12.138522+00	\N	default_propic/default_propic.png	50	1	\N
41	pbkdf2_sha256$216000$qAsdOKBaYYuB$qTCofCew7FpNVSr1FIyDVGs4kC4l7IH8p8fF2ubs/Cc=	1110630205	王小明	1	2	1	aaa@gmail.com	f	2022-03-12 23:23:57.081037+00	2022-03-12 22:33:28.217078+00	2022-03-12 23:22:24.217881+00	\N	default_propic/default_propic.png	50	1	\N
\.


--
-- Data for Name: alcpt_userachievement; Type: TABLE DATA; Schema: alcpt; Owner: postgres
--

COPY alcpt.alcpt_userachievement (id, progress, unlock, registered_at, achievement_id, user_id) FROM stdin;
76	0	f	2020-12-29 14:10:28.561623+00	13	1
77	0	f	2020-12-29 14:10:28.564251+00	13	2
78	1	t	2020-12-29 14:10:28.566969+00	13	5
79	0	f	2020-12-29 14:10:28.56931+00	13	6
80	0	f	2020-12-29 14:10:28.5714+00	13	7
81	0	f	2020-12-29 14:10:28.573403+00	13	8
82	5	t	2020-12-29 14:10:28.575398+00	13	9
83	0	f	2020-12-29 14:10:28.577423+00	13	10
84	0	f	2020-12-29 14:11:07.102903+00	14	1
85	0	f	2020-12-29 14:11:07.105699+00	14	2
86	3	t	2020-12-29 14:11:07.109588+00	14	5
87	0	f	2020-12-29 14:11:07.112536+00	14	6
88	0	f	2020-12-29 14:11:07.115467+00	14	7
89	0	f	2020-12-29 14:11:07.117821+00	14	8
90	0	f	2020-12-29 14:11:07.119986+00	14	9
91	0	f	2020-12-29 14:11:07.122057+00	14	10
92	0	f	2020-12-29 14:11:32.702086+00	15	1
93	0	f	2020-12-29 14:11:32.707022+00	15	2
94	6	t	2020-12-29 14:11:32.712236+00	15	5
95	0	f	2020-12-29 14:11:32.716573+00	15	6
96	0	f	2020-12-29 14:11:32.719463+00	15	7
97	0	f	2020-12-29 14:11:32.722079+00	15	8
98	0	f	2020-12-29 14:11:32.724557+00	15	9
99	0	f	2020-12-29 14:11:32.726923+00	15	10
100	0	f	2020-12-29 14:12:01.533408+00	16	1
101	0	f	2020-12-29 14:12:01.536077+00	16	2
102	4	f	2020-12-29 14:12:01.538728+00	16	5
103	0	f	2020-12-29 14:12:01.542174+00	16	6
104	0	f	2020-12-29 14:12:01.545731+00	16	7
105	0	f	2020-12-29 14:12:01.548973+00	16	8
106	0	f	2020-12-29 14:12:01.552102+00	16	9
107	0	f	2020-12-29 14:12:01.55486+00	16	10
108	0	f	2020-12-29 14:12:33.821148+00	17	1
109	0	f	2020-12-29 14:12:33.82376+00	17	2
110	4	f	2020-12-29 14:12:33.826244+00	17	5
111	0	f	2020-12-29 14:12:33.828889+00	17	6
112	0	f	2020-12-29 14:12:33.83129+00	17	7
113	0	f	2020-12-29 14:12:33.833245+00	17	8
114	0	f	2020-12-29 14:12:33.835378+00	17	9
115	0	f	2020-12-29 14:12:33.837364+00	17	10
116	0	f	2020-12-29 14:51:25.107846+00	18	1
117	0	f	2020-12-29 14:51:25.110782+00	18	2
118	4	f	2020-12-29 14:51:25.113424+00	18	5
119	0	f	2020-12-29 14:51:25.115797+00	18	6
120	0	f	2020-12-29 14:51:25.118201+00	18	7
121	0	f	2020-12-29 14:51:25.12107+00	18	8
122	0	f	2020-12-29 14:51:25.123709+00	18	9
123	0	f	2020-12-29 14:51:25.126281+00	18	10
124	0	f	2020-12-29 14:52:03.747585+00	19	1
125	0	f	2020-12-29 14:52:03.750357+00	19	2
126	4	f	2020-12-29 14:52:03.753048+00	19	5
127	0	f	2020-12-29 14:52:03.755573+00	19	6
128	0	f	2020-12-29 14:52:03.758032+00	19	7
129	0	f	2020-12-29 14:52:03.760861+00	19	8
130	0	f	2020-12-29 14:52:03.763438+00	19	9
131	0	f	2020-12-29 14:52:03.76589+00	19	10
132	0	f	2020-12-29 14:54:51.66788+00	20	1
133	0	f	2020-12-29 14:54:51.670481+00	20	2
134	1	t	2020-12-29 14:54:51.673048+00	20	5
135	0	f	2020-12-29 14:54:51.676777+00	20	6
136	0	f	2020-12-29 14:54:51.680821+00	20	7
137	0	f	2020-12-29 14:54:51.684334+00	20	8
138	0	f	2020-12-29 14:54:51.687036+00	20	9
139	0	f	2020-12-29 14:54:51.689714+00	20	10
140	0	f	2020-12-29 14:56:59.184287+00	21	1
141	0	f	2020-12-29 14:56:59.186876+00	21	2
142	2	f	2020-12-29 14:56:59.189643+00	21	5
143	0	f	2020-12-29 14:56:59.192171+00	21	6
144	0	f	2020-12-29 14:56:59.194616+00	21	7
145	0	f	2020-12-29 14:56:59.197023+00	21	8
146	0	f	2020-12-29 14:56:59.199228+00	21	9
147	0	f	2020-12-29 14:56:59.201553+00	21	10
148	0	f	2020-12-29 14:57:31.875869+00	22	1
149	0	f	2020-12-29 14:57:31.878759+00	22	2
150	2	f	2020-12-29 14:57:31.881448+00	22	5
151	0	f	2020-12-29 14:57:31.884001+00	22	6
152	0	f	2020-12-29 14:57:31.886509+00	22	7
153	0	f	2020-12-29 14:57:31.888969+00	22	8
154	0	f	2020-12-29 14:57:31.891394+00	22	9
155	0	f	2020-12-29 14:57:31.893845+00	22	10
156	0	f	2020-12-29 14:58:04.075593+00	23	1
157	0	f	2020-12-29 14:58:04.078391+00	23	2
158	2	f	2020-12-29 14:58:04.081024+00	23	5
159	0	f	2020-12-29 14:58:04.08361+00	23	6
160	0	f	2020-12-29 14:58:04.086457+00	23	7
161	0	f	2020-12-29 14:58:04.08884+00	23	8
162	0	f	2020-12-29 14:58:04.091076+00	23	9
163	0	f	2020-12-29 14:58:04.093259+00	23	10
164	0	f	2020-12-29 14:58:41.952305+00	24	1
165	0	f	2020-12-29 14:58:41.955058+00	24	2
166	2	f	2020-12-29 14:58:41.957601+00	24	5
167	0	f	2020-12-29 14:58:41.960169+00	24	6
168	0	f	2020-12-29 14:58:41.962608+00	24	7
169	0	f	2020-12-29 14:58:41.964933+00	24	8
170	0	f	2020-12-29 14:58:41.967274+00	24	9
171	0	f	2020-12-29 14:58:41.969443+00	24	10
172	0	f	2020-12-29 15:00:40.560897+00	25	1
173	0	f	2020-12-29 15:00:40.563572+00	25	2
174	2	f	2020-12-29 15:00:40.566203+00	25	5
175	0	f	2020-12-29 15:00:40.568906+00	25	6
176	0	f	2020-12-29 15:00:40.571303+00	25	7
177	0	f	2020-12-29 15:00:40.57373+00	25	8
178	0	f	2020-12-29 15:00:40.57617+00	25	9
179	0	f	2020-12-29 15:00:40.578413+00	25	10
180	0	f	2020-12-29 15:01:08.788895+00	26	1
181	0	f	2020-12-29 15:01:08.791577+00	26	2
182	2	f	2020-12-29 15:01:08.794027+00	26	5
183	0	f	2020-12-29 15:01:08.796385+00	26	6
184	0	f	2020-12-29 15:01:08.79854+00	26	7
185	0	f	2020-12-29 15:01:08.800611+00	26	8
186	0	f	2020-12-29 15:01:08.802567+00	26	9
187	0	f	2020-12-29 15:01:08.80462+00	26	10
188	0	f	2020-12-29 15:03:20.009562+00	27	1
189	0	f	2020-12-29 15:03:20.014385+00	27	2
190	1	t	2020-12-29 15:03:20.01923+00	27	5
191	0	f	2020-12-29 15:03:20.024577+00	27	6
192	0	f	2020-12-29 15:03:20.029498+00	27	7
193	0	f	2020-12-29 15:03:20.034174+00	27	8
194	1	t	2020-12-29 15:03:20.03923+00	27	9
195	0	f	2020-12-29 15:03:20.044302+00	27	10
196	0	f	2020-12-29 15:03:42.472465+00	28	1
197	0	f	2020-12-29 15:03:42.475158+00	28	2
198	0	f	2020-12-29 15:03:42.477623+00	28	5
199	0	f	2020-12-29 15:03:42.480056+00	28	6
200	0	f	2020-12-29 15:03:42.482484+00	28	7
201	0	f	2020-12-29 15:03:42.484669+00	28	8
202	0	f	2020-12-29 15:03:42.486855+00	28	9
203	0	f	2020-12-29 15:03:42.489189+00	28	10
204	0	f	2020-12-29 15:04:25.819853+00	29	1
205	0	f	2020-12-29 15:04:25.822633+00	29	2
206	0	f	2020-12-29 15:04:25.825272+00	29	5
207	0	f	2020-12-29 15:04:25.827692+00	29	6
208	0	f	2020-12-29 15:04:25.83005+00	29	7
209	0	f	2020-12-29 15:04:25.832087+00	29	8
210	0	f	2020-12-29 15:04:25.834072+00	29	9
211	0	f	2020-12-29 15:04:25.836153+00	29	10
212	0	f	2020-12-29 15:04:53.427148+00	30	1
213	0	f	2020-12-29 15:04:53.429892+00	30	2
214	0	f	2020-12-29 15:04:53.432541+00	30	5
215	0	f	2020-12-29 15:04:53.434741+00	30	6
216	0	f	2020-12-29 15:04:53.436928+00	30	7
217	0	f	2020-12-29 15:04:53.4389+00	30	8
218	0	f	2020-12-29 15:04:53.441047+00	30	9
219	0	f	2020-12-29 15:04:53.442994+00	30	10
220	0	f	2020-12-29 15:05:30.035521+00	31	1
221	0	f	2020-12-29 15:05:30.038167+00	31	2
222	0	f	2020-12-29 15:05:30.040711+00	31	5
223	0	f	2020-12-29 15:05:30.043108+00	31	6
224	0	f	2020-12-29 15:05:30.045398+00	31	7
225	0	f	2020-12-29 15:05:30.04753+00	31	8
226	0	f	2020-12-29 15:05:30.049543+00	31	9
227	0	f	2020-12-29 15:05:30.051519+00	31	10
228	0	f	2020-12-29 15:06:29.038401+00	32	1
229	0	f	2020-12-29 15:06:29.040947+00	32	2
230	0	f	2020-12-29 15:06:29.043611+00	32	5
231	0	f	2020-12-29 15:06:29.046081+00	32	6
232	0	f	2020-12-29 15:06:29.049215+00	32	7
233	0	f	2020-12-29 15:06:29.051383+00	32	8
234	0	f	2020-12-29 15:06:29.053519+00	32	9
235	0	f	2020-12-29 15:06:29.055494+00	32	10
236	0	f	2020-12-29 15:06:57.545198+00	33	1
237	0	f	2020-12-29 15:06:57.54775+00	33	2
238	0	f	2020-12-29 15:06:57.550154+00	33	5
239	0	f	2020-12-29 15:06:57.55251+00	33	6
240	0	f	2020-12-29 15:06:57.554726+00	33	7
241	0	f	2020-12-29 15:06:57.556717+00	33	8
242	0	f	2020-12-29 15:06:57.558696+00	33	9
243	0	f	2020-12-29 15:06:57.560696+00	33	10
244	0	f	2020-12-29 15:13:41.223098+00	34	1
245	0	f	2020-12-29 15:13:41.228394+00	34	2
246	1	t	2020-12-29 15:13:41.233614+00	34	5
247	0	f	2020-12-29 15:13:41.239094+00	34	6
248	0	f	2020-12-29 15:13:41.243744+00	34	7
249	0	f	2020-12-29 15:13:41.249232+00	34	8
250	1	t	2020-12-29 15:13:41.254219+00	34	9
251	0	f	2020-12-29 15:13:41.259428+00	34	10
252	0	f	2020-12-29 15:14:15.004859+00	35	1
253	0	f	2020-12-29 15:14:15.007622+00	35	2
254	3	t	2020-12-29 15:14:15.010322+00	35	5
255	0	f	2020-12-29 15:14:15.012837+00	35	6
256	0	f	2020-12-29 15:14:15.015347+00	35	7
257	0	f	2020-12-29 15:14:15.01758+00	35	8
258	0	f	2020-12-29 15:14:15.019787+00	35	9
259	0	f	2020-12-29 15:14:15.021939+00	35	10
260	0	f	2020-12-29 15:15:05.567534+00	36	1
261	0	f	2020-12-29 15:15:05.570635+00	36	2
262	4	f	2020-12-29 15:15:05.573458+00	36	5
263	0	f	2020-12-29 15:15:05.576228+00	36	6
264	0	f	2020-12-29 15:15:05.578939+00	36	7
265	0	f	2020-12-29 15:15:05.581544+00	36	8
266	0	f	2020-12-29 15:15:05.584364+00	36	9
267	0	f	2020-12-29 15:15:05.587061+00	36	10
268	0	f	2020-12-29 15:16:25.167052+00	37	1
269	0	f	2020-12-29 15:16:25.169699+00	37	2
270	1	t	2020-12-29 15:16:25.172308+00	37	5
271	0	f	2020-12-29 15:16:25.174888+00	37	6
272	0	f	2020-12-29 15:16:25.17757+00	37	7
273	0	f	2020-12-29 15:16:25.179971+00	37	8
274	0	f	2020-12-29 15:16:25.182236+00	37	9
275	0	f	2020-12-29 15:16:25.184475+00	37	10
276	0	f	2020-12-29 15:17:03.585471+00	38	1
277	0	f	2020-12-29 15:17:03.588055+00	38	2
278	2	f	2020-12-29 15:17:03.590759+00	38	5
279	0	f	2020-12-29 15:17:03.593162+00	38	6
280	0	f	2020-12-29 15:17:03.59561+00	38	7
281	0	f	2020-12-29 15:17:03.597857+00	38	8
282	0	f	2020-12-29 15:17:03.599866+00	38	9
283	0	f	2020-12-29 15:17:03.601907+00	38	10
284	0	f	2020-12-29 15:17:30.13422+00	39	1
285	0	f	2020-12-29 15:17:30.136836+00	39	2
286	2	f	2020-12-29 15:17:30.139285+00	39	5
287	0	f	2020-12-29 15:17:30.141692+00	39	6
288	0	f	2020-12-29 15:17:30.143893+00	39	7
289	0	f	2020-12-29 15:17:30.146256+00	39	8
290	0	f	2020-12-29 15:17:30.1486+00	39	9
291	0	f	2020-12-29 15:17:30.150547+00	39	10
292	0	f	2020-12-29 15:18:30.932398+00	40	1
293	0	f	2020-12-29 15:18:30.934989+00	40	2
294	1	t	2020-12-29 15:18:30.93865+00	40	5
295	0	f	2020-12-29 15:18:30.941298+00	40	6
296	0	f	2020-12-29 15:18:30.943843+00	40	7
297	0	f	2020-12-29 15:18:30.946197+00	40	8
298	1	t	2020-12-29 15:18:30.948556+00	40	9
299	0	f	2020-12-29 15:18:30.950782+00	40	10
300	0	f	2020-12-29 15:19:09.035036+00	41	1
301	0	f	2020-12-29 15:19:09.037632+00	41	2
302	0	f	2020-12-29 15:19:09.040532+00	41	5
303	0	f	2020-12-29 15:19:09.043043+00	41	6
304	0	f	2020-12-29 15:19:09.045367+00	41	7
305	0	f	2020-12-29 15:19:09.047587+00	41	8
306	0	f	2020-12-29 15:19:09.049983+00	41	9
307	0	f	2020-12-29 15:19:09.052254+00	41	10
308	0	f	2020-12-29 15:19:31.489135+00	42	1
309	0	f	2020-12-29 15:19:31.491901+00	42	2
310	0	f	2020-12-29 15:19:31.494573+00	42	5
311	0	f	2020-12-29 15:19:31.497284+00	42	6
312	0	f	2020-12-29 15:19:31.499555+00	42	7
313	0	f	2020-12-29 15:19:31.501676+00	42	8
314	0	f	2020-12-29 15:19:31.503695+00	42	9
315	0	f	2020-12-29 15:19:31.506009+00	42	10
316	0	f	2021-01-25 11:30:59.922455+00	13	19
317	0	f	2021-01-25 11:30:59.922481+00	14	19
318	0	f	2021-01-25 11:30:59.922496+00	15	19
319	0	f	2021-01-25 11:30:59.92251+00	16	19
320	0	f	2021-01-25 11:30:59.922524+00	17	19
321	0	f	2021-01-25 11:30:59.922537+00	18	19
322	0	f	2021-01-25 11:30:59.922551+00	19	19
323	0	f	2021-01-25 11:30:59.925051+00	20	19
324	0	f	2021-01-25 11:30:59.925072+00	21	19
325	0	f	2021-01-25 11:30:59.925088+00	22	19
326	0	f	2021-01-25 11:30:59.925102+00	23	19
327	0	f	2021-01-25 11:30:59.925116+00	24	19
328	0	f	2021-01-25 11:30:59.925129+00	25	19
329	0	f	2021-01-25 11:30:59.925143+00	26	19
330	1	t	2021-01-25 11:30:59.927453+00	27	19
331	0	f	2021-01-25 11:30:59.927474+00	28	19
332	0	f	2021-01-25 11:30:59.927489+00	29	19
333	0	f	2021-01-25 11:30:59.927503+00	30	19
334	0	f	2021-01-25 11:30:59.927517+00	31	19
335	0	f	2021-01-25 11:30:59.927531+00	32	19
336	0	f	2021-01-25 11:30:59.927545+00	33	19
337	0	f	2021-01-25 11:30:59.929915+00	34	19
338	0	f	2021-01-25 11:30:59.929936+00	35	19
339	0	f	2021-01-25 11:30:59.929952+00	36	19
340	0	f	2021-01-25 11:30:59.931918+00	37	19
341	0	f	2021-01-25 11:30:59.931939+00	38	19
342	0	f	2021-01-25 11:30:59.931954+00	39	19
343	0	f	2021-01-25 11:30:59.93396+00	40	19
344	0	f	2021-01-25 11:30:59.933981+00	41	19
345	0	f	2021-01-25 11:30:59.933996+00	42	19
346	0	f	2021-02-22 10:50:09.634051+00	13	20
347	0	f	2021-02-22 10:50:09.634076+00	14	20
348	0	f	2021-02-22 10:50:09.634092+00	15	20
349	0	f	2021-02-22 10:50:09.634107+00	16	20
350	0	f	2021-02-22 10:50:09.634121+00	17	20
351	0	f	2021-02-22 10:50:09.634136+00	18	20
352	0	f	2021-02-22 10:50:09.63415+00	19	20
353	0	f	2021-02-22 10:50:09.637286+00	20	20
354	0	f	2021-02-22 10:50:09.637308+00	21	20
355	0	f	2021-02-22 10:50:09.637325+00	22	20
356	0	f	2021-02-22 10:50:09.63734+00	23	20
357	0	f	2021-02-22 10:50:09.637355+00	24	20
358	0	f	2021-02-22 10:50:09.637369+00	25	20
359	0	f	2021-02-22 10:50:09.637384+00	26	20
360	0	f	2021-02-22 10:50:09.639901+00	27	20
361	0	f	2021-02-22 10:50:09.639923+00	28	20
362	0	f	2021-02-22 10:50:09.639939+00	29	20
363	0	f	2021-02-22 10:50:09.639954+00	30	20
364	0	f	2021-02-22 10:50:09.639969+00	31	20
365	0	f	2021-02-22 10:50:09.639983+00	32	20
366	0	f	2021-02-22 10:50:09.639997+00	33	20
367	0	f	2021-02-22 10:50:09.642204+00	34	20
368	0	f	2021-02-22 10:50:09.642226+00	35	20
369	0	f	2021-02-22 10:50:09.642243+00	36	20
370	0	f	2021-02-22 10:50:09.64416+00	37	20
371	0	f	2021-02-22 10:50:09.644182+00	38	20
372	0	f	2021-02-22 10:50:09.644198+00	39	20
373	0	f	2021-02-22 10:50:09.646194+00	40	20
374	0	f	2021-02-22 10:50:09.646216+00	41	20
375	0	f	2021-02-22 10:50:09.646232+00	42	20
376	0	f	2021-02-22 10:51:14.100307+00	13	22
377	0	f	2021-02-22 10:51:14.100336+00	14	22
378	0	f	2021-02-22 10:51:14.100352+00	15	22
379	0	f	2021-02-22 10:51:14.100367+00	16	22
380	0	f	2021-02-22 10:51:14.100382+00	17	22
381	0	f	2021-02-22 10:51:14.100397+00	18	22
382	0	f	2021-02-22 10:51:14.100412+00	19	22
383	0	f	2021-02-22 10:51:14.104452+00	20	22
384	0	f	2021-02-22 10:51:14.10448+00	21	22
385	0	f	2021-02-22 10:51:14.104496+00	22	22
386	0	f	2021-02-22 10:51:14.104511+00	23	22
387	0	f	2021-02-22 10:51:14.104525+00	24	22
388	0	f	2021-02-22 10:51:14.10454+00	25	22
389	0	f	2021-02-22 10:51:14.104554+00	26	22
390	0	f	2021-02-22 10:51:14.106993+00	27	22
391	0	f	2021-02-22 10:51:14.107017+00	28	22
392	0	f	2021-02-22 10:51:14.107033+00	29	22
393	0	f	2021-02-22 10:51:14.107047+00	30	22
394	0	f	2021-02-22 10:51:14.107061+00	31	22
395	0	f	2021-02-22 10:51:14.107075+00	32	22
396	0	f	2021-02-22 10:51:14.107089+00	33	22
397	0	f	2021-02-22 10:51:14.109243+00	34	22
398	0	f	2021-02-22 10:51:14.109265+00	35	22
399	0	f	2021-02-22 10:51:14.109281+00	36	22
400	0	f	2021-02-22 10:51:14.11145+00	37	22
401	0	f	2021-02-22 10:51:14.111473+00	38	22
402	0	f	2021-02-22 10:51:14.111488+00	39	22
403	0	f	2021-02-22 10:51:14.113469+00	40	22
404	0	f	2021-02-22 10:51:14.113491+00	41	22
405	0	f	2021-02-22 10:51:14.113507+00	42	22
406	0	f	2021-02-22 11:28:11.54579+00	13	23
407	0	f	2021-02-22 11:28:11.545812+00	14	23
408	0	f	2021-02-22 11:28:11.545828+00	15	23
409	0	f	2021-02-22 11:28:11.545842+00	16	23
410	0	f	2021-02-22 11:28:11.545856+00	17	23
411	0	f	2021-02-22 11:28:11.54587+00	18	23
412	0	f	2021-02-22 11:28:11.545884+00	19	23
413	0	f	2021-02-22 11:28:11.548451+00	20	23
414	0	f	2021-02-22 11:28:11.548472+00	21	23
415	0	f	2021-02-22 11:28:11.548487+00	22	23
416	0	f	2021-02-22 11:28:11.548502+00	23	23
417	0	f	2021-02-22 11:28:11.548516+00	24	23
418	0	f	2021-02-22 11:28:11.54853+00	25	23
419	0	f	2021-02-22 11:28:11.548544+00	26	23
420	0	f	2021-02-22 11:28:11.551304+00	27	23
421	0	f	2021-02-22 11:28:11.551327+00	28	23
422	0	f	2021-02-22 11:28:11.551343+00	29	23
423	0	f	2021-02-22 11:28:11.551357+00	30	23
424	0	f	2021-02-22 11:28:11.551371+00	31	23
425	0	f	2021-02-22 11:28:11.551384+00	32	23
426	0	f	2021-02-22 11:28:11.551398+00	33	23
427	0	f	2021-02-22 11:28:11.554401+00	34	23
428	0	f	2021-02-22 11:28:11.554424+00	35	23
429	0	f	2021-02-22 11:28:11.55444+00	36	23
430	0	f	2021-02-22 11:28:11.556476+00	37	23
431	0	f	2021-02-22 11:28:11.556499+00	38	23
432	0	f	2021-02-22 11:28:11.556514+00	39	23
433	0	f	2021-02-22 11:28:11.55852+00	40	23
434	0	f	2021-02-22 11:28:11.558541+00	41	23
435	0	f	2021-02-22 11:28:11.558557+00	42	23
436	0	f	2021-02-22 11:29:23.414646+00	13	25
437	0	f	2021-02-22 11:29:23.414675+00	14	25
438	0	f	2021-02-22 11:29:23.41469+00	15	25
439	0	f	2021-02-22 11:29:23.414704+00	16	25
440	0	f	2021-02-22 11:29:23.414718+00	17	25
441	0	f	2021-02-22 11:29:23.414732+00	18	25
442	0	f	2021-02-22 11:29:23.414746+00	19	25
443	0	f	2021-02-22 11:29:23.417489+00	20	25
444	0	f	2021-02-22 11:29:23.417512+00	21	25
445	0	f	2021-02-22 11:29:23.417527+00	22	25
446	0	f	2021-02-22 11:29:23.417542+00	23	25
447	0	f	2021-02-22 11:29:23.417555+00	24	25
448	0	f	2021-02-22 11:29:23.41757+00	25	25
449	0	f	2021-02-22 11:29:23.417583+00	26	25
450	0	f	2021-02-22 11:29:23.420126+00	27	25
451	0	f	2021-02-22 11:29:23.420148+00	28	25
452	0	f	2021-02-22 11:29:23.420164+00	29	25
453	0	f	2021-02-22 11:29:23.420178+00	30	25
454	0	f	2021-02-22 11:29:23.420192+00	31	25
455	0	f	2021-02-22 11:29:23.420206+00	32	25
456	0	f	2021-02-22 11:29:23.42022+00	33	25
457	0	f	2021-02-22 11:29:23.422532+00	34	25
458	0	f	2021-02-22 11:29:23.422555+00	35	25
459	0	f	2021-02-22 11:29:23.42257+00	36	25
460	0	f	2021-02-22 11:29:23.424537+00	37	25
461	0	f	2021-02-22 11:29:23.424559+00	38	25
462	0	f	2021-02-22 11:29:23.424575+00	39	25
463	0	f	2021-02-22 11:29:23.426571+00	40	25
464	0	f	2021-02-22 11:29:23.426592+00	41	25
465	0	f	2021-02-22 11:29:23.426608+00	42	25
466	0	f	2021-02-22 11:36:11.418762+00	13	26
467	0	f	2021-02-22 11:36:11.41879+00	14	26
468	0	f	2021-02-22 11:36:11.418806+00	15	26
469	0	f	2021-02-22 11:36:11.418821+00	16	26
470	0	f	2021-02-22 11:36:11.418836+00	17	26
471	0	f	2021-02-22 11:36:11.41885+00	18	26
472	0	f	2021-02-22 11:36:11.418864+00	19	26
473	0	f	2021-02-22 11:36:11.421708+00	20	26
474	0	f	2021-02-22 11:36:11.421732+00	21	26
475	0	f	2021-02-22 11:36:11.421749+00	22	26
476	0	f	2021-02-22 11:36:11.421764+00	23	26
477	0	f	2021-02-22 11:36:11.421778+00	24	26
478	0	f	2021-02-22 11:36:11.421793+00	25	26
479	0	f	2021-02-22 11:36:11.421808+00	26	26
480	0	f	2021-02-22 11:36:11.424408+00	27	26
481	0	f	2021-02-22 11:36:11.424432+00	28	26
482	0	f	2021-02-22 11:36:11.424448+00	29	26
483	0	f	2021-02-22 11:36:11.424463+00	30	26
484	0	f	2021-02-22 11:36:11.424478+00	31	26
485	0	f	2021-02-22 11:36:11.424493+00	32	26
486	0	f	2021-02-22 11:36:11.424508+00	33	26
487	0	f	2021-02-22 11:36:11.426825+00	34	26
488	0	f	2021-02-22 11:36:11.426847+00	35	26
489	0	f	2021-02-22 11:36:11.426863+00	36	26
490	0	f	2021-02-22 11:36:11.429264+00	37	26
491	0	f	2021-02-22 11:36:11.429289+00	38	26
492	0	f	2021-02-22 11:36:11.429305+00	39	26
493	0	f	2021-02-22 11:36:11.431388+00	40	26
494	0	f	2021-02-22 11:36:11.431412+00	41	26
495	0	f	2021-02-22 11:36:11.431428+00	42	26
496	0	f	2021-02-22 11:36:47.279178+00	13	27
497	0	f	2021-02-22 11:36:47.279202+00	14	27
498	0	f	2021-02-22 11:36:47.279218+00	15	27
499	0	f	2021-02-22 11:36:47.279232+00	16	27
500	0	f	2021-02-22 11:36:47.279246+00	17	27
501	0	f	2021-02-22 11:36:47.279259+00	18	27
502	0	f	2021-02-22 11:36:47.279273+00	19	27
503	0	f	2021-02-22 11:36:47.282311+00	20	27
504	0	f	2021-02-22 11:36:47.282336+00	21	27
505	0	f	2021-02-22 11:36:47.282352+00	22	27
506	0	f	2021-02-22 11:36:47.282366+00	23	27
507	0	f	2021-02-22 11:36:47.28238+00	24	27
508	0	f	2021-02-22 11:36:47.282395+00	25	27
509	0	f	2021-02-22 11:36:47.282409+00	26	27
510	0	f	2021-02-22 11:36:47.285145+00	27	27
511	0	f	2021-02-22 11:36:47.285169+00	28	27
512	0	f	2021-02-22 11:36:47.285185+00	29	27
513	0	f	2021-02-22 11:36:47.285199+00	30	27
514	0	f	2021-02-22 11:36:47.285214+00	31	27
515	0	f	2021-02-22 11:36:47.285228+00	32	27
516	0	f	2021-02-22 11:36:47.285242+00	33	27
517	0	f	2021-02-22 11:36:47.287605+00	34	27
518	0	f	2021-02-22 11:36:47.287627+00	35	27
519	0	f	2021-02-22 11:36:47.287643+00	36	27
520	0	f	2021-02-22 11:36:47.289625+00	37	27
521	0	f	2021-02-22 11:36:47.289648+00	38	27
522	0	f	2021-02-22 11:36:47.289664+00	39	27
523	0	f	2021-02-22 11:36:47.291751+00	40	27
524	0	f	2021-02-22 11:36:47.291774+00	41	27
525	0	f	2021-02-22 11:36:47.291789+00	42	27
526	0	f	2021-02-22 11:43:36.935759+00	13	28
527	0	f	2021-02-22 11:43:36.935787+00	14	28
528	0	f	2021-02-22 11:43:36.935804+00	15	28
529	0	f	2021-02-22 11:43:36.935819+00	16	28
530	0	f	2021-02-22 11:43:36.935833+00	17	28
531	0	f	2021-02-22 11:43:36.935848+00	18	28
532	0	f	2021-02-22 11:43:36.935862+00	19	28
533	0	f	2021-02-22 11:43:36.938603+00	20	28
534	0	f	2021-02-22 11:43:36.938626+00	21	28
535	0	f	2021-02-22 11:43:36.938643+00	22	28
536	0	f	2021-02-22 11:43:36.938658+00	23	28
537	0	f	2021-02-22 11:43:36.938673+00	24	28
538	0	f	2021-02-22 11:43:36.938688+00	25	28
539	0	f	2021-02-22 11:43:36.938703+00	26	28
540	0	f	2021-02-22 11:43:36.941397+00	27	28
541	0	f	2021-02-22 11:43:36.94142+00	28	28
542	0	f	2021-02-22 11:43:36.941437+00	29	28
543	0	f	2021-02-22 11:43:36.941452+00	30	28
544	0	f	2021-02-22 11:43:36.941468+00	31	28
545	0	f	2021-02-22 11:43:36.941483+00	32	28
546	0	f	2021-02-22 11:43:36.941498+00	33	28
547	0	f	2021-02-22 11:43:36.943863+00	34	28
548	0	f	2021-02-22 11:43:36.943886+00	35	28
549	0	f	2021-02-22 11:43:36.943904+00	36	28
550	0	f	2021-02-22 11:43:36.945935+00	37	28
551	0	f	2021-02-22 11:43:36.945957+00	38	28
552	0	f	2021-02-22 11:43:36.945973+00	39	28
553	0	f	2021-02-22 11:43:36.94809+00	40	28
554	0	f	2021-02-22 11:43:36.948111+00	41	28
555	0	f	2021-02-22 11:43:36.948127+00	42	28
556	0	f	2021-02-22 11:44:37.50855+00	13	30
557	0	f	2021-02-22 11:44:37.508574+00	14	30
558	0	f	2021-02-22 11:44:37.50859+00	15	30
559	0	f	2021-02-22 11:44:37.508604+00	16	30
560	0	f	2021-02-22 11:44:37.508619+00	17	30
561	0	f	2021-02-22 11:44:37.508633+00	18	30
562	0	f	2021-02-22 11:44:37.508651+00	19	30
563	0	f	2021-02-22 11:44:37.511492+00	20	30
564	0	f	2021-02-22 11:44:37.511514+00	21	30
565	0	f	2021-02-22 11:44:37.511529+00	22	30
566	0	f	2021-02-22 11:44:37.511544+00	23	30
567	0	f	2021-02-22 11:44:37.511558+00	24	30
568	0	f	2021-02-22 11:44:37.511572+00	25	30
569	0	f	2021-02-22 11:44:37.511586+00	26	30
570	0	f	2021-02-22 11:44:37.514047+00	27	30
571	0	f	2021-02-22 11:44:37.514069+00	28	30
572	0	f	2021-02-22 11:44:37.514084+00	29	30
573	0	f	2021-02-22 11:44:37.514099+00	30	30
574	0	f	2021-02-22 11:44:37.514113+00	31	30
575	0	f	2021-02-22 11:44:37.514127+00	32	30
576	0	f	2021-02-22 11:44:37.514142+00	33	30
577	0	f	2021-02-22 11:44:37.516443+00	34	30
578	0	f	2021-02-22 11:44:37.516464+00	35	30
579	0	f	2021-02-22 11:44:37.516481+00	36	30
580	0	f	2021-02-22 11:44:37.518977+00	37	30
581	0	f	2021-02-22 11:44:37.519009+00	38	30
582	0	f	2021-02-22 11:44:37.519027+00	39	30
583	0	f	2021-02-22 11:44:37.521277+00	40	30
584	0	f	2021-02-22 11:44:37.521299+00	41	30
585	0	f	2021-02-22 11:44:37.521315+00	42	30
586	0	f	2021-02-22 11:46:06.341795+00	13	31
587	0	f	2021-02-22 11:46:06.341825+00	14	31
588	0	f	2021-02-22 11:46:06.341843+00	15	31
589	0	f	2021-02-22 11:46:06.34186+00	16	31
590	0	f	2021-02-22 11:46:06.341876+00	17	31
591	0	f	2021-02-22 11:46:06.341892+00	18	31
592	0	f	2021-02-22 11:46:06.341908+00	19	31
593	0	f	2021-02-22 11:46:06.347374+00	20	31
594	0	f	2021-02-22 11:46:06.347405+00	21	31
595	0	f	2021-02-22 11:46:06.347423+00	22	31
596	0	f	2021-02-22 11:46:06.347439+00	23	31
597	0	f	2021-02-22 11:46:06.347455+00	24	31
598	0	f	2021-02-22 11:46:06.347475+00	25	31
599	0	f	2021-02-22 11:46:06.347492+00	26	31
600	0	f	2021-02-22 11:46:06.35037+00	27	31
601	0	f	2021-02-22 11:46:06.350395+00	28	31
602	0	f	2021-02-22 11:46:06.350414+00	29	31
603	0	f	2021-02-22 11:46:06.350431+00	30	31
604	0	f	2021-02-22 11:46:06.350448+00	31	31
605	0	f	2021-02-22 11:46:06.350464+00	32	31
606	0	f	2021-02-22 11:46:06.35048+00	33	31
607	0	f	2021-02-22 11:46:06.353471+00	34	31
608	0	f	2021-02-22 11:46:06.353497+00	35	31
609	0	f	2021-02-22 11:46:06.353514+00	36	31
610	0	f	2021-02-22 11:46:06.356046+00	37	31
611	0	f	2021-02-22 11:46:06.356071+00	38	31
612	0	f	2021-02-22 11:46:06.35609+00	39	31
613	0	f	2021-02-22 11:46:06.358357+00	40	31
614	0	f	2021-02-22 11:46:06.35838+00	41	31
615	0	f	2021-02-22 11:46:06.358398+00	42	31
616	0	f	2021-02-22 11:51:04.721093+00	13	32
617	0	f	2021-02-22 11:51:04.721121+00	14	32
618	0	f	2021-02-22 11:51:04.721136+00	15	32
619	0	f	2021-02-22 11:51:04.721151+00	16	32
620	0	f	2021-02-22 11:51:04.721166+00	17	32
621	0	f	2021-02-22 11:51:04.72118+00	18	32
622	0	f	2021-02-22 11:51:04.721194+00	19	32
623	0	f	2021-02-22 11:51:04.723918+00	20	32
624	0	f	2021-02-22 11:51:04.723939+00	21	32
625	0	f	2021-02-22 11:51:04.723955+00	22	32
626	0	f	2021-02-22 11:51:04.723969+00	23	32
627	0	f	2021-02-22 11:51:04.723984+00	24	32
628	0	f	2021-02-22 11:51:04.723998+00	25	32
629	0	f	2021-02-22 11:51:04.724012+00	26	32
630	0	f	2021-02-22 11:51:04.726703+00	27	32
631	0	f	2021-02-22 11:51:04.726725+00	28	32
632	0	f	2021-02-22 11:51:04.726741+00	29	32
633	0	f	2021-02-22 11:51:04.726756+00	30	32
634	0	f	2021-02-22 11:51:04.72677+00	31	32
635	0	f	2021-02-22 11:51:04.726785+00	32	32
636	0	f	2021-02-22 11:51:04.726799+00	33	32
637	0	f	2021-02-22 11:51:04.729099+00	34	32
638	0	f	2021-02-22 11:51:04.729121+00	35	32
639	0	f	2021-02-22 11:51:04.729137+00	36	32
640	0	f	2021-02-22 11:51:04.731191+00	37	32
641	0	f	2021-02-22 11:51:04.731212+00	38	32
642	0	f	2021-02-22 11:51:04.731228+00	39	32
643	0	f	2021-02-22 11:51:04.733416+00	40	32
644	0	f	2021-02-22 11:51:04.733441+00	41	32
645	0	f	2021-02-22 11:51:04.733457+00	42	32
646	0	f	2021-03-08 10:32:39.565055+00	13	35
647	0	f	2021-03-08 10:32:39.565083+00	14	35
648	0	f	2021-03-08 10:32:39.565099+00	15	35
649	0	f	2021-03-08 10:32:39.565114+00	16	35
650	0	f	2021-03-08 10:32:39.565128+00	17	35
651	0	f	2021-03-08 10:32:39.565142+00	18	35
652	0	f	2021-03-08 10:32:39.565156+00	19	35
653	0	f	2021-03-08 10:32:39.568066+00	20	35
654	0	f	2021-03-08 10:32:39.568088+00	21	35
655	0	f	2021-03-08 10:32:39.568103+00	22	35
656	0	f	2021-03-08 10:32:39.568118+00	23	35
657	0	f	2021-03-08 10:32:39.568131+00	24	35
658	0	f	2021-03-08 10:32:39.568145+00	25	35
659	0	f	2021-03-08 10:32:39.568159+00	26	35
660	0	f	2021-03-08 10:32:39.571088+00	27	35
661	0	f	2021-03-08 10:32:39.571112+00	28	35
662	0	f	2021-03-08 10:32:39.571127+00	29	35
663	0	f	2021-03-08 10:32:39.571158+00	30	35
664	0	f	2021-03-08 10:32:39.571173+00	31	35
665	0	f	2021-03-08 10:32:39.571187+00	32	35
666	0	f	2021-03-08 10:32:39.571201+00	33	35
667	0	f	2021-03-08 10:32:39.573675+00	34	35
668	0	f	2021-03-08 10:32:39.573698+00	35	35
669	0	f	2021-03-08 10:32:39.573715+00	36	35
670	0	f	2021-03-08 10:32:39.575887+00	37	35
671	0	f	2021-03-08 10:32:39.57591+00	38	35
672	0	f	2021-03-08 10:32:39.575927+00	39	35
673	0	f	2021-03-08 10:32:39.578734+00	40	35
674	0	f	2021-03-08 10:32:39.578757+00	41	35
675	0	f	2021-03-08 10:32:39.578774+00	42	35
676	1	t	2021-08-20 12:17:47.583722+00	13	36
677	3	t	2021-08-20 12:17:47.583742+00	14	36
678	5	t	2021-08-20 12:17:47.583749+00	15	36
679	7	t	2021-08-20 12:17:47.583755+00	16	36
680	9	t	2021-08-20 12:17:47.583761+00	17	36
681	12	t	2021-08-20 12:17:47.583767+00	18	36
682	15	t	2021-08-20 12:17:47.583773+00	19	36
683	1	t	2021-08-20 12:17:47.589267+00	20	36
684	3	f	2021-08-20 12:17:47.589286+00	21	36
685	3	f	2021-08-20 12:17:47.589294+00	22	36
686	3	f	2021-08-20 12:17:47.5893+00	23	36
687	3	f	2021-08-20 12:17:47.589306+00	24	36
688	3	f	2021-08-20 12:17:47.589312+00	25	36
689	3	f	2021-08-20 12:17:47.589319+00	26	36
690	1	t	2021-08-20 12:17:47.590843+00	27	36
691	5	t	2021-08-20 12:17:47.590854+00	28	36
692	10	t	2021-08-20 12:17:47.59086+00	29	36
693	0	f	2021-08-20 12:17:47.590867+00	30	36
694	0	f	2021-08-20 12:17:47.590873+00	31	36
695	0	f	2021-08-20 12:17:47.590879+00	32	36
696	0	f	2021-08-20 12:17:47.590886+00	33	36
697	1	t	2021-08-20 12:17:47.592262+00	34	36
698	2	f	2021-08-20 12:17:47.592273+00	35	36
699	2	f	2021-08-20 12:17:47.59228+00	36	36
700	1	t	2021-08-20 12:17:47.59389+00	37	36
701	3	t	2021-08-20 12:17:47.593914+00	38	36
702	2	f	2021-08-20 12:17:47.593921+00	39	36
703	1	t	2021-08-20 12:17:47.59663+00	40	36
704	3	t	2021-08-20 12:17:47.596652+00	41	36
705	4	f	2021-08-20 12:17:47.596659+00	42	36
706	0	f	2021-10-21 10:57:31.331558+00	13	37
707	0	f	2021-10-21 10:57:31.331585+00	14	37
708	0	f	2021-10-21 10:57:31.331593+00	15	37
709	0	f	2021-10-21 10:57:31.331601+00	16	37
710	0	f	2021-10-21 10:57:31.331609+00	17	37
711	0	f	2021-10-21 10:57:31.331617+00	18	37
712	0	f	2021-10-21 10:57:31.331624+00	19	37
713	0	f	2021-10-21 10:57:31.335864+00	20	37
714	0	f	2021-10-21 10:57:31.335882+00	21	37
715	0	f	2021-10-21 10:57:31.335891+00	22	37
716	0	f	2021-10-21 10:57:31.335899+00	23	37
717	0	f	2021-10-21 10:57:31.335906+00	24	37
718	0	f	2021-10-21 10:57:31.335914+00	25	37
719	0	f	2021-10-21 10:57:31.335922+00	26	37
720	0	f	2021-10-21 10:57:31.338038+00	27	37
721	0	f	2021-10-21 10:57:31.338051+00	28	37
722	0	f	2021-10-21 10:57:31.33806+00	29	37
723	0	f	2021-10-21 10:57:31.338068+00	30	37
724	0	f	2021-10-21 10:57:31.338075+00	31	37
725	0	f	2021-10-21 10:57:31.338083+00	32	37
726	0	f	2021-10-21 10:57:31.33809+00	33	37
727	0	f	2021-10-21 10:57:31.339962+00	34	37
728	0	f	2021-10-21 10:57:31.339974+00	35	37
729	0	f	2021-10-21 10:57:31.339982+00	36	37
730	0	f	2021-10-21 10:57:31.341587+00	37	37
731	0	f	2021-10-21 10:57:31.341599+00	38	37
732	0	f	2021-10-21 10:57:31.341607+00	39	37
733	0	f	2021-10-21 10:57:31.348303+00	40	37
734	0	f	2021-10-21 10:57:31.348329+00	41	37
735	0	f	2021-10-21 10:57:31.348338+00	42	37
736	1	t	2022-03-12 22:30:08.092366+00	13	38
737	0	f	2022-03-12 22:30:08.092397+00	14	38
738	0	f	2022-03-12 22:30:08.092405+00	15	38
739	0	f	2022-03-12 22:30:08.092413+00	16	38
740	0	f	2022-03-12 22:30:08.092522+00	17	38
741	0	f	2022-03-12 22:30:08.092532+00	18	38
742	0	f	2022-03-12 22:30:08.09254+00	19	38
743	0	f	2022-03-12 22:30:08.101966+00	20	38
744	0	f	2022-03-12 22:30:08.101987+00	21	38
745	0	f	2022-03-12 22:30:08.101995+00	22	38
746	0	f	2022-03-12 22:30:08.102003+00	23	38
747	0	f	2022-03-12 22:30:08.102011+00	24	38
748	0	f	2022-03-12 22:30:08.102018+00	25	38
749	0	f	2022-03-12 22:30:08.102026+00	26	38
750	0	f	2022-03-12 22:30:08.105496+00	27	38
751	0	f	2022-03-12 22:30:08.10551+00	28	38
752	0	f	2022-03-12 22:30:08.105526+00	29	38
753	0	f	2022-03-12 22:30:08.105536+00	30	38
754	0	f	2022-03-12 22:30:08.105543+00	31	38
755	0	f	2022-03-12 22:30:08.105551+00	32	38
756	0	f	2022-03-12 22:30:08.105559+00	33	38
757	0	f	2022-03-12 22:30:08.109016+00	34	38
758	0	f	2022-03-12 22:30:08.109028+00	35	38
759	0	f	2022-03-12 22:30:08.109036+00	36	38
760	0	f	2022-03-12 22:30:08.112563+00	37	38
761	0	f	2022-03-12 22:30:08.112582+00	38	38
762	0	f	2022-03-12 22:30:08.11259+00	39	38
763	0	f	2022-03-12 22:30:08.114751+00	40	38
764	0	f	2022-03-12 22:30:08.114769+00	41	38
765	0	f	2022-03-12 22:30:08.114778+00	42	38
766	1	t	2022-03-12 22:30:48.244249+00	13	39
767	0	f	2022-03-12 22:30:48.244277+00	14	39
768	0	f	2022-03-12 22:30:48.244286+00	15	39
769	0	f	2022-03-12 22:30:48.244294+00	16	39
770	0	f	2022-03-12 22:30:48.244301+00	17	39
771	0	f	2022-03-12 22:30:48.244309+00	18	39
772	0	f	2022-03-12 22:30:48.244317+00	19	39
773	0	f	2022-03-12 22:30:48.246983+00	20	39
774	0	f	2022-03-12 22:30:48.246998+00	21	39
775	0	f	2022-03-12 22:30:48.247006+00	22	39
776	0	f	2022-03-12 22:30:48.247014+00	23	39
777	0	f	2022-03-12 22:30:48.247022+00	24	39
778	0	f	2022-03-12 22:30:48.247029+00	25	39
779	0	f	2022-03-12 22:30:48.247037+00	26	39
780	0	f	2022-03-12 22:30:48.24987+00	27	39
781	0	f	2022-03-12 22:30:48.249887+00	28	39
782	0	f	2022-03-12 22:30:48.249895+00	29	39
783	0	f	2022-03-12 22:30:48.249902+00	30	39
784	0	f	2022-03-12 22:30:48.249909+00	31	39
785	0	f	2022-03-12 22:30:48.249917+00	32	39
786	0	f	2022-03-12 22:30:48.249925+00	33	39
787	0	f	2022-03-12 22:30:48.252755+00	34	39
788	0	f	2022-03-12 22:30:48.252774+00	35	39
789	0	f	2022-03-12 22:30:48.252782+00	36	39
790	0	f	2022-03-12 22:30:48.255041+00	37	39
791	0	f	2022-03-12 22:30:48.255064+00	38	39
792	0	f	2022-03-12 22:30:48.255073+00	39	39
793	0	f	2022-03-12 22:30:48.259889+00	40	39
794	0	f	2022-03-12 22:30:48.259914+00	41	39
795	0	f	2022-03-12 22:30:48.259922+00	42	39
796	1	t	2022-03-12 22:31:08.730399+00	13	40
797	0	f	2022-03-12 22:31:08.730421+00	14	40
798	0	f	2022-03-12 22:31:08.730429+00	15	40
799	0	f	2022-03-12 22:31:08.730437+00	16	40
800	0	f	2022-03-12 22:31:08.730445+00	17	40
801	0	f	2022-03-12 22:31:08.730454+00	18	40
802	0	f	2022-03-12 22:31:08.730461+00	19	40
803	0	f	2022-03-12 22:31:08.733189+00	20	40
804	0	f	2022-03-12 22:31:08.733201+00	21	40
805	0	f	2022-03-12 22:31:08.73321+00	22	40
806	0	f	2022-03-12 22:31:08.733217+00	23	40
807	0	f	2022-03-12 22:31:08.733225+00	24	40
808	0	f	2022-03-12 22:31:08.733233+00	25	40
809	0	f	2022-03-12 22:31:08.733241+00	26	40
810	0	f	2022-03-12 22:31:08.737974+00	27	40
811	0	f	2022-03-12 22:31:08.737996+00	28	40
812	0	f	2022-03-12 22:31:08.738004+00	29	40
813	0	f	2022-03-12 22:31:08.738012+00	30	40
814	0	f	2022-03-12 22:31:08.73802+00	31	40
815	0	f	2022-03-12 22:31:08.738028+00	32	40
816	0	f	2022-03-12 22:31:08.738036+00	33	40
817	0	f	2022-03-12 22:31:08.740415+00	34	40
818	0	f	2022-03-12 22:31:08.740435+00	35	40
819	0	f	2022-03-12 22:31:08.740443+00	36	40
820	0	f	2022-03-12 22:31:08.747215+00	37	40
821	0	f	2022-03-12 22:31:08.747236+00	38	40
822	0	f	2022-03-12 22:31:08.747245+00	39	40
823	0	f	2022-03-12 22:31:08.749061+00	40	40
824	0	f	2022-03-12 22:31:08.749073+00	41	40
825	0	f	2022-03-12 22:31:08.749082+00	42	40
826	1	t	2022-03-12 22:33:28.221333+00	13	41
827	0	f	2022-03-12 22:33:28.221354+00	14	41
828	0	f	2022-03-12 22:33:28.221362+00	15	41
829	0	f	2022-03-12 22:33:28.22137+00	16	41
830	0	f	2022-03-12 22:33:28.221377+00	17	41
831	0	f	2022-03-12 22:33:28.221385+00	18	41
832	0	f	2022-03-12 22:33:28.221392+00	19	41
833	0	f	2022-03-12 22:33:28.224086+00	20	41
834	0	f	2022-03-12 22:33:28.2241+00	21	41
835	0	f	2022-03-12 22:33:28.224108+00	22	41
836	0	f	2022-03-12 22:33:28.224134+00	23	41
837	0	f	2022-03-12 22:33:28.224142+00	24	41
838	0	f	2022-03-12 22:33:28.22415+00	25	41
839	0	f	2022-03-12 22:33:28.224158+00	26	41
840	0	f	2022-03-12 22:33:28.225924+00	27	41
841	0	f	2022-03-12 22:33:28.225936+00	28	41
842	0	f	2022-03-12 22:33:28.225944+00	29	41
843	0	f	2022-03-12 22:33:28.225952+00	30	41
844	0	f	2022-03-12 22:33:28.22599+00	31	41
845	0	f	2022-03-12 22:33:28.226+00	32	41
846	0	f	2022-03-12 22:33:28.226007+00	33	41
847	0	f	2022-03-12 22:33:28.227614+00	34	41
848	0	f	2022-03-12 22:33:28.227652+00	35	41
849	0	f	2022-03-12 22:33:28.227662+00	36	41
850	0	f	2022-03-12 22:33:28.229805+00	37	41
851	0	f	2022-03-12 22:33:28.229826+00	38	41
852	0	f	2022-03-12 22:33:28.229834+00	39	41
853	0	f	2022-03-12 22:33:28.23364+00	40	41
854	0	f	2022-03-12 22:33:28.233662+00	41	41
855	0	f	2022-03-12 22:33:28.23367+00	42	41
\.


--
-- Data for Name: alcpt_word; Type: TABLE DATA; Schema: alcpt; Owner: postgres
--

COPY alcpt.alcpt_word (id, word, definiton) FROM stdin;
\.


--
-- Data for Name: alcpt_word_library; Type: TABLE DATA; Schema: alcpt; Owner: postgres
--

COPY alcpt.alcpt_word_library (id, words, translations) FROM stdin;
1	Apple	apple
2	Banana	banana
3	Cow	cow
4	pen	鉛筆
\.


--
-- Data for Name: audio_file; Type: TABLE DATA; Schema: alcpt; Owner: postgres
--

COPY alcpt.audio_file (id, name, audio_file, created_date, updated_date, user_id) FROM stdin;
\.


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: alcpt; Owner: postgres
--

COPY alcpt.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: alcpt; Owner: postgres
--

COPY alcpt.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: alcpt; Owner: postgres
--

COPY alcpt.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can add permission	2	add_permission
5	Can change permission	2	change_permission
6	Can delete permission	2	delete_permission
7	Can add group	3	add_group
8	Can change group	3	change_group
9	Can delete group	3	delete_group
10	Can add content type	4	add_contenttype
11	Can change content type	4	change_contenttype
12	Can delete content type	4	delete_contenttype
13	Can add session	5	add_session
14	Can change session	5	change_session
15	Can delete session	5	delete_session
16	Can add user	6	add_user
17	Can change user	6	change_user
18	Can delete user	6	delete_user
19	Can add answer	7	add_answer
20	Can change answer	7	change_answer
21	Can delete answer	7	delete_answer
22	Can add answer sheet	8	add_answersheet
23	Can change answer sheet	8	change_answersheet
24	Can delete answer sheet	8	delete_answersheet
25	Can add choice	9	add_choice
26	Can change choice	9	change_choice
27	Can delete choice	9	delete_choice
28	Can add department	10	add_department
29	Can change department	10	change_department
30	Can delete department	10	delete_department
31	Can add exam	11	add_exam
32	Can change exam	11	change_exam
33	Can delete exam	11	delete_exam
34	Can add group	12	add_group
35	Can change group	12	change_group
36	Can delete group	12	delete_group
37	Can add option list	13	add_optionlist
38	Can change option list	13	change_optionlist
39	Can delete option list	13	delete_optionlist
40	Can add proclamation	14	add_proclamation
41	Can change proclamation	14	change_proclamation
42	Can delete proclamation	14	delete_proclamation
43	Can add question	15	add_question
44	Can change question	15	change_question
45	Can delete question	15	delete_question
46	Can add report	16	add_report
47	Can change report	16	change_report
48	Can delete report	16	delete_report
49	Can add report category	17	add_reportcategory
50	Can change report category	17	change_reportcategory
51	Can delete report category	17	delete_reportcategory
52	Can add squadron	18	add_squadron
53	Can change squadron	18	change_squadron
54	Can delete squadron	18	delete_squadron
55	Can add student	19	add_student
56	Can change student	19	change_student
57	Can delete student	19	delete_student
58	Can add test paper	20	add_testpaper
59	Can change test paper	20	change_testpaper
60	Can delete test paper	20	delete_testpaper
61	Can add captcha store	21	add_captchastore
62	Can change captcha store	21	change_captchastore
63	Can delete captcha store	21	delete_captchastore
64	Can add testee list	22	add_testeelist
65	Can change testee list	22	change_testeelist
66	Can delete testee list	22	delete_testeelist
67	Can add reply	23	add_reply
68	Can change reply	23	change_reply
69	Can delete reply	23	delete_reply
70	Can view log entry	1	view_logentry
71	Can view permission	2	view_permission
72	Can view group	3	view_group
73	Can view content type	4	view_contenttype
74	Can view session	5	view_session
75	Can view user	6	view_user
76	Can view answer	7	view_answer
77	Can view answer sheet	8	view_answersheet
78	Can view choice	9	view_choice
79	Can view department	10	view_department
80	Can view exam	11	view_exam
81	Can view group	12	view_group
82	Can view proclamation	14	view_proclamation
83	Can view question	15	view_question
84	Can view report	16	view_report
85	Can view report category	17	view_reportcategory
86	Can view squadron	18	view_squadron
87	Can view student	19	view_student
88	Can view test paper	20	view_testpaper
89	Can view testee list	22	view_testeelist
90	Can view reply	23	view_reply
91	Can view captcha store	21	view_captchastore
92	Can add notification	24	add_notification
93	Can change notification	24	change_notification
94	Can delete notification	24	delete_notification
95	Can view notification	24	view_notification
96	Can add dash app	25	add_dashapp
97	Can change dash app	25	change_dashapp
98	Can delete dash app	25	delete_dashapp
99	Can view dash app	25	view_dashapp
100	Can add stateless app	26	add_statelessapp
101	Can change stateless app	26	change_statelessapp
102	Can delete stateless app	26	delete_statelessapp
103	Can view stateless app	26	view_statelessapp
104	Can add achievement	27	add_achievement
105	Can change achievement	27	change_achievement
106	Can delete achievement	27	delete_achievement
107	Can view achievement	27	view_achievement
108	Can add user achievement	28	add_userachievement
109	Can change user achievement	28	change_userachievement
110	Can delete user achievement	28	delete_userachievement
111	Can view user achievement	28	view_userachievement
112	Can add forum	29	add_forum
113	Can change forum	29	change_forum
114	Can delete forum	29	delete_forum
115	Can view forum	29	view_forum
116	Can add word_exam	30	add_word_exam
117	Can change word_exam	30	change_word_exam
118	Can delete word_exam	30	delete_word_exam
119	Can view word_exam	30	view_word_exam
120	Can add word_library	30	add_word_library
121	Can change word_library	30	change_word_library
122	Can delete word_library	30	delete_word_library
123	Can view word_library	30	view_word_library
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: alcpt; Owner: postgres
--

COPY alcpt.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
1	pbkdf2_sha256$36000$NR3ItP0hMf3C$gpm4p9l5r6Y+20rzeD4lte1tOsuN9nQPgPNgooeQJsY=	2019-12-18 08:11:02.232747+00	t	d.wsu			wei860925@gmail.com	t	t	2019-12-18 08:10:55.194024+00
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: alcpt; Owner: postgres
--

COPY alcpt.auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: alcpt; Owner: postgres
--

COPY alcpt.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: captcha_captchastore; Type: TABLE DATA; Schema: alcpt; Owner: postgres
--

COPY alcpt.captcha_captchastore (id, challenge, response, hashkey, expiration) FROM stdin;
519	QWSH	qwsh	0c3cc6184da3b9be5c384f8b8f9329df8898f272	2023-01-26 15:24:50.15375+00
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: alcpt; Owner: postgres
--

COPY alcpt.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: alcpt; Owner: postgres
--

COPY alcpt.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
27	alcpt	achievement
7	alcpt	answer
8	alcpt	answersheet
9	alcpt	choice
10	alcpt	department
11	alcpt	exam
29	alcpt	forum
12	alcpt	group
24	alcpt	notification
13	alcpt	optionlist
14	alcpt	proclamation
15	alcpt	question
23	alcpt	reply
16	alcpt	report
17	alcpt	reportcategory
18	alcpt	squadron
19	alcpt	student
22	alcpt	testeelist
20	alcpt	testpaper
6	alcpt	user
28	alcpt	userachievement
30	alcpt	word_library
3	auth	group
2	auth	permission
21	captcha	captchastore
4	contenttypes	contenttype
25	django_plotly_dash	dashapp
26	django_plotly_dash	statelessapp
5	sessions	session
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: alcpt; Owner: postgres
--

COPY alcpt.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2020-02-11 12:55:28.154105+00
2	alcpt	0001_initial	2020-02-11 12:55:29.436003+00
3	admin	0001_initial	2020-02-11 12:55:29.523835+00
4	admin	0002_logentry_remove_auto_add	2020-02-11 12:55:29.551044+00
5	contenttypes	0002_remove_content_type_name	2020-02-11 12:55:29.627345+00
6	auth	0001_initial	2020-02-11 12:55:29.799531+00
7	auth	0002_alter_permission_name_max_length	2020-02-11 12:55:29.834748+00
8	auth	0003_alter_user_email_max_length	2020-02-11 12:55:29.852611+00
9	auth	0004_alter_user_username_opts	2020-02-11 12:55:29.86192+00
10	auth	0005_alter_user_last_login_null	2020-02-11 12:55:29.871194+00
11	auth	0006_require_contenttypes_0002	2020-02-11 12:55:29.873803+00
12	auth	0007_alter_validators_add_error_messages	2020-02-11 12:55:29.887929+00
13	auth	0008_alter_user_username_max_length	2020-02-11 12:55:29.896072+00
14	captcha	0001_initial	2020-02-11 12:55:29.918277+00
15	sessions	0001_initial	2020-02-11 12:55:29.94562+00
16	alcpt	0002_auto_20200211_1457	2020-02-11 14:57:20.13329+00
17	alcpt	0002_auto_20200212_2312	2020-02-12 23:13:10.729115+00
18	alcpt	0003_testpaper_is_used	2020-02-12 23:32:05.156396+00
19	alcpt	0004_auto_20200214_0950	2020-02-14 09:50:44.665963+00
20	alcpt	0005_auto_20200216_0016	2020-02-18 11:44:28.056102+00
21	alcpt	0006_remove_question_used_freq	2020-02-18 11:44:28.21821+00
22	alcpt	0007_auto_20200219_0102	2020-02-19 01:02:20.889312+00
23	alcpt	0008_auto_20200220_0855	2020-02-20 08:55:12.109729+00
24	alcpt	0009_auto_20200223_0054	2020-02-23 00:54:56.335952+00
25	alcpt	0010_user_introduction	2020-02-24 01:48:36.068849+00
26	alcpt	0011_auto_20200228_0224	2020-02-28 02:24:43.896742+00
27	alcpt	0012_user_photo	2020-03-02 11:23:51.184589+00
28	admin	0003_logentry_add_action_flag_choices	2020-03-06 00:28:02.820436+00
29	auth	0009_alter_user_last_name_max_length	2020-03-06 00:28:02.858645+00
30	auth	0010_alter_group_name_max_length	2020-03-06 00:28:02.935353+00
31	auth	0011_update_proxy_permissions	2020-03-06 00:28:02.962196+00
32	alcpt	0013_exam_testeelist	2020-03-12 00:41:54.833163+00
33	alcpt	0014_delete_testeelist	2020-03-12 00:41:54.982885+00
34	alcpt	0015_notification	2020-03-17 19:04:42.665041+00
35	alcpt	0015_auto_20200318_0845	2020-03-18 08:45:45.492761+00
36	alcpt	0016_auto_20200318_1708	2020-03-19 01:08:23.122393+00
37	alcpt	0017_auto_20200319_0108	2020-03-19 01:08:23.212788+00
38	auth	0012_alter_user_first_name_max_length	2020-09-24 11:36:35.28024+00
39	django_plotly_dash	0001_initial	2020-09-24 11:36:35.324549+00
40	django_plotly_dash	0002_add_examples	2020-09-24 11:36:35.344285+00
41	alcpt	0002_auto_20200924_1137	2020-09-24 11:37:25.837784+00
42	alcpt	0002_answersheet_is_tested	2020-09-28 23:32:35.553236+00
43	alcpt	0002_auto_20201211_0821	2020-12-11 08:21:39.621639+00
44	alcpt	0002_achievement_userachievement	2020-12-11 08:26:01.17955+00
45	alcpt	0002_auto_20201214_0834	2020-12-14 08:34:19.266685+00
46	alcpt	0003_proclamation_exam_id	2020-12-14 11:21:45.959679+00
47	alcpt	0002_proclamation_report_id	2020-12-15 16:09:38.58989+00
48	alcpt	0003_achievement_trophy	2020-12-17 09:10:42.351977+00
49	alcpt	0004_auto_20210125_1035	2021-01-25 10:35:55.315077+00
50	alcpt	0005_exam_remaining_time	2021-07-23 13:17:52.524961+00
51	alcpt	0006_auto_20210315_1529	2021-07-23 13:17:52.570603+00
52	alcpt	0007_remove_exam_remaining_time	2021-07-23 13:17:52.592347+00
53	alcpt	0008_exam_remaining_time	2021-07-23 13:17:52.607601+00
54	alcpt	0009_user_browser	2021-07-23 13:17:52.637824+00
55	alcpt	0010_exam_is_started	2021-07-23 13:17:52.661153+00
56	alcpt	0011_auto_20211220_1648	2021-12-20 16:48:51.657452+00
57	alcpt	0012_auto_20220221_2316	2022-02-21 23:16:41.316134+00
58	alcpt	0013_question_in_forum	2022-02-28 22:23:11.615809+00
59	alcpt	0014_auto_20220303_2319	2022-03-03 23:19:34.350964+00
60	alcpt	0015_auto_20220305_1653	2022-03-05 16:53:36.448418+00
61	alcpt	0016_auto_20220329_1404	2022-03-29 14:04:41.00252+00
62	alcpt	0002_auto_20221227_2011	2022-12-27 20:21:06.025761+00
63	alcpt	0003_rename_word_words	2022-12-27 20:21:06.031447+00
64	alcpt	0004_auto_20221227_2018	2022-12-27 20:21:06.03683+00
65	captcha	0002_alter_captchastore_id	2022-12-27 20:21:06.043087+00
66	django_plotly_dash	0003_auto_20221226_1053	2022-12-27 20:21:06.047557+00
67	alcpt	0002_word_exam	2022-12-27 20:24:41.64132+00
68	alcpt	0003_auto_20221229_1137	2022-12-29 14:35:54.278414+00
69	alcpt	0003_auto_20230103_2022	2023-01-03 20:27:36.510301+00
\.


--
-- Data for Name: django_plotly_dash_dashapp; Type: TABLE DATA; Schema: alcpt; Owner: postgres
--

COPY alcpt.django_plotly_dash_dashapp (id, instance_name, slug, base_state, creation, update, save_on_change, stateless_app_id) FROM stdin;
\.


--
-- Data for Name: django_plotly_dash_statelessapp; Type: TABLE DATA; Schema: alcpt; Owner: postgres
--

COPY alcpt.django_plotly_dash_statelessapp (id, app_name, slug) FROM stdin;
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: alcpt; Owner: postgres
--

COPY alcpt.django_session (session_key, session_data, expire_date) FROM stdin;
00be7hpe2kbt6ou9tooaep5vxc6m9hna	NjRiMzliZGY5YTg2ZDI3ZTE4YTFkODViMGRhMzE0ZDhjODRkNTRmOTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIyN2MzNWRlNzNjMzZhODcxNzQ4OWNhMzlmZGQ5M2Y1ZGQyNDEzNTFmIn0=	2020-04-01 16:20:28.787148+00
0k13tzrw24accqvha1sfhtn76071ww84	YzRjMWQ0MzY2OWI1MzMyZGQ5Mjc5MGQ5N2Y4MzUyZWVkMDhiN2YzMjp7Il9hdXRoX3VzZXJfaWQiOiIxNiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMjdhODE1NDdhZDFmNzIxMzU1NjJkOGRiNDFlYjA5Y2Y1MDUxZTU5MSJ9	2020-04-28 11:08:17.700032+00
0pgu8q4ybvazj9dve8c5vyiokwt3py2t	.eJxVjEEOwiAQRe_C2pDO0NLi0r1nIDMwSNVAUtqV8e7apAvd_vfefylP25r91mTxc1RnZaw6_Y5M4SFlJ_FO5VZ1qGVdZta7og_a9LVGeV4O9-8gU8vfmvpExo5I0TAHGACmaF0_GRehQ5LJCUjqAo4GHKKz3ZBGYYQhMWMI6v0BBLw3-w:1mnY7E:9obHIberfynccrnxTOEgZ-u-_3FVQoHr2jhAn5_sT84	2021-12-02 11:29:36.757973+00
0xxern4lu45f75ta06ldxrf7j72ou1ba	.eJxVjMEOwiAQRP-FsyFLKMJ69O43kAUWqRpISnsy_rs06UEPk0zmzcxbeNrW4rfOi5-TuAgjTr9ZoPjkuoP0oHpvMra6LnOQe0UetMtbS_y6Ht2_g0K9jHWEM2sAZM7oMiNaIONIZ4cMIdnIwzqDaihpZ3SYGLIzGVXQVk3i8wXrTzen:1kLI5w:WKTtIy0YIw3Iowy4TJ53Nrob0THYaqXEM2f-6_blFO0	2020-10-08 11:38:56.86729+00
10mp5574oxf8eq4egr1wvoqwpsgwfl54	NjZiYTM5NzNiNDUwNzk4NDgyMWRjZTBhNzliZDQ3N2RlZmU4ZTViNDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJmY2RiNzE3NTNiZmE1OGEyYTVjYjBlYTZkMWIzYmE4NjM5ODgxNjMxIn0=	2020-03-18 19:58:36.227155+00
2hrzoceuayiuqgim8x4zt4jqcasyptc8	.eJxVjEEOwiAQRe_C2pDO0NLi0r1nIDMwSNVAUtqV8e7apAvd_vfefylP25r91mTxc1RnZaw6_Y5M4SFlJ_FO5VZ1qGVdZta7og_a9LVGeV4O9-8gU8vfmvpExo5I0TAHGACmaF0_GRehQ5LJCUjqAo4GHKKz3ZBGYYQhMWMI6v0BBLw3-w:1mNUKZ:Jcc0FreZVFtPSRC_WcQjvCjpVjNSlFxhcBa2k8AV4NM	2021-09-21 14:11:39.715834+00
2stzviqbmsosxnu9uzw7n6kfaz9t6mop	ZTIyY2QxNDIzNjcxMzVhYTNkMGRlMmJmZGY1YTI3OTFmMjNmNmMzYTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIzMWQ4MzMxOGM2ZDlkODM2YzE1NTVmYmU5ZWJiZWIwODdmYTI3OWUzIn0=	2020-02-27 16:35:15.282861+00
3b2km17qdz88s7x6cg8usnfl55xlided	.eJxVjEEOwiAQRe_C2pDO0NLi0r1nIDMwSNVAUtqV8e7apAvd_vfefylP25r91mTxc1RnZaw6_Y5M4SFlJ_FO5VZ1qGVdZta7og_a9LVGeV4O9-8gU8vfmvpExo5I0TAHGACmaF0_GRehQ5LJCUjqAo4GHKKz3ZBGYYQhMWMI6v0BBLw3-w:1mXf5h:xruQZN0hk6pDQADQIEb-SaR7nlxVXgbQ14-Ss7wIsiI	2021-10-19 15:42:21.620694+00
4tmw6r9ziyzln7ofu70o1k0433h9xjq4	ZWY5NTQ4NDgyNWZiMDYwNDBhMmJlMjlhOGZjZGE3MDA4YTc5OWMyMDp7Il9hdXRoX3VzZXJfaWQiOiI2IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI3ZjNlYzc0YWY1MWRjNWRjZmFmZTJiMjFkMzYwZGE2Y2Q2YWE1ZTIwIn0=	2020-04-12 23:58:49.73958+00
69u2ohvks8jyt5gzym2zoy2vkivdp24j	.eJxVjMEOwiAQRP-FsyFLKMJ69O43kAUWqRpISnsy_rs06UEPk0zmzcxbeNrW4rfOi5-TuAgjTr9ZoPjkuoP0oHpvMra6LnOQe0UetMtbS_y6Ht2_g0K9jHWEM2sAZM7oMiNaIONIZ4cMIdnIwzqDaihpZ3SYGLIzGVXQVk3i8wXrTzen:1kto0g:w0-qBgTvJf1CV2rVkHqLUidDOuEYiGwB6CJ4n2dIeFk	2021-01-11 16:36:10.17978+00
6nfyisopsgfk7ye2h73y0ekg5oqf6dji	.eJxVjMsOwiAQRf-FtSHAAAMu3fcbyPBQqgaS0q6M_65NutDtPefcFwu0rTVsoyxhzuzMPDv9bpHSo7Qd5Du1W-ept3WZI98VftDBp57L83K4fweVRv3WBTxeISshgSCTAacLoTXCGO2UBeEiCTQCU0bri3YYo_MgjfYyodLs_QG9azZl:1pKwYA:bhX93D9EafLkDqH5gk66iaduWGVLjl6V1-ZAD8Sxcrw	2023-02-09 15:19:58.232621+00
6sjqaydx3v358r5ykqebrrv3dvr4asao	.eJxVjMEOwiAQRP-FsyEgUBeP3vsNZNmlUjWQlPZk_Hdp0oMmkznMm5m3CLitOWwtLWFmcRVenH6ziPRMZQf8wHKvkmpZlznKvSIP2uRYOb1uR_fvIGPLfa2cTV2TAw2kJjZMEQEs6svQXyI6GgyB8hTh7COzMc57ZTR0t8qLzxf29jey:1kjcWf:7PP36KTveG-FVVvSMyaq0UqAWIGCgo7pDiWgqOO9c2M	2020-12-14 14:19:05.945224+00
7g5gt377if0wratijhgqstk9p76lhacq	ZjNiZmNiYzAxOWZkNzdhZDk1MmYyOGQzOWQ3ZmJiOWNmZDg0OWQ4Yzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIzNmUyY2NmMjJlOTE1MDBkZTdmNmRjY2QyMWM5Y2Q4NTliMjI3YTIwIn0=	2020-03-16 16:39:20.849575+00
7l6x5b5jcdi7l3wfkeio6ilvojaod2g0	.eJxVjEEOwiAQRe_C2pDO0NLi0r1nIDMwSNVAUtqV8e7apAvd_vfefylP25r91mTxc1RnZaw6_Y5M4SFlJ_FO5VZ1qGVdZta7og_a9LVGeV4O9-8gU8vfmvpExo5I0TAHGACmaF0_GRehQ5LJCUjqAo4GHKKz3ZBGYYQhMWMI6v0BBLw3-w:1ndvzR:RBk6uN9G8DeKO80zer70SXZnFa39s-PDQY1_DnDm-ts	2022-04-25 23:30:05.526964+00
7qwhtobte4xnvtflo1qd6267lsa3ww7n	.eJxVjEEOwiAQRe_C2pDO0NLi0r1nIDMwSNVAUtqV8e7apAvd_vfefylP25r91mTxc1RnZaw6_Y5M4SFlJ_FO5VZ1qGVdZta7og_a9LVGeV4O9-8gU8vfmvpExo5I0TAHGACmaF0_GRehQ5LJCUjqAo4GHKKz3ZBGYYQhMWMI6v0BBLw3-w:1mryGs:5NqVVYIKUGHyj7hCbGOd9h0OXkPRZyQ-9kti81whwYI	2021-12-14 16:13:50.077072+00
7ses2poqph60umk26j0wwhb8ltz6y149	.eJxVjMEOwiAQRP-FsyFLKMJ69O43kAUWqRpISnsy_rs06UEPk0zmzcxbeNrW4rfOi5-TuAgjTr9ZoPjkuoP0oHpvMra6LnOQe0UetMtbS_y6Ht2_g0K9jHWEM2sAZM7oMiNaIONIZ4cMIdnIwzqDaihpZ3SYGLIzGVXQVk3i8wXrTzen:1knYTJ:h2dMJ42k7REk6EbESZ2zWJclJYhBKn7DIlEBUGEG-qo	2020-12-25 10:47:53.512166+00
8ct0k56m4otj4kx7s9efo6706hxtgmcq	.eJxVjMEOwiAQRP-FsyFLKMJ69O43kAUWqRpISnsy_rs06UEPk0zmzcxbeNrW4rfOi5-TuAgjTr9ZoPjkuoP0oHpvMra6LnOQe0UetMtbS_y6Ht2_g0K9jHWEM2sAZM7oMiNaIONIZ4cMIdnIwzqDaihpZ3SYGLIzGVXQVk3i8wXrTzen:1lJ5fn:SsrRRXN3k-xmi6waOBCrnUpu_tFIe8tkimmBe6n45gM	2021-03-22 10:31:07.541436+00
92f59ce2fgwft14oxo9ik4gzlwxlvu0y	.eJxVjEEOwiAQRe_C2pDO0NLi0r1nIDMwSNVAUtqV8e7apAvd_vfefylP25r91mTxc1RnZaw6_Y5M4SFlJ_FO5VZ1qGVdZta7og_a9LVGeV4O9-8gU8vfmvpExo5I0TAHGACmaF0_GRehQ5LJCUjqAo4GHKKz3ZBGYYQhMWMI6v0BBLw3-w:1nMAKk:1snvXoGeNiDtJDo0bBZe7wD4KMFhg3CLo4Mfe3LFqwI	2022-03-07 23:10:38.603462+00
9tpon82s22ox0fixeet8lfl05wnewuam	.eJxVjMsOwiAQRf-FtSHAAAMu3fcbyPBQqgaS0q6M_65NutDtPefcFwu0rTVsoyxhzuzMPDv9bpHSo7Qd5Du1W-ept3WZI98VftDBp57L83K4fweVRv3WBTxeISshgSCTAacLoTXCGO2UBeEiCTQCU0bri3YYo_MgjfYyodLs_QG9azZl:1pA9Cj:dfRdAr2U63Hi07zOxvaLnE8KozWwrNdIg2I-17HJq0M	2023-01-10 20:37:13.033129+00
a3ab07snbgrkojpftbnw8klbludsjk3m	.eJxVjMEOwiAQRP-FsyFLKMJ69O43kAUWqRpISnsy_rs06UEPk0zmzcxbeNrW4rfOi5-TuAgjTr9ZoPjkuoP0oHpvMra6LnOQe0UetMtbS_y6Ht2_g0K9jHWEM2sAZM7oMiNaIONIZ4cMIdnIwzqDaihpZ3SYGLIzGVXQVk3i8wXrTzen:1lKzfU:lL8Ma3ESgX9HukLlLViEe8hYPrvSMUZZAxHvLu0Ui2k	2021-03-27 16:30:40.637187+00
a3d2ulqe9nfz1i8zsxt02o13gebszblt	ZjNiZmNiYzAxOWZkNzdhZDk1MmYyOGQzOWQ3ZmJiOWNmZDg0OWQ4Yzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIzNmUyY2NmMjJlOTE1MDBkZTdmNmRjY2QyMWM5Y2Q4NTliMjI3YTIwIn0=	2020-03-16 10:26:33.142668+00
aank85e5rogr0xd4zzz5udn6bw81ij5l	OTEwOTA3ODQzOWFiM2QwZGRkMDUwN2Q0YWMwNjM5NTU0MDkyZTExYzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIwYjU1ZGY4ZjdlMzhiNjRkMDVkM2M4MTMyZDZlODRiZTVkMTAyYWFmIn0=	2020-05-11 10:21:05.558514+00
ae241q5zpfbp6qh7wvt6enz763k1g9zl	.eJxVjEEOwiAQRe_C2pDO0NLi0r1nIDMwSNVAUtqV8e7apAvd_vfefylP25r91mTxc1RnZaw6_Y5M4SFlJ_FO5VZ1qGVdZta7og_a9LVGeV4O9-8gU8vfmvpExo5I0TAHGACmaF0_GRehQ5LJCUjqAo4GHKKz3ZBGYYQhMWMI6v0BBLw3-w:1n2b7D:t9pXUvz6DdJzr3tRGYr528a-MF17QidFJkf9iu1IKVQ	2022-01-12 23:43:47.707674+00
asnbau72k5gksxi0ojvc78djaa6l3yvn	.eJxVjDsOwjAQRO_iGlnxB-OlpM8ZrLW9iwPIluKkQtydREoBxTTz3sxbBFyXEtZOc5iyuAoF4vRbRkxPqjvJD6z3JlOryzxFuSvyoF2OLdPrdrh_BwV72dYYNUf2DHYAbzNbgIEVkXfWXJT2OiV39rAlEyk0lMBlp7WKyIbZis8XE7E4XQ:1l3sb2:nQiMZEOyhYmBG4zlonmbC2x-O-32kn8OK0wSUMI1eMs	2021-02-08 11:31:20.514509+00
byxlzsqls9uev2hia0nqmuloofu0qeut	.eJxVjEEOwiAQRe_C2pDO0NLi0r1nIDMwSNVAUtqV8e7apAvd_vfefylP25r91mTxc1RnZaw6_Y5M4SFlJ_FO5VZ1qGVdZta7og_a9LVGeV4O9-8gU8vfmvpExo5I0TAHGACmaF0_GRehQ5LJCUjqAo4GHKKz3ZBGYYQhMWMI6v0BBLw3-w:1mfvqv:bZFUzwG8k2iuyuN3T-_uG1Fed1_y0QxEST9ZaN2FihM	2021-11-11 11:13:17.565103+00
cxvn7gyxsu80agryf0k2hyi4js62nuqr	OTEwOTA3ODQzOWFiM2QwZGRkMDUwN2Q0YWMwNjM5NTU0MDkyZTExYzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIwYjU1ZGY4ZjdlMzhiNjRkMDVkM2M4MTMyZDZlODRiZTVkMTAyYWFmIn0=	2020-04-30 09:57:36.865305+00
d7u4phph0alohnbemkw22ogyv0336l8q	.eJxVjEEOwiAQRe_C2pDO0NLi0r1nIDMwSNVAUtqV8e7apAvd_vfefylP25r91mTxc1RnZaw6_Y5M4SFlJ_FO5VZ1qGVdZta7og_a9LVGeV4O9-8gU8vfmvpExo5I0TAHGACmaF0_GRehQ5LJCUjqAo4GHKKz3ZBGYYQhMWMI6v0BBLw3-w:1mxWAi:1f9ILfacrAuLAtR8rjPnx0e02NCki-OTJ798ZzHQ-cY	2021-12-29 23:26:24.798631+00
da8qatewgj3o7iz7umr7xogrcpx4w5dd	OTEwOTA3ODQzOWFiM2QwZGRkMDUwN2Q0YWMwNjM5NTU0MDkyZTExYzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIwYjU1ZGY4ZjdlMzhiNjRkMDVkM2M4MTMyZDZlODRiZTVkMTAyYWFmIn0=	2020-04-02 01:10:37.935014+00
dj4u6lnmzr2u1osx9hikoy91kyhk2wj3	.eJxVjMEOwiAQRP-FsyFLKMJ69O43kAUWqRpISnsy_rs06UEPk0zmzcxbeNrW4rfOi5-TuAgjTr9ZoPjkuoP0oHpvMra6LnOQe0UetMtbS_y6Ht2_g0K9jHWEM2sAZM7oMiNaIONIZ4cMIdnIwzqDaihpZ3SYGLIzGVXQVk3i8wXrTzen:1km621:ANDv-dw1ZQIw8ErGAcB7Nla68qiwJEk1rdd_9eBHbtI	2020-12-21 10:13:41.949113+00
e4g29i9bcmnw3sqh8oejqhgk4bd7lkd5	ZjdiYzQ2MWZhNzIyMTU1YjE1MTFlYTJiYTZmN2VkMjk1MWFjYmQxMDp7Il9hdXRoX3VzZXJfaWQiOiI0IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJmNTAzYjQyNzdmMTc2NjMzZjg5Nzk0YTRmNWY4N2VlMTgzOGRjMWE1In0=	2020-04-20 22:31:42.278008+00
ex3ov52ab4mydar7r9szvqic100ez2iu	.eJxVjEEOwiAQRe_C2pDO0NLi0r1nIDMwSNVAUtqV8e7apAvd_vfefylP25r91mTxc1RnZaw6_Y5M4SFlJ_FO5VZ1qGVdZta7og_a9LVGeV4O9-8gU8vfmvpExo5I0TAHGACmaF0_GRehQ5LJCUjqAo4GHKKz3ZBGYYQhMWMI6v0BBLw3-w:1mGwc9:JCrgDWdKHo2ehGJheuS6_IRxUqLumS4aH0gLyVYks2w	2021-09-03 12:58:45.358231+00
flibkl1869ftlhzdtdvzfgg7og1exp02	ZTIyY2QxNDIzNjcxMzVhYTNkMGRlMmJmZGY1YTI3OTFmMjNmNmMzYTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIzMWQ4MzMxOGM2ZDlkODM2YzE1NTVmYmU5ZWJiZWIwODdmYTI3OWUzIn0=	2020-03-09 10:03:41.905289+00
gnt1lppycz8z2v0p6ch1tttq94iborq2	MmMzMzBlMDA2MjE5MmRiZGJjNzIyMWNjZTBjY2RlMmVlNWMyYzYzODp7Il9hdXRoX3VzZXJfaWQiOiIzIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJmMmVkNjlmMzdlOGQwYmRlYjk1MWI0ZGYwZWVkYjc5OTkxYTlhMjljIn0=	2020-02-26 00:55:55.517976+00
i4gniur0azepsszo79h8nonx2h4vaqcn	.eJxVjEEOwiAQRe_C2pDO0NLi0r1nIDMwSNVAUtqV8e7apAvd_vfefylP25r91mTxc1RnZaw6_Y5M4SFlJ_FO5VZ1qGVdZta7og_a9LVGeV4O9-8gU8vfmvpExo5I0TAHGACmaF0_GRehQ5LJCUjqAo4GHKKz3ZBGYYQhMWMI6v0BBLw3-w:1oOsPh:gIOlrK-xefhWhiiTuraPzmFUuNp8w49suA_ZrFfBct0	2022-09-02 11:11:13.38237+00
j1d0um7489keat0wn42pb4ore19fpw7x	ZWY5NTQ4NDgyNWZiMDYwNDBhMmJlMjlhOGZjZGE3MDA4YTc5OWMyMDp7Il9hdXRoX3VzZXJfaWQiOiI2IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI3ZjNlYzc0YWY1MWRjNWRjZmFmZTJiMjFkMzYwZGE2Y2Q2YWE1ZTIwIn0=	2020-04-29 22:15:15.486029+00
jwlqhd07yvkr6kuchrddonk3s4kejh5e	.eJxVjMEOwiAQRP-FsyEgUBeP3vsNZNmlUjWQlPZk_Hdp0oMmkznMm5m3CLitOWwtLWFmcRVenH6ziPRMZQf8wHKvkmpZlznKvSIP2uRYOb1uR_fvIGPLfa2cTV2TAw2kJjZMEQEs6svQXyI6GgyB8hTh7COzMc57ZTR0t8qLzxf29jey:1kwFSh:qhIaDlntDbA_ui1JsmdDUBra2JvXY0yxZam2rkBhw14	2021-01-18 10:19:11.567088+00
lfnw7yc77c51rtvwbw5xb8tf1qvqc348	.eJxVjMEOwiAQRP-FsyEgUBeP3vsNZNmlUjWQlPZk_Hdp0oMmkznMm5m3CLitOWwtLWFmcRVenH6ziPRMZQf8wHKvkmpZlznKvSIP2uRYOb1uR_fvIGPLfa2cTV2TAw2kJjZMEQEs6svQXyI6GgyB8hTh7COzMc57ZTR0t8qLzxf29jey:1m7fyr:vW25_lsmSoyqZmpZ9qobCjpBV3DhF356HvT_KqvgxgM	2021-08-08 23:23:53.002296+00
mb43m678gya5be2qiovq7gozzry16b2p	ZjNiZmNiYzAxOWZkNzdhZDk1MmYyOGQzOWQ3ZmJiOWNmZDg0OWQ4Yzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIzNmUyY2NmMjJlOTE1MDBkZTdmNmRjY2QyMWM5Y2Q4NTliMjI3YTIwIn0=	2020-03-16 16:18:44.41001+00
mggmzfjyy58cm334ch9ubs34xl7prbio	NjZiYTM5NzNiNDUwNzk4NDgyMWRjZTBhNzliZDQ3N2RlZmU4ZTViNDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJmY2RiNzE3NTNiZmE1OGEyYTVjYjBlYTZkMWIzYmE4NjM5ODgxNjMxIn0=	2020-03-18 20:24:33.063765+00
mxtihxqyg0bk9i4palthqqqh21iutepd	.eJxVjEEOwiAQRe_C2pDO0NLi0r1nIDMwSNVAUtqV8e7apAvd_vfefylP25r91mTxc1RnZaw6_Y5M4SFlJ_FO5VZ1qGVdZta7og_a9LVGeV4O9-8gU8vfmvpExo5I0TAHGACmaF0_GRehQ5LJCUjqAo4GHKKz3ZBGYYQhMWMI6v0BBLw3-w:1nH5Qv:3ZRk0Ngcuyzj6bV5M8T8b2Ba-esQnLGJ7uWLFWybCwA	2022-02-21 22:56:01.359598+00
n0y4i7e15tbz8xplh4a5g56llhhnl00m	.eJxVjMEOwiAQRP-FsyFLKMJ69O43kAUWqRpISnsy_rs06UEPk0zmzcxbeNrW4rfOi5-TuAgjTr9ZoPjkuoP0oHpvMra6LnOQe0UetMtbS_y6Ht2_g0K9jHWEM2sAZM7oMiNaIONIZ4cMIdnIwzqDaihpZ3SYGLIzGVXQVk3i8wXrTzen:1kzKsp:_89Na2sp1QZSfZ5t4e9JIFBPH1UFlMre163wfeoY12E	2021-01-26 22:42:55.129833+00
nabun9yq5v1b14pb8c7lsofkfk7100eg	ZjNiZmNiYzAxOWZkNzdhZDk1MmYyOGQzOWQ3ZmJiOWNmZDg0OWQ4Yzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIzNmUyY2NmMjJlOTE1MDBkZTdmNmRjY2QyMWM5Y2Q4NTliMjI3YTIwIn0=	2020-03-17 20:36:56.194636+00
oehzrfe12nddpecnng35jixxaynbn6nq	.eJxVjEEOwiAQRe_C2pDO0NLi0r1nIDMwSNVAUtqV8e7apAvd_vfefylP25r91mTxc1RnZaw6_Y5M4SFlJ_FO5VZ1qGVdZta7og_a9LVGeV4O9-8gU8vfmvpExo5I0TAHGACmaF0_GRehQ5LJCUjqAo4GHKKz3ZBGYYQhMWMI6v0BBLw3-w:1nY99V:b0JA9B6f3Pa-PLKMBwdT8qW2cKPmOOSXGe8i_iNkiik	2022-04-10 00:20:33.308208+00
q08qu2sogktht9fb4wg0jnlwozav8ul2	.eJxVjMEOwiAQRP-FsyFLKMJ69O43kAUWqRpISnsy_rs06UEPk0zmzcxbeNrW4rfOi5-TuAgjTr9ZoPjkuoP0oHpvMra6LnOQe0UetMtbS_y6Ht2_g0K9jHWEM2sAZM7oMiNaIONIZ4cMIdnIwzqDaihpZ3SYGLIzGVXQVk3i8wXrTzen:1l6QK7:K5xwM94dthWy2p7Pu-YxYuIsHea1mPcTE7J5QgyNE0I	2021-02-15 11:56:23.174543+00
q4pcjghohotjfli31pb9h8k728dp6adl	.eJxVjMEOwiAQRP-FsyFLKMJ69O43kAUWqRpISnsy_rs06UEPk0zmzcxbeNrW4rfOi5-TuAgjTr9ZoPjkuoP0oHpvMra6LnOQe0UetMtbS_y6Ht2_g0K9jHWEM2sAZM7oMiNaIONIZ4cMIdnIwzqDaihpZ3SYGLIzGVXQVk3i8wXrTzen:1lE17X:NBwqsf28PwI3FW3K-eqxgM8glCVZKEPVZVBdCW82kUQ	2021-03-08 10:38:47.763456+00
qd8ir1ggzn0gsviulku0ja6fhun4ruz0	NjZiYTM5NzNiNDUwNzk4NDgyMWRjZTBhNzliZDQ3N2RlZmU4ZTViNDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJmY2RiNzE3NTNiZmE1OGEyYTVjYjBlYTZkMWIzYmE4NjM5ODgxNjMxIn0=	2020-03-18 20:13:43.094693+00
qkmzn0yze2h929ui10n6e1hp4url7o0x	.eJxVjMEOwiAQRP-FsyFLKMJ69O43kAUWqRpISnsy_rs06UEPk0zmzcxbeNrW4rfOi5-TuAgjTr9ZoPjkuoP0oHpvMra6LnOQe0UetMtbS_y6Ht2_g0K9jHWEM2sAZM7oMiNaIONIZ4cMIdnIwzqDaihpZ3SYGLIzGVXQVk3i8wXrTzen:1lE4Y8:BdIN9fD7wFEx1d6xRxKwCah15TNUJMET0euuw6iqIWo	2021-03-08 14:18:28.753648+00
ravwtqymw5g4c7fskr331a86ked5dgl9	.eJxVjEEOwiAQRe_C2pDO0NLi0r1nIDMwSNVAUtqV8e7apAvd_vfefylP25r91mTxc1RnZaw6_Y5M4SFlJ_FO5VZ1qGVdZta7og_a9LVGeV4O9-8gU8vfmvpExo5I0TAHGACmaF0_GRehQ5LJCUjqAo4GHKKz3ZBGYYQhMWMI6v0BBLw3-w:1miSrN:_IGNDyq_2jOyJz_O9uynPY7b-hEfwd4JjGraJDPj_MQ	2021-11-18 10:52:13.531641+00
rbal6psg5qatn4blsakknlev5bji25b7	.eJxVjMEOwiAQRP-FsyFLKMJ69O43kAUWqRpISnsy_rs06UEPk0zmzcxbeNrW4rfOi5-TuAgjTr9ZoPjkuoP0oHpvMra6LnOQe0UetMtbS_y6Ht2_g0K9jHWEM2sAZM7oMiNaIONIZ4cMIdnIwzqDaihpZ3SYGLIzGVXQVk3i8wXrTzen:1l1Kt4:FjBpsrLCDBG67jp21z5ZIAhQwFfLckQOQqdwBF6iqV4	2021-02-01 11:07:26.585141+00
ro9wsvqvv5uw4rzt757n0na3rgfnx39n	.eJxVjMEOwiAQRP-FsyFLKMJ69O43kAUWqRpISnsy_rs06UEPk0zmzcxbeNrW4rfOi5-TuAgjTr9ZoPjkuoP0oHpvMra6LnOQe0UetMtbS_y6Ht2_g0K9jHWEM2sAZM7oMiNaIONIZ4cMIdnIwzqDaihpZ3SYGLIzGVXQVk3i8wXrTzen:1ku9oD:tDPZ48udTwGyhs7kr--elTc5Mm9vyTXyqVNjCizPMr8	2021-01-12 15:52:45.519477+00
sv76jz2d1x2miehd524x0w6gik36ftq1	.eJxVjMEOwiAQRP-FsyFLKMJ69O43kAUWqRpISnsy_rs06UEPk0zmzcxbeNrW4rfOi5-TuAgjTr9ZoPjkuoP0oHpvMra6LnOQe0UetMtbS_y6Ht2_g0K9jHWEM2sAZM7oMiNaIONIZ4cMIdnIwzqDaihpZ3SYGLIzGVXQVk3i8wXrTzen:1kVEAM:L6XrGV6xNih2gzib5T-gCgQkd-VeHKXX2wfyEPHUuhQ	2020-11-04 21:28:34.01331+00
tcvqk2gx6h4hem5e9zvetchi5s5r8lrc	OTEwOTA3ODQzOWFiM2QwZGRkMDUwN2Q0YWMwNjM5NTU0MDkyZTExYzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIwYjU1ZGY4ZjdlMzhiNjRkMDVkM2M4MTMyZDZlODRiZTVkMTAyYWFmIn0=	2020-04-24 08:12:23.224556+00
tdmp4904rek1sidppitdx7np5khk8jlf	.eJxVjEEOwiAQRe_C2pDO0NLi0r1nIDMwSNVAUtqV8e7apAvd_vfefylP25r91mTxc1RnZaw6_Y5M4SFlJ_FO5VZ1qGVdZta7og_a9LVGeV4O9-8gU8vfmvpExo5I0TAHGACmaF0_GRehQ5LJCUjqAo4GHKKz3ZBGYYQhMWMI6v0BBLw3-w:1nqn9k:OrYi-TuSZFUNdJdfI3XI4rAl-dNUQrXbT2RuOf4WOmo	2022-05-31 10:41:52.107178+00
v829p49eq1fotkzwf19hc7iv411v7el5	OTEwOTA3ODQzOWFiM2QwZGRkMDUwN2Q0YWMwNjM5NTU0MDkyZTExYzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIwYjU1ZGY4ZjdlMzhiNjRkMDVkM2M4MTMyZDZlODRiZTVkMTAyYWFmIn0=	2020-05-05 20:57:56.513253+00
vcdltnut7vtqjqg2getb1mu4h21gpwsb	.eJxVjMEOwiAQRP-FsyEgUBeP3vsNZNmlUjWQlPZk_Hdp0oMmkznMm5m3CLitOWwtLWFmcRVenH6ziPRMZQf8wHKvkmpZlznKvSIP2uRYOb1uR_fvIGPLfa2cTV2TAw2kJjZMEQEs6svQXyI6GgyB8hTh7COzMc57ZTR0t8qLzxf29jey:1kjcIS:xgqpb5dZh0I2UMePUMidMfbJDwsMgh5shlcilvmpdI0	2020-12-14 14:04:24.028053+00
vem2uskxx9pq29h9b028274cg3mkrtfp	.eJxVjEEOgjAQRe_StWlmWijUpXvP0Mx0poIaSCisjHdXEha6_e-9_zKJtnVIW9UljWLOxpnT78aUHzrtQO403Wab52ldRra7Yg9a7XUWfV4O9-9goDp8ax9iEyMIopPcspNGfQkK3GPBANlDyz4rSMAukAOKXV8AmJseSUHN-wPMczeF:1kjZyk:6zz_w5VYV7N9IqfHV82Q6e3G-QRynH40ugQDJf6zzLE	2020-12-14 11:35:54.693134+00
w79f4ud438o3ozoc6zvno74jbn2e45mu	.eJxVjEEOwiAQRe_C2pDO0NLi0r1nIDMwSNVAUtqV8e7apAvd_vfefylP25r91mTxc1RnZaw6_Y5M4SFlJ_FO5VZ1qGVdZta7og_a9LVGeV4O9-8gU8vfmvpExo5I0TAHGACmaF0_GRehQ5LJCUjqAo4GHKKz3ZBGYYQhMWMI6v0BBLw3-w:1nlYP2:Q1jfus9XgtmtcyVGyL4n3b5vl2NMSdkv2gfvjUzvAOA	2022-05-16 23:56:00.015274+00
yubs6nefayz2wfof5ng1hoat6qge53kz	NjZiYTM5NzNiNDUwNzk4NDgyMWRjZTBhNzliZDQ3N2RlZmU4ZTViNDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJmY2RiNzE3NTNiZmE1OGEyYTVjYjBlYTZkMWIzYmE4NjM5ODgxNjMxIn0=	2020-03-18 13:51:42.386922+00
z3elbd8e2233fftjfaen22cyclpc1iu3	ZTIyY2QxNDIzNjcxMzVhYTNkMGRlMmJmZGY1YTI3OTFmMjNmNmMzYTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIzMWQ4MzMxOGM2ZDlkODM2YzE1NTVmYmU5ZWJiZWIwODdmYTI3OWUzIn0=	2020-02-28 13:20:20.652045+00
\.


--
-- Name: alcpt_achievement_id_seq; Type: SEQUENCE SET; Schema: alcpt; Owner: postgres
--

SELECT pg_catalog.setval('alcpt.alcpt_achievement_id_seq', 42, true);


--
-- Name: alcpt_answer_id_seq; Type: SEQUENCE SET; Schema: alcpt; Owner: postgres
--

SELECT pg_catalog.setval('alcpt.alcpt_answer_id_seq', 2902, true);


--
-- Name: alcpt_answersheet_id_seq; Type: SEQUENCE SET; Schema: alcpt; Owner: postgres
--

SELECT pg_catalog.setval('alcpt.alcpt_answersheet_id_seq', 141, true);


--
-- Name: alcpt_choice_id_seq; Type: SEQUENCE SET; Schema: alcpt; Owner: postgres
--

SELECT pg_catalog.setval('alcpt.alcpt_choice_id_seq', 2116, true);


--
-- Name: alcpt_department_id_seq; Type: SEQUENCE SET; Schema: alcpt; Owner: postgres
--

SELECT pg_catalog.setval('alcpt.alcpt_department_id_seq', 4, true);


--
-- Name: alcpt_exam_id_seq; Type: SEQUENCE SET; Schema: alcpt; Owner: postgres
--

SELECT pg_catalog.setval('alcpt.alcpt_exam_id_seq', 111, true);


--
-- Name: alcpt_exam_testeelist_id_seq; Type: SEQUENCE SET; Schema: alcpt; Owner: postgres
--

SELECT pg_catalog.setval('alcpt.alcpt_exam_testeelist_id_seq', 297, true);


--
-- Name: alcpt_forum_id_seq; Type: SEQUENCE SET; Schema: alcpt; Owner: postgres
--

SELECT pg_catalog.setval('alcpt.alcpt_forum_id_seq', 258, true);


--
-- Name: alcpt_group_id_seq; Type: SEQUENCE SET; Schema: alcpt; Owner: postgres
--

SELECT pg_catalog.setval('alcpt.alcpt_group_id_seq', 31, true);


--
-- Name: alcpt_group_member_id_seq; Type: SEQUENCE SET; Schema: alcpt; Owner: postgres
--

SELECT pg_catalog.setval('alcpt.alcpt_group_member_id_seq', 134, true);


--
-- Name: alcpt_proclamation_id_seq; Type: SEQUENCE SET; Schema: alcpt; Owner: postgres
--

SELECT pg_catalog.setval('alcpt.alcpt_proclamation_id_seq', 177, true);


--
-- Name: alcpt_question_favorite_id_seq; Type: SEQUENCE SET; Schema: alcpt; Owner: postgres
--

SELECT pg_catalog.setval('alcpt.alcpt_question_favorite_id_seq', 45, true);


--
-- Name: alcpt_question_id_seq; Type: SEQUENCE SET; Schema: alcpt; Owner: postgres
--

SELECT pg_catalog.setval('alcpt.alcpt_question_id_seq', 540, true);


--
-- Name: alcpt_reply_id_seq; Type: SEQUENCE SET; Schema: alcpt; Owner: postgres
--

SELECT pg_catalog.setval('alcpt.alcpt_reply_id_seq', 1, true);


--
-- Name: alcpt_report_id_seq; Type: SEQUENCE SET; Schema: alcpt; Owner: postgres
--

SELECT pg_catalog.setval('alcpt.alcpt_report_id_seq', 27, true);


--
-- Name: alcpt_reportcategory_id_seq; Type: SEQUENCE SET; Schema: alcpt; Owner: postgres
--

SELECT pg_catalog.setval('alcpt.alcpt_reportcategory_id_seq', 4, true);


--
-- Name: alcpt_squadron_id_seq; Type: SEQUENCE SET; Schema: alcpt; Owner: postgres
--

SELECT pg_catalog.setval('alcpt.alcpt_squadron_id_seq', 5, true);


--
-- Name: alcpt_student_id_seq; Type: SEQUENCE SET; Schema: alcpt; Owner: postgres
--

SELECT pg_catalog.setval('alcpt.alcpt_student_id_seq', 34, true);


--
-- Name: alcpt_testpaper_id_seq; Type: SEQUENCE SET; Schema: alcpt; Owner: postgres
--

SELECT pg_catalog.setval('alcpt.alcpt_testpaper_id_seq', 94, true);


--
-- Name: alcpt_testpaper_question_list_id_seq; Type: SEQUENCE SET; Schema: alcpt; Owner: postgres
--

SELECT pg_catalog.setval('alcpt.alcpt_testpaper_question_list_id_seq', 2272, true);


--
-- Name: alcpt_user_id_seq; Type: SEQUENCE SET; Schema: alcpt; Owner: postgres
--

SELECT pg_catalog.setval('alcpt.alcpt_user_id_seq', 41, true);


--
-- Name: alcpt_userachievement_id_seq; Type: SEQUENCE SET; Schema: alcpt; Owner: postgres
--

SELECT pg_catalog.setval('alcpt.alcpt_userachievement_id_seq', 855, true);


--
-- Name: alcpt_word_id_seq; Type: SEQUENCE SET; Schema: alcpt; Owner: postgres
--

SELECT pg_catalog.setval('alcpt.alcpt_word_id_seq', 1, true);


--
-- Name: alcpt_word_library_id_seq; Type: SEQUENCE SET; Schema: alcpt; Owner: postgres
--

SELECT pg_catalog.setval('alcpt.alcpt_word_library_id_seq', 4, true);


--
-- Name: audio_file_id_seq; Type: SEQUENCE SET; Schema: alcpt; Owner: postgres
--

SELECT pg_catalog.setval('alcpt.audio_file_id_seq', 1, true);


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: alcpt; Owner: postgres
--

SELECT pg_catalog.setval('alcpt.auth_group_id_seq', 1, true);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: alcpt; Owner: postgres
--

SELECT pg_catalog.setval('alcpt.auth_group_permissions_id_seq', 1, true);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: alcpt; Owner: postgres
--

SELECT pg_catalog.setval('alcpt.auth_permission_id_seq', 123, true);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: alcpt; Owner: postgres
--

SELECT pg_catalog.setval('alcpt.auth_user_groups_id_seq', 1, true);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: alcpt; Owner: postgres
--

SELECT pg_catalog.setval('alcpt.auth_user_id_seq', 1, true);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: alcpt; Owner: postgres
--

SELECT pg_catalog.setval('alcpt.auth_user_user_permissions_id_seq', 1, true);


--
-- Name: captcha_captchastore_id_seq; Type: SEQUENCE SET; Schema: alcpt; Owner: postgres
--

SELECT pg_catalog.setval('alcpt.captcha_captchastore_id_seq', 519, true);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: alcpt; Owner: postgres
--

SELECT pg_catalog.setval('alcpt.django_admin_log_id_seq', 1, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: alcpt; Owner: postgres
--

SELECT pg_catalog.setval('alcpt.django_content_type_id_seq', 30, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: alcpt; Owner: postgres
--

SELECT pg_catalog.setval('alcpt.django_migrations_id_seq', 69, true);


--
-- Name: django_plotly_dash_dashapp_id_seq; Type: SEQUENCE SET; Schema: alcpt; Owner: postgres
--

SELECT pg_catalog.setval('alcpt.django_plotly_dash_dashapp_id_seq', 1, true);


--
-- Name: django_plotly_dash_statelessapp_id_seq; Type: SEQUENCE SET; Schema: alcpt; Owner: postgres
--

SELECT pg_catalog.setval('alcpt.django_plotly_dash_statelessapp_id_seq', 1, true);


--
-- Name: alcpt_achievement idx_24579_primary; Type: CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_achievement
    ADD CONSTRAINT idx_24579_primary PRIMARY KEY (id);


--
-- Name: alcpt_answer idx_24588_primary; Type: CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_answer
    ADD CONSTRAINT idx_24588_primary PRIMARY KEY (id);


--
-- Name: alcpt_answersheet idx_24594_primary; Type: CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_answersheet
    ADD CONSTRAINT idx_24594_primary PRIMARY KEY (id);


--
-- Name: alcpt_choice idx_24600_primary; Type: CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_choice
    ADD CONSTRAINT idx_24600_primary PRIMARY KEY (id);


--
-- Name: alcpt_department idx_24606_primary; Type: CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_department
    ADD CONSTRAINT idx_24606_primary PRIMARY KEY (id);


--
-- Name: alcpt_exam idx_24612_primary; Type: CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_exam
    ADD CONSTRAINT idx_24612_primary PRIMARY KEY (id);


--
-- Name: alcpt_exam_testeelist idx_24618_primary; Type: CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_exam_testeelist
    ADD CONSTRAINT idx_24618_primary PRIMARY KEY (id);


--
-- Name: alcpt_forum idx_24624_primary; Type: CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_forum
    ADD CONSTRAINT idx_24624_primary PRIMARY KEY (id);


--
-- Name: alcpt_group idx_24633_primary; Type: CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_group
    ADD CONSTRAINT idx_24633_primary PRIMARY KEY (id);


--
-- Name: alcpt_group_member idx_24639_primary; Type: CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_group_member
    ADD CONSTRAINT idx_24639_primary PRIMARY KEY (id);


--
-- Name: alcpt_proclamation idx_24645_primary; Type: CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_proclamation
    ADD CONSTRAINT idx_24645_primary PRIMARY KEY (id);


--
-- Name: alcpt_question idx_24654_primary; Type: CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_question
    ADD CONSTRAINT idx_24654_primary PRIMARY KEY (id);


--
-- Name: alcpt_question_favorite idx_24663_primary; Type: CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_question_favorite
    ADD CONSTRAINT idx_24663_primary PRIMARY KEY (id);


--
-- Name: alcpt_reply idx_24669_primary; Type: CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_reply
    ADD CONSTRAINT idx_24669_primary PRIMARY KEY (id);


--
-- Name: alcpt_report idx_24678_primary; Type: CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_report
    ADD CONSTRAINT idx_24678_primary PRIMARY KEY (id);


--
-- Name: alcpt_reportcategory idx_24687_primary; Type: CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_reportcategory
    ADD CONSTRAINT idx_24687_primary PRIMARY KEY (id);


--
-- Name: alcpt_squadron idx_24693_primary; Type: CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_squadron
    ADD CONSTRAINT idx_24693_primary PRIMARY KEY (id);


--
-- Name: alcpt_student idx_24699_primary; Type: CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_student
    ADD CONSTRAINT idx_24699_primary PRIMARY KEY (id);


--
-- Name: alcpt_testpaper idx_24705_primary; Type: CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_testpaper
    ADD CONSTRAINT idx_24705_primary PRIMARY KEY (id);


--
-- Name: alcpt_testpaper_question_list idx_24711_primary; Type: CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_testpaper_question_list
    ADD CONSTRAINT idx_24711_primary PRIMARY KEY (id);


--
-- Name: alcpt_user idx_24717_primary; Type: CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_user
    ADD CONSTRAINT idx_24717_primary PRIMARY KEY (id);


--
-- Name: alcpt_userachievement idx_24726_primary; Type: CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_userachievement
    ADD CONSTRAINT idx_24726_primary PRIMARY KEY (id);


--
-- Name: alcpt_word idx_24732_primary; Type: CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_word
    ADD CONSTRAINT idx_24732_primary PRIMARY KEY (id);


--
-- Name: alcpt_word_library idx_24741_primary; Type: CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_word_library
    ADD CONSTRAINT idx_24741_primary PRIMARY KEY (id);


--
-- Name: audio_file idx_24750_primary; Type: CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.audio_file
    ADD CONSTRAINT idx_24750_primary PRIMARY KEY (id);


--
-- Name: auth_group idx_24756_primary; Type: CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.auth_group
    ADD CONSTRAINT idx_24756_primary PRIMARY KEY (id);


--
-- Name: auth_group_permissions idx_24762_primary; Type: CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.auth_group_permissions
    ADD CONSTRAINT idx_24762_primary PRIMARY KEY (id);


--
-- Name: auth_permission idx_24768_primary; Type: CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.auth_permission
    ADD CONSTRAINT idx_24768_primary PRIMARY KEY (id);


--
-- Name: auth_user idx_24774_primary; Type: CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.auth_user
    ADD CONSTRAINT idx_24774_primary PRIMARY KEY (id);


--
-- Name: auth_user_groups idx_24783_primary; Type: CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.auth_user_groups
    ADD CONSTRAINT idx_24783_primary PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions idx_24789_primary; Type: CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.auth_user_user_permissions
    ADD CONSTRAINT idx_24789_primary PRIMARY KEY (id);


--
-- Name: captcha_captchastore idx_24795_primary; Type: CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.captcha_captchastore
    ADD CONSTRAINT idx_24795_primary PRIMARY KEY (id);


--
-- Name: django_admin_log idx_24801_primary; Type: CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.django_admin_log
    ADD CONSTRAINT idx_24801_primary PRIMARY KEY (id);


--
-- Name: django_content_type idx_24810_primary; Type: CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.django_content_type
    ADD CONSTRAINT idx_24810_primary PRIMARY KEY (id);


--
-- Name: django_migrations idx_24816_primary; Type: CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.django_migrations
    ADD CONSTRAINT idx_24816_primary PRIMARY KEY (id);


--
-- Name: django_plotly_dash_dashapp idx_24825_primary; Type: CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.django_plotly_dash_dashapp
    ADD CONSTRAINT idx_24825_primary PRIMARY KEY (id);


--
-- Name: django_plotly_dash_statelessapp idx_24834_primary; Type: CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.django_plotly_dash_statelessapp
    ADD CONSTRAINT idx_24834_primary PRIMARY KEY (id);


--
-- Name: django_session idx_24838_primary; Type: CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.django_session
    ADD CONSTRAINT idx_24838_primary PRIMARY KEY (session_key);


--
-- Name: idx_24588_alcpt_answer_answer_sheet_id_c4fe1234_fk_alcpt_answer; Type: INDEX; Schema: alcpt; Owner: postgres
--

CREATE INDEX idx_24588_alcpt_answer_answer_sheet_id_c4fe1234_fk_alcpt_answer ON alcpt.alcpt_answer USING btree (answer_sheet_id);


--
-- Name: idx_24588_alcpt_answer_question_id_af4ab1ab_fk_alcpt_question_i; Type: INDEX; Schema: alcpt; Owner: postgres
--

CREATE INDEX idx_24588_alcpt_answer_question_id_af4ab1ab_fk_alcpt_question_i ON alcpt.alcpt_answer USING btree (question_id);


--
-- Name: idx_24594_alcpt_answersheet_exam_id_147bc9a1_fk_alcpt_exam_id; Type: INDEX; Schema: alcpt; Owner: postgres
--

CREATE INDEX idx_24594_alcpt_answersheet_exam_id_147bc9a1_fk_alcpt_exam_id ON alcpt.alcpt_answersheet USING btree (exam_id);


--
-- Name: idx_24594_alcpt_answersheet_user_id_8e290a44_fk_alcpt_user_id; Type: INDEX; Schema: alcpt; Owner: postgres
--

CREATE INDEX idx_24594_alcpt_answersheet_user_id_8e290a44_fk_alcpt_user_id ON alcpt.alcpt_answersheet USING btree (user_id);


--
-- Name: idx_24600_alcpt_choice_question_id_cdc3736d_fk_alcpt_question_i; Type: INDEX; Schema: alcpt; Owner: postgres
--

CREATE INDEX idx_24600_alcpt_choice_question_id_cdc3736d_fk_alcpt_question_i ON alcpt.alcpt_choice USING btree (question_id);


--
-- Name: idx_24606_name; Type: INDEX; Schema: alcpt; Owner: postgres
--

CREATE UNIQUE INDEX idx_24606_name ON alcpt.alcpt_department USING btree (name);


--
-- Name: idx_24612_alcpt_exam_created_by_id_3e8088e6_fk_alcpt_user_id; Type: INDEX; Schema: alcpt; Owner: postgres
--

CREATE INDEX idx_24612_alcpt_exam_created_by_id_3e8088e6_fk_alcpt_user_id ON alcpt.alcpt_exam USING btree (created_by_id);


--
-- Name: idx_24612_alcpt_exam_testpaper_id_6048fb92_fk_alcpt_testpaper_i; Type: INDEX; Schema: alcpt; Owner: postgres
--

CREATE INDEX idx_24612_alcpt_exam_testpaper_id_6048fb92_fk_alcpt_testpaper_i ON alcpt.alcpt_exam USING btree (testpaper_id);


--
-- Name: idx_24612_name; Type: INDEX; Schema: alcpt; Owner: postgres
--

CREATE UNIQUE INDEX idx_24612_name ON alcpt.alcpt_exam USING btree (name);


--
-- Name: idx_24618_alcpt_exam_testeelist_exam_id_user_id_3c6f3f1f_uniq; Type: INDEX; Schema: alcpt; Owner: postgres
--

CREATE UNIQUE INDEX idx_24618_alcpt_exam_testeelist_exam_id_user_id_3c6f3f1f_uniq ON alcpt.alcpt_exam_testeelist USING btree (exam_id, user_id);


--
-- Name: idx_24618_alcpt_exam_testeelist_user_id_465cf978_fk_alcpt_user_; Type: INDEX; Schema: alcpt; Owner: postgres
--

CREATE INDEX idx_24618_alcpt_exam_testeelist_user_id_465cf978_fk_alcpt_user_ ON alcpt.alcpt_exam_testeelist USING btree (user_id);


--
-- Name: idx_24624_alcpt_forum_f_creator_id_2d5c97cb; Type: INDEX; Schema: alcpt; Owner: postgres
--

CREATE INDEX idx_24624_alcpt_forum_f_creator_id_2d5c97cb ON alcpt.alcpt_forum USING btree (f_creator_id);


--
-- Name: idx_24624_alcpt_forum_f_question_id_c48581b1; Type: INDEX; Schema: alcpt; Owner: postgres
--

CREATE INDEX idx_24624_alcpt_forum_f_question_id_c48581b1 ON alcpt.alcpt_forum USING btree (f_question_id);


--
-- Name: idx_24633_alcpt_group_created_by_id_f15e6b32_fk_alcpt_user_id; Type: INDEX; Schema: alcpt; Owner: postgres
--

CREATE INDEX idx_24633_alcpt_group_created_by_id_f15e6b32_fk_alcpt_user_id ON alcpt.alcpt_group USING btree (created_by_id);


--
-- Name: idx_24633_name; Type: INDEX; Schema: alcpt; Owner: postgres
--

CREATE UNIQUE INDEX idx_24633_name ON alcpt.alcpt_group USING btree (name);


--
-- Name: idx_24639_alcpt_group_member_group_id_user_id_5bfb75ae_uniq; Type: INDEX; Schema: alcpt; Owner: postgres
--

CREATE UNIQUE INDEX idx_24639_alcpt_group_member_group_id_user_id_5bfb75ae_uniq ON alcpt.alcpt_group_member USING btree (group_id, user_id);


--
-- Name: idx_24639_alcpt_group_member_user_id_6268bc82_fk_alcpt_user_id; Type: INDEX; Schema: alcpt; Owner: postgres
--

CREATE INDEX idx_24639_alcpt_group_member_user_id_6268bc82_fk_alcpt_user_id ON alcpt.alcpt_group_member USING btree (user_id);


--
-- Name: idx_24645_alcpt_proclamation_created_by_id_02e079a0_fk_alcpt_us; Type: INDEX; Schema: alcpt; Owner: postgres
--

CREATE INDEX idx_24645_alcpt_proclamation_created_by_id_02e079a0_fk_alcpt_us ON alcpt.alcpt_proclamation USING btree (created_by_id);


--
-- Name: idx_24645_alcpt_proclamation_recipient_id_dc91a846_fk_alcpt_use; Type: INDEX; Schema: alcpt; Owner: postgres
--

CREATE INDEX idx_24645_alcpt_proclamation_recipient_id_dc91a846_fk_alcpt_use ON alcpt.alcpt_proclamation USING btree (recipient_id);


--
-- Name: idx_24654_alcpt_question_created_by_id_2c7db757_fk_alcpt_user_i; Type: INDEX; Schema: alcpt; Owner: postgres
--

CREATE INDEX idx_24654_alcpt_question_created_by_id_2c7db757_fk_alcpt_user_i ON alcpt.alcpt_question USING btree (created_by_id);


--
-- Name: idx_24654_alcpt_question_last_updated_by_id_7e7caa2c_fk_alcpt_u; Type: INDEX; Schema: alcpt; Owner: postgres
--

CREATE INDEX idx_24654_alcpt_question_last_updated_by_id_7e7caa2c_fk_alcpt_u ON alcpt.alcpt_question USING btree (last_updated_by_id);


--
-- Name: idx_24654_replier_id; Type: INDEX; Schema: alcpt; Owner: postgres
--

CREATE UNIQUE INDEX idx_24654_replier_id ON alcpt.alcpt_question USING btree (replier_id);


--
-- Name: idx_24663_alcpt_question_favorite_question_id_user_id_c0064f48_; Type: INDEX; Schema: alcpt; Owner: postgres
--

CREATE UNIQUE INDEX idx_24663_alcpt_question_favorite_question_id_user_id_c0064f48_ ON alcpt.alcpt_question_favorite USING btree (question_id, user_id);


--
-- Name: idx_24663_alcpt_question_favorite_user_id_8d37521c_fk_alcpt_use; Type: INDEX; Schema: alcpt; Owner: postgres
--

CREATE INDEX idx_24663_alcpt_question_favorite_user_id_8d37521c_fk_alcpt_use ON alcpt.alcpt_question_favorite USING btree (user_id);


--
-- Name: idx_24669_alcpt_reply_created_by_id_40250197_fk_alcpt_user_id; Type: INDEX; Schema: alcpt; Owner: postgres
--

CREATE INDEX idx_24669_alcpt_reply_created_by_id_40250197_fk_alcpt_user_id ON alcpt.alcpt_reply USING btree (created_by_id);


--
-- Name: idx_24669_alcpt_reply_source_id_0390ee54_fk_alcpt_report_id; Type: INDEX; Schema: alcpt; Owner: postgres
--

CREATE INDEX idx_24669_alcpt_reply_source_id_0390ee54_fk_alcpt_report_id ON alcpt.alcpt_reply USING btree (source_id);


--
-- Name: idx_24678_alcpt_report_category_id_108323c9_fk_alcpt_reportcate; Type: INDEX; Schema: alcpt; Owner: postgres
--

CREATE INDEX idx_24678_alcpt_report_category_id_108323c9_fk_alcpt_reportcate ON alcpt.alcpt_report USING btree (category_id);


--
-- Name: idx_24678_alcpt_report_created_by_id_82b9f434_fk_alcpt_user_id; Type: INDEX; Schema: alcpt; Owner: postgres
--

CREATE INDEX idx_24678_alcpt_report_created_by_id_82b9f434_fk_alcpt_user_id ON alcpt.alcpt_report USING btree (created_by_id);


--
-- Name: idx_24678_alcpt_report_question_id_171cd9d9_fk_alcpt_question_i; Type: INDEX; Schema: alcpt; Owner: postgres
--

CREATE INDEX idx_24678_alcpt_report_question_id_171cd9d9_fk_alcpt_question_i ON alcpt.alcpt_report USING btree (question_id);


--
-- Name: idx_24678_alcpt_report_resolved_by_id_4dc90590_fk_alcpt_user_id; Type: INDEX; Schema: alcpt; Owner: postgres
--

CREATE INDEX idx_24678_alcpt_report_resolved_by_id_4dc90590_fk_alcpt_user_id ON alcpt.alcpt_report USING btree (resolved_by_id);


--
-- Name: idx_24687_name; Type: INDEX; Schema: alcpt; Owner: postgres
--

CREATE UNIQUE INDEX idx_24687_name ON alcpt.alcpt_reportcategory USING btree (name);


--
-- Name: idx_24693_name; Type: INDEX; Schema: alcpt; Owner: postgres
--

CREATE UNIQUE INDEX idx_24693_name ON alcpt.alcpt_squadron USING btree (name);


--
-- Name: idx_24699_alcpt_student_department_id_257bfbd3_fk_alcpt_departm; Type: INDEX; Schema: alcpt; Owner: postgres
--

CREATE INDEX idx_24699_alcpt_student_department_id_257bfbd3_fk_alcpt_departm ON alcpt.alcpt_student USING btree (department_id);


--
-- Name: idx_24699_alcpt_student_squadron_id_4bbcc05a_fk_alcpt_squadron_; Type: INDEX; Schema: alcpt; Owner: postgres
--

CREATE INDEX idx_24699_alcpt_student_squadron_id_4bbcc05a_fk_alcpt_squadron_ ON alcpt.alcpt_student USING btree (squadron_id);


--
-- Name: idx_24699_stu_id; Type: INDEX; Schema: alcpt; Owner: postgres
--

CREATE UNIQUE INDEX idx_24699_stu_id ON alcpt.alcpt_student USING btree (stu_id);


--
-- Name: idx_24699_user_id; Type: INDEX; Schema: alcpt; Owner: postgres
--

CREATE UNIQUE INDEX idx_24699_user_id ON alcpt.alcpt_student USING btree (user_id);


--
-- Name: idx_24705_alcpt_testpaper_created_by_id_def16d7a_fk_alcpt_user_; Type: INDEX; Schema: alcpt; Owner: postgres
--

CREATE INDEX idx_24705_alcpt_testpaper_created_by_id_def16d7a_fk_alcpt_user_ ON alcpt.alcpt_testpaper USING btree (created_by_id);


--
-- Name: idx_24705_name; Type: INDEX; Schema: alcpt; Owner: postgres
--

CREATE UNIQUE INDEX idx_24705_name ON alcpt.alcpt_testpaper USING btree (name);


--
-- Name: idx_24711_alcpt_testpaper_ques_question_id_980638fa_fk_alcpt_qu; Type: INDEX; Schema: alcpt; Owner: postgres
--

CREATE INDEX idx_24711_alcpt_testpaper_ques_question_id_980638fa_fk_alcpt_qu ON alcpt.alcpt_testpaper_question_list USING btree (question_id);


--
-- Name: idx_24711_alcpt_testpaper_question_testpaper_id_question_id_886; Type: INDEX; Schema: alcpt; Owner: postgres
--

CREATE UNIQUE INDEX idx_24711_alcpt_testpaper_question_testpaper_id_question_id_886 ON alcpt.alcpt_testpaper_question_list USING btree (testpaper_id, question_id);


--
-- Name: idx_24717_reg_id; Type: INDEX; Schema: alcpt; Owner: postgres
--

CREATE UNIQUE INDEX idx_24717_reg_id ON alcpt.alcpt_user USING btree (reg_id);


--
-- Name: idx_24726_alcpt_userachievemen_achievement_id_5cf009f6_fk_alcpt; Type: INDEX; Schema: alcpt; Owner: postgres
--

CREATE INDEX idx_24726_alcpt_userachievemen_achievement_id_5cf009f6_fk_alcpt ON alcpt.alcpt_userachievement USING btree (achievement_id);


--
-- Name: idx_24726_alcpt_userachievement_user_id_951479b3_fk_alcpt_user_; Type: INDEX; Schema: alcpt; Owner: postgres
--

CREATE INDEX idx_24726_alcpt_userachievement_user_id_951479b3_fk_alcpt_user_ ON alcpt.alcpt_userachievement USING btree (user_id);


--
-- Name: idx_24750_audio_file_user_id_ada556f9_fk_alcpt_user_id; Type: INDEX; Schema: alcpt; Owner: postgres
--

CREATE INDEX idx_24750_audio_file_user_id_ada556f9_fk_alcpt_user_id ON alcpt.audio_file USING btree (user_id);


--
-- Name: idx_24756_name; Type: INDEX; Schema: alcpt; Owner: postgres
--

CREATE UNIQUE INDEX idx_24756_name ON alcpt.auth_group USING btree (name);


--
-- Name: idx_24762_auth_group_permissio_permission_id_84c5c92e_fk_auth_p; Type: INDEX; Schema: alcpt; Owner: postgres
--

CREATE INDEX idx_24762_auth_group_permissio_permission_id_84c5c92e_fk_auth_p ON alcpt.auth_group_permissions USING btree (permission_id);


--
-- Name: idx_24762_auth_group_permissions_group_id_permission_id_0cd325b; Type: INDEX; Schema: alcpt; Owner: postgres
--

CREATE UNIQUE INDEX idx_24762_auth_group_permissions_group_id_permission_id_0cd325b ON alcpt.auth_group_permissions USING btree (group_id, permission_id);


--
-- Name: idx_24768_auth_permission_content_type_id_codename_01ab375a_uni; Type: INDEX; Schema: alcpt; Owner: postgres
--

CREATE UNIQUE INDEX idx_24768_auth_permission_content_type_id_codename_01ab375a_uni ON alcpt.auth_permission USING btree (content_type_id, codename);


--
-- Name: idx_24774_username; Type: INDEX; Schema: alcpt; Owner: postgres
--

CREATE UNIQUE INDEX idx_24774_username ON alcpt.auth_user USING btree (username);


--
-- Name: idx_24783_auth_user_groups_group_id_97559544_fk_auth_group_id; Type: INDEX; Schema: alcpt; Owner: postgres
--

CREATE INDEX idx_24783_auth_user_groups_group_id_97559544_fk_auth_group_id ON alcpt.auth_user_groups USING btree (group_id);


--
-- Name: idx_24783_auth_user_groups_user_id_group_id_94350c0c_uniq; Type: INDEX; Schema: alcpt; Owner: postgres
--

CREATE UNIQUE INDEX idx_24783_auth_user_groups_user_id_group_id_94350c0c_uniq ON alcpt.auth_user_groups USING btree (user_id, group_id);


--
-- Name: idx_24789_auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_p; Type: INDEX; Schema: alcpt; Owner: postgres
--

CREATE INDEX idx_24789_auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_p ON alcpt.auth_user_user_permissions USING btree (permission_id);


--
-- Name: idx_24789_auth_user_user_permissions_user_id_permission_id_14a6; Type: INDEX; Schema: alcpt; Owner: postgres
--

CREATE UNIQUE INDEX idx_24789_auth_user_user_permissions_user_id_permission_id_14a6 ON alcpt.auth_user_user_permissions USING btree (user_id, permission_id);


--
-- Name: idx_24795_hashkey; Type: INDEX; Schema: alcpt; Owner: postgres
--

CREATE UNIQUE INDEX idx_24795_hashkey ON alcpt.captcha_captchastore USING btree (hashkey);


--
-- Name: idx_24801_django_admin_log_content_type_id_c4bce8eb_fk_django_c; Type: INDEX; Schema: alcpt; Owner: postgres
--

CREATE INDEX idx_24801_django_admin_log_content_type_id_c4bce8eb_fk_django_c ON alcpt.django_admin_log USING btree (content_type_id);


--
-- Name: idx_24801_django_admin_log_user_id_c564eba6_fk_alcpt_user_id; Type: INDEX; Schema: alcpt; Owner: postgres
--

CREATE INDEX idx_24801_django_admin_log_user_id_c564eba6_fk_alcpt_user_id ON alcpt.django_admin_log USING btree (user_id);


--
-- Name: idx_24810_django_content_type_app_label_model_76bd3d3b_uniq; Type: INDEX; Schema: alcpt; Owner: postgres
--

CREATE UNIQUE INDEX idx_24810_django_content_type_app_label_model_76bd3d3b_uniq ON alcpt.django_content_type USING btree (app_label, model);


--
-- Name: idx_24825_django_plotly_dash_d_stateless_app_id_220444de_fk_dja; Type: INDEX; Schema: alcpt; Owner: postgres
--

CREATE INDEX idx_24825_django_plotly_dash_d_stateless_app_id_220444de_fk_dja ON alcpt.django_plotly_dash_dashapp USING btree (stateless_app_id);


--
-- Name: idx_24825_instance_name; Type: INDEX; Schema: alcpt; Owner: postgres
--

CREATE UNIQUE INDEX idx_24825_instance_name ON alcpt.django_plotly_dash_dashapp USING btree (instance_name);


--
-- Name: idx_24825_slug; Type: INDEX; Schema: alcpt; Owner: postgres
--

CREATE UNIQUE INDEX idx_24825_slug ON alcpt.django_plotly_dash_dashapp USING btree (slug);


--
-- Name: idx_24834_app_name; Type: INDEX; Schema: alcpt; Owner: postgres
--

CREATE UNIQUE INDEX idx_24834_app_name ON alcpt.django_plotly_dash_statelessapp USING btree (app_name);


--
-- Name: idx_24834_slug; Type: INDEX; Schema: alcpt; Owner: postgres
--

CREATE UNIQUE INDEX idx_24834_slug ON alcpt.django_plotly_dash_statelessapp USING btree (slug);


--
-- Name: idx_24838_django_session_expire_date_a5c62663; Type: INDEX; Schema: alcpt; Owner: postgres
--

CREATE INDEX idx_24838_django_session_expire_date_a5c62663 ON alcpt.django_session USING btree (expire_date);


--
-- Name: alcpt_answer alcpt_answer_answer_sheet_id_c4fe1234_fk_alcpt_answersheet_id; Type: FK CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_answer
    ADD CONSTRAINT alcpt_answer_answer_sheet_id_c4fe1234_fk_alcpt_answersheet_id FOREIGN KEY (answer_sheet_id) REFERENCES alcpt.alcpt_answersheet(id);


--
-- Name: alcpt_answer alcpt_answer_question_id_af4ab1ab_fk_alcpt_question_id; Type: FK CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_answer
    ADD CONSTRAINT alcpt_answer_question_id_af4ab1ab_fk_alcpt_question_id FOREIGN KEY (question_id) REFERENCES alcpt.alcpt_question(id);


--
-- Name: alcpt_answersheet alcpt_answersheet_exam_id_147bc9a1_fk_alcpt_exam_id; Type: FK CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_answersheet
    ADD CONSTRAINT alcpt_answersheet_exam_id_147bc9a1_fk_alcpt_exam_id FOREIGN KEY (exam_id) REFERENCES alcpt.alcpt_exam(id);


--
-- Name: alcpt_answersheet alcpt_answersheet_user_id_8e290a44_fk_alcpt_user_id; Type: FK CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_answersheet
    ADD CONSTRAINT alcpt_answersheet_user_id_8e290a44_fk_alcpt_user_id FOREIGN KEY (user_id) REFERENCES alcpt.alcpt_user(id);


--
-- Name: alcpt_choice alcpt_choice_question_id_cdc3736d_fk_alcpt_question_id; Type: FK CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_choice
    ADD CONSTRAINT alcpt_choice_question_id_cdc3736d_fk_alcpt_question_id FOREIGN KEY (question_id) REFERENCES alcpt.alcpt_question(id);


--
-- Name: alcpt_exam alcpt_exam_created_by_id_3e8088e6_fk_alcpt_user_id; Type: FK CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_exam
    ADD CONSTRAINT alcpt_exam_created_by_id_3e8088e6_fk_alcpt_user_id FOREIGN KEY (created_by_id) REFERENCES alcpt.alcpt_user(id);


--
-- Name: alcpt_exam_testeelist alcpt_exam_testeelist_exam_id_3b6c9639_fk_alcpt_exam_id; Type: FK CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_exam_testeelist
    ADD CONSTRAINT alcpt_exam_testeelist_exam_id_3b6c9639_fk_alcpt_exam_id FOREIGN KEY (exam_id) REFERENCES alcpt.alcpt_exam(id);


--
-- Name: alcpt_exam_testeelist alcpt_exam_testeelist_user_id_465cf978_fk_alcpt_user_id; Type: FK CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_exam_testeelist
    ADD CONSTRAINT alcpt_exam_testeelist_user_id_465cf978_fk_alcpt_user_id FOREIGN KEY (user_id) REFERENCES alcpt.alcpt_user(id);


--
-- Name: alcpt_exam alcpt_exam_testpaper_id_6048fb92_fk_alcpt_testpaper_id; Type: FK CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_exam
    ADD CONSTRAINT alcpt_exam_testpaper_id_6048fb92_fk_alcpt_testpaper_id FOREIGN KEY (testpaper_id) REFERENCES alcpt.alcpt_testpaper(id);


--
-- Name: alcpt_forum alcpt_forum_f_creator_id_2d5c97cb_fk_alcpt_user_id; Type: FK CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_forum
    ADD CONSTRAINT alcpt_forum_f_creator_id_2d5c97cb_fk_alcpt_user_id FOREIGN KEY (f_creator_id) REFERENCES alcpt.alcpt_user(id);


--
-- Name: alcpt_forum alcpt_forum_f_question_id_c48581b1_fk_alcpt_question_id; Type: FK CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_forum
    ADD CONSTRAINT alcpt_forum_f_question_id_c48581b1_fk_alcpt_question_id FOREIGN KEY (f_question_id) REFERENCES alcpt.alcpt_question(id);


--
-- Name: alcpt_group alcpt_group_created_by_id_f15e6b32_fk_alcpt_user_id; Type: FK CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_group
    ADD CONSTRAINT alcpt_group_created_by_id_f15e6b32_fk_alcpt_user_id FOREIGN KEY (created_by_id) REFERENCES alcpt.alcpt_user(id);


--
-- Name: alcpt_group_member alcpt_group_member_group_id_b62cbe32_fk_alcpt_group_id; Type: FK CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_group_member
    ADD CONSTRAINT alcpt_group_member_group_id_b62cbe32_fk_alcpt_group_id FOREIGN KEY (group_id) REFERENCES alcpt.alcpt_group(id);


--
-- Name: alcpt_group_member alcpt_group_member_user_id_6268bc82_fk_alcpt_user_id; Type: FK CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_group_member
    ADD CONSTRAINT alcpt_group_member_user_id_6268bc82_fk_alcpt_user_id FOREIGN KEY (user_id) REFERENCES alcpt.alcpt_user(id);


--
-- Name: alcpt_proclamation alcpt_proclamation_created_by_id_02e079a0_fk_alcpt_user_id; Type: FK CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_proclamation
    ADD CONSTRAINT alcpt_proclamation_created_by_id_02e079a0_fk_alcpt_user_id FOREIGN KEY (created_by_id) REFERENCES alcpt.alcpt_user(id);


--
-- Name: alcpt_proclamation alcpt_proclamation_recipient_id_dc91a846_fk_alcpt_user_id; Type: FK CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_proclamation
    ADD CONSTRAINT alcpt_proclamation_recipient_id_dc91a846_fk_alcpt_user_id FOREIGN KEY (recipient_id) REFERENCES alcpt.alcpt_user(id);


--
-- Name: alcpt_question alcpt_question_created_by_id_2c7db757_fk_alcpt_user_id; Type: FK CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_question
    ADD CONSTRAINT alcpt_question_created_by_id_2c7db757_fk_alcpt_user_id FOREIGN KEY (created_by_id) REFERENCES alcpt.alcpt_user(id);


--
-- Name: alcpt_question_favorite alcpt_question_favor_question_id_e0108f03_fk_alcpt_que; Type: FK CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_question_favorite
    ADD CONSTRAINT alcpt_question_favor_question_id_e0108f03_fk_alcpt_que FOREIGN KEY (question_id) REFERENCES alcpt.alcpt_question(id);


--
-- Name: alcpt_question_favorite alcpt_question_favorite_user_id_8d37521c_fk_alcpt_user_id; Type: FK CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_question_favorite
    ADD CONSTRAINT alcpt_question_favorite_user_id_8d37521c_fk_alcpt_user_id FOREIGN KEY (user_id) REFERENCES alcpt.alcpt_user(id);


--
-- Name: alcpt_question alcpt_question_last_updated_by_id_7e7caa2c_fk_alcpt_user_id; Type: FK CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_question
    ADD CONSTRAINT alcpt_question_last_updated_by_id_7e7caa2c_fk_alcpt_user_id FOREIGN KEY (last_updated_by_id) REFERENCES alcpt.alcpt_user(id);


--
-- Name: alcpt_question alcpt_question_replier_id_6fe0d52f_fk_alcpt_user_id; Type: FK CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_question
    ADD CONSTRAINT alcpt_question_replier_id_6fe0d52f_fk_alcpt_user_id FOREIGN KEY (replier_id) REFERENCES alcpt.alcpt_user(id);


--
-- Name: alcpt_reply alcpt_reply_created_by_id_40250197_fk_alcpt_user_id; Type: FK CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_reply
    ADD CONSTRAINT alcpt_reply_created_by_id_40250197_fk_alcpt_user_id FOREIGN KEY (created_by_id) REFERENCES alcpt.alcpt_user(id);


--
-- Name: alcpt_reply alcpt_reply_source_id_0390ee54_fk_alcpt_report_id; Type: FK CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_reply
    ADD CONSTRAINT alcpt_reply_source_id_0390ee54_fk_alcpt_report_id FOREIGN KEY (source_id) REFERENCES alcpt.alcpt_report(id);


--
-- Name: alcpt_report alcpt_report_category_id_108323c9_fk_alcpt_reportcategory_id; Type: FK CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_report
    ADD CONSTRAINT alcpt_report_category_id_108323c9_fk_alcpt_reportcategory_id FOREIGN KEY (category_id) REFERENCES alcpt.alcpt_reportcategory(id);


--
-- Name: alcpt_report alcpt_report_created_by_id_82b9f434_fk_alcpt_user_id; Type: FK CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_report
    ADD CONSTRAINT alcpt_report_created_by_id_82b9f434_fk_alcpt_user_id FOREIGN KEY (created_by_id) REFERENCES alcpt.alcpt_user(id);


--
-- Name: alcpt_report alcpt_report_question_id_171cd9d9_fk_alcpt_question_id; Type: FK CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_report
    ADD CONSTRAINT alcpt_report_question_id_171cd9d9_fk_alcpt_question_id FOREIGN KEY (question_id) REFERENCES alcpt.alcpt_question(id);


--
-- Name: alcpt_report alcpt_report_resolved_by_id_4dc90590_fk_alcpt_user_id; Type: FK CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_report
    ADD CONSTRAINT alcpt_report_resolved_by_id_4dc90590_fk_alcpt_user_id FOREIGN KEY (resolved_by_id) REFERENCES alcpt.alcpt_user(id);


--
-- Name: alcpt_student alcpt_student_department_id_257bfbd3_fk_alcpt_department_id; Type: FK CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_student
    ADD CONSTRAINT alcpt_student_department_id_257bfbd3_fk_alcpt_department_id FOREIGN KEY (department_id) REFERENCES alcpt.alcpt_department(id);


--
-- Name: alcpt_student alcpt_student_squadron_id_4bbcc05a_fk_alcpt_squadron_id; Type: FK CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_student
    ADD CONSTRAINT alcpt_student_squadron_id_4bbcc05a_fk_alcpt_squadron_id FOREIGN KEY (squadron_id) REFERENCES alcpt.alcpt_squadron(id);


--
-- Name: alcpt_student alcpt_student_user_id_c43c5a79_fk_alcpt_user_id; Type: FK CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_student
    ADD CONSTRAINT alcpt_student_user_id_c43c5a79_fk_alcpt_user_id FOREIGN KEY (user_id) REFERENCES alcpt.alcpt_user(id);


--
-- Name: alcpt_testpaper alcpt_testpaper_created_by_id_def16d7a_fk_alcpt_user_id; Type: FK CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_testpaper
    ADD CONSTRAINT alcpt_testpaper_created_by_id_def16d7a_fk_alcpt_user_id FOREIGN KEY (created_by_id) REFERENCES alcpt.alcpt_user(id);


--
-- Name: alcpt_testpaper_question_list alcpt_testpaper_ques_question_id_980638fa_fk_alcpt_que; Type: FK CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_testpaper_question_list
    ADD CONSTRAINT alcpt_testpaper_ques_question_id_980638fa_fk_alcpt_que FOREIGN KEY (question_id) REFERENCES alcpt.alcpt_question(id);


--
-- Name: alcpt_testpaper_question_list alcpt_testpaper_ques_testpaper_id_6848bb19_fk_alcpt_tes; Type: FK CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_testpaper_question_list
    ADD CONSTRAINT alcpt_testpaper_ques_testpaper_id_6848bb19_fk_alcpt_tes FOREIGN KEY (testpaper_id) REFERENCES alcpt.alcpt_testpaper(id);


--
-- Name: alcpt_userachievement alcpt_userachievemen_achievement_id_5cf009f6_fk_alcpt_ach; Type: FK CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_userachievement
    ADD CONSTRAINT alcpt_userachievemen_achievement_id_5cf009f6_fk_alcpt_ach FOREIGN KEY (achievement_id) REFERENCES alcpt.alcpt_achievement(id);


--
-- Name: alcpt_userachievement alcpt_userachievement_user_id_951479b3_fk_alcpt_user_id; Type: FK CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.alcpt_userachievement
    ADD CONSTRAINT alcpt_userachievement_user_id_951479b3_fk_alcpt_user_id FOREIGN KEY (user_id) REFERENCES alcpt.alcpt_user(id);


--
-- Name: audio_file audio_file_user_id_ada556f9_fk_alcpt_user_id; Type: FK CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.audio_file
    ADD CONSTRAINT audio_file_user_id_ada556f9_fk_alcpt_user_id FOREIGN KEY (user_id) REFERENCES alcpt.alcpt_user(id);


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES alcpt.auth_permission(id);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES alcpt.auth_group(id);


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES alcpt.django_content_type(id);


--
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES alcpt.auth_group(id);


--
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES alcpt.auth_user(id);


--
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES alcpt.auth_permission(id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES alcpt.auth_user(id);


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES alcpt.django_content_type(id);


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_alcpt_user_id; Type: FK CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_alcpt_user_id FOREIGN KEY (user_id) REFERENCES alcpt.alcpt_user(id);


--
-- Name: django_plotly_dash_dashapp django_plotly_dash_d_stateless_app_id_220444de_fk_django_pl; Type: FK CONSTRAINT; Schema: alcpt; Owner: postgres
--

ALTER TABLE ONLY alcpt.django_plotly_dash_dashapp
    ADD CONSTRAINT django_plotly_dash_d_stateless_app_id_220444de_fk_django_pl FOREIGN KEY (stateless_app_id) REFERENCES alcpt.django_plotly_dash_statelessapp(id);


--
-- PostgreSQL database dump complete
--

