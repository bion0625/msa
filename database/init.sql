-- auto-generated definition
create table licenses
(
    comment         varchar(255),
    description     varchar(255),
    license_id      varchar(255) not null
        primary key,
    license_type    varchar(255) not null,
    organization_id varchar(255) not null,
    project_name    varchar(255) not null
);

alter table licenses
    owner to postgres;