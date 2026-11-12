import { getAllCategories, getCategoryDetails, getProjectsByCategoryId } from '../models/categories.js';

const showCategoriesPage = async (req, res, next) => {
    try {
        const categories = await getAllCategories();
        res.render('categories', { 
            title: 'Service Categories', 
            categories 
        });
    } catch (err) {
        next(err);
    }
};

const showCategoryDetailsPage = async (req, res, next) => {
    try {
        const categoryId = req.params.id;
        const categoryDetails = await getCategoryDetails(categoryId);
        
        if (!categoryDetails) {
            const error = new Error('Category not found');
            error.status = 404;
            return next(error);
        }

        const projects = await getProjectsByCategoryId(categoryId);

        res.render('category', {
            title: `Category: ${categoryDetails.name}`,
            categoryDetails,
            projects
        });
    } catch (err) {
        next(err);
    }
};

export { showCategoriesPage, showCategoryDetailsPage };