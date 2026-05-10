-- Supersonik GTM — SQLite schema v1
-- Run: sqlite3 gtm/db/gtm.db < gtm/db/init.sql

PRAGMA foreign_keys = ON;

-- ===========================================================================
-- accounts — companies, shared across all GTM motions
-- ===========================================================================
CREATE TABLE IF NOT EXISTS accounts (
    id            INTEGER PRIMARY KEY AUTOINCREMENT,
    name          TEXT    NOT NULL,
    domain        TEXT    UNIQUE,
    tier          INTEGER CHECK (tier IN (1, 2, 3)),
    industry      TEXT,
    hq_country    TEXT,
    arr_band      TEXT,
    employees     INTEGER,
    crm_id        TEXT,
    status        TEXT    NOT NULL DEFAULT 'active'
                       CHECK (status IN ('active', 'archived', 'not_now')),
    created_at    TEXT    NOT NULL DEFAULT (datetime('now')),
    updated_at    TEXT
);

-- ===========================================================================
-- archetypes — seed table (9 rows, from icp/archetypes/_index.md)
-- ===========================================================================
CREATE TABLE IF NOT EXISTS archetypes (
    id              TEXT    PRIMARY KEY CHECK (id IN ('a','b','c','d','e','f','g','h','i')),
    tier            INTEGER NOT NULL CHECK (tier IN (1, 2, 3)),
    name            TEXT    NOT NULL,
    role_category   TEXT    NOT NULL CHECK (role_category IN ('Decision Maker', 'Implementator', 'Champion'))
);

-- ===========================================================================
-- contacts — people, shared across motions
-- ===========================================================================
CREATE TABLE IF NOT EXISTS contacts (
    id            INTEGER PRIMARY KEY AUTOINCREMENT,
    account_id    INTEGER NOT NULL REFERENCES accounts(id),
    full_name     TEXT    NOT NULL,
    title         TEXT,
    archetype_id  TEXT    REFERENCES archetypes(id),
    linkedin_url  TEXT,
    email         TEXT    UNIQUE,
    crm_id        TEXT,
    status        TEXT    NOT NULL DEFAULT 'active'
                       CHECK (status IN ('active', 'archived', 'bounced', 'replied')),
    created_at    TEXT    NOT NULL DEFAULT (datetime('now')),
    updated_at    TEXT
);

-- ===========================================================================
-- signals — signal events (12 types from 12_icp.md inventory)
-- ===========================================================================
CREATE TABLE IF NOT EXISTS signals (
    id            INTEGER PRIMARY KEY AUTOINCREMENT,
    account_id    INTEGER NOT NULL REFERENCES accounts(id),
    signal_type   INTEGER NOT NULL CHECK (signal_type BETWEEN 1 AND 12),
    source        TEXT,
    raw_payload   TEXT,   -- JSON
    occurred_at   TEXT,
    ingested_at   TEXT    NOT NULL DEFAULT (datetime('now'))
);

-- ===========================================================================
-- signal_scores — v2 placeholder, one row per account
-- ===========================================================================
CREATE TABLE IF NOT EXISTS signal_scores (
    id            INTEGER PRIMARY KEY AUTOINCREMENT,
    account_id    INTEGER NOT NULL UNIQUE REFERENCES accounts(id),
    score         REAL,
    weights       TEXT,   -- JSON
    updated_at    TEXT    NOT NULL DEFAULT (datetime('now'))
);

-- ===========================================================================
-- frameworks — stored cold-email/DM frameworks
-- ===========================================================================
CREATE TABLE IF NOT EXISTS frameworks (
    id                      INTEGER PRIMARY KEY AUTOINCREMENT,
    name                    TEXT    NOT NULL UNIQUE,
    source                  TEXT,
    sequence_steps          TEXT,   -- JSON: array of {step, channel, delay_days, ask}
    messaging_guidelines    TEXT,
    title_guidelines        TEXT,
    linked_campaign_kpis    TEXT,   -- JSON
    added_at                TEXT    NOT NULL DEFAULT (datetime('now'))
);

-- ===========================================================================
-- sequences — stored sequence instances (from template or custom)
-- ===========================================================================
CREATE TABLE IF NOT EXISTS sequences (
    id                    INTEGER PRIMARY KEY AUTOINCREMENT,
    name                  TEXT    NOT NULL UNIQUE,
    source_framework_id   INTEGER REFERENCES frameworks(id),
    steps                 TEXT    NOT NULL,   -- JSON: array per sequences/_schema.yml
    crm_actions           TEXT,               -- JSON
    created_at            TEXT    NOT NULL DEFAULT (datetime('now'))
);

-- ===========================================================================
-- campaigns — one row per running/historical campaign
-- ===========================================================================
CREATE TABLE IF NOT EXISTS campaigns (
    id                       INTEGER PRIMARY KEY AUTOINCREMENT,
    name                     TEXT    NOT NULL UNIQUE,
    type                     TEXT    NOT NULL CHECK (type IN (
                                'outbound', 'awareness', 'feedback',
                                'event_promotion', 'event_post', 'customer_winback')),
    framework_id             INTEGER REFERENCES frameworks(id),
    sequence_id              INTEGER REFERENCES sequences(id),
    voice_id                 TEXT,
    archetype_id             TEXT,   -- a-i, or 'mixed'
    status                   TEXT    NOT NULL DEFAULT 'draft'
                                  CHECK (status IN ('draft', 'active', 'paused', 'completed', 'archived')),
    kpis                     TEXT,   -- JSON
    instantly_campaign_id    TEXT,
    created_at               TEXT    NOT NULL DEFAULT (datetime('now')),
    launched_at              TEXT
);

-- ===========================================================================
-- campaign_leads — M:N: contacts in campaigns
-- ===========================================================================
CREATE TABLE IF NOT EXISTS campaign_leads (
    campaign_id      INTEGER NOT NULL REFERENCES campaigns(id),
    contact_id       INTEGER NOT NULL REFERENCES contacts(id),
    enriched_email   TEXT,
    status           TEXT    NOT NULL DEFAULT 'pending'
                          CHECK (status IN ('pending', 'sending', 'replied', 'bounced', 'completed', 'unsubscribed')),
    added_at         TEXT    NOT NULL DEFAULT (datetime('now')),
    PRIMARY KEY (campaign_id, contact_id)
);

-- ===========================================================================
-- messages — generated outbound messages
-- ===========================================================================
CREATE TABLE IF NOT EXISTS messages (
    id              INTEGER PRIMARY KEY AUTOINCREMENT,
    campaign_id     INTEGER NOT NULL REFERENCES campaigns(id),
    contact_id      INTEGER NOT NULL REFERENCES contacts(id),
    step            INTEGER NOT NULL CHECK (step >= 1),
    channel         TEXT    NOT NULL CHECK (channel IN ('email', 'linkedin')),
    subject         TEXT,
    body            TEXT    NOT NULL,
    generated_at    TEXT    NOT NULL DEFAULT (datetime('now')),
    sent_at         TEXT,
    status          TEXT    NOT NULL DEFAULT 'draft'
                         CHECK (status IN ('draft', 'sent', 'opened', 'replied', 'bounced', 'paused'))
);

-- ===========================================================================
-- Indexes
-- ===========================================================================
CREATE INDEX IF NOT EXISTS idx_contacts_account              ON contacts(account_id);
CREATE INDEX IF NOT EXISTS idx_contacts_archetype            ON contacts(archetype_id);
CREATE INDEX IF NOT EXISTS idx_signals_account               ON signals(account_id);
CREATE INDEX IF NOT EXISTS idx_signals_type_occurred         ON signals(signal_type, occurred_at);
CREATE INDEX IF NOT EXISTS idx_messages_campaign             ON messages(campaign_id);
CREATE INDEX IF NOT EXISTS idx_messages_status               ON messages(status);
CREATE INDEX IF NOT EXISTS idx_campaign_leads_campaign       ON campaign_leads(campaign_id);
CREATE INDEX IF NOT EXISTS idx_campaign_leads_status         ON campaign_leads(status);

-- ===========================================================================
-- Seed: 9 archetypes from icp/archetypes/_index.md
-- ===========================================================================
INSERT OR IGNORE INTO archetypes (id, tier, name, role_category) VALUES
    ('a', 1, 'Alex the CRO',                'Decision Maker'),
    ('b', 1, 'Ben the RevOps Lead',         'Implementator'),
    ('c', 1, 'Carla the Demand Gen Lead',   'Champion'),
    ('d', 2, 'Dan the International CEO',   'Decision Maker'),
    ('e', 2, 'Eric the Enablement Lead',    'Implementator'),
    ('f', 2, 'Felix the Regional VP',       'Champion'),
    ('g', 3, 'Gabriel the AI-Native CEO',   'Decision Maker'),
    ('h', 3, 'Hugo the GTM Engineer',       'Implementator'),
    ('i', 3, 'Iris the Head of Growth',     'Champion');
