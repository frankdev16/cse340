import db from './db.js';

// 1. Get all projects
const getAllProjects = async () => {
    const sql = `
        SELECT p.title, p.date, o.name AS organization_name 
        FROM project p
        JOIN organization o ON p.organization_id = o.organization_id
        ORDER BY p.date DESC
    `;
    const result = await db.query(sql);
    return result.rows;
};

// 2. Get only the next few upcoming projects (e.g., next 5)
const getUpcomingProjects = async (numberOfProjects) => {
    const query = `
        SELECT 
            p.project_id,
            p.title,
            p.description,
            p.date,
            p.location,
            p.organization_id,
            o.name AS organization_name
        FROM project p
        JOIN organization o ON p.organization_id = o.organization_id
        WHERE p.date >= CURRENT_DATE
        ORDER BY p.date ASC
        LIMIT $1;
    `;
    const result = await db.query(query, [numberOfProjects]);
    return result.rows;
};

// 3. Get details for one single project by its ID
const getProjectDetails = async (projectId) => {
    const query = `
        SELECT 
            p.project_id,
            p.title,
            p.description,
            p.date,
            p.location,
            p.organization_id,
            o.name AS organization_name
        FROM project p
        JOIN organization o ON p.organization_id = o.organization_id
        WHERE p.project_id = $1;
    `;
    const result = await db.query(query, [projectId]);
    return result.rows.length > 0 ? result.rows[0] : null;
};

// 4. Get projects associated with a specific organization ID
const getProjectsByOrganizationId = async (organizationId) => {
    const query = `
        SELECT
          project_id,
          organization_id,
          title,
          description,
          location,
          date
        FROM project
        WHERE organization_id = $1
        ORDER BY date;
    `;
    const queryParams = [organizationId];
    const result = await db.query(query, queryParams);

    return result.rows;
};

// Export ALL functions so both controllers can access them without crashing
export { 
    getAllProjects, 
    getUpcomingProjects, 
    getProjectDetails, 
    getProjectsByOrganizationId 
};