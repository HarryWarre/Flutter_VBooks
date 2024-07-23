const Favorite = require('../models/favourite')

module.exports = {
    addFavorite: async (req, res) => {
        const { accountId, productId } = req.body
        console.log(accountId)
        console.log(productId)
        try{
            const addedFavorite = await new Favorite({accountId, productId})
            const savedFavorite = addedFavorite.save()
            console.log(accountId)
            console.log(productId)
            console.log(savedFavorite)
            res.status(200).json({message: "Thêm thành công", success: true, favorite: savedFavorite})
        }
        catch(err){
            res.status(500).json(err)
        }
    },

    getFavorite: async (req, res) => {
        await Favorite.find()
              .then(info => res.json(info))
              .catch(err => res.json(err))
    },
    getFavoritesByAccountId: async (req, res) => {
        const { accountId } = req.params;
        try {
            const favorites = await Favorite.find({ accountId: accountId });
            console.log(favorites)
            console.log(accountId)
            if (favorites.length === 0) {
                return res.status(404).json({ success: false, message: 'Không tìm thấy mục yêu thích nào' });
            }
            res.status(200).json({ success: true, favorites: favorites });
        } catch (err) {
            res.status(500).json(err);
        }
    },

    deleteFavorite: async (req, res) => {
        const { accountId, productId } = req.params;
        console.log('AccountId:', accountId);
        console.log('ProductId:', productId);
    
        if (!accountId || !productId) {
            return res.status(400).json({ success: false, message: 'Thiếu accountId hoặc productId' });
        }
        try {
            const favorite = await Favorite.findOne({ accountId, productId });
            if (!favorite) {
                return res.status(404).json({ success: false, message: 'Không tìm thấy mục yêu thích' });
            }
            await Favorite.deleteOne({ accountId: accountId, productId: productId });
            res.status(200).json({ success: true, message: 'Xóa thành công' });
        } catch (err) {
            console.error('Error deleting favorite:', err); // Log error for debugging
            res.status(500).json({ success: false, message: 'Lỗi server, không thể xóa mục yêu thích', error: err.message });
        }
    },

    isFavorite: async (req, res) => {
        const { accountId, productId } = req.params;
        try {
            const favorite = await Favorite.findOne({ accountId, productId });
            if (favorite) {
                return res.status(200).json({ success: true, isFavorite: true });
            } else {
                return res.status(200).json({ success: true, isFavorite: false });
            }
        } catch (err) {
            res.status(500).json(err);
        }
    }
}