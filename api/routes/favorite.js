const router = require('express').Router()
const Favorite = require('../controller/favoriteController')

router.post('/addFavorite',Favorite.addFavorite)

router.get('/', Favorite.getFavorite)

router.get('/:accountId', Favorite.getFavoritesByAccountId)

router.delete('/deleteFavorite', Favorite.deleteFavorite)

module.exports = router