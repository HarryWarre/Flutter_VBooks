const router = require('express').Router()
const favoriteController = require('../controller/favoriteController')
const Favorite = require('../controller/favoriteController')

router.post('/addFavorite',Favorite.addFavorite)

router.get('/', Favorite.getFavorite)

router.get('/:accountId', Favorite.getFavoritesByAccountId)

router.get('/isFavorite/:accountId/:productId', Favorite.isFavorite);

router.delete('/deleteFavorite/:accountId/:productId', Favorite.deleteFavorite);

module.exports = router