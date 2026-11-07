-- ========================================
-- Organization Table
-- ========================================
CREATE TABLE organization (
    organization_id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    description TEXT NOT NULL,
    contact_email VARCHAR(255) NOT NULL,
    logo_filename VARCHAR(255) NOT NULL
);

INSERT INTO organization (name, description, contact_email, logo_filename)
VALUES 
('BrightFuture Builders', 
'A nonprofit focused on improving community infrastructure through sustainable construction projects.', 
'info@brightfuturebuilders.org', 'brightfuture-logo.png'),
('GreenHarvest Growers', 
'An urban farming collective promoting food sustainability and education in local neighborhoods.', 
'contact@greenharvest.org', 'greenharvest-logo.png'),
('UnityServe Volunteers', 
'A volunteer coordination group supporting local charities and service initiatives.', 
'hello@unityserve.org', 'unityserve-logo.png');

SELECT * FROM organization;

SELECT name AS nomenclature, contact_email AS Email
FROM organization;


-- ========================================
-- Project Table
-- ========================================
CREATE TABLE project (
    project_id SERIAL PRIMARY KEY,
    organization_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(255) NOT NULL,
    date DATE NOT NULL,
    CONSTRAINT fk_organization
        FOREIGN KEY (organization_id)
        REFERENCES organization(organization_id)
);

-- Insert 15 sample projects (5 for each of the 3 organizations)
INSERT INTO project (organization_id, title, description, location, date)
VALUES 
-- Projects for BrightFuture Builders (ID 1)
(1, 'Community Center Roof Repair', 'Fixing the community center roof before rainy season.', 'Downtown Center', '2026-11-15'),
(1, 'Playground Rebuild', 'Installing new sustainable play equipment.', 'City Park', '2026-11-20'),
(1, 'Library Ramps', 'Building wheelchair access ramps for the local library.', 'Main Library', '2026-12-05'),
(1, 'School Painting', 'Repainting the exterior of the local high school.', 'Westside High', '2026-12-12'),
(1, 'Solar Panel Install', 'Setting up solar panels for the neighborhood clinic.', 'Health Clinic', '2026-12-18'),


(2, 'Community Garden Setup', 'Tilling and preparing soil for the new spring garden.', 'Eastside Lot', '2026-11-18'),
(2, 'Compost Workshop', 'Teaching locals how to build backyard compost bins.', 'Botanical Gardens', '2026-11-22'),
(2, 'Seed Distribution', 'Handing out winter crop seeds to neighborhood families.', 'Town Square', '2026-11-25'),
(2, 'Urban Orchard Pruning', 'Trimming fruit trees before the winter freeze.', 'Northside Orchard', '2026-12-02'),
(2, 'Farmers Market Prep', 'Setting up stalls and infrastructure for the weekend market.', 'Market Street', '2026-12-09'),


(3, 'Food Drive Sorting', 'Sorting canned goods collected over the holidays.', 'Food Bank Warehouse', '2026-11-28'),
(3, 'Senior Center Visit', 'Hosting a game night and dinner for elderly residents.', 'Sunrise Senior Living', '2026-12-01'),
(3, 'Park Cleanup', 'Picking up litter and clearing trail paths.', 'Riverfront Park', '2026-12-08'),
(3, 'Winter Coat Drive', 'Collecting and distributing warm clothing.', 'Community Hall', '2026-12-15'),
(3, 'Holiday Toy Wrapping', 'Wrapping donated toys for local children in need.', 'Downtown Center', '2026-12-20');


SELECT p.title, p.date, o.name AS organization_name 
FROM project p
JOIN organization o ON p.organization_id = o.organization_id;


-- ========================================
-- Category Table
-- ========================================
CREATE TABLE category (
    category_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- Insert 3 relevant service project categories
INSERT INTO category (name) 
VALUES 
('Construction & Repair'),
('Environment & Agriculture'),
('Community Support & Education');

-- ========================================
-- Junction Table: Project <-> Category (Many-to-Many)
-- ========================================
CREATE TABLE project_category (
    project_id INT NOT NULL,
    category_id INT NOT NULL,
    PRIMARY KEY (project_id, category_id),
    CONSTRAINT fk_project
        FOREIGN KEY (project_id)
        REFERENCES project(project_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_category
        FOREIGN KEY (category_id)
        REFERENCES category(category_id)
        ON DELETE CASCADE
);

-- Link projects to categories (Mapping the 15 projects)
INSERT INTO project_category (project_id, category_id) 
VALUES 
-- BrightFuture Builders Projects (IDs 1-5) -> Construction & Repair (ID 1)
(1, 1), (2, 1), (3, 1), (4, 1), (5, 1),
-- GreenHarvest Growers Projects (IDs 6-10) -> Environment & Agriculture (ID 2)
(6, 2), (7, 2), (8, 2), (9, 2), (10, 2),
-- UnityServe Volunteers Projects (IDs 11-15) -> Community Support & Education (ID 3)
(11, 3), (12, 3), (13, 3), (14, 3), (15, 3);