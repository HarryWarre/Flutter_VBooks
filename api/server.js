const express = require("express");
const app = express();
const dotenv = require("dotenv");
const mongoose = require("mongoose");
const categoryRoute = require("./routes/categories");
const productRoute = require("./routes/products");
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

app.use("/product/", productRoute);

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