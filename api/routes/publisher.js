const router = require("express").Router();
const publisherController = require("../controller/publisherController");

// Create a new publisher
router.post('/', publisherController.createPublisher);

// Get all publishers
router.get('/', publisherController.getPublishers);

// Get a specific publisher by ID
router.get('/:id', publisherController.getPublisherById);

// Update a publisher by ID
router.put('/:id', publisherController.updatePublisher);

// Delete a publisher by ID
router.delete('/:id', publisherController.deletePublisher);

module.exports = router;