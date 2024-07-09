const Publisher = require('../models/publisher');

module.exports = {
    // Create a new publisher
    createPublisher: async (req, res) => {
        const { name, email, address } = req.body;
        
        const newPublisher = new Publisher({
            name,
            email,
            address
        });

        try {
            const savedPublisher = await newPublisher.save();
            console.log(savedPublisher);
            res.status(201).json(savedPublisher);
        } catch (err) {
            res.status(500).json(err);
        }
    },

    // Get all publishers
    getPublishers: async (req, res) => {
        try {
            const publishers = await Publisher.find();
            res.json(publishers);
        } catch (err) {
            res.status(500).json(err);
        }
    },

    // Get a specific publisher by ID
    getPublisherById: async (req, res) => {
        const { id } = req.params;

        try {
            const publisher = await Publisher.findById(id);
            if (!publisher) {
                return res.status(404).json({ message: 'Publisher not found' });
            }
            res.json(publisher);
        } catch (err) {
            res.status(500).json(err);
        }
    },

    // Update a publisher by ID
    updatePublisher: async (req, res) => {
        const { id } = req.params;
        const { name, email, address } = req.body;

        try {
            const updatedPublisher = await Publisher.findByIdAndUpdate(
                id,
                { name, email, address },
                { new: true }
            );
            if (!updatedPublisher) {
                return res.status(404).json({ message: 'Publisher not found' });
            }
            res.json(updatedPublisher);
        } catch (err) {
            res.status(500).json(err);
        }
    },

    // Delete a publisher by ID
    deletePublisher: async (req, res) => {
        const { id } = req.params;

        try {
            const deletedPublisher = await Publisher.findByIdAndDelete(id);
            if (!deletedPublisher) {
                return res.status(404).json({ message: 'Publisher not found' });
            }
            res.json({ success: true, message: 'Publisher deleted successfully' });
        } catch (err) {
            res.status(500).json(err);
        }
    }
};
