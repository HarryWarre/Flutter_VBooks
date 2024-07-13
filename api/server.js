const express = require("express");
const app = express();
const dotenv = require("dotenv");
const mongoose = require("mongoose");
const categoryRoute = require("./routes/categories");
const productRoute = require("./routes/products");
const publisherRoute = require("./routes/publisher");
const adminRoute = require("./routes/admins");
const paymentRoute = require("./routes/payments");
const accountRoute = require("./routes/accounts");
const favoriteRoute = require("./routes/favorite");
const orderRoute = require("./routes/order");
const orderdetailRoute = require("./routes/orderdetails");
const cartRoute = require("./routes/carts");
const fearturedRoute = require("./routes/collection/feartured");
const BestSellingRoute = require("./routes/collection/bestSelling");
// app configuration

dotenv.config();

mongoose
  .connect(process.env.MONGO_URL)
  .then(() => console.log("db connect"))
  .catch((err) => {
    console.log(err);
  });
//middleware configuration

app.use(express.json());

//api routes
// quản lý thể loại
app.use("/category/", categoryRoute);

// quản lý sản phẩm
app.use("/product/", productRoute);

// quản lý ?
app.use("/publisher/", publisherRoute);

// quản lý admin
app.use("/admin/", adminRoute);

// quản lý phương thức thanh toán
app.use("/payment/", paymentRoute);

//quản lý tài khoản khách hàng
app.use("/account/", accountRoute);

//quản lý danh sách yêu thích
app.use("/favorite/", favoriteRoute);

//quản lý đơn hàng
app.use("/order/", orderRoute);

//quản lý chi tiết đơn hàng
app.use("/orderdetail/", orderdetailRoute);

//quản lý giỏ hàng
app.use("/cart/", cartRoute);

app.use("/feartured/", fearturedRoute);
app.use("/bestselling/", BestSellingRoute);

app.get("/", (req, res) => res.send("Hello"));

//listener
try {
  app.listen(
    process.env.PORT || 5001,
    console.log(`Server khởi động tại port ${process.env.PORT}`)
  );
} catch {
  console.log("Server khởi động thất bại");
}
