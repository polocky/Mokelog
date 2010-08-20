create table project (
    project_id integer NOT NULL PRIMARY KEY,
    title varchar(255) NOT NULL,
    description text NOT NULL,
    created_by varchar(255) NOT NULL,
    members varchar(1000) NOT NULL,
    created_at datetime NOT NULL,
    updated_at timestamp NOT NULL
);

create table event (
    event_id integer NOT NULL PRIMARY KEY,
    project_id integer NOT NULL,
    title varchar(255) NOT NULL,
    description text NOT NULL,
    created_by varchar(255) NOT NULL,
    created_at datetime NOT NULL,
    updated_at timestamp NOT NULL
);

create table response (
    response_id integer NOT NULL PRIMARY KEY,
    event_id integer NOT NULL,
    description text NOT NULL,
    icon integer NOT NULL default 0,
    created_by varchar(255) NOT NULL,
    created_at datetime NOT NULL,
    updated_at timestamp NOT NULL
);
