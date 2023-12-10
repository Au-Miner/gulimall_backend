create table QRTZ_CALENDARS
(
    SCHED_NAME    varchar(120) not null,
    CALENDAR_NAME varchar(200) not null,
    CALENDAR      blob         not null,
    primary key (SCHED_NAME, CALENDAR_NAME)
)
    charset = utf8mb3;

create table QRTZ_FIRED_TRIGGERS
(
    SCHED_NAME        varchar(120) not null,
    ENTRY_ID          varchar(95)  not null,
    TRIGGER_NAME      varchar(200) not null,
    TRIGGER_GROUP     varchar(200) not null,
    INSTANCE_NAME     varchar(200) not null,
    FIRED_TIME        bigint       not null,
    SCHED_TIME        bigint       not null,
    PRIORITY          int          not null,
    STATE             varchar(16)  not null,
    JOB_NAME          varchar(200) null,
    JOB_GROUP         varchar(200) null,
    IS_NONCONCURRENT  varchar(1)   null,
    REQUESTS_RECOVERY varchar(1)   null,
    primary key (SCHED_NAME, ENTRY_ID)
)
    charset = utf8mb3;

create index IDX_QRTZ_FT_INST_JOB_REQ_RCVRY
    on QRTZ_FIRED_TRIGGERS (SCHED_NAME, INSTANCE_NAME, REQUESTS_RECOVERY);

create index IDX_QRTZ_FT_JG
    on QRTZ_FIRED_TRIGGERS (SCHED_NAME, JOB_GROUP);

create index IDX_QRTZ_FT_J_G
    on QRTZ_FIRED_TRIGGERS (SCHED_NAME, JOB_NAME, JOB_GROUP);

create index IDX_QRTZ_FT_TG
    on QRTZ_FIRED_TRIGGERS (SCHED_NAME, TRIGGER_GROUP);

create index IDX_QRTZ_FT_TRIG_INST_NAME
    on QRTZ_FIRED_TRIGGERS (SCHED_NAME, INSTANCE_NAME);

create index IDX_QRTZ_FT_T_G
    on QRTZ_FIRED_TRIGGERS (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP);

create table QRTZ_JOB_DETAILS
(
    SCHED_NAME        varchar(120) not null,
    JOB_NAME          varchar(200) not null,
    JOB_GROUP         varchar(200) not null,
    DESCRIPTION       varchar(250) null,
    JOB_CLASS_NAME    varchar(250) not null,
    IS_DURABLE        varchar(1)   not null,
    IS_NONCONCURRENT  varchar(1)   not null,
    IS_UPDATE_DATA    varchar(1)   not null,
    REQUESTS_RECOVERY varchar(1)   not null,
    JOB_DATA          blob         null,
    primary key (SCHED_NAME, JOB_NAME, JOB_GROUP)
)
    charset = utf8mb3;

create index IDX_QRTZ_J_GRP
    on QRTZ_JOB_DETAILS (SCHED_NAME, JOB_GROUP);

create index IDX_QRTZ_J_REQ_RECOVERY
    on QRTZ_JOB_DETAILS (SCHED_NAME, REQUESTS_RECOVERY);

create table QRTZ_LOCKS
(
    SCHED_NAME varchar(120) not null,
    LOCK_NAME  varchar(40)  not null,
    primary key (SCHED_NAME, LOCK_NAME)
)
    charset = utf8mb3;

create table QRTZ_PAUSED_TRIGGER_GRPS
(
    SCHED_NAME    varchar(120) not null,
    TRIGGER_GROUP varchar(200) not null,
    primary key (SCHED_NAME, TRIGGER_GROUP)
)
    charset = utf8mb3;

create table QRTZ_SCHEDULER_STATE
(
    SCHED_NAME        varchar(120) not null,
    INSTANCE_NAME     varchar(200) not null,
    LAST_CHECKIN_TIME bigint       not null,
    CHECKIN_INTERVAL  bigint       not null,
    primary key (SCHED_NAME, INSTANCE_NAME)
)
    charset = utf8mb3;

create table QRTZ_TRIGGERS
(
    SCHED_NAME     varchar(120) not null,
    TRIGGER_NAME   varchar(200) not null,
    TRIGGER_GROUP  varchar(200) not null,
    JOB_NAME       varchar(200) not null,
    JOB_GROUP      varchar(200) not null,
    DESCRIPTION    varchar(250) null,
    NEXT_FIRE_TIME bigint       null,
    PREV_FIRE_TIME bigint       null,
    PRIORITY       int          null,
    TRIGGER_STATE  varchar(16)  not null,
    TRIGGER_TYPE   varchar(8)   not null,
    START_TIME     bigint       not null,
    END_TIME       bigint       null,
    CALENDAR_NAME  varchar(200) null,
    MISFIRE_INSTR  smallint     null,
    JOB_DATA       blob         null,
    primary key (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP),
    constraint qrtz_triggers_ibfk_1
        foreign key (SCHED_NAME, JOB_NAME, JOB_GROUP) references QRTZ_JOB_DETAILS (SCHED_NAME, JOB_NAME, JOB_GROUP)
)
    charset = utf8mb3;

create table QRTZ_BLOB_TRIGGERS
(
    SCHED_NAME    varchar(120) not null,
    TRIGGER_NAME  varchar(200) not null,
    TRIGGER_GROUP varchar(200) not null,
    BLOB_DATA     blob         null,
    primary key (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP),
    constraint qrtz_blob_triggers_ibfk_1
        foreign key (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP) references QRTZ_TRIGGERS (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP)
)
    charset = utf8mb3;

create index SCHED_NAME
    on QRTZ_BLOB_TRIGGERS (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP);

create table QRTZ_CRON_TRIGGERS
(
    SCHED_NAME      varchar(120) not null,
    TRIGGER_NAME    varchar(200) not null,
    TRIGGER_GROUP   varchar(200) not null,
    CRON_EXPRESSION varchar(120) not null,
    TIME_ZONE_ID    varchar(80)  null,
    primary key (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP),
    constraint qrtz_cron_triggers_ibfk_1
        foreign key (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP) references QRTZ_TRIGGERS (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP)
)
    charset = utf8mb3;

create table QRTZ_SIMPLE_TRIGGERS
(
    SCHED_NAME      varchar(120) not null,
    TRIGGER_NAME    varchar(200) not null,
    TRIGGER_GROUP   varchar(200) not null,
    REPEAT_COUNT    bigint       not null,
    REPEAT_INTERVAL bigint       not null,
    TIMES_TRIGGERED bigint       not null,
    primary key (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP),
    constraint qrtz_simple_triggers_ibfk_1
        foreign key (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP) references QRTZ_TRIGGERS (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP)
)
    charset = utf8mb3;

create table QRTZ_SIMPROP_TRIGGERS
(
    SCHED_NAME    varchar(120)   not null,
    TRIGGER_NAME  varchar(200)   not null,
    TRIGGER_GROUP varchar(200)   not null,
    STR_PROP_1    varchar(512)   null,
    STR_PROP_2    varchar(512)   null,
    STR_PROP_3    varchar(512)   null,
    INT_PROP_1    int            null,
    INT_PROP_2    int            null,
    LONG_PROP_1   bigint         null,
    LONG_PROP_2   bigint         null,
    DEC_PROP_1    decimal(13, 4) null,
    DEC_PROP_2    decimal(13, 4) null,
    BOOL_PROP_1   varchar(1)     null,
    BOOL_PROP_2   varchar(1)     null,
    primary key (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP),
    constraint qrtz_simprop_triggers_ibfk_1
        foreign key (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP) references QRTZ_TRIGGERS (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP)
)
    charset = utf8mb3;

create index IDX_QRTZ_T_C
    on QRTZ_TRIGGERS (SCHED_NAME, CALENDAR_NAME);

create index IDX_QRTZ_T_G
    on QRTZ_TRIGGERS (SCHED_NAME, TRIGGER_GROUP);

create index IDX_QRTZ_T_J
    on QRTZ_TRIGGERS (SCHED_NAME, JOB_NAME, JOB_GROUP);

create index IDX_QRTZ_T_JG
    on QRTZ_TRIGGERS (SCHED_NAME, JOB_GROUP);

create index IDX_QRTZ_T_NEXT_FIRE_TIME
    on QRTZ_TRIGGERS (SCHED_NAME, NEXT_FIRE_TIME);

create index IDX_QRTZ_T_NFT_MISFIRE
    on QRTZ_TRIGGERS (SCHED_NAME, MISFIRE_INSTR, NEXT_FIRE_TIME);

create index IDX_QRTZ_T_NFT_ST
    on QRTZ_TRIGGERS (SCHED_NAME, TRIGGER_STATE, NEXT_FIRE_TIME);

create index IDX_QRTZ_T_NFT_ST_MISFIRE
    on QRTZ_TRIGGERS (SCHED_NAME, MISFIRE_INSTR, NEXT_FIRE_TIME, TRIGGER_STATE);

create index IDX_QRTZ_T_NFT_ST_MISFIRE_GRP
    on QRTZ_TRIGGERS (SCHED_NAME, MISFIRE_INSTR, NEXT_FIRE_TIME, TRIGGER_GROUP, TRIGGER_STATE);

create index IDX_QRTZ_T_N_G_STATE
    on QRTZ_TRIGGERS (SCHED_NAME, TRIGGER_GROUP, TRIGGER_STATE);

create index IDX_QRTZ_T_N_STATE
    on QRTZ_TRIGGERS (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP, TRIGGER_STATE);

create index IDX_QRTZ_T_STATE
    on QRTZ_TRIGGERS (SCHED_NAME, TRIGGER_STATE);

create table schedule_job
(
    job_id          bigint auto_increment comment '任务id'
        primary key,
    bean_name       varchar(200)  null comment 'spring bean名称',
    params          varchar(2000) null comment '参数',
    cron_expression varchar(100)  null comment 'cron表达式',
    status          tinyint       null comment '任务状态  0：正常  1：暂停',
    remark          varchar(255)  null comment '备注',
    create_time     datetime      null comment '创建时间'
)
    comment '定时任务' charset = utf8mb4;

create table schedule_job_log
(
    log_id      bigint auto_increment comment '任务日志id'
        primary key,
    job_id      bigint        not null comment '任务id',
    bean_name   varchar(200)  null comment 'spring bean名称',
    params      varchar(2000) null comment '参数',
    status      tinyint       not null comment '任务状态    0：成功    1：失败',
    error       varchar(2000) null comment '失败信息',
    times       int           not null comment '耗时(单位：毫秒)',
    create_time datetime      null comment '创建时间'
)
    comment '定时任务日志' charset = utf8mb4;

create index job_id
    on schedule_job_log (job_id);

create table sys_captcha
(
    uuid        char(36)   not null comment 'uuid'
        primary key,
    code        varchar(6) not null comment '验证码',
    expire_time datetime   null comment '过期时间'
)
    comment '系统验证码' charset = utf8mb4;

create table sys_config
(
    id          bigint auto_increment
        primary key,
    param_key   varchar(50)       null comment 'key',
    param_value varchar(2000)     null comment 'value',
    status      tinyint default 1 null comment '状态   0：隐藏   1：显示',
    remark      varchar(500)      null comment '备注',
    constraint param_key
        unique (param_key)
)
    comment '系统配置信息表' charset = utf8mb4;

create table sys_log
(
    id          bigint auto_increment
        primary key,
    username    varchar(50)   null comment '用户名',
    operation   varchar(50)   null comment '用户操作',
    method      varchar(200)  null comment '请求方法',
    params      varchar(5000) null comment '请求参数',
    time        bigint        not null comment '执行时长(毫秒)',
    ip          varchar(64)   null comment 'IP地址',
    create_date datetime      null comment '创建时间'
)
    comment '系统日志' charset = utf8mb4;

create table sys_menu
(
    menu_id   bigint auto_increment
        primary key,
    parent_id bigint       null comment '父菜单ID，一级菜单为0',
    name      varchar(50)  null comment '菜单名称',
    url       varchar(200) null comment '菜单URL',
    perms     varchar(500) null comment '授权(多个用逗号分隔，如：user:list,user:create)',
    type      int          null comment '类型   0：目录   1：菜单   2：按钮',
    icon      varchar(50)  null comment '菜单图标',
    order_num int          null comment '排序'
)
    comment '菜单管理' charset = utf8mb4;

create table sys_oss
(
    id          bigint auto_increment
        primary key,
    url         varchar(200) null comment 'URL地址',
    create_date datetime     null comment '创建时间'
)
    comment '文件上传' charset = utf8mb4;

create table sys_role
(
    role_id        bigint auto_increment
        primary key,
    role_name      varchar(100) null comment '角色名称',
    remark         varchar(100) null comment '备注',
    create_user_id bigint       null comment '创建者ID',
    create_time    datetime     null comment '创建时间'
)
    comment '角色' charset = utf8mb4;

create table sys_role_menu
(
    id      bigint auto_increment
        primary key,
    role_id bigint null comment '角色ID',
    menu_id bigint null comment '菜单ID'
)
    comment '角色与菜单对应关系' charset = utf8mb4;

create table sys_user
(
    user_id        bigint auto_increment
        primary key,
    username       varchar(50)  not null comment '用户名',
    password       varchar(100) null comment '密码',
    salt           varchar(20)  null comment '盐',
    email          varchar(100) null comment '邮箱',
    mobile         varchar(100) null comment '手机号',
    status         tinyint      null comment '状态  0：禁用   1：正常',
    create_user_id bigint       null comment '创建者ID',
    create_time    datetime     null comment '创建时间',
    constraint username
        unique (username)
)
    comment '系统用户' charset = utf8mb4;

create table sys_user_role
(
    id      bigint auto_increment
        primary key,
    user_id bigint null comment '用户ID',
    role_id bigint null comment '角色ID'
)
    comment '用户与角色对应关系' charset = utf8mb4;

create table sys_user_token
(
    user_id     bigint       not null
        primary key,
    token       varchar(100) not null comment 'token',
    expire_time datetime     null comment '过期时间',
    update_time datetime     null comment '更新时间',
    constraint token
        unique (token)
)
    comment '系统用户Token' charset = utf8mb4;

create table tb_user
(
    user_id     bigint auto_increment
        primary key,
    username    varchar(50) not null comment '用户名',
    mobile      varchar(20) not null comment '手机号',
    password    varchar(64) null comment '密码',
    create_time datetime    null comment '创建时间',
    constraint username
        unique (username)
)
    comment '用户' charset = utf8mb4;

