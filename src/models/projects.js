import db from './db.js'; 

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

export { getAllProjects };