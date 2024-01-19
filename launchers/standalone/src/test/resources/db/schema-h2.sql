-- chat tables
CREATE TABLE IF NOT EXISTS `s2_chat_context`
(
    `chat_id`        BIGINT NOT NULL , -- context chat id
    `modified_at`    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP , -- row modify time
    `user`           varchar(64) DEFAULT NULL , -- row modify user
    `query_text`     LONGVARCHAR DEFAULT NULL , -- query text
    `semantic_parse` LONGVARCHAR DEFAULT NULL , -- parse data
    `ext_data`       LONGVARCHAR DEFAULT NULL , -- extend data
    PRIMARY KEY (`chat_id`)
    );

CREATE TABLE IF NOT EXISTS `s2_chat`
(
    `chat_id`       BIGINT auto_increment ,-- AUTO_INCREMENT,
    `agent_id`       INT DEFAULT NULL,
    `chat_name`     varchar(100) DEFAULT NULL,
    `create_time`   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP ,
    `last_time`     TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP ,
    `creator`       varchar(30)  DEFAULT NULL,
    `last_question` varchar(200) DEFAULT NULL,
    `is_delete`     INT DEFAULT '0' COMMENT 'is deleted',
    `is_top`        INT DEFAULT '0' COMMENT 'is top',
    PRIMARY KEY (`chat_id`)
    ) ;


CREATE TABLE `s2_chat_query`
(
    `question_id`             BIGINT  NOT NULL AUTO_INCREMENT,
    `agent_id`             INT  NULL,
    `create_time`       TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `query_text`          mediumtext,
    `user_name`         varchar(150)  DEFAULT NULL COMMENT '',
    `query_state`             int(1) DEFAULT NULL,
    `chat_id`           BIGINT NOT NULL , -- context chat id
    `query_result` mediumtext NOT NULL ,
    `score`             int DEFAULT '0',
    `feedback`          varchar(1024) DEFAULT '',
    `similar_queries`          varchar(1024) DEFAULT '',
    PRIMARY KEY (`question_id`)
);

CREATE TABLE `s2_chat_parse`
(
    `question_id`             BIGINT  NOT NULL,
    `chat_id`           BIGINT NOT NULL ,
    `parse_id`          INT NOT NULL ,
    `create_time`       TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `query_text`          varchar(500),
    `user_name`         varchar(150)  DEFAULT NULL COMMENT '',
    `parse_info` mediumtext NOT NULL ,
    `is_candidate` INT DEFAULT 1 COMMENT '1是candidate,0是selected'
);

CREATE TABLE `s2_chat_statistics`
(
    `question_id`             BIGINT  NOT NULL,
    `chat_id`           BIGINT NOT NULL ,
    `user_name`         varchar(150)  DEFAULT NULL COMMENT '',
    `query_text`          varchar(200),
    `interface_name`         varchar(100)  DEFAULT NULL COMMENT '',
    `cost` INT(6) NOT NULL ,
    `type` INT NOT NULL ,
    `create_time`       TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS `s2_chat_config` (
                                                `id` INT NOT NULL AUTO_INCREMENT,
                                                `model_id` INT DEFAULT NULL ,
                                                `chat_detail_config` varchar(655) ,
    `chat_agg_config` varchar(655)    ,
    `recommended_questions`  varchar(1500)    ,
    `created_at` TIMESTAMP  NOT NULL   ,
    `updated_at` TIMESTAMP  NOT NULL   ,
    `created_by` varchar(100) NOT NULL   ,
    `updated_by` varchar(100) NOT NULL   ,
    `status` INT NOT NULL  DEFAULT '0' , -- domain extension information status : 0 is normal, 1 is off the shelf, 2 is deleted
    `llm_examples` TEXT,
    PRIMARY KEY (`id`)
    ) ;
COMMENT ON TABLE s2_chat_config IS 'chat config information table ';


create table s2_user
(
    id       INT AUTO_INCREMENT,
    name     varchar(100) not null,
    display_name varchar(100) null,
    password varchar(100) null,
    email varchar(100) null,
    is_admin INT null,
    PRIMARY KEY (`id`)
);
COMMENT ON TABLE s2_user IS 'user information table';

-- semantic tables

CREATE TABLE IF NOT EXISTS `s2_domain` (
    `id` INT NOT NULL AUTO_INCREMENT  ,
    `name` varchar(255) DEFAULT NULL  , -- domain name
    `biz_name` varchar(255) DEFAULT NULL  , -- internal name
    `parent_id` INT DEFAULT '0'  , -- parent domain ID
    `status` INT NOT NULL  ,
    `created_at` TIMESTAMP DEFAULT NULL  ,
    `created_by` varchar(100) DEFAULT NULL  ,
    `updated_at` TIMESTAMP DEFAULT NULL  ,
    `updated_by` varchar(100) DEFAULT NULL  ,
    `admin` varchar(3000) DEFAULT NULL  , -- domain administrator
    `admin_org` varchar(3000) DEFAULT NULL  , -- domain administrators organization
    `is_open` TINYINT DEFAULT NULL  , -- whether the domain is public
    `viewer` varchar(3000) DEFAULT NULL  , -- domain available users
    `view_org` varchar(3000) DEFAULT NULL  , -- domain available organization
    PRIMARY KEY (`id`)
    );
COMMENT ON TABLE s2_domain IS 'domain basic information';

CREATE TABLE IF NOT EXISTS `s2_model` (
    `id` INT NOT NULL AUTO_INCREMENT  ,
    `name` varchar(255) DEFAULT NULL  , -- domain name
    `biz_name` varchar(255) DEFAULT NULL  , -- internal name
    `domain_id` INT DEFAULT '0'  , -- parent domain ID
    `alias` varchar(255) DEFAULT NULL  , -- internal name
    `status` INT DEFAULT NULL,
    `description` varchar(500) DEFAULT  NULL ,
    `created_at` TIMESTAMP DEFAULT NULL  ,
    `created_by` varchar(100) DEFAULT NULL  ,
    `updated_at` TIMESTAMP DEFAULT NULL  ,
    `updated_by` varchar(100) DEFAULT NULL  ,
    `admin` varchar(3000) DEFAULT NULL  , -- domain administrator
    `admin_org` varchar(3000) DEFAULT NULL  , -- domain administrators organization
    `is_open` TINYINT DEFAULT NULL  , -- whether the domain is public
    `viewer` varchar(3000) DEFAULT NULL  , -- domain available users
    `view_org` varchar(3000) DEFAULT NULL  , -- domain available organization
    `entity` varchar(500) DEFAULT NULL  , -- domain entity info
    `drill_down_dimensions` varchar(500) DEFAULT NULL  , -- drill down dimensions info
    `database_id` INT NOT  NULL ,
    `model_detail` LONGVARCHAR NOT  NULL ,
    `depends` varchar(500) DEFAULT NULL ,
    `source_type` varchar(128) DEFAULT NULL ,
    `filter_sql` varchar(1000) DEFAULT NULL ,
    PRIMARY KEY (`id`)
    );
COMMENT ON TABLE s2_model IS 'model information';


CREATE TABLE `s2_database` (
                               `id` INT NOT NULL AUTO_INCREMENT,
                               `name` varchar(255) NOT  NULL ,
                               `description` varchar(500) DEFAULT  NULL ,
                               `version` varchar(64) DEFAULT  NULL ,
                               `type` varchar(20) NOT  NULL , -- type: mysql,clickhouse,tdw
                               `config` varchar(655) NOT  NULL ,
                               `created_at` TIMESTAMP NOT  NULL ,
                               `created_by` varchar(100) NOT  NULL ,
                               `updated_at` TIMESTAMP NOT  NULL ,
                               `updated_by` varchar(100) NOT  NULL,
                               `admin` varchar(500) NOT  NULL,
                               `viewer` varchar(500) DEFAULT  NULL,
                               PRIMARY KEY (`id`)
);
COMMENT ON TABLE s2_database IS 'database instance table';

create table s2_auth_groups
(
    group_id INT,
    config varchar(2048),
    PRIMARY KEY (`group_id`)
);

CREATE TABLE IF NOT EXISTS `s2_metric` (
                                           `id` INT NOT NULL  AUTO_INCREMENT,
                                           `model_id` INT  NOT NULL ,
                                           `name` varchar(255)  NOT NULL ,
    `biz_name` varchar(255)  NOT NULL ,
    `description` varchar(500) DEFAULT NULL ,
    `status` INT  NOT NULL ,
    `sensitive_level` INT NOT NULL ,
    `type` varchar(50)  NOT NULL , -- ATOMIC, DERIVED
    `type_params` LONGVARCHAR DEFAULT NULL  ,
    `created_at` TIMESTAMP NOT NULL ,
    `created_by` varchar(100) NOT NULL ,
    `updated_at` TIMESTAMP NOT NULL ,
    `updated_by` varchar(100) NOT NULL ,
    `data_format_type` varchar(50) DEFAULT NULL ,
    `data_format` varchar(500) DEFAULT NULL,
    `alias` varchar(500) DEFAULT NULL,
    `tags` varchar(500) DEFAULT NULL,
    `relate_dimensions` varchar(500) DEFAULT NULL,
    `ext` LONGVARCHAR DEFAULT NULL  ,
    `define_type` varchar(50)  NOT NULL, -- MEASURE, FIELD, METRIC
    PRIMARY KEY (`id`)
    );
COMMENT ON TABLE s2_metric IS 'metric information table';


CREATE TABLE IF NOT EXISTS `s2_dimension` (
                                              `id` INT NOT NULL  AUTO_INCREMENT ,
                                              `model_id` INT NOT NULL ,
                                              `name` varchar(255) NOT NULL ,
    `biz_name` varchar(255)  NOT NULL ,
    `description` varchar(500) NOT NULL ,
    `status` INT NOT NULL , -- status, 0 is off the shelf, 1 is normal
    `sensitive_level` INT DEFAULT NULL ,
    `data_type` varchar(50)  DEFAULT NULL , -- type date,array,varchar
    `type` varchar(50)  NOT NULL , -- type categorical,time
    `type_params` LONGVARCHAR  DEFAULT NULL ,
    `expr` LONGVARCHAR NOT NULL , -- expression
    `created_at` TIMESTAMP  NOT NULL ,
    `created_by` varchar(100)  NOT NULL ,
    `updated_at` TIMESTAMP  NOT NULL ,
    `updated_by` varchar(100)  NOT NULL ,
    `semantic_type` varchar(20)  NOT NULL,  -- semantic type: DATE, ID, CATEGORY
    `alias` varchar(500) DEFAULT NULL,
    `default_values` varchar(500) DEFAULT NULL,
    `dim_value_maps` varchar(500) DEFAULT NULL,
    `is_tag` INT DEFAULT NULL,
    PRIMARY KEY (`id`)
    );
COMMENT ON TABLE s2_dimension IS 'dimension information table';

CREATE TABLE s2_model_rela
(
    id             BIGINT AUTO_INCREMENT,
    domain_id       BIGINT,
    from_model_id    BIGINT,
    to_model_id      BIGINT,
    join_type       VARCHAR(255),
    join_condition  VARCHAR(255),
    PRIMARY KEY (`id`)
);

create table s2_view_info
(
    id         INT auto_increment,
    domain_id  INT       null,
    type       varchar(20)  null comment 'model、dimension、metric',
    config     LONGVARCHAR   null comment 'config detail',
    created_at TIMESTAMP     null,
    created_by varchar(100) null,
    updated_at TIMESTAMP     null,
    updated_by varchar(100) not null
);
COMMENT ON TABLE s2_view_info IS 'view information table';


CREATE TABLE `s2_query_stat_info` (
                                      `id` INT NOT NULL AUTO_INCREMENT,
                                      `trace_id` varchar(200) DEFAULT NULL, -- query unique identifier
                                      `model_id` INT DEFAULT NULL,
                                      `user`    varchar(200) DEFAULT NULL,
                                      `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ,
                                      `query_type` varchar(200) DEFAULT NULL, -- the corresponding scene
                                      `query_type_back` INT DEFAULT '0' , -- query type, 0-normal query, 1-pre-refresh type
                                      `query_sql_cmd`LONGVARCHAR , -- sql type request parameter
                                      `sql_cmd_md5` varchar(200) DEFAULT NULL, -- sql type request parameter md5
                                      `query_struct_cmd`LONGVARCHAR , -- struct type request parameter
                                      `struct_cmd_md5` varchar(200) DEFAULT NULL, -- struct type request parameter md5值
                                      `sql`LONGVARCHAR ,
                                      `sql_md5` varchar(200) DEFAULT NULL, -- sql md5
                                      `query_engine` varchar(20) DEFAULT NULL,
                                      `elapsed_ms` bigINT DEFAULT NULL,
                                      `query_state` varchar(20) DEFAULT NULL,
                                      `native_query` INT DEFAULT NULL, -- 1-detail query, 0-aggregation query
                                      `start_date` varchar(50) DEFAULT NULL,
                                      `end_date` varchar(50) DEFAULT NULL,
                                      `dimensions`LONGVARCHAR , -- dimensions involved in sql
                                      `metrics`LONGVARCHAR , -- metric  involved in sql
                                      `select_cols`LONGVARCHAR ,
                                      `agg_cols`LONGVARCHAR ,
                                      `filter_cols`LONGVARCHAR ,
                                      `group_by_cols`LONGVARCHAR ,
                                      `order_by_cols`LONGVARCHAR ,
                                      `use_result_cache` TINYINT DEFAULT '-1' , -- whether to hit the result cache
                                      `use_sql_cache` TINYINT DEFAULT '-1' , -- whether to hit the sql cache
                                      `sql_cache_key`LONGVARCHAR , -- sql cache key
                                      `result_cache_key`LONGVARCHAR , -- result cache key
                                      `query_opt_mode` varchar(50) DEFAULT NULL ,
                                      PRIMARY KEY (`id`)
) ;
COMMENT ON TABLE s2_query_stat_info IS 'query statistics table';


CREATE TABLE IF NOT EXISTS `s2_semantic_pasre_info` (
                                                        `id` INT NOT NULL AUTO_INCREMENT,
                                                        `trace_id` varchar(200) NOT NULL  ,
    `model_id` INT  NOT NULL ,
    `dimensions`LONGVARCHAR ,
    `metrics`LONGVARCHAR ,
    `orders`LONGVARCHAR ,
    `filters`LONGVARCHAR ,
    `date_info`LONGVARCHAR ,
    `limit` INT NOT NULL ,
    `native_query` TINYINT NOT NULL DEFAULT '0' ,
    `sql`LONGVARCHAR ,
    `created_at` TIMESTAMP  NOT NULL ,
    `created_by` varchar(100) NOT NULL ,
    `status` INT NOT NULL ,
    `elapsed_ms` bigINT DEFAULT NULL ,
    PRIMARY KEY (`id`)
    );
COMMENT ON TABLE s2_semantic_pasre_info IS 'semantic layer sql parsing information table';


CREATE TABLE IF NOT EXISTS `s2_available_date_info` (
                                                        `id` INT NOT NULL  AUTO_INCREMENT ,
                                                        `item_id` INT NOT NULL ,
                                                        `type`    varchar(255) NOT NULL ,
    `date_format` varchar(64)  NOT NULL ,
    `start_date`  varchar(64) ,
    `end_date`  varchar(64) ,
    `unavailable_date` LONGVARCHAR  DEFAULT NULL ,
    `created_at` TIMESTAMP  NOT NULL ,
    `created_by` varchar(100)  NOT NULL ,
    `updated_at` TIMESTAMP  NOT NULL ,
    `updated_by` varchar(100)  NOT NULL ,
    `date_period` varchar(100)  DEFAULT NULL ,
    `status` INT  DEFAULT '0', -- 1-in use  0 is normal, 1 is off the shelf, 2 is deleted
    PRIMARY KEY (`id`)
    );
COMMENT ON TABLE s2_dimension IS 'dimension information table';


CREATE TABLE IF NOT EXISTS `s2_plugin`
(
    `id`         INT AUTO_INCREMENT,
    `type`      varchar(50)   NULL,
    `model`     varchar(100)  NULL,
    `pattern`    varchar(500)  NULL,
    `parse_mode` varchar(100)  NULL,
    `parse_mode_config` LONGVARCHAR  NULL,
    `name`       varchar(100)  NULL,
    `created_at` TIMESTAMP   NULL,
    `created_by` varchar(100) null,
    `updated_at` TIMESTAMP    NULL,
    `updated_by` varchar(100) NULL,
    `config`     LONGVARCHAR  NULL,
    `comment`     LONGVARCHAR  NULL,
    PRIMARY KEY (`id`)
); COMMENT ON TABLE s2_plugin IS 'plugin information table';

CREATE TABLE IF NOT EXISTS s2_agent
(
    id          int AUTO_INCREMENT,
    name        varchar(100)  null,
    description varchar(500) null,
    status       int null,
    examples    varchar(500) null,
    config      varchar(2000)  null,
    created_by  varchar(100) null,
    created_at  TIMESTAMP  null,
    updated_by  varchar(100) null,
    updated_at  TIMESTAMP null,
    enable_search int null,
    PRIMARY KEY (`id`)
); COMMENT ON TABLE s2_agent IS 'agent information table';


-------demo for semantic and chat
CREATE TABLE IF NOT EXISTS `s2_user_department` (
    `user_name` varchar(200) NOT NULL,
    `department` varchar(200) NOT NULL -- department of user
    );
COMMENT ON TABLE s2_user_department IS 'user_department_info';

CREATE TABLE IF NOT EXISTS `s2_pv_uv_statis` (
    `imp_date` varchar(200) NOT NULL,
    `user_name` varchar(200) NOT NULL,
    `page` varchar(200) NOT NULL
    );
COMMENT ON TABLE s2_pv_uv_statis IS 's2_pv_uv_statis';

CREATE TABLE IF NOT EXISTS `s2_stay_time_statis` (
    `imp_date` varchar(200) NOT NULL,
    `user_name` varchar(200) NOT NULL,
    `stay_hours` DOUBLE NOT NULL,
    `page` varchar(200) NOT NULL
    );
COMMENT ON TABLE s2_stay_time_statis IS 's2_stay_time_statis_info';

CREATE TABLE IF NOT EXISTS `singer` (
    `imp_date` varchar(200) NOT NULL,
    `singer_name` varchar(200) NOT NULL,
    `act_area` varchar(200) NOT NULL,
    `song_name` varchar(200) NOT NULL,
    `genre` varchar(200) NOT NULL,
    `js_play_cnt` bigINT DEFAULT NULL,
    `down_cnt` bigINT DEFAULT NULL,
    `favor_cnt` bigINT DEFAULT NULL
    );
COMMENT ON TABLE singer IS 'singer_info';

CREATE TABLE IF NOT EXISTS `s2_dictionary_task` (
   `id` INT NOT NULL AUTO_INCREMENT,
   `name` varchar(255) NOT NULL , -- task name
   `description` varchar(255) ,
   `command`LONGVARCHAR  NOT NULL , -- task Request Parameters
   `command_md5` varchar(255)  NOT NULL , -- task Request Parameters md5
   `status` INT NOT NULL , -- the final status of the task
   `dimension_ids` varchar(500)  NULL ,
   `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP  ,
   `created_by` varchar(100) NOT NULL ,
   `progress` DOUBLE default 0.00  ,  -- task real-time progress
   `elapsed_ms` bigINT DEFAULT NULL , -- the task takes time in milliseconds
   `message` LONGVARCHAR  , -- remark related information
   PRIMARY KEY (`id`)
);
COMMENT ON TABLE s2_dictionary_task IS 'dictionary task information table';



-- benchmark
CREATE TABLE IF NOT EXISTS `genre` (
    `g_name` varchar(20) NOT NULL , -- genre name
    `rating` INT ,
    `most_popular_in` varchar(50) ,
    PRIMARY KEY (`g_name`)
    );
COMMENT ON TABLE genre IS 'genre';

CREATE TABLE IF NOT EXISTS `artist` (
    `artist_name` varchar(50) NOT NULL , -- genre name
    `country` varchar(20) ,
    `gender` varchar(20) ,
    `g_name` varchar(50)
    );
COMMENT ON TABLE artist IS 'artist';

CREATE TABLE IF NOT EXISTS `files` (
    `f_id` bigINT NOT NULL,
    `artist_name` varchar(50) ,
    `file_size` varchar(20) ,
    `duration` varchar(20) ,
    `formats` varchar(20) ,
    PRIMARY KEY (`f_id`)
    );
COMMENT ON TABLE files IS 'files';

CREATE TABLE IF NOT EXISTS `song` (
    `imp_date` varchar(50) ,
    `song_name` varchar(50) ,
    `artist_name` varchar(50) ,
    `country` varchar(20) ,
    `f_id` bigINT ,
    `g_name` varchar(20) ,
    `rating` INT ,
    `languages` varchar(20) ,
    `releasedate` varchar(50) ,
    `resolution` bigINT NOT NULL
    );
COMMENT ON TABLE song IS 'song';

CREATE TABLE s2_sys_parameter
(
    id  INT PRIMARY KEY AUTO_INCREMENT,
    admin varchar(500),
    parameters text null
);

CREATE TABLE `s2_collect` (
    `id` bigint NOT NULL AUTO_INCREMENT,
    `type` varchar(20) NOT NULL,
    `username` varchar(20) NOT NULL,
    `collect_id` bigint NOT NULL,
    `create_time` TIMESTAMP,
    `update_time` TIMESTAMP,
    PRIMARY KEY (`id`)
);

CREATE TABLE `s2_metric_query_default_config` (
       `id` bigint NOT NULL AUTO_INCREMENT,
       `metric_id` bigint ,
       `user_name` varchar(255) NOT NULL,
       `default_config` varchar(1000) NOT NULL,
       `created_at` TIMESTAMP null,
       `updated_at` TIMESTAMP null,
       `created_by` varchar(100) null,
       `updated_by` varchar(100) not null,
       PRIMARY KEY (`id`)
);

CREATE TABLE `s2_app` (
    id          bigint AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(255),
    description VARCHAR(255),
    status      INT,
    config      TEXT,
    end_date    TIMESTAMP,
    qps         INT,
    app_secret  VARCHAR(255),
    owner       VARCHAR(255),
    created_at  TIMESTAMP,
    created_by  VARCHAR(255),
    updated_at  TIMESTAMP,
    updated_by  VARCHAR(255)
);