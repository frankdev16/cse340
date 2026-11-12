import { getAllProjects, getUpcomingProjects, getProjectDetails } from '../models/projects.js';

const NUMBER_OF_UPCOMING_PROJECTS = 5;

const showProjectsPage = async (req, res) => {
    const projects = await getUpcomingProjects(NUMBER_OF_UPCOMING_PROJECTS);
    const title = 'Upcoming Service Projects';

    res.render('projects', { title, projects });
};

const showProjectDetailsPage = async (req, res) => {
    // Grab the project ID from the URL parameter (e.g., /project/3 -> id is 3)
    const projectId = req.params.id;
    
    // Call our model to fetch just that one project
    const project = await getProjectDetails(projectId);
    
    const title = project ? project.title : 'Project Details';

    // Render the project details view, passing in the project data
    res.render('project', { title, project });
};

// Export both controller functions so the routes file can use them
export { showProjectsPage, showProjectDetailsPage };